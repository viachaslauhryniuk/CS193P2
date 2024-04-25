//
//  ContentView.swift
//  CS193P2
//
//  Created by Слава Гринюк on 21.04.24.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            Text(viewModel.chosenTheme.name)
                .font(.largeTitle)
                .foregroundStyle(Color(wordName: viewModel.chosenTheme.color) ?? .black)
            Text("Your score: \(viewModel.score)")
                .font(.system(size: 20))
            ScrollView{
                cards
            }
            playButton
        }
        .onAppear(perform: viewModel.startGame)
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive (minimum: 75))]) {
            ForEach(viewModel.cards) { card in
                CardView(card).environmentObject(viewModel)
                    .aspectRatio (2/3,contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                        viewModel.getScore()
                    }
            }
        }
    }
    
    var playButton: some View {
        Button {
            withAnimation(.bouncy) {
                viewModel.startGame()
            }
        } 
        label: {
            Image(systemName: "play.fill")
                .imageScale(.large)
                .font(.largeTitle)
                .frame(width: 100, height: 75)
                .foregroundStyle(Color(wordName: viewModel.chosenTheme.color) ?? .black)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(Color(wordName: viewModel.chosenTheme.color) ?? .black)
                        .opacity(0.2)
                }
        }
    }
}


struct CardView: View {
    @EnvironmentObject var viewModel: EmojiMemoryGame
    let card: MemoryGame<String>.Card
    init (_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack {
            let base = RoundedRectangle (cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(Color(wordName: viewModel.chosenTheme.color) ?? .black,lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor (0.01)
                    .aspectRatio(contentMode:.fit)
            }
            .opacity (card.isFaceUp ? 1 : 0)
            base.fill(viewModel.chosenTheme.color.contains(" ") ? Gradient(colors: viewModel.gradientColors) : Gradient(colors: [Color(wordName: viewModel.chosenTheme.color) ?? .clear]))
                .opacity (card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
