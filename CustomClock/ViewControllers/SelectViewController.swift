import UIKit

class SelectViewController: UIViewController {
    
    var firstArray: [Int] = [10, 5, 3]
    var secondArray: [Int] = [25, 5, 3]
    var threeArray: [Int] = [25, 5, 5]
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    private func setUpView() {
        firstButton.layer.cornerRadius = 15
        secondButton.layer.cornerRadius = 15
        threeButton.layer.cornerRadius = 15
    }
    
    @IBAction func firstBtnTapped(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let timerViewController = storyboard.instantiateViewController(withIdentifier: "PomodoroTimerViewController") as! PomodoroTimerViewController
        timerViewController.selectArray = self.firstArray
        
        self.navigationController?.pushViewController(timerViewController, animated: true)
    }
    
    @IBAction func secondBtnTapped(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let timerViewController = storyboard.instantiateViewController(withIdentifier: "PomodoroTimerViewController") as! PomodoroTimerViewController
        timerViewController.selectArray = self.secondArray
        
        self.navigationController?.pushViewController(timerViewController, animated: true)
    }
    
    @IBAction func threeBtnTapped(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let timerViewController = storyboard.instantiateViewController(withIdentifier: "PomodoroTimerViewController") as! PomodoroTimerViewController
        timerViewController.selectArray = self.threeArray
        
        self.navigationController?.pushViewController(timerViewController, animated: true)
    }
}
