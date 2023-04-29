//
//  Fixtures.swift
//  soccerApp
//
//  Created by Paula Viloria on 4/9/23.
//

import Foundation


struct Fixtures : Codable {
    var response: [ResponseFixture]
}

struct ResponseFixture : Codable {
    // array of fixtures [Fixtures] instead?
    var teams: Teams
    var goals: Goals
}

struct Teams: Codable {
    var home: Home
    var away: Away
}

struct Home: Codable {
    var name: String

}
struct Away: Codable {
    var name: String

}
 

struct Goals : Codable {
    var home: Int
    var away: Int
}
