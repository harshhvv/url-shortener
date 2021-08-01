//
//  viewModel.swift
//  url shortener
//
//  Created by Harsh  on 01/08/21.
//

import Foundation

struct Model:Hashable {
    let long:String
    let short:String
}

class ViewModel:ObservableObject{
    
    @Published var models = [Model]()
    
    func submit(urlString:String){
        guard URL(string: urlString) != nil else{
            return
        }
        //API call here
        guard let apiUrl = URL(string: "https://api.1pt.co/addURL?long=\(urlString)") else{
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiUrl) {[weak self] data, response, error in
            if error != nil{
                print("error")
            }
            //convert data to json
            if let safeData = data{
                do{
                    let result = try JSONDecoder().decode(apiResponse.self, from: safeData)
                    print(result)
                    let long = result.long
                    let short = result.short
                    DispatchQueue.main.async {
                        self?.models.append(.init(long: long, short: short))
                    }
                    //print(short)
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
}


struct apiResponse:Codable{
    let status:Int
    let message:String
    let short:String
    let long:String
}
