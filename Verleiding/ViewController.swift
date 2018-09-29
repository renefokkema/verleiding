//
//  ViewController.swift
//  Verleiding
//
//  Created by René Fokkema on 29-08-18.
//  Copyright © 2018 René Fokkema. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let userDefaults = UserDefaults.standard
    private let key = "nummertje"
    
    private var nummertje: Int = 0 {
        didSet {
            saveToStorage(number: nummertje)
            
            updateViews()
        }
    }
    
    private let button = UIButton()
    
    override func loadView() {
        super.loadView()
        
        nummertje = readFromStorage()
        
        view.backgroundColor = .blue
        
        button.addTarget(self, action: #selector(self.increaseCounter), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        button.backgroundColor = .green
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(button)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    internal func updateViews() {
  
        button.setTitle("\(nummertje)", for: .normal)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateViews()
        
        
    }

    func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
    
    @objc internal func increaseCounter() {
        nummertje = nummertje + 1
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.button.titleLabel?.font = UIFont.systemFont(ofSize: 128)
//            self.view.setNeedsLayout()
//            self.view.layoutIfNeeded()
//
//        }) { (_) in
//            UIView.animate(withDuration: 0.5, animations: {
//                self.button.titleLabel?.font = UIFont.systemFont(ofSize: 96)
////                self.button.frame = self.getRandomFrame()
//                self.view.setNeedsLayout()
//                self.view.layoutIfNeeded()
//
//            })
//        }
    }
    
    func getRandomFrame() -> CGRect {
        let x = randomCGFloat(min: 0, max: UIScreen.main.bounds.width - 100)
        let y = randomCGFloat(min: 0, max: UIScreen.main.bounds.height - 50)
        let w: CGFloat = 100
        let h: CGFloat = 50
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    internal func readFromStorage() -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    internal func saveToStorage(number: Int) {
        userDefaults.set(number, forKey: key)
    }
    
    internal func resetCounter() {
        saveToStorage(number: 0)
        nummertje = readFromStorage()
        updateViews()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        resetCounter()
    }
}

