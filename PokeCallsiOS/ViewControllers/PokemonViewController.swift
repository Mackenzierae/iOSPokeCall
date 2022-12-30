//
//  PokemonViewController.swift
//  PokeCallsiOS
//
//  Created by Mackenzie Wacker on 12/29/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Methods
    func fetchSpriteAndUpdateViews(pokemon: Pokemon) {
        PokemonController.fetchSprite(pokemon: pokemon) { (result) in
            DispatchQueue.main.async { // UI on main thread
                
                switch result {
                    
                case .success(let spriteImage):
                    self.pokeImageView.image = spriteImage
                    self.pokeNameLabel.text = pokemon.name
                    self.pokeIDLabel.text = String(pokemon.id)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
} // End of Class

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchterm: searchTerm) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
} // End of Extension
