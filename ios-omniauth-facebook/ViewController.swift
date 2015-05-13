//
//  ViewController.swift
//  ios-omniauth-facebook
//
//  Created by Nicolas on 13/05/15.
//  Copyright (c) 2015 Nicolas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,  FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println(result)
        println(error)
    }
    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickOnSendRequestButton(sender: AnyObject) {
        requestAPI()
    }
    
    private func requestAPI() {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
            
            Alamofire.request(.GET,
                "http://dev-api.qemotion.com/auth/facebook_access_token/callback",
                parameters: [
                    "access_token": accessToken,
                    "user": [
                        "username": "testazeaze"
                    ]
                ])
                .responseJSON { (request, response, data, error) in
                    if(error != nil) {
                        NSLog("Error: \(error)")
                        println(request)
                        println(response)
                    }
                    else {
                        var json = JSON(data!)
                        
                        println(json)
                    }
            }
        } else {
            println("No Access Token")
        }
    }
}

