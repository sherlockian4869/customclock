import UIKit

class TimerViewController: UIViewController {
    
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0.0
    private var timerRunning: Bool = false
    
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerStartButton: UIButton!
    @IBOutlet weak var timerStopButton: UIButton!
    @IBOutlet weak var timerResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        self.navigationItem.title = "Timer"
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 80, weight: .medium)
        timerStartButton.layer.cornerRadius = 40
        timerStopButton.layer.cornerRadius = 40
        timerResetButton.layer.cornerRadius = 40
        timerStartButton.isEnabled = true
        timerStopButton.isEnabled = false
        timerResetButton.isEnabled = false
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        timeDatePicker.isHidden = true
        if timerRunning == false {
            if elapsedTime == 0.0 {
                elapsedTime = TimeInterval(timeDatePicker.countDownDuration)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.handleTimer), userInfo: nil, repeats: true)
            } else {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.handleTimer), userInfo: nil, repeats: true)
            }
            
        }
        timerRunning = true
        timerStopButton.isEnabled = true
        timerResetButton.isEnabled = true
    }
    
    @IBAction func stopBtnTapped(_ sender: Any) {
        if timerRunning == true {
            timer?.invalidate()
            self.timerStopButton.isEnabled = false
            self.timerStartButton.isEnabled = true
        }
        timerRunning = false
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        timeDatePicker.isHidden = false
        timer?.invalidate()
        elapsedTime = 0.0
        self.timerLabel.text = "00:00:00"
        timerStopButton.isEnabled = false
        timerResetButton.isEnabled = false
    }
    
    @objc private func handleTimer() {
        elapsedTime -= 1
        if elapsedTime == 0 {
            timer?.invalidate()
            self.timerLabel.text = "00:00:00"
            timeDatePicker.isHidden = false
        }
        let second = Int(self.elapsedTime) % 60
        let minutes = Int(self.elapsedTime) % 3600 / 60
        let hour = Int(self.elapsedTime / 3600)
        self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, second)
        print("timer fired. total: \(elapsedTime)")
    }
    
}

