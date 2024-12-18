//
//  SettingsView.swift
//  Loom
//
//  Created by Lorenzo Pizzuto on 18/12/24.
//

import SwiftUI
import MapKit
import PhotosUI
import UIKit



struct SettingsView: View {
    @State private var nickname: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var mapType: MKMapType = MKMapType(rawValue: UInt(UserDefaults.standard.integer(forKey: "MapType"))) ?? .standard
    @State private var showPhotoPicker = false
    @State private var showCameraPicker = false
    @State private var showActionSheet = false

    var body: some View {
        VStack(spacing: 20) {
            // Bottone per Upload della Foto
            ZStack {
                Circle()
                    .stroke(Color.red, lineWidth: 4)
                    .frame(width: 150, height: 150)
                
                Button(action: {
                    showActionSheet = true
                }) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 130, height: 130)
                    } else {
                        Text("Upload Photo")
                            .foregroundColor(.black)
                            .frame(width: 130, height: 130)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
            }
            
            // Campo per Nickname
            TextField("Choose your nickname", text: $nickname)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray))
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
            
            // Testi di riepilogo
            VStack {
                Text("Luoghi inseriti: 5")
                Text("Canzoni preferite: 12")
            }
            .font(.headline)
            
            // Selettore della Mappa
            VStack {
                MapView(mapType: $mapType)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                
                Picker("Map View", selection: $mapType) {
                    Text("Standard").tag(MKMapType.standard)
                    Text("Hybrid").tag(MKMapType.hybrid)
                    Text("Satellite").tag(MKMapType.satellite)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                .onChange(of: mapType) { newValue in
                    UserDefaults.standard.set(newValue.rawValue, forKey: "MapType")
                }
            }
            
            Spacer()
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Select Photo"),
                message: Text("Choose a source"),
                buttons: [
                    .default(Text("Take a Photo")) { showCameraPicker = true },
                    .default(Text("Choose from Library")) { showPhotoPicker = true },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showCameraPicker) {
            CameraPicker(selectedImage: $selectedImage)
        }
    }
}

// Picker per foto dalla libreria
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    self?.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}

// Picker per scattare foto con la fotocamera
struct CameraPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker
        
        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

// MapView personalizzato
struct MapView: UIViewRepresentable {
    @Binding var mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = mapType
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = mapType
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
