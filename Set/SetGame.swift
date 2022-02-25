//
//  Set.swift
//  Set
//
//  Created by Vasile Sebastian Catur on 24.02.2022.
//

import Foundation
import UIKit

enum FindSameShape {
    case found
    case notFound
}

enum FindSet {
    case found
    case notFound
}

class SetGame {

    var cards = [Card]()
    var arrayOfCards = [Card(color: .orange, number: 1, shape: "1", icon: "1"),
                Card(color: .orange, number: 2, shape: "1", icon: "11"),
                Card(color: .orange, number: 3, shape: "1", icon: "111"),
                Card(color: .red, number: 1, shape: "2", icon: "2"),
                Card(color: .red, number: 2, shape: "2", icon: "22"),
                Card(color: .red, number: 3, shape: "2", icon: "222"),
                Card(color: .green, number: 1, shape: "3", icon: "3"),
                Card(color: .green, number: 2, shape: "3", icon: "33"),
                Card(color: .green, number: 3, shape: "3", icon: "333"),
                Card(color: .blue, number: 1, shape: "4", icon: "4"),
                Card(color: .blue, number: 2, shape: "4", icon: "44"),
                Card(color: .blue, number: 3, shape: "4", icon: "444"),
                Card(color: .purple, number: 1, shape: "5", icon: "5"),
                Card(color: .purple, number: 2, shape: "5", icon: "55"),
                Card(color: .purple, number: 3, shape: "5", icon: "555"),
                Card(color: .black, number: 1, shape: "6", icon: "6"),
                Card(color: .black, number: 2, shape: "6", icon: "66"),
                Card(color: .black, number: 3, shape: "6", icon: "666"),
                Card(color: .gray, number: 1, shape: "7", icon: "7"),
                Card(color: .gray, number: 2, shape: "7", icon: "77"),
                Card(color: .gray, number: 3, shape: "7", icon: "777"),
                Card(color: .cyan, number: 1, shape: "8", icon: "8"),
                Card(color: .cyan, number: 2, shape: "8", icon: "88"),
                Card(color: .cyan, number: 3, shape: "8", icon: "888"),
                Card(color: .brown, number: 1, shape: "9", icon: "9"),
                Card(color: .brown, number: 2, shape: "9", icon: "99"),
                Card(color: .brown, number: 3, shape: "9", icon: "999"),]
    var foundMatch = false

    init(numberOfCards: Int) {

        for index in 0..<numberOfCards {
            let card = arrayOfCards[index]
            cards.append(card)
        }
        shuffleCards()
    }

    func shuffleCards() {
        cards = cards.shuffled()
    }

    func chosenCards(cards: [Card]) {

        // check card
        let selectedCards = findColor(array: cards)

        switch selectedCards {
        case .found:
            print("found")
            foundMatch = true
        case .notFound:
            print("not found")
            foundMatch = false
        }
    }

    func findColor(array: [Card]) -> FindSet {
        let number = Set([array[0].number, array[1].number, array[2].number])
        let shape = Set([array[0].shape, array[1].shape, array[2].shape])
        let color = Set([array[0].color, array[1].color, array[2].color])

        if number.count == 1 || number.count == 3 {
            if shape.count == 1 || shape.count == 3 {
                if color.count == 1 || color.count == 3 {
                    return .found
                }
            }
        }

        return .notFound
    }
}
