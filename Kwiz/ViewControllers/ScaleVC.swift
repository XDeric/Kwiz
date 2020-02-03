//
//  ScaleVC.swift
//  Kwiz
//
//  Created by Angela Garrovillas on 2/3/20.
//  Copyright © 2020 2Legit2Quit. All rights reserved.
//

import UIKit

class ScaleVC: UIViewController {
    //MARK: - UIObjects
    var line: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 360, height: 25))
        lineView.backgroundColor = .black
        return lineView
    }()
    var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance the scale"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Times New Roman", size: 40)
        return label
    }()
    var steel: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        image.backgroundColor = .gray
        return image
    }()
    var mysteryBox: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.text = "?"
        label.font = UIFont(name: "System", size: 20)
        label.textAlignment = .center
        label.textColor = .white
        image.addSubview(label)
        label.center = image.center
        
        image.backgroundColor = .brown
        return image
    }()
    var inputBox: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        image.layer.borderWidth = 5
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    var triangle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        return view
    }()
    
    //MARK: - Properties
    var steelPanGesture = UIPanGestureRecognizer()
    
    //MARK: - Constraints
    private func setConstraints() {
        constrainLine()
        constrainPrompt()
        constrainSteel()
        constrainMysteryBox()
        constrainInputBox()
        constrainTriangle()
        makeTriangle()
        
        rotateObjects()
    }
    private func constrainLine() {
        view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: line.frame.width),
            line.heightAnchor.constraint(equalToConstant: line.frame.height)])
    }
    private func constrainPrompt() {
        view.addSubview(promptLabel)
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    private func constrainSteel() {
        view.addSubview(steel)
        steel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            steel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            steel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            steel.widthAnchor.constraint(equalToConstant: steel.frame.width),
            steel.heightAnchor.constraint(equalToConstant: steel.frame.height)])
    }
    private func constrainMysteryBox() {
        view.addSubview(mysteryBox)
        mysteryBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mysteryBox.widthAnchor.constraint(equalToConstant: mysteryBox.frame.width),
            mysteryBox.heightAnchor.constraint(equalToConstant: mysteryBox.frame.height),
            mysteryBox.bottomAnchor.constraint(equalTo: line.topAnchor, constant: 45),
            mysteryBox.leadingAnchor.constraint(equalTo: line.centerXAnchor, constant: 75)])
    }
    private func constrainInputBox() {
        view.addSubview(inputBox)
        inputBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputBox.widthAnchor.constraint(equalToConstant: inputBox.frame.width),
            inputBox.heightAnchor.constraint(equalToConstant: inputBox.frame.height),
            inputBox.leadingAnchor.constraint(equalTo: line.leadingAnchor, constant: 35),
            inputBox.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -35)])
    }
    private func constrainTriangle() {
        view.addSubview(triangle)
        triangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            triangle.widthAnchor.constraint(equalToConstant: triangle.frame.width),
            triangle.heightAnchor.constraint(equalToConstant: triangle.frame.height),
            triangle.centerXAnchor.constraint(equalTo: line.centerXAnchor),
            triangle.topAnchor.constraint(equalTo: line.bottomAnchor)])
    }
    
    //MARK: Rotate
    private func rotateLine() {
        line.transform = CGAffineTransform(rotationAngle: CGFloat.pi/9)
    }
    private func rotateMysteryBox() {
        mysteryBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi/9)
    }
    private func rotateObjects() {
        rotateLine()
        rotateMysteryBox()
        inputBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi/9)

    }
    
    //MARK: Setup
    private func addGestures() {
        steel.isUserInteractionEnabled = true
        steelPanGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedSteel(_:)))
        steel.addGestureRecognizer(steelPanGesture)
    }
    
    //MARK: - Functions
    private func makeTriangle() {
        let path = UIBezierPath()
        let strokeColor: UIColor = .black
        let lineWidth: CGFloat = 2.0
        let shapeLayer = CAShapeLayer()
        
        path.move(to: CGPoint(x: triangle.frame.minX, y: triangle.frame.maxY))
        path.addLine(to: CGPoint(x: triangle.frame.minX, y: triangle.frame.maxY))
        
        //path.move(to: CGPoint(x: triangle.frame.midX, y: triangle.frame.minY))
        path.addLine(to: CGPoint(x: triangle.frame.midX, y: triangle.frame.minY))
        
        //path.move(to: CGPoint(x: triangle.frame.maxX, y: triangle.frame.maxY))
        path.addLine(to: CGPoint(x: triangle.frame.maxX, y: triangle.frame.maxY))
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.black.cgColor
        triangle.layer.addSublayer(shapeLayer)
    }
    
    
    
    //MARK: Objc Func
    @objc func draggedSteel(_ sender: UIPanGestureRecognizer) {
        view.bringSubviewToFront(steel)
        let translation = sender.translation(in: view)
        steel.center = CGPoint(x: steel.center.x + translation.x, y: steel.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        addGestures()
        
    }
    

    

}
