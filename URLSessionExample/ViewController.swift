//
//  ViewController.swift
//  URLSessionStartProject
//
//  Created by Alexey Pavlov on 29.11.2021.
//

import UIKit
import CryptoKit

class ViewController: UIViewController {
    
    private let endpointClient = EndpointClient(applicationSettings: ApplicationSettingsService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        executeCall()
    }
    
    func executeCall() {
        let endpoint = GetNameEndpoint()
        let completion: EndpointClient.ObjectEndpointCompletion<String> = { result, response in
            guard let responseUnwrapped = response else { return }
            
            print("\n\n response = \(responseUnwrapped.allHeaderFields) ;\n \(responseUnwrapped.statusCode) \n")
            switch result {
            case .success(let team):
                print("team = \(team)")
                
            case .failure(let error):
                print(error)
            }
        }
        
        endpointClient.executeRequest(endpoint, completion: completion)
    }
}

final class GetNameEndpoint: ObjectResponseEndpoint<String> {

    override var method: RESTClient.RequestType { return .get }
    override var path: String { "/v1/public/characters" }

    let timeStamp = NSDate().timeIntervalSince1970.description
    let publicKey = "4115a60241c2fc3734625110328b11f3"
    let privateKey = "70fbecd8502cd87b598d9296085c8e2d36b74c10"

    override init() {
        super.init()
        queryItems = [URLQueryItem(name: "name", value: "Deadpool"),
                      URLQueryItem(name: "ts", value: "\(timeStamp)"),
                      URLQueryItem(name: "apikey", value: "\(publicKey)"),
                      URLQueryItem(name: "hash", value: (timeStamp + privateKey + publicKey).md5())]
    }
}

func decodeJSONOld() {
    let str = """
        {\"team\": [\"ios\", \"android\", \"backend\"]}
    """
    
    let data = Data(str.utf8)
    
    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let names = json["team"] as? [String] {
                print(names)
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}
