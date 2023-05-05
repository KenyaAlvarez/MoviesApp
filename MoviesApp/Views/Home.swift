//
//  Home.swift
//  MoviesApp
//
//  Created by Kenya Alvarez on 03/05/23.
//

import SwiftUI

struct Home: View {
    @State private var search = ""
    @State private var buscar = false

    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                   TextField("Search", text: $search)
                        .textFieldStyle(.roundedBorder)
                        .padding(.top, 15)
                        .padding(.bottom, 22)
                        .onAppear{
                            search = ""
                        }
                    
                    Button{
                        buscar.toggle()
                    } label: {
                        Text("Search")
                            .font(.title2)
                            .bold()
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    Spacer()
                    
                    .navigationDestination(isPresented: $buscar){
                        MovieView(movie: search)
                    }
                }.padding(.all)
                    .navigationTitle("App movie search")
            }
        }
    }
}

