//
//  Config.swift
//  ClarifaiSwiftClient
//
//  Created by Minh Hoang on 10/27/16.
//  Copyright © 2016 Minh Hoang. All rights reserved.
//

import Foundation

struct Config {
    static let BaseURL: String = "https://api.clarifai.com/v1"
}


/// All avaiable Models
enum Model: String {
    case General = "general-v1.3"
    case NSFW = "nsfw-v1.0"
    case Weddings = "weddings-v1.0"
    case Travel = "travel-v1.0"
    case Food = "food-items-v0.1"
}


// All possible errors
enum ConnectionError: Error {
    case invalidAccessToken
    case invalidImageURL
}
