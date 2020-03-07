//
//  HomeVC.swift
//  LoginThirdParty
//
//  Created by Rohmat Suseno on 07/03/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import GoogleSignIn

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(didTapSignOut(_:)))
    }
    
    @objc func didTapSignOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
