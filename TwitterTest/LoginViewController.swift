//
//  ViewController.swift
//  TwitterTest
//
//  Created by chander bhushan on 17/03/19.
//  Copyright © 2019 Educational. All rights reserved.
//

import UIKit
import TwitterKit
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clickedLoginBtn(_ sender: Any) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if session != nil{
                UserDefaults.standard.set(session?.userID, forKey: "userId")
                UserDefaults.standard.set(session?.userName, forKey: "userName")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    if (email != nil) {
                        UserDefaults.standard.set(email, forKey: "email")
                        let mainNav = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationViewController") as? MainNavigationViewController
                        self.present(mainNav!, animated: false, completion: nil)
                    } else {
                        print("error: \(error!.localizedDescription)");
                        let mainNav = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationViewController") as? MainNavigationViewController
                        self.present(mainNav!, animated: false, completion: nil)
                    }
                }
            }else{
                print(error.debugDescription)
            }
        }
    }
    
}

