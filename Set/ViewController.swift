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
    private var chosenCards = [Card]()
    private var matchCards = [Card]()
    private var hasThree = false
    private var indexArray = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    @IBAction func dealMoreCards(_ sender: UIButton) {
        if game.foundMatch {
            refreshButtonsMatched()
        } else {
            game.dealThreeMoreCards()
            updateViewFromModel()
        }
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if hasThree {
            if game.foundMatch {
                refreshButtonsMatched()
            } else {
                updateViewFromModel()
            }
            hasThree = false
        }

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
            hasThree = true
        }
    }

    func refreshButtonsMatched() {
        game.getThreeNewCards()
        for cardIndex in game.cards.indices {
            let card = game.cards[cardIndex]
            for index in matchCards.indices {
                let match = matchCards[index]
                if card == match {
                    if game.newCards.count != 0 {
                        game.cards[cardIndex] = game.newCards[index]
                    }
                    if !indexArray.contains(cardIndex) {
                        indexArray.append(cardIndex)
                    }
                }
            }
        }

        game.newCards.removeAll()
        matchCards.removeAll()
        updateViewFromModel()
        game.foundMatch = false
    }

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cards.count && !game.deckCards.isEmpty{
                button.alpha = 1.0
                let card = game.cards[index]
                button.setTitle(card.icon, for: .normal)
                button.setTitleColor(card.color, for: .normal)
                button.layer.borderWidth = 0.0
                button.layer.borderColor = UIColor.clear.cgColor
                button.backgroundColor = .white
            } else {
                if game.deckCards.isEmpty {
                    for matchIndex in indexArray {
                        cardButtons[matchIndex].alpha = 0.0
                    }
                } else {
                    button.alpha = 0.0
                }
            }
        }

        indexArray.removeAll()

        if game.deckCards.isEmpty || game.cards.count >= 24 {
            dealMoreCardsButton.isEnabled = false
            dealMoreCardsButton.alpha = 0.2
        } else {
            dealMoreCardsButton.isEnabled = true
            dealMoreCardsButton.alpha = 1.0
        }
    }

    private func updateChosenButtons() {
        for chosenCard in chosenCards {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                if index < game.cards.count {
                    let card = game.cards[index]
                    if chosenCard == card {
                        button.layer.borderWidth = 5.0
                        if game.foundMatch == true {
                            matchCards.append(chosenCard)
                            button.layer.borderColor = UIColor.green.cgColor
                        } else {
                            button.layer.borderColor = UIColor.red.cgColor
                        }
                    }
                }
            }
        }
        chosenCards.removeAll()
    }
}

