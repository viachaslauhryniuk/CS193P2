//
//  Theme.swift
//  CS193P2
//
//  Created by Слава Гринюк on 21.04.24.
//

import Foundation

struct ThemeChoice {
    private static var themes = [Theme(name: "Future", emoji: ["👾","🤖","👽","⚙️","🔮","🧬","🕹️","💾"], colors: ["purple"]), Theme(name: "Animals", emoji: ["🐶","🐱","🐹","🐼","🐸", "🦆"], colors: ["brown"]), Theme(name: "Fruit", emoji: ["🍏","🍎", "🥑","🍌","🍒","🥭","🍇", "🥥","🍋","🍓"], numbersOfPairs: 10, randomNumberOfPairs: true, colors: ["orange", "purple"]), Theme(name: "Sport", emoji: ["⚽️", "🏀", "🏈","⚾️","🥎","🏉"], colors: ["black", "white"]), Theme(name: "Cars", emoji: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🛻"], colors: ["yellow"]), Theme(name: "Hearts", emoji: ["🩷","❤️","🧡","💚","🩵","💙"], colors: ["pink"] )]
    
    mutating func addTheme(theme: Theme) {
        ThemeChoice.themes.append(theme)
    }
    
    mutating func chooseTheme() -> Theme? {
        var randTheme = ThemeChoice.themes.randomElement()!
        if randTheme.randomNumberOfPairs {
            randTheme.numbersOfPairs = Int.random(in: 2...10)
        }
        if randTheme.numbersOfPairs > randTheme.emoji.count || randTheme.numbersOfPairs < 2 {
            return nil
        }
        randTheme.emoji.shuffle()
        return randTheme
    }
    
    struct Theme {
        let name: String
        var emoji: [String]
        var numbersOfPairs: Int
        let color: String
        let randomNumberOfPairs: Bool
        init(name: String, emoji: [String], numbersOfPairs: Int, randomNumberOfPairs: Bool, colors: [String]) {
            self.name = name
            self.emoji = emoji
            self.numbersOfPairs = numbersOfPairs
            self.randomNumberOfPairs = randomNumberOfPairs
            self.color = colors.count > 1 ? colors.joined(separator: " ") : colors.first!
        }
        init(name: String, emoji: [String], colors: [String]) {
            self.init(name: name, emoji: emoji, numbersOfPairs: emoji.count, randomNumberOfPairs: false, colors: colors )
        }
        
    }
}

