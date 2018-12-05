//
//  TriviaQuestion.swift
//  Triva Game
//
//  Created by Kaleb Allen on 10/9/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import Foundation

class TriviaQuestion {
    // string storing for next question
    let question: String
    
    //string array storing the potential answers to the question
    let answers: [String]
    
    // store the index of the correct answer in the array
    let correctAnswersIndex: Int
    
    //computed property theat returns the correct answer for the Triva Question
    var correctAnswer: String {
       return answers[ correctAnswersIndex ]
    }
    
    //init(init = initial) for TrivaQuestion class
    init(questions: String, Answers: [String], correctIndex: Int) {
        self.question = questions
        self.answers = Answers
        self.correctAnswersIndex = correctIndex
    }
}






