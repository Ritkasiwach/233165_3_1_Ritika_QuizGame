import UIKit

class QuizViewController: UIViewController {
    
   @IBOutlet weak var questionLabel: UILabel!
   @IBOutlet weak var option1Button: UIButton!
   @IBOutlet weak var option2Button: UIButton!
   @IBOutlet weak var option3Button: UIButton!
   @IBOutlet weak var backButton: UIButton!
   @IBOutlet weak var nextButton: UIButton!

//    @IBOutlet var option1Button: UIButton!
    let questions = [
        "What is the capital of France?",
        "What is the largest mammal?",
        "What is the chemical symbol for water?",
        "Which planet is known as the Red Planet?",
        "Who painted the Mona Lisa?",
        "What is the chemical symbol for gold?",
        "What is the largest ocean on Earth?",
        "What is the tallest mountain in the world?",
        "Who wrote 'Romeo and Juliet'?",
        "What is the chemical symbol for oxygen?"
    ]
    
    let options = [
        ["Paris", "London", "Berlin"],
        ["Elephant", "Blue Whale", "Giraffe"],
        ["H2O", "CO2", "NaCl"],
        ["Mars", "Venus", "Mercury"],
        ["Leonardo da Vinci", "Vincent van Gogh", "Pablo Picasso"],
        ["Au", "Ag", "Cu"],
        ["Pacific", "Atlantic", "Indian"],
        ["Mount Everest", "K2", "Kangchenjunga"],
        ["William Shakespeare", "Jane Austen", "Charles Dickens"],
        ["O2", "H2", "N2"]
    ]
    
    let correctAnswers = ["Paris", "Blue Whale", "H2O", "Mars", "Leonardo da Vinci", "Au", "Pacific", "Mount Everest", "William Shakespeare", "O2"]
    
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion()
    }
    
    func displayQuestion() {
        questionLabel.text = questions[currentQuestionIndex]
        option1Button.setTitle(options[currentQuestionIndex][0], for: .normal)
        option2Button.setTitle(options[currentQuestionIndex][1], for: .normal)
        option3Button.setTitle(options[currentQuestionIndex][2], for: .normal)
        
        option1Button.backgroundColor = .clear
        option2Button.backgroundColor = .clear
        option3Button.backgroundColor = .clear
        
        // If at the first question, hide the back button
        backButton.isHidden = currentQuestionIndex == 0
    }
    
    func checkAnswer(selectedOption: String, selectedButton: UIButton) {
        let correctAnswer = correctAnswers[currentQuestionIndex]
        if selectedOption == correctAnswer {
            score += 1
            selectedButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        } else {
            selectedButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            // Highlight the correct answer by changing its background color
            if let correctButton = findCorrectButton() {
                correctButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            }
        }
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            displayQuestion()
        } else {
            showScore()
        }
    }
    
    func findCorrectButton() -> UIButton? {
        let correctAnswerIndex = correctAnswers.firstIndex(of: correctAnswers[currentQuestionIndex])
        switch correctAnswerIndex {
        case 0:
            return option1Button
        case 1:
            return option2Button
        case 2:
            return option3Button
        default:
            return nil
        }
    }
    
    func showScore() {
        let alert = UIAlertController(title: "Quiz Completed", message: "Your score is \(score) out of \(questions.count)", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default) { (_) in
            self.restartQuiz()
        }
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        displayQuestion()
    }
    
    @IBAction func option1Selected(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle!, selectedButton: sender)
    }
    
    @IBAction func option2Selected(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle!, selectedButton: sender)
    }
    
    @IBAction func option3Selected(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle!, selectedButton: sender)
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            displayQuestion()
        } else {
            showScore()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            displayQuestion()
        }
    }
}
