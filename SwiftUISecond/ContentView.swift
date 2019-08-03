//
//  ContentView.swift
//  SwiftUISecond
//
//

import SwiftUI

struct ContentView : View {
    @State private var things = ["bamboo", "cat", "eyes", "flame", "glass", "mustache", "rainbow", "scratch", "star", "teeth"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // Want this score property to be managed and persistent outside struct by SwiftUI
    // mark it private so that only the current ContentView can access to this.
    @State private var score = 0
    
    @State private var alertTile = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var continueMsg = "continue"
    
    var body: some View {
        NavigationView{
            VStack{
                ForEach (0...2){
                    number in
                    Image(self.things[number])
                        .border(Color.black, width: 1)
                        .tapAction {
                            self.flagTapped(number)
                    }
                }
            }
            .navigationBarTitle(Text(things[correctAnswer].uppercased()))
                .presentation($showAlert) // Binding alert with "$"
                {
                    Alert(title: Text(alertTile), message: Text(alertMessage), dismissButton: .default(Text(continueMsg)){
                            // completion closure when Alert's continune button is clicked
                            self.askQuestion()
                        })
            }
        }
    }
    
    func flagTapped(_ tap: Int){
        if tap == correctAnswer {
            // correct answer
            score += 1
            alertTile = "Correct"
        }
        else {
            // wrong answer
            score -= 1
            alertTile = "Wrong"
        }
        alertMessage = "Your score is \(score)"
        showAlert = true
    }
    
    func askQuestion() {
        things = things.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
