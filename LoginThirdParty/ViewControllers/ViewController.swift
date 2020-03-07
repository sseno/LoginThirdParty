//
//  ViewController.swift
//  LoginThirdParty
//
//  Created by Rohmat Suseno on 06/03/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    let signInButton = GIDSignInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

// MARK: - GIDSignInDelegate
extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            //stopLoading()
            print(error.localizedDescription)
            return
        }
        print("userID " + user.userID)
        print("idToken " + user.authentication.idToken)
        print("fullName " + user.profile.name)
        print("givenName " + user.profile.givenName)
        print("familyName " + user.profile.familyName)
        print("email " + user.profile.email)
        
        self.navigationController?.pushViewController(HomeVC(), animated: true)
    }
}

