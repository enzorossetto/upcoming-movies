//
//  Utils.swift
//  LearningUIKit
//
//  Created by Enzo Rossetto on 14/03/24.
//

import Foundation

let apiKey = "THE_MOVIE_DB_API_KEY"

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()
