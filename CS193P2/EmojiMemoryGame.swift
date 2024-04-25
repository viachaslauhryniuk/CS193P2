//
//  EmojiMemoryGame.swift
//  CS193P2
//
//  Created by Слава Гринюк on 21.04.24.
//

import Foundation
import SwiftUI
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    typealias Theme = ThemeChoice.Theme
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numbersOfPairs) { pairIndex in theme.emoji[pairIndex]}
    }
    @Published private var model: MemoryGame<String> = createMemoryGame(theme: Theme(name: "error", emoji: [""], colors: ["black"]))
    @Published private var theme: ThemeChoice = ThemeChoice()
    @Published private(set) var gradientColors: [Color] = []
    @Published private(set) var score = 0
    @Published private(set) var chosenTheme: Theme = Theme(name: "error", emoji: [""], colors: ["black"])
    
    var cards: Array<Card> {
           return model.cards
    }
       
       // MARK: - Intent(s)
        
    func choose(_ card: Card) {
        model.choose(card)
    }
       
    func shuffle() {
        model.shuffle()
    }
       
    func startGame() {
        chosenTheme = theme.chooseTheme() ?? Theme(name: "error", emoji: [""], colors: ["black"])
        score = 0
        if chosenTheme.color.contains(" "){
            let gradientColors = chosenTheme.color.components(separatedBy: " ")
            extractGradient(gradientColors)
        }
        model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
    }
    
    func extractGradient(_ colors: [String]) {
        gradientColors = []
        for color in colors {
            self.gradientColors.append(Color(wordName: color)!)
        }
    }
    
    func getScore() {
        score = model.score
    }
    
}
extension Color {
        init?(wordName: String) {
                switch wordName {
                case "clear":       self = .clear
                case "black":       self = .black
                case "brown":       self = .brown
                case "white":       self = .white
                case "gray":        self = .gray
                case "red":         self = .red
                case "green":       self = .green
                case "blue":        self = .blue
                case "orange":      self = .orange
                case "yellow":      self = .yellow
                case "pink":        self = .pink
                case "purple":      self = .purple
                case "primary":     self = .primary
                case "secondary":   self = .secondary
                default:            return nil
                }
        }
    
}
