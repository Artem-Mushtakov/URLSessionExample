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
        let completion: EndpointClient.ObjectEndpointCompletion<Cards> = { result, response in
            guard let responseUnwrapped = response else { return }
            
            print("\n\n response = \(responseUnwrapped.allHeaderFields) ;\n \(responseUnwrapped.statusCode) \n")
            switch result {
            case .success(let data):

                for i in data.cards {
                    print("Names: \(i.name ?? "")")
                    print("Cmc: \(i.cmc ?? 0 )")
                    print("ManaCost: \(i.manaCost ?? "")")
                    print("Toughness: \(i.toughness ?? "")")
                    print("ID: \(i.id ?? "")")
                    print("Flavor: \(i.flavor ?? "")\n")
                }

            case .failure(let error):
                print(error)
            }
        }
        
        endpointClient.executeRequest(endpoint, completion: completion)
    }
}

final class GetNameEndpoint: ObjectResponseEndpoint<Cards> {

    override var method: RESTClient.RequestType { return .get }
    override var path: String { "/v1/cards" }

    override init() {
        super.init()
        queryItems = [URLQueryItem(name: "name", value: "Optimus Prime|Black Lotus")]
    }
}
