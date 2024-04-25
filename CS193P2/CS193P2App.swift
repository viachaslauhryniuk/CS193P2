//
//  CS193P2App.swift
//  CS193P2
//
//  Created by Слава Гринюк on 21.04.24.
//

import SwiftUI

@main
struct CS193P2App: App {
    @StateObject var vm = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: vm)
        }
    }
}
