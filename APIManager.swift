//
//  APIManager.swift
//  soccerApp
//
//  Created by Paula Viloria on 4/26/23.
//

import Foundation

var responseArray = [String]()
var requestString = ""

struct APIManager {

    
    func callAPIWithSelectedCombination(team: Int, option:String, league: Int) -> [String]{
        var semaphore = DispatchSemaphore (value: 0)
        if(option == "fixtures" || option == "teams/statistics"){
            requestString = "https://v3.football.api-sports.io/" + option + "?season=2020&team=" + String(team) + "&league=" + String(league)
        } else {
            requestString = "https://v3.football.api-sports.io/players/topscorers?season=2020&league=" + String(league)
        }

        var request = URLRequest(url: URL(string: requestString)!)
        request.addValue("0c37b56adf9cc74824e1be35e36a577c", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
  
            if(option == "fixtures"){
                fixturesJSON(data: data)
            } else if(option == "players/topscorers"){
                topScorersJSON(data: data)
            }
            else if(option == "teams/statistics"){
                statsJSON(data: data)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return responseArray
    }
   
    func fixturesJSON(data: Data) -> [String]{
        let decodedResponse = try? JSONDecoder().decode(Fixtures.self, from: data)
        responseArray.append(String(decodedResponse!.response[0].goals.home))
        responseArray.append(String(decodedResponse!.response[0].goals.away))
        responseArray.append(decodedResponse!.response[0].teams.home.name)
        responseArray.append(decodedResponse!.response[0].teams.away.name)
        return responseArray
    }
    
    func statsJSON(data: Data) -> [String]{
        let decodedResponse = try? JSONDecoder().decode(Statistics.self, from: data)
         responseArray.append(String(decodedResponse!.response.form))
         responseArray.append(String(decodedResponse!.response.clean_sheet.total))
        return responseArray
    }
    
    func topScorersJSON(data: Data) -> [String]{
        let decodedResponse = try? JSONDecoder().decode(TopScorers.self, from: data)
        for topscorer in decodedResponse!.response {
            responseArray.append(topscorer.player.name)
        }
        return responseArray
    }

    func resetArray(){
        responseArray = []
    }
}
