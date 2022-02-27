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

    var deckCards = [Card]()
    var foundMatch = false
    var arrayOfCards = [Card]()
    var cards = [Card]()
    var newCards = [Card]()

    init(numberOfCards: Int) {
        let numbers = [1, 2, 3]
        let shapes = ["▲", "●", "■"]//, "▢", "▥"]
        let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.purple, UIColor.orange]

        for colorIndex in colors.indices {
            let color = colors[colorIndex]
            for iconIndex in shapes.indices {
                let shape = shapes[iconIndex]
                for numberIndex in numbers.indices {
                    let number = numbers[numberIndex]
                    let icon = String(repeating: shape, count: number)
                    let card = Card(color: color, number: number , shape: shape , icon: icon)
                    arrayOfCards.append(card)
                }
            }
        }

        shuffleCards()

        for index in 0..<12 {
            cards.append(deckCards[index])
            deckCards.remove(at: index)
        }
    }

    func dealThreeMoreCards() {
        for index in 0..<3 {
            cards.append(deckCards[index])
            deckCards.remove(at: index)
        }
    }

    func getThreeNewCards() {
        for index in 0..<3 {
            newCards.append(deckCards[index])
            deckCards.remove(at: index)
        }
    }

    func shuffleCards() {
        deckCards = arrayOfCards.shuffled()
    }

    func chosenCards(cards: [Card]) {
        let selectedCards = findColor(array: cards)

        switch selectedCards {
        case .found:
            foundMatch = true
        case .notFound:
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
