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
    @State private var showSheet = true // The sheet is visible by default
    @State private var categorySelection = "Select Category" // Default Category
    @State private var rating = 0 // Rating value
    @State private var selectedMonth = "December" // Month for the calendar
    @State private var memories: [String] = [] // For photos
    @State private var music: [String] = [] // For music

    var body: some View {
        ZStack {
            // Map View
            Map(coordinateRegion: $region)
                .ignoresSafeArea()

            VStack {
                // Search Bar (Centered)
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
                    // Left Column
                    VStack(spacing: 15) {
                        Button(action: {}) {
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

                    // Right Column
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
        // Customizable sheet
        .sheet(isPresented: $showSheet) {
            VStack {
                // 1. Circle with + for uploading an image
                HStack {
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .stroke(Color.red, lineWidth: 4)
                                .frame(width: 70, height: 70)
                            Text("+")
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                        }
                    }
                    
                    // 2. Title TextField and Pencil Icon
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("Enter title", text: .constant("Arenile di bagnoli"))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.red)
                                .padding(.leading, 10)
                        }
                        
                        // 3. Category with dropdown
                        HStack {
                            Text("Category")
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                // Category selection action (show menu)
                            }) {
                                HStack {
                                    Text(categorySelection)
                                        .foregroundColor(.gray)
                                    
                                    Image(systemName: "arrow.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            }
                        }
                    }
                    .padding(.leading, 20)
                }
                .padding(.top, 10)

                // 4. Memories Section
                Text("Memories")
                    .font(.headline)
                    .padding(.top, 20)
                
                // Add rectangles for photos
                ForEach(memories, id: \.self) { memory in
                    HStack {
                        Rectangle()
                            .frame(height: 100)
                            .overlay(Text("+").foregroundColor(.red))
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
                
                // Button to add more memories (photos)
                Button(action: {
                    memories.append("New Memory")
                }) {
                    Text("Add Memory")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                // 5. Music Section
                Text("Music")
                    .font(.headline)
                    .padding(.top, 20)
                
                // Add rectangles for music
                ForEach(music, id: \.self) { song in
                    HStack {
                        Rectangle()
                            .frame(height: 50)
                            .overlay(Text("+").foregroundColor(.red))
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
                
                // Button to add more music
                Button(action: {
                    music.append("New Song")
                }) {
                    Text("Add Music")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                // 6. Description Section
                Text("Description")
                    .font(.headline)
                    .padding(.top, 20)
                
                TextField("Describe it as only you can...", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.top, 10)

                // 7. Rating Section
                Text("Rating")
                    .font(.headline)
                    .padding(.top, 20)
                
                HStack {
                    ForEach(0..<5, id: \.self) { star in
                        Image(systemName: star < rating ? "star.fill" : "star")
                            .foregroundColor(star < rating ? .yellow : .gray)
                            .onTapGesture {
                                rating = star + 1
                            }
                    }
                }

                // 8. Calendar Section
                Text("Select Date")
                    .font(.headline)
                    .padding(.top, 20)
                
                HStack {
                    Button(action: {
                        // Decrease month logic
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.red)
                    }
                    
                    Text(selectedMonth)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    Button(action: {
                        // Increase month logic
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.red)
                    }
                }
                
                // Calendar Dates (example)
                HStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .overlay(Text("7").foregroundColor(.white))
                        .background(Color.red)
                    
                    Circle()
                        .frame(width: 30, height: 30)
                        .overlay(Text("10").foregroundColor(.white))
                        .background(Color.red)
                }
                .padding(.top, 10)

            }
            .padding()
            .presentationDetents([.height(80), .large]) // Default height set to 150 points
            .presentationDragIndicator(.visible) // Show the drag indicator
            .interactiveDismissDisabled(true) // Prevent full dismissal
            .presentationBackground(Color.white) // Remove background dimming
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
