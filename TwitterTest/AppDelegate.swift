//
//  AppDelegate.swift
//  TwitterTest
//
//  Created by chander bhushan on 17/03/19.
//  Copyright © 2019 Educational. All rights reserved.
//

import UIKit
import TwitterKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // if user logged in or not
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            let hvc = storyboard.instantiateViewController(withIdentifier: "MainNavigationViewController") as? MainNavigationViewController
            window?.rootViewController = hvc
            window?.makeKeyAndVisible()
        }else{
            let hvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            window?.rootViewController = hvc
            window?.makeKeyAndVisible()
        }

        
        
        TWTRTwitter.sharedInstance().start(withConsumerKey:"iJ7UwAXt8DpgFX160taJw06Ff", consumerSecret:"sCxqp6alxvwvNTScPnG7nmzdodrY96bxEW4sDAUENJNScEYbQz")
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }

}

