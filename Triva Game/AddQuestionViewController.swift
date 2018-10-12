//
//  AddQuestionViewController.swift
//  Triva Game
//
//  Created by Kaleb Allen on 10/11/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    @IBOutlet weak var TypeQuestion: UITextField!
    @IBOutlet weak var Answer1: UITextField!
    @IBOutlet weak var Answer2: UITextField!
    @IBOutlet weak var Answer3: UITextField!
    @IBOutlet weak var Answer4: UITextField!
    @IBOutlet weak var CorrectAnswer: UISegmentedControl!
    @IBOutlet weak var Submit: UIButton!
    
    var newQuestion: TriviaQuestion!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? ViewController {
            // Append the new question to the Question Array
            destination.questions.append(newQuestion)
        }
    }
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Alert", message: "Please enter in ALL feilds, or hit the back button to go back to the quiz.", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        guard let question = TypeQuestion.text, !question.isEmpty,
            let Answer1 = Answer1.text, !Answer1.isEmpty,
            let Answer2 = Answer2.text, !Answer2.isEmpty,
            let Answer3 = Answer3.text, !Answer3.isEmpty,
            let Answer4 = Answer4.text, !Answer4.isEmpty else {
                showErrorAlert()
                return
        }
        newQuestion = TriviaQuestion(questions: question, Answers: [Answer1,Answer2,Answer3,Answer4], correctIndex: CorrectAnswer.selectedSegmentIndex)
        self.performSegue(withIdentifier: "unwindToQuizScreen", sender: self)
    
    }
}
