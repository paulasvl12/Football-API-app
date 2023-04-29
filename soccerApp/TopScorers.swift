//
//  TopScorers.swift
//  soccerApp
//
//  Created by Paula Viloria on 4/9/23.
//

import Foundation

struct TopScorers : Codable {
    var response: [TopScorer]
}

struct TopScorer : Codable {
    var player: Player
    
}
struct Player : Codable {
    var name: String
}
