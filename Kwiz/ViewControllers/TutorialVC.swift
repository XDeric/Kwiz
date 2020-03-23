//
//  InstructionsVC.swift
//  Kwiz
//
//  Created by Kevin Natera on 3/17/20.
//  Copyright © 2020 2Legit2Quit. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
    
    //MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString.init(string: "How to play")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        label.attributedText = attributedString
        label.frame = CGRect(x: view.center.x - 150, y: 75, width: 300, height: 70)
        label.textAlignment = .center
        label.font = label.font.withSize(60)
        label.alpha = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: view.center.x - 200, y: 175, width: 400, height: 475)
        label.text = "Hey there! This is an interactive quiz game designed to challenge you to think outside the box, so not every question should be taken literally! If the obvious approach doesn't work, try something completely outlandish! What can be interacted with isn't always straightforward, so try pinching, dragging, and messing with everything!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 20
        label.alpha = 0
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: view.center.x - 100, y: 700, width: 200, height: 75)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.setTitle("Let's go!", for: .normal)
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: view.center.x + 45, y: 800, width: 50, height: 50)
        button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(showButtonPressed), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    lazy var showText: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: view.center.x - 100, y: 800, width: 200, height: 50)
        label.text = "  Don't show again?"
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 20
        label.alpha = 0
        return label
    }()
    
    lazy var whiteScreen: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        view.backgroundColor = .white
        view.layer.zPosition = 1
        return view
    }()
    
    //MARK: - Button Funcs
    
    @objc func startButtonPressed() {
        let multipleChoice = MultipleChoiceVC()
        
        let navigationController = UINavigationController(rootViewController: multipleChoice)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        Game.shared.start()
        Game.shared.setUser(user: User(highestScore: 0, nickname: "Bob"))
        Game.shared.getNewCurrentQuestion()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {return}
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            window.rootViewController = navigationController
        }, completion: nil)
    }
    
    @objc func showButtonPressed() {
        
        switch showButton.backgroundImage(for: .normal) {
        case UIImage(systemName: "square"):
            showButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            UserDefaults.standard.set(false, forKey: "showTutorial")
        default:
            showButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            UserDefaults.standard.set(true, forKey: "showTutorial")
        }
        
    }
    
    //MARK: - Private Methods
    private func addSubviews() {
        view.backgroundColor = #colorLiteral(red: 0.4326986074, green: 0.5668497086, blue: 1, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startButton)
        view.addSubview(showButton)
        view.addSubview(showText)
        view.addSubview(whiteScreen)
        
        if let showTutorial = UserDefaults.standard.value(forKey: "showTutorial") as? Bool {
            if !showTutorial {
                showButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }
        }
    }
    
    private func fadeInViews() {
        UIView.animate(withDuration: 1) {
            self.whiteScreen.alpha = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)  {
            UIView.animate(withDuration: 2) {
                self.titleLabel.alpha = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 4) {
                self.descriptionLabel.alpha = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIView.animate(withDuration: 3) {
                self.startButton.alpha = 1
                self.showButton.alpha = 1
                self.showText.alpha = 1
            }
        }
    }
    
    
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        fadeInViews()
    }
    
    
}




