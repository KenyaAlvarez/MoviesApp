//
//  MovieView.swift
//  MoviesApp
//
//  Created by Kenya Alvarez on 03/05/23.
//

import SwiftUI

struct MovieView: View {
    
    var movie : String
    @StateObject var movies = MovieViewModel()
    
  
    
    var body: some View {
        VStack{
            List{
                ForEach(movies.dataMovies){item in
                    CardView(poster: item.poster_path ?? "", title: item.original_title, overview: item.overview){
                        movies.sendItem(item: item)
                    }
                    .sheet(isPresented: $movies.show){
                       TrailerView(movies: movies)
                    }
                }
            }
        }.navigationTitle(movie)
        .task {
            await movies.fetch(movie: movie)
        }
    }
}

struct CardView : View{
    
    var poster : String
    var title : String
    var overview : String
    var action : () -> Void
    
    var body: some View{
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(poster)")){ image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 5)
            }placeholder: {
                Image("no_poster")
            }
            Text(title)
                .font(.title)
            Text(overview)
                .foregroundColor(.gray)
        }.padding(.all)
            .onTapGesture {
                action()
            }
    }
}

