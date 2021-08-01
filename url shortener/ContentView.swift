//
//  ContentView.swift
//  url shortener
//
//  Created by Harsh  on 01/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var text:String = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
//                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
//                    .edgesIgnoringSafeArea(.all)
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                header()
                ForEach(viewModel.models, id: \.self) {model in
                    HStack {
//                        Image("DSC01264")
//                            .resizable()
//                            .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        VStack(alignment:.leading){
                            Text("https://1pt.co/"+model.short)
                                .font(.system(size: 18))
                            
                            Text(model.long)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .onTapGesture {
                            guard let url = URL(string: "https://1pt.co/"+model.short) else {return}
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    }
                }
            }
            .navigationTitle("URL Shortner")
            //.background(Color.clear)
        }
        
    }
    
    @ViewBuilder func header() -> some View{
        VStack{
            Text("Enter url to be shortened")
                .bold()
                //.foregroundColor(Color.white)
                .font(.system(size: 24))
                .padding()
            
            TextField("URL...", text: $text)
                .foregroundColor(.black)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .cornerRadius(9)
                .padding()
            
            Button(action: {
                guard !text.isEmpty else {
                    return
                }
                viewModel.submit(urlString: text)
                text = ""
            }, label: {
                Text("Submit")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(9)
                    .padding()
            })
        }
        .cornerRadius(5)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
        .background(Color.customBackgroundColor)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let customBackgroundColor = Color("backgroundColor")
}

