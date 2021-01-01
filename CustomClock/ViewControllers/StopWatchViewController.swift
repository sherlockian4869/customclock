import UIKit

class StopWatchViewController: UIViewController {
    
    private var elapsedTime: TimeInterval = 0.0
    private var timer: Timer?
    private var timerRunning: Bool = false
    private var timerData:[String] = []
    
    @IBOutlet weak var stopWatchLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var rapButton: UIButton!
    
    @IBOutlet weak var rapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        self.navigationItem.title = "StopWatch"
        stopWatchLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 80, weight: .medium)
        
        startButton.layer.cornerRadius = 40
        stopButton.layer.cornerRadius = 40
        resetButton.layer.cornerRadius = 40
        rapButton.layer.cornerRadius = 10
        stopButton.isEnabled = false
        resetButton.isEnabled = false
        rapButton.isEnabled = false
        
        rapTableView.delegate = self
        rapTableView.dataSource = self
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        if timerRunning == false {
            startButton.isEnabled = false
            timer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(StopWatchViewController.handleTimer),
                userInfo: nil,
                repeats: true
            )
            timerRunning = true
            self.stopButton.isEnabled = true
            self.resetButton.isEnabled = true
            self.rapButton.isEnabled = true
        } else {
            self.startButton.isEnabled = true
        }
    }
    @IBAction func stopBtnTapped(_ sender: Any) {
        if timerRunning == true {
            timer?.invalidate()
            self.stopButton.isEnabled = false
            self.startButton.isEnabled = true
        }
        timerRunning = false
    }
    @IBAction func resetBtnTapped(_ sender: Any) {
        timer?.invalidate()
        elapsedTime = 0.0
        self.stopWatchLabel.text = "00:00.00"
        self.startButton.isEnabled = true
        self.stopButton.isEnabled = true
        timerRunning = false
        timerData.removeAll()
        rapTableView.reloadData()
    }
    @IBAction func rapBtnTapped(_ sender: Any) {
        let milliSecond = Int(self.elapsedTime * 100) % 100
        let second = Int(self.elapsedTime) % 60
        let minutes = Int(self.elapsedTime / 60)
        var elapsedTimeString = String(format: "%02d:%02d.%02d", minutes, second, milliSecond)
        timerData.append(elapsedTimeString)
        rapTableView.reloadData()
    }

    @objc private func handleTimer() {
        elapsedTime += 0.01
        let milliSecond = Int(self.elapsedTime * 100) % 100
        let second = Int(self.elapsedTime) % 60
        let minutes = Int(self.elapsedTime / 60)
        self.stopWatchLabel.text = String(format: "%02d:%02d.%02d", minutes, second, milliSecond)
        print("timer fired. total: \(elapsedTime)")
    }
}

extension StopWatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StopWatchTableViewCell
        cell.rapLabel.text = timerData[indexPath.row]
        return cell
    }
}

class StopWatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rapLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
