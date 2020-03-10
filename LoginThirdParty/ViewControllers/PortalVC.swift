//
//  PortalVC.swift
//  LoginThirdParty
//
//  Created by Rohmat Suseno on 09/03/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import FirebaseAuth

class PortalVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            setRootViewController(rootViewController: HomeVC(), animated: true, completion: nil)
        } else {
            setRootViewController(rootViewController: LoginVC(), animated: true, completion: nil)
        }
    }
}
