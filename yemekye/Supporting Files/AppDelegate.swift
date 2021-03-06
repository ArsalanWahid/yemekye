//
//  AppDelegate.swift
//  yemekye
//
//  Created by Arsalan Wahid Asghar on 10/22/17.
//  Copyright © 2017 Arsalan Wahid Asghar. All rights reserved.
//

//
//  AppDelegate.swift
//  FacebookLoginExample
//
//  Created by Belal Khan on 09/08/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //added these 3 methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //use firebase library to configure APIs
        FirebaseApp.configure()
        
        //Setting up faceBook login
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Support For keyboard Management
        IQKeyboardManager.shared().isEnabled = true
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
//    func applicationWillResignActive(_ application: UIApplication) {
//        FBSDKAppEvents.activateApp()
//    }
//
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true 
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        if UserDefaults.standard.object(forKey: "loginStatus") != nil{
//            LoginManager.LoginStatus.isLoggedIn = (UserDefaults.standard.object(forKey: "loginStatus") as! Bool)
//            print(LoginManager.LoginStatus.isLoggedIn)
//        }else{
//            print("user is new")
//        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
       
      
    }
    
    
   
    
    
}
