//
//  ContentView.swift
//  Loom
//
//  Created by Lorenzo Pizzuto on 16/12/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                // Titolo principale
                VStack(spacing: 10) {
                    Text("Welcome to Loom")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.red)

                    Text("Where places, music, and memories come together")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 100)

                Spacer()

                // Sezione dei punti salienti
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .top, spacing: 20) {
                        Image(systemName: "map")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Add locations, pair them with your favorite songs, and create unforgettable memories.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    HStack(alignment: .top, spacing: 20) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Let music bring your most cherished moments back to life.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    HStack(alignment: .top, spacing: 20) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Turn every saved spot into a masterpiece with your own touch of creativity.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 30)

                Spacer()

                // Pulsante "Continue"
                NavigationLink(destination: ContentView()
                    .navigationBarBackButtonHidden(true) // Nasconde il pulsante back
                ) {
                    Text("Continue")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color.red)
                        .cornerRadius(15)
                        .padding(.horizontal, 50)
                }

                Spacer()
            }
            .background(Color(.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
