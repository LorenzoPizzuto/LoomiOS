//
//  MainView.swift
//  Loom
//
//  Created by Lorenzo Pizzuto on 16/12/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var showSheet = true // La sheet è visibile di default
    @State private var navigateToSettings = false // Per gestire la navigazione
    
    var body: some View {
        NavigationView {
            ZStack {
                // Map View
                Map(coordinateRegion: $region)
                    .ignoresSafeArea()

                VStack {
                    // Search Bar (centrata)
                    HStack {
                        Spacer()
                        Text("Search your place…")
                            .font(.custom("SFPro-Regular", size: 14))
                            .foregroundColor(Color(red: 214 / 255, green: 25 / 255, blue: 14 / 255, opacity: 0.7))
                            .frame(width: 180, height: 40)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.3)
                            )
                        Spacer()
                    }
                    .padding(.top, 10)

                    Spacer()

                    HStack {
                        // Colonna sinistra
                        VStack(spacing: 15) {
                            Button(action: {
                                showSheet = false // Nascondi la sheet
                                navigateToSettings = true // Naviga alla SettingsView
                            }) {
                                Image(systemName: "gear")
                                    .font(.system(size: 20))
                                    .foregroundColor(.red)
                                    .frame(width: 45, height: 45)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.3))
                            }

                            Button(action: {}) {
                                Image(systemName: "chevron.down.2")
                                    .font(.system(size: 20))
                                    .foregroundColor(.red)
                                    .frame(width: 45, height: 45)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.3))
                            }

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, -50)

                        Spacer()

                        // Colonna destra
                        VStack(spacing: 15) {
                            Button(action: {}) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 20))
                                    .foregroundColor(.red)
                                    .frame(width: 45, height: 45)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.3))
                            }

                            Button(action: {}) {
                                Text("+")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .frame(width: 45, height: 45)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.3))
                            }

                            Button(action: {}) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.red)
                                    .frame(width: 45, height: 45)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.3))
                            }

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 20)
                        .padding(.top, -50)
                    }
                    .padding(.bottom, 50)
                }
            }
            // Sheet
            .sheet(isPresented: $showSheet) {
                VStack {
                    Spacer()
                    Text("Sheet Content")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                .presentationDetents([.height(80), .large]) // Altezza minima 80, espandibile
                .presentationDragIndicator(.visible) // Mostra l'indicatore di drag
                .interactiveDismissDisabled(true) // Impedisce la chiusura
                .presentationBackgroundInteraction(.enabled) // Permette di trascinare
                .presentationBackground(Color.white) // Rimuove oscuramento di default
            }
            .background(
                NavigationLink("", destination: SettingsView(), isActive: $navigateToSettings)
                    .hidden() // Nascondiamo il NavigationLink
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
