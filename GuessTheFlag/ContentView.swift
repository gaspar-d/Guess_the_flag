//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Diogo Gaspar on 19/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var showingScore = false

    @State private var scoreTitle = ""
    @State private var scorePoints = 0
    @State private var clickedFlag = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top , endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach(0 ..< 3) {country in
                    Button(action: {
                        flagTapped(country)
                    }) {
                        //   MARK: Image
                        Image(countries[country])
                            .renderingMode(
                                .original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 4)
                        
                    }
                }
                Text("Your score is: \(scorePoints) points")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("\(scoreTitle == "Correct" ?  "Congrats!" : "That's the flag of \(countries[clickedFlag])")").font(.largeTitle) , dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scorePoints += 1
        } else {
            scoreTitle = "Wrong"
            scorePoints -= 1
            clickedFlag = number
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
