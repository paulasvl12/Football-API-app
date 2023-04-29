//
//  ViewController.swift
//  soccerApp
//
//  Created by Paula Viloria on 3/26/23.
//

import UIKit
import SwiftUI

//General
var titleLabelText = ""
var firstLabel = ""
var secondLabel = ""
 //Fixtures
var homeTeamName = ""
var awayTeamName = ""
//Stats
 var formLegend = ""
//Top Scorers
var topScorers = [String]()

class ViewController: UIViewController{

    var teams: [String] = [];
    var options: [String] = [];
    var players: [String] = [];
    var apiManager = APIManager()
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
   
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var holderLabelOne: UILabel!
    @IBOutlet weak var holderLabelTwo: UILabel!
    
    //Fixtures
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    //Stats
    @IBOutlet weak var formLegendLabel: UILabel!
    
    
    let mapTeamId = [
        "Real Madrid 🇪🇸" : 541,
        "FC Barcelona 🇪🇸" : 529,
        "Inter Milan 🇮🇹" : 505,
        "Bayern Munich 🇩🇪" : 157,
        "Borussia Dortmund 🇩🇪" : 165,
        "Chelsea FC 🏴󠁧󠁢󠁥󠁮󠁧󠁿" : 49,
        "Liverpool 🏴󠁧󠁢󠁥󠁮󠁧󠁿" : 40,
        "Manchester United 🏴󠁧󠁢󠁥󠁮󠁧󠁿" : 33
    ]
    let mapLeagueId = [
        "Real Madrid 🇪🇸" : 140,
        "FC Barcelona 🇪🇸" : 140,
        "Inter Milan 🇮🇹" : 135,
        "Bayern Munich 🇩🇪" : 529,
        "Borussia Dortmund 🇩🇪" : 529,
        "Chelsea FC 🏴󠁧󠁢󠁥󠁮󠁧󠁿" : 39,
        "Liverpool 🏴󠁧󠁢󠁥󠁮󠁧󠁿" : 39,
        "Manchester United 🏴󠁧󠁢󠁥󠁮󠁧󠁿" : 39
    ]
    let mapOptions = [
        "Fixtures": "fixtures",
        "Top Scorers": "players/topscorers",
        "Statistics": "teams/statistics"
    ]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        teams = ["Real Madrid 🇪🇸", "FC Barcelona 🇪🇸", "Inter Milan 🇮🇹", "Bayern Munich 🇩🇪", "Borussia Dortmund 🇩🇪", "Chelsea FC 🏴󠁧󠁢󠁥󠁮󠁧󠁿", "Liverpool 🏴󠁧󠁢󠁥󠁮󠁧󠁿", "Manchester United 🏴󠁧󠁢󠁥󠁮󠁧󠁿"]
        options = ["Fixtures", "Top Scorers", "Statistics"]
        self.picker?.delegate = self
        self.picker?.dataSource = self
        self.titleLabel?.text = titleLabelText
        self.holderLabelOne?.text = firstLabel
        self.holderLabelTwo?.text = secondLabel
        self.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.formLegendLabel?.text = formLegend
        self.homeTeamNameLabel?.text = homeTeamName
        self.awayTeamNameLabel?.text = awayTeamName
        self.holderLabelOne?.numberOfLines = 0
        self.awayTeamNameLabel?.numberOfLines = 0
    }
    @IBAction func doneButton(_ sender: Any) {
        let team : Int? = mapTeamId[teams[picker.selectedRow(inComponent: 0)]]
        let league : Int? = mapLeagueId[teams[picker.selectedRow(inComponent: 0)]]
        let option: String? = mapOptions[String(options[picker.selectedRow(inComponent: 1)])]
        
        if(option == "fixtures"){
            titleLabelText = "Most Recent Fixture"
            firstLabel = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)[0]
            secondLabel = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)[1]
            homeTeamName = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)[2]
            awayTeamName = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)[3]
        } else if(option == "teams/statistics"){
            titleLabelText = "Stats this Season"
            firstLabel = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)[0]
           
            secondLabel = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)[1]
            formLegend = "W: Win, D: Draw, L: Loss"
            awayTeamName = "Clean Sheets this Season"
                            
        } else if(option == "players/topscorers"){
            titleLabelText = "Top Scorers in the League"
           topScorers = apiManager.callAPIWithSelectedCombination(team: team!, option: option!, league: league!)
            if(topScorers.count == 0){
                firstLabel = "No Top Scorers in this League"
            } else {
                firstLabel = topScorers[0]
                secondLabel = topScorers[1]
                homeTeamName = topScorers[2]
                awayTeamName = topScorers[3]
            }
          
           
        }
    }

    //Resetting all of the values when user moves from one page to another
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent{
           apiManager.resetArray()
            titleLabelText = ""
            firstLabel = ""
            secondLabel = ""
            homeTeamName = ""
            awayTeamName = ""
            formLegend = ""
            topScorers = [String]()
            
        }
    }
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return teams.count;
        }
        else {
            return options.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            teamLabel.text = teams[row]
            return teams[row];
        }
        else {
            optionsLabel.text = options[row]
            return options[row];
        }
    }

}

