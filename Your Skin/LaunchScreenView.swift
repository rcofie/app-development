//
//  LaunchScreenView.swift
//  Your Skin
//
//  Created by Rebecca Cofie on 30/10/2022.
//

import SwiftUI

 struct CustomBlue {
    static let blue = Color("GradientBlue")
}

struct LaunchScreenView: View {
    @State private var isActive = false // initial state of launch screen is false
   
    var body: some View {
        if isActive {
            ProgressView()
        } else {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color.white, CustomBlue.blue]), center: .center, startRadius: 1, endRadius: 100).ignoresSafeArea()
                Text("Your Skin")
                    .font(Font.custom("RobotoMono-Regular", size: 47))
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
        
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
