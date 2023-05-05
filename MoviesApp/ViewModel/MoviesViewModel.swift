//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Kenya Alvarez on 03/05/23.
//

import Foundation

@MainActor
class MovieViewModel : ObservableObject{
    
    @Published var dataMovies : [Result] = []
    @Published var titulo = ""
    @Published var movieid = 0
    @Published var show = false
    @Published var key = ""
    
    func fetch (movie : String) async{
        do{
            let urlString = "https://api.themoviedb.org/3/search/movie?api_key=e3adf98ad312650f0f768174ad4a204f&language=en-US&query=\(movie)&page=1&include_adult=false"
            
            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") else {return}
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONDecoder().decode(Movies.self, from: data)
            self.dataMovies = json.results
            print(json.results)
        }catch let error as NSError{
            print("Error en la api:", error.localizedDescription)
        }
    }
    
    func fetchVideo () async{
        do{
            let urlString = "https://api.themoviedb.org/3/movie/\(movieid)/videos?api_key=e3adf98ad312650f0f768174ad4a204f&language=en-US"
            
            guard let url = URL(string: urlString) else {return}
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONDecoder().decode(VideoModel.self, from: data)
            let res = json.results.filter({$0.type.contains("Trailer")})
            self.key = res.first?.key ?? ""
        }catch let error as NSError{
            print("Error en la api:", error.localizedDescription)
        }
    }
    func sendItem(item: Result){
        titulo = item.original_title
        movieid = item.id
        show.toggle()
    }
}
