//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Eshan Singh on 03/06/22.
//

import SwiftUI

struct ContentView: View {
    @State var moves = ["rock","paper","scissors"]
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var computerMove = "ra"
    @State private var alertShow = false
    @State private var finalAlert = false
    @State private var count = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.blue,.red]), startPoint: .bottom, endPoint:.topLeading).ignoresSafeArea()
            VStack(spacing:-5){
            Text("Rock Paper and Scissors").bold().font(.title).foregroundColor(.yellow).shadow(color: .cyan, radius: 0.5, x: 0.4, y: 0.5).shadow(color: .red, radius:6, x: 1, y: 2).font(.largeTitle)
                Text("Computer's Move:").font(.largeTitle.weight(.bold)).foregroundColor(.orange);         Image(computerMove).resizable().padding().shadow(color: .red, radius: 1, x: 3, y: 3)
            HStack{
            ForEach(moves, id: \.self){ move in
                Button(action: {
                    buttonTap(move)
                }, label: {
                    currentMove.init(image: move)
                })
                
            }
            }
            
        }.padding().padding()
        }.ignoresSafeArea()
            .alert(scoreTitle, isPresented: $alertShow) {
                Button("Continue",action: resetScreen)
            } message: {
                Text("Make a Move")
            }
            .alert(scoreTitle, isPresented: $finalAlert) {
                Button("Continue",action: resetScreen)
            } message: {
                Text("Your score is \(score)")
            }
    }
    func buttonTap(_ move:String){
        count = count + 1
        computerMove = moves.shuffled().randomElement() ?? "ra"
        if(computerMove == move){
            scoreTitle = "Draw"
        }
        else if(computerMove == "rock" && move == "paper"){
            scoreTitle = "User Wins"
            score = score + 1
        }
        else if(computerMove == "paper" && move == "scissors"){
            scoreTitle = "User Wins"
            score = score + 1
        }
        else if(computerMove == "scissors" && move == "stone"){
            scoreTitle = "User Wins"
            score = score + 1
        }
        else{
            scoreTitle = "Computer Wins"
            score = score - 1
        }
        alertShow = true
    }
    func resetScreen(){
        computerMove = "ra"
        if(count==10){
            scoreTitle = "Finally"
            finalAlert = true
            alertShow = false
        }
    }
}

struct currentMove: View{
    var image:String
    var body: some View{
        Image(image).resizable().renderingMode(.original).aspectRatio(contentMode: .fit).clipShape(Capsule()).shadow(color:.blue, radius: 4, x: 3, y: 3)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
