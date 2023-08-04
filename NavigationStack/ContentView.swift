//
//  ContentView.swift
//  NavigationStack
//
//  Created by Lucas Santana Brito on 20/06/23.
//

import SwiftUI

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
    let games: [Game]
}

struct Game: Hashable {
    let name: String
    let rating: String
}

struct ContentView: View {
    
    let platforms: [Platform] = [
        .init(
            name: "Xbox",
            imageName: "xbox.logo",
            color: .green,
            games: [
                .init(name: "Manecraft AAAA", rating: "99"),
                .init(name: "God of War AAAA", rating: "98"),
                .init(name: "Fortnite AAAA", rating: "92"),
                .init(name: "Madden AAAA", rating: "88")
            ]
        ),
        .init(
            name: "Playstation",
            imageName: "playstation.logo",
            color: .indigo,
            games: [
                .init(name: "Manecraft BBBB", rating: "99"),
                .init(name: "God of War BBBB", rating: "98"),
                .init(name: "Fortnite BBBB", rating: "92"),
                .init(name: "Madden BBBB", rating: "88")
            ]
        ),
        .init(
            name: "PC",
            imageName: "pc",
            color: .pink,
            games: [
                .init(name: "Manecraft CCCC", rating: "99"),
                .init(name: "God of War CCCC", rating: "98"),
                .init(name: "Fortnite CCCC", rating: "92"),
                .init(name: "Madden CCCC", rating: "88")
            ]
        ),
        .init(
            name: "Mobile",
            imageName: "iphone",
            color: .mint,
            games: [
                .init(name: "Manecraft DDDD", rating: "99"),
                .init(name: "God of War DDDD", rating: "98"),
                .init(name: "Fortnite DDDD", rating: "92"),
                .init(name: "Madden DDDD", rating: "88")
            ]
        )
    ]
    
    let games: [Game] = [
        .init(name: "Manecraft", rating: "99"),
        .init(name: "God of War", rating: "98"),
        .init(name: "Fortnite", rating: "92"),
        .init(name: "Madden", rating: "88")
    ]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Platforms") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    
                    VStack {
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        
                        List {
                            ForEach(platform.games, id: \.name) { game in
                                NavigationLink(value: game) {
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle).bold()
                    
                    Button("Recomended Game") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go to another platform") {
                        path.append(platforms.randomElement()!)
                    }
                    
                    Button("Go home") {
                        print(path.count)
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
