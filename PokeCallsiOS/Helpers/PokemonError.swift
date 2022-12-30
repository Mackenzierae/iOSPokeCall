//
//  PokemonError.swift
//  PokeCallsiOS
//
//  Created by Mackenzie Wacker on 12/27/22.
//

import Foundation

enum PokemonError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach to PokeApi.co"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "the server responded with no data"
        case .unableToDecode:
            return "the server responded with bad data"
        }
    }
}
