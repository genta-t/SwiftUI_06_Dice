//
//  ContentView.swift
//  Dice
//
//  Created by 田之脇絃太 on 2023/02/16.
//

import SwiftUI

struct ContentView: View {
    @State private var randomNumber = 1
    @State private var timer: Timer?
    @State private var isRolling = false
    @State var isShowThirdView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
                    .padding()
                NavigationLink(destination: SecondView().navigationTitle("画面2")) {
                    Text("SecondViewへ")
                }
                Button(action: {
                    isShowThirdView = true
                }) {
                    Text("モーダル遷移")
                        .padding()
                }
                .sheet(isPresented: $isShowThirdView) {
                    ThridView()
                }
                
                Spacer()
                Image(systemName: "die.face.\(randomNumber)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/2)
                    .padding()
                Spacer()
                Button(action: {
                    playDice()
                }) {
                    Text("サイコロを振る")
                        .padding()
                        .background(.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .disabled(isRolling)
                Spacer()
            }
            .padding()
            .navigationTitle("画面1")
        }
    }
    
    private func playDice() {
        print("ボタンが押されたよ")
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
            randomNumber = Int.random(in: 1...6)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            timer?.invalidate()
            timer = nil
            isRolling = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
