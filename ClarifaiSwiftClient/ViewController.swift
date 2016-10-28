//
//  ViewController.swift
//  ClarifaiSwiftClient
//
//  Created by Minh Hoang on 10/27/16.
//  Copyright © 2016 Minh Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let clarifaiClient = ClarifaiAPI(clientID: "XgU4TGxLJbab8WVSQN04HNzMsp24ttAkH2o1r9pe",
                                     clientSecret: "rydEOSNRqOqkbzoCOd-X-05W2ft7EH0Xmoy4Lmqj")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clarifaiClient.predict(model: .General, url: "https://samples.clarifai.com/metro-north.jpg") { (result, error) in
            if error != nil {
                print("shit happened!")
                print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

