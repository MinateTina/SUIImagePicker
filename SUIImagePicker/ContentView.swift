//
//  ContentView.swift
//  SUIImagePicker
//
//  Created by Minate on 10/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox = UIImage()
    
    var body: some View {
        
        VStack{
            Image(uiImage: imageInBlackBox)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .border(Color.black, width: 1)
                .clipped()
            
            Button {
                self.isShowingImagePicker.toggle()
            } label: {
                Text("Select Image")
                    .font(.system(size: 32))
            }.sheet(isPresented: $isShowingImagePicker, content: {
                ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$imageInBlackBox)
            })

        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context
                              :Context) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
//                print(selectedImage)
                self.parent.selectedImage = selectedImageFromPicker
            }
            self.parent.isPresented = false
            
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: Context) {
        
    }
}

struct DummyView: UIViewRepresentable {
  
    
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton()
        button.setTitle("DUMMY", for: .normal)
        button.backgroundColor = .red
        return button
    }
    
    func updateUIView(_ uiView: DummyView.UIViewType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
