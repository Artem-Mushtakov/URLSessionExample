//
//  Model.swift
//  URLSessionStartProject
//
//  Created by Alexey Pavlov on 29/11/21.
//

import Foundation

struct Cards: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let name: String?
    let manaCost: String?
    let cmc: Int?
    let toughness: String?
    let id: String?
    let flavor: String?
}

