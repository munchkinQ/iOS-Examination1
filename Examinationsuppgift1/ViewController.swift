//
//  ViewController.swift
//  Examinationsuppgift1
//
//  Created by Åsa Östmark on 2024-09-13.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turns {
        case X
        case O
    }

    @IBOutlet weak var UpperLeft: UIButton!
    @IBOutlet weak var UpperMiddle: UIButton!
    @IBOutlet weak var UpperRight: UIButton!
    @IBOutlet weak var MiddleLeft: UIButton!
    @IBOutlet weak var Middle: UIButton!
    @IBOutlet weak var MiddleRight: UIButton!
    @IBOutlet weak var BottomLeft: UIButton!
    @IBOutlet weak var BottomMiddle: UIButton!
    @IBOutlet weak var BottomRight: UIButton!
    @IBOutlet weak var CurrentTurnLabel: UILabel!
    
    var startingTurn = Turns.X
    var currentTurn = Turns.X
    
    var playerX = "X"
    var playerO = "O"
    var gameBoard = [UIButton]()
    
    
    override func viewDidLoad()
    
    {
       
        super.viewDidLoad()
        setUpGameBoard()
        
        
    }
    
    func setUpGameBoard() {
        gameBoard.append(UpperLeft)
        gameBoard.append(UpperMiddle)
        gameBoard.append(UpperRight)
        gameBoard.append(MiddleLeft)
        gameBoard.append(Middle)
        gameBoard.append(MiddleRight)
        gameBoard.append(BottomLeft)
        gameBoard.append(BottomMiddle)
        gameBoard.append(BottomRight)
    }

    @IBAction func placeTokenOnBoard(_ sender: UIButton) {
        
        layToken(sender)
        
        if victoryAssesment(playerO) {
            alertGameResults(title: "Player O Wins!")
        }
        
        if victoryAssesment(playerX) {
            alertGameResults(title: "Player X Wins!")
        }
        
        
        if (isGameBoardFull()) {
            
            
            alertGameResults(title: "The Game has resulted in a draw!")
            
        }
       
            }
    
    func tokens(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func victoryAssesment(_ token: String) -> Bool {
       
        //horizontal
        if tokens(UpperLeft, token) && tokens(UpperMiddle, token) && tokens(UpperRight, token) {
        return true
    } 
        if
        tokens(MiddleLeft, token) && tokens(Middle, token) && tokens(MiddleRight, token) {
            return true
        }
        if
        tokens(BottomLeft, token) && tokens(BottomMiddle, token) && tokens(BottomRight, token) {
            return true
        }
        //vertical
        if tokens(UpperLeft, token) && tokens(MiddleLeft, token) && tokens(BottomLeft, token) {
        return true
    }
        if
        tokens(UpperMiddle, token) && tokens(Middle, token) && tokens(BottomMiddle, token) {
            return true
        }
        if
        tokens(UpperRight, token) && tokens(MiddleRight, token) && tokens(BottomRight, token) {
            return true
        }
        
        //diagonal
        if tokens(UpperLeft, token) && tokens(Middle, token) && tokens(BottomRight, token) {
        return true
    }
        if
        tokens(UpperRight, token) && tokens(Middle, token) && tokens(BottomLeft, token) {
            return true
        }
        
        return false
    }
    
    
    func alertGameResults(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet) 
        alert.addAction(UIAlertAction(title: "Reset Game", style: .default, handler: {(_) in
            self.resetGameBoard()
        }))
        self.present(alert, animated: true)
    }

    
    func resetGameBoard() {
        for button in gameBoard {
            button.isEnabled = true
            button.setTitle(nil, for: .normal)
            
        }
        if(startingTurn == Turns.X) {
            startingTurn = Turns.O
            CurrentTurnLabel.text = playerO
            
        } else if (startingTurn == Turns.O) {
            startingTurn = Turns.X
            CurrentTurnLabel.text = playerX
        }
        
        currentTurn = startingTurn
        
    }
    
    func isGameBoardFull() -> Bool {
        for button in gameBoard {
            if button.title(for: .normal) == nil {
                return false
            }
        } 
        return true
    }
    
    
    func layToken(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            if(currentTurn == Turns.X) {
                sender.setTitle(playerX, for: .normal)
                currentTurn = Turns.O
                CurrentTurnLabel.text = playerO
            } else if (currentTurn == Turns.O){
                    sender.setTitle(playerO, for: .normal)
                    currentTurn = Turns.X
                CurrentTurnLabel.text = playerX
            }
            sender.isEnabled = false
        }
        
    }
    
}

