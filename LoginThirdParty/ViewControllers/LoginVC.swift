//
//  LoginVC.swift
//  LoginThirdParty
//
//  Created by Rohmat Suseno on 06/03/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FacebookLogin

class LoginVC: UIViewController {

    @IBOutlet weak var fbSignInView: UIView!
    @IBOutlet weak var googleSignInView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        setupView()
    }
    
    func setupView() {
        fbSignInView.layer.cornerRadius = 10
        fbSignInView.isUserInteractionEnabled = true
        fbSignInView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFbSignIn(_:))))
        
        googleSignInView.layer.cornerRadius = 10
        googleSignInView.isUserInteractionEnabled = true
        googleSignInView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGoogleSignIn(_:))))
    }
    
    @objc func didTapFbSignIn(_ sender: UIButton) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (authDataResult, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let profile = authDataResult?.additionalUserInfo?.profile
                let email = profile?["email"] as! String
                let firstName = profile?["first_name"] as! String
                let lastName = profile?["last_name"] as! String
                let idFB = profile?["id"] as! String
                
                print(email + " ", firstName + " ", lastName + " ", idFB)
                
                self.navigationController?.pushViewController(HomeVC(), animated: true)
            }
        }
    }
    
    @objc func didTapGoogleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

// MARK: - GIDSignInDelegate
extension LoginVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            //stopLoading()
            print("Login error \(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        print("userID " + user.userID)
        print("idToken " + authentication.idToken)
        print("fullName " + user.profile.name)
        print("givenName " + user.profile.givenName)
        print("familyName " + user.profile.familyName)
        print("email " + user.profile.email)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print("Login error \(error.localizedDescription)")
            return
          }
          // User is signed in
          self.navigationController?.pushViewController(HomeVC(), animated: true)
        }
    }
}
