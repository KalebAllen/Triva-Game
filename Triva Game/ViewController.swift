//
//  ViewController.swift
//  Triva Game
//
//  Created by Kaleb Allen on 10/8/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //my buttons and lables
    @IBOutlet weak var Questions: UILabel!
    @IBOutlet weak var Answer1: UIButton!   // index num 0
    @IBOutlet weak var Answer2: UIButton!   // index num 1
    @IBOutlet weak var Answer3: UIButton!   // index num 2
    @IBOutlet weak var Answer4: UIButton!   // index num 3
    @IBOutlet weak var scoreLabel: UILabel!
    
    //pulls a question from the question array
    var currentQuestion: TriviaQuestion! {
        didSet {
            Questions.text = currentQuestion.question
            Answer1.setTitle(currentQuestion.answers[0], for: .normal)
            Answer2.setTitle(currentQuestion.answers[1], for: .normal)
            Answer3.setTitle(currentQuestion.answers[2], for: .normal)
            Answer4.setTitle(currentQuestion.answers[3], for: .normal)
        }
    }
    
    var questions: [TriviaQuestion] = []
    
    var questionsPlaceholder: [TriviaQuestion] = []
    //shows what the players score currently is
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    //this will store the question as a random index
    var randomIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        populateQuestions()
        getNewQuestion()
    }
    
    //this function will be used to get a random question form a rdm question array
    func getNewQuestion() {
        if questions.count > 0 {
            randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            currentQuestion = questions[randomIndex]
        } else {
            showGameOverAlert()
        }
    }
    //resets the whole game
    func resetGame() {
        score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        //get a new place holder
        getNewQuestion()
    }
    //My array of questions used in the game
    func populateQuestions() {
        let Question0 = TriviaQuestion(questions: "Who is the main character in Halo", Answers: ["Master Cheif", "Joker", "Joseph", "Samus"], correctIndex: 0)
        let Question1 = TriviaQuestion(questions: "What is the armor that Guts uses", Answers: ["Blazing Sword","Bersker Armor","Ki Blast", "Plasma Gernade"], correctIndex: 1)
        let Question2 = TriviaQuestion(questions: "Which Triforce does Zelda hold", Answers: ["Triforce of courage","TriForce of Bows","Tri force of Wisdom","Triforce of Power"], correctIndex: 2)
        let Question3 = TriviaQuestion(questions: "a person who raises the dead is a...", Answers:["necromorph","xenomorph","necromancer","pyromancer"], correctIndex: 2)
        let Question4 = TriviaQuestion(questions: "Who was reposible for killing SuperMan", Answers: ["Doomsday","Solme Grundy","The Flash","BatMan"], correctIndex: 0)
        let Question5 = TriviaQuestion(questions: "Who was the first person Venom bonded to", Answers: ["SpiderMan","DeadPool","Dr.Doom","CaptinAmerica"], correctIndex: 1)
        
        print(Question0.correctAnswer)
        questions.append(Question0)
        questions.append(Question1)
        questions.append(Question2)
        questions.append(Question3)
        questions.append(Question4)
        questions.append(Question5)
    }
    // shows the user that they got the answer right
    func showCorrectAnswerAlert() {
        //UIAlertController
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer)", preferredStyle: .actionSheet)
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            print("close button tapped")
            self.questionsPlaceholder.append(self.questions.remove(at: self.randomIndex))
            self.getNewQuestion()
        }
        //Action to the Alert Controller
        correctAlert.addAction(closeAction)
        //present AlertController
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    //shows the user they got the answer wrong
    func showIncorrectAnswerAlert() {
        let inCorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer)", preferredStyle: .actionSheet)
        
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.getNewQuestion()
        }
        inCorrectAlert.addAction(closeAction)
        self.present(inCorrectAlert, animated: true, completion: nil)
    }
    //shwo an alert to show the user when game is over. game will reset and will show user score
    func showGameOverAlert() {
        //UIAlertController
        let gameOverAlert = UIAlertController(title: "Results", message: "Game over! your score was\(score) out of \(questionsPlaceholder.count)", preferredStyle: .actionSheet)
        //UIAlertAction
        let resetAction = UIAlertAction(title: "Reset", style: .default) { _ in
            self.resetGame()//reset function will be called when th reset button on the alert is clicked/tapped
        }
        //Add the action to the alert controller
        gameOverAlert.addAction(resetAction)
        //Present the alert controller
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    //sends rhe user an alert telling wather they got the answer right or wrong and adds/removes a point accordingly
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        if sender.tag == currentQuestion.correctAnswersIndex {
            //they got the question right so we need to let them know
            showCorrectAnswerAlert()
            score += 1
        } else {
            //they got the question wrong and we need to tell them
            showIncorrectAnswerAlert()
            score -= 1
        }
    }
    @IBAction func ResetButtontapped(_ sender: Any) {
        resetGame()
    }
    //unwind segway
    @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue) { }
}









//print("The Darkest of Dungens will always wield the greatest reward")
