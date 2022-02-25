//
//  ViewController.swift
//  Set
//
//  Created by Vasile Sebastian Catur on 23.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var dealMoreCardsButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!

    private lazy var game = SetGame(numberOfCards: numberOfButtons)
    var numberOfButtons: Int {
        return (cardButtons.count)
    }
    private var buttonsList = [UIButton]()
    private var chosenCards = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    @IBAction func dealMoreCards(_ sender: UIButton) {
        print("deal more cards")

    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            let selectedCard = game.cards[cardNumber]
            if sender.backgroundColor == .white {
                if chosenCards.count < 3 {
                    sender.backgroundColor = .lightGray
                    chosenCards.append(selectedCard)
                }
            } else {
                sender.backgroundColor = .white
                if let index = chosenCards.firstIndex(of: selectedCard) {
                    chosenCards.remove(at: index)
                }
            }
        }

        if chosenCards.count == 3 {
            game.chosenCards(cards: chosenCards)
            updateChosenButtons()
        }
    }

    func refreshButtons() {

    }

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            button.setTitle(card.icon, for: .normal)
            button.setTitleColor(card.color, for: .normal)
            button.layer.borderWidth = 0.0
            button.layer.borderColor = UIColor.clear.cgColor
            button.backgroundColor = .white
        }
    }

    private func updateChosenButtons() {
        for chosenCard in chosenCards {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if chosenCard == card {
                    button.layer.borderWidth = 5.0
                    if game.foundMatch == true {
                        button.layer.borderColor = UIColor.green.cgColor
                    } else {
                        button.layer.borderColor = UIColor.red.cgColor
                    }
                }
            }
        }
    }
}

