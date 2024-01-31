//
//  ContentView.swift
//  CalculatorApp03
//
//  Created by Beatriz Enríquez on 30/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.3), .yellow.opacity(0.2)]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            KeyView()
        }
    }
}

#Preview {
    ContentView()
}
