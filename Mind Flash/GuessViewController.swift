//
//  GuessViewController.swift
//  Mind Flash
//
//  Created by Devan Allara on 3/19/18.
//  Copyright © 2018 Devan Allara. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var questions = [Question]()
    
    var colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
    
    var score = 0
    
    var displayedQuestion: Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestionButton.layer.cornerRadius = 5
        addQuestionButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 5
        resetButton.clipsToBounds = true
        button1.layer.cornerRadius = 5
        button1.clipsToBounds = true
        button2.layer.cornerRadius = 5
        button2.clipsToBounds = true
        button3.layer.cornerRadius = 5
        button3.clipsToBounds = true
        button4.layer.cornerRadius = 5
        button4.clipsToBounds = true
        loadQuestions()
        generateQuestionText()
        scoreLabel.text = "Score: \(score)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadQuestions() {
        let question1 = Question(questionText: "What color is the sun?", answers: ["Yellow", "Blue", "Green", "Purple"], correctAnswer: 0)
        questions.append(question1)
    }
    
    func generateAnswerButtons(question: Question, colorSelection: [UIColor]) {
       var colorArray = colorSelection
       var questionAnswers = question.answers
        for i in 0...3 {
            let randomAnswer = Int(arc4random_uniform(UInt32(questionAnswers.count)))
            let randomColor = Int(arc4random_uniform(UInt32(colorArray.count)))
            switch i {
            case 0 :
                button1.setTitle(questionAnswers[randomAnswer], for: .normal)
                button1.backgroundColor = colorArray[randomColor]
            case 1:
                button2.setTitle(questionAnswers[randomAnswer], for: .normal)
                button2.backgroundColor = colorArray[randomColor]
            case 2:
                button3.setTitle(questionAnswers[randomAnswer], for: .normal)
                button3.backgroundColor = colorArray[randomColor]
            case 3:
                button4.setTitle(questionAnswers[randomAnswer], for: .normal)
                button4.backgroundColor = colorArray[randomColor]
            default:
                return
            }
            questionAnswers.remove(at: randomAnswer)
            colorArray.remove(at: randomColor)
        }
    }
    
    func generateQuestionText() {
        let randomQuestionIndex = Int(arc4random_uniform(UInt32(questions.count)))
        let currentQuestion = questions[randomQuestionIndex]
        displayedQuestion = currentQuestion
        questionLabel.text = currentQuestion.questionText
        generateAnswerButtons(question: currentQuestion,colorSelection: colors)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func answerButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        if button.title(for: .normal) == displayedQuestion!.answers[(displayedQuestion!.correctAnswer)] {
            let alertView = UIAlertController(title: "Correct!", message: "You got the answer right, good job!", preferredStyle: .alert)
           alertView.addAction(UIAlertAction(title: "Okay!", style: .default))
          self.present(alertView, animated: true, completion: nil)
        }

    }
    
    
    
}
