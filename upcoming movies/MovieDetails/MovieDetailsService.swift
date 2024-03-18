//
//  MovieDetailsService.swift
//  LearningUIKit
//
//  Created by Enzo Rossetto on 18/03/24.
//

import UIKit

enum ImageError: Error {
    case cauldNotDecode
}

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCastMember]
}

class MovieDetailsService {
    func getPoster(for movie: Movie, _ completition: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: movie.posterURL) { data, _, error in
            guard error == nil else {
                completition(.failure(error!))
                return
            }
            
            guard let decoded = UIImage(data: data!) else {
                completition(.failure(ImageError.cauldNotDecode))
                return
            }
            
            completition(.success(decoded))
        }.resume()
    }
    
    func getCredits(for movie: Movie, _ completition: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completition(.failure(error!))
                return
            }
            
            let decoded = try! jsonDecoder.decode(MovieCreditsResponse.self, from: data!)
            
            completition(.success(decoded))
        }.resume()
    }
}
