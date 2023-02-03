//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anthony Mugasa Jr on 02/02/2023.

import SwiftUI

struct ContentView: View {
    @State private var showingOutcome = false;
    @State private var gameResult = ""
    @State private var gameOver = false
    @State private var gameRounds = 0
    @State private var gameScore = 0
    @State private var gameSlots = ["Rock","Paper","Scissors"]
    @State private var gameOption = ["Rock","Paper","Scissors"].randomElement()
    @State private var winOrLose = Int.random(in: 0...1)
    private var plays = 3
    private var gameDecision:String{
        winOrLose > 0 ? "Win":"Lose"
    }
    var body: some View {
        VStack{
            VStack {
                Text("Rock Paper Scissors Game")
                    .font(.system(size: 30))
                    .foregroundColor(.accentColor)
                
                Text("You are playing to \(gameDecision)")
                    .font(.system(size: 25))
                    .fontDesign(.monospaced)
                    .foregroundColor(winOrLose > 0 ? .white:.yellow)
                    .background(winOrLose > 0 ? .green : .red)
                    .clipShape(Capsule())
                Spacer()
                ForEach(0..<3){ number in
                    Image(gameSlots[number])
                        .resizable()
                        .frame(width:200,height:200)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .onTapGesture {
                         gameOutcomes(gameSlots[number])
                        }
                }
                Spacer()
            }
            .alert(gameResult,isPresented: $showingOutcome){
                gameRounds == plays ? Button("Final score is \(gameScore) out of \(plays) : Play again", action:resetGame) :Button("continue", action:continuePlaying)
            }
           
        }
        .frame(maxWidth:.infinity)
        .padding(.vertical , 20)
        .background(.ellipticalGradient(colors: [.teal,.secondary,.teal,.white]))
        .clipShape(RoundedRectangle(cornerRadius: 20))
            
       
        
        
    }
    func continuePlaying(){
        gameOption = gameSlots.randomElement()
        winOrLose = Int.random(in: 0...1)
    }
    func resetGame(){
        gameRounds = 0
        gameScore = 0
        gameOption = gameSlots.randomElement()
        winOrLose = Int.random(in: 0...1)
    }
    
    func shoot(_ myHand:String, _ winningPlay:String){
        if myHand == winningPlay{
            
            showingOutcome = true
            gameRounds += 1
            gameScore += 1
            if gameRounds == plays{
                gameResult = "Game Over"
                
                if gameScore >= 0{
                    
                }else{
                    gameScore = 0
                }
            }else{
               gameResult = "You Win"
                
                if gameScore >= 0{
                    
                }else{
                    gameScore = 0
                }
            }
        }else{
            showingOutcome = true
            gameRounds += 1
            gameScore -= 1
            
            if gameRounds == plays{
                gameResult = "Game Over"
                
                if gameScore >= 0{
                    
                }else{
                    gameScore = 0
                }
            }else{
               gameResult = "You Lose"
                
                if gameScore >= 0{
                    
                }else{
                    gameScore = 0
                }
            }
        }
    }
    func gameOutcomes(_ playerOption:String){
       
        if winOrLose == 1 && gameOption ?? "n/a" == "Rock"{
           //play Scissors
            shoot(playerOption, "Scissors")
        }
        else if winOrLose == 0 && gameOption ?? "n/a" == "Rock"{
            //play Paper
            shoot(playerOption, "Paper")
        }
        else if winOrLose == 1 && gameOption ?? "n/a" == "Paper"{
            //play Rock
            shoot(playerOption, "Rock")
           
        }
        else if winOrLose == 0 && gameOption ?? "n/a" == "Paper"{
            //play Scissors
            shoot(playerOption, "Scissors")
            
        }
        else if winOrLose == 1 && gameOption ?? "n/a" == "Scissors"{
            //play Paper
           shoot(playerOption, "Paper")
           
        }
        else if winOrLose == 0 && gameOption ?? "n/a" == "Scissors"{
            //play Rock
            shoot(playerOption, "Rock")
        }
        else{
            //Does not count
            gameResult = "Its a tie"
            showingOutcome = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
