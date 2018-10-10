//
//  ViewController.swift
//  Triva Game
//
//  Created by Kaleb Allen on 10/8/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MainMenue: UINavigationBar!
    @IBOutlet weak var Questions: UILabel!
    @IBOutlet weak var Answer1: UIButton!   // index num 0
    @IBOutlet weak var Answer2: UIButton!   // index num 1
    @IBOutlet weak var Answer3: UIButton!   // index num 2
    @IBOutlet weak var Answer4: UIButton!   // index num 3
    @IBOutlet weak var ResetGame: UIBarButtonItem!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
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
        }
        /* let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
         currentQuestion = questions[randomIndex] */
        randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        currentQuestion = questions [randomIndex]
    }
    
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
    func populateQuestions() {
        let Question0 = TriviaQuestion(questions: "Who is the main character in Halo", Answers: ["Master Cheif", "Joker", "Joseph", "Samus"], correctIndex: 0)
        let Question1 = TriviaQuestion(questions: "What is the armor that Guts uses", Answers: ["Blazing Sword","Bersker Armor","Ki Blast", "Plasma Gernade"], correctIndex: 1)
        let Question2 = TriviaQuestion(questions: "Which Triforce does Zelda hold", Answers: ["Triforce of courage","TriForce of Bows","Tri force of Wisdom","Triforce of Power"], correctIndex: 2)
        let Question3 = TriviaQuestion(questions: "What do you call a person who raises the dead", Answers:["necromorph","xenomorph","necromancer","pyromancer"], correctIndex: 3)
        print(Question0.correctAnswer)
        questions.append(Question0)
        questions.append(Question1)
        questions.append(Question2)
        questions.append(Question3)
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
}









//print("The Darkest of Dungens will always wield the greatest reward")
