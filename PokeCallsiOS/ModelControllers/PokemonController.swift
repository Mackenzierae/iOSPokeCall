//
//  PokemonController.swift
//  PokeCallsiOS
//
//  Created by Mackenzie Wacker on 12/27/22.
//

import UIKit

//https://pokeapi.co/
class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEndpoint = "pokemon"
    
    static func fetchPokemon(searchterm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        // 1 - URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndpoint)
        let searchtermURL = pokemonURL.appendingPathComponent(searchterm.lowercased())
        print(searchtermURL)
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: searchtermURL) { data, res, error in
            // 3 - Error Handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Check for Data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Decode Data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
                
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
    }
    
    
    static func fetchSprite(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        //1 - URL
        let spriteURL = pokemon.sprites.classicSpriteURL
        
        //2 - Data Task
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            //3 - error handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            //4 - Check for Data
            guard let data = data else { return completion(.failure(.noData))}
            
            //5 - decode data
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            return completion(.success(sprite))
            
        } .resume()
    }
    
    
} // End Controller
