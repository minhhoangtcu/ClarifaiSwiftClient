//
//  Clarifai.swift
//  ClarifaiSwiftClient
//
//  Created by Minh Hoang on 10/27/16.
//  Copyright © 2016 Minh Hoang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ClarifaiAPI {
    
    private var clientID: String
    private var clientSecret: String
    private var accessToken: String?
    
    /// Initializes the client using the provided clientID and clientSecret.
    ///
    /// - parameter clientID:       The client ID.
    /// - parameter clientSecret:   The client Secret.
    init(clientID: String, clientSecret: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        
        loadAccessToken()
    }
    
    // MARK: Access Token Management
    
    private func loadAccessToken() {
        
        let params = [
            "grant_type": "client_credentials",
            "client_id": self.clientID,
            "client_secret": self.clientSecret
        ]
        
        Alamofire.request(Config.BaseURL.appending("/token"), method: .post, parameters: params)
            .validate()
            .responseJSON() { response in
                switch response.result {
                case .success(_):
                    let json = JSON(response.result.value)
                    let tokenResponse = json["access_token"].stringValue
                    self.accessToken = tokenResponse
                case .failure(let error):
                    print("Cannot get Access Token")
                    print(error)
                }
        }
    }
    
    // MARK: Get Tags
    
    public func predict(model: Model, url: String, withCompletionHandler completionHandler: ([String], Error) -> Void) {
        
        guard self.accessToken != nil else {
            completionHandler([], ConnectionError.invalidAccessToken)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            completionHandler([], ConnectionError.invalidImageURL)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + self.accessToken!,
            "Content-Type": "application/json"
        ]
        
        let tagURL = try! URLRequest(url: "https://api.clarifai.com/v2/models/", method: .post, headers: headers)
        
        Alamofire.upload(multipartFormData: {
            (multipartFormData) in
                multipartFormData.append(imageURL, withName: "url")
            },
            with: tagURL,
            encodingCompletion: { (result) in
                print("Completed!")
        })
        
    }
    
    
}
