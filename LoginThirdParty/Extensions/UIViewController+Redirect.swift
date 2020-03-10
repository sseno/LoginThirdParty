//
//  UIViewController+Redirect.swift
//  LoginThirdParty
//
//  Created by Rohmat Suseno on 09/03/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let window = UIWindow.key else { return }
        let navigationController = UINavigationController(rootViewController: rootViewController)
        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = navigationController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window.rootViewController = navigationController
        }
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
