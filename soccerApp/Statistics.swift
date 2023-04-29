//
//  Statistics.swift
//  soccerApp
//
//  Created by Paula Viloria on 4/9/23.
//

import Foundation

struct Statistics : Codable {
    var response: Response
}
struct Response : Codable {
    var form: String
    var biggest: Biggest
    var clean_sheet: Clean_Sheet
}

struct Clean_Sheet: Codable {
    var home : Int
    var away: Int
    var total: Int
}
struct Biggest: Codable {
    var streak: Streak
}
struct Streak: Codable {
    var wins: Int
    var draws: Int
    var loses: Int
}


