//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Michele Galvagno on 13/10/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        /// Four built-in shapes in Swift: rectangle, rounded rectangle, circle, capsule
                        /// To draw a border around an image, use the `overlay()` modifier
                        
                        /// Commented out for Project 3 challenge 3
//                        Image(self.countries[number])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                            .shadow(color: .black, radius: 2)
                        FlagImage(name: self.countries[number])
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.heavy)
                    .shadow(color: .yellow, radius: 4)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)!"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!\nThat's the flag of \(countries[number])!"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
