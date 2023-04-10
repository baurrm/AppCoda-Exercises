//
//  ContentView.swift
//  HelloWorld
//
//  Created by Bauyrzhan Marat on 10.04.2023.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        VStack {
//            New Button
            Button {
                speak(text: "Happy programming")
            } label: {
                Text("Happy programming")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(.yellow)
            .cornerRadius(20)

//            HelloWorld Button
            Button {
    //            What to perform
                speak(text: "Hello World")
            } label: {
    //            How the button looks like
                Text("Hello World")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(.purple)
            .cornerRadius(20)
        }
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
