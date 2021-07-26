//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    // for send calculate data to calculatePressed button
    var tip = 0.10
    var numberOfPeople = 2
    var totalBill = 0.0
    var finalResult = "0.0"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        // dismiss the keyboard
        billTextField.endEditing(true)
        
        // deselect all button
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // select button which user tapped
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        // dismiss the keyboard
        billTextField.endEditing(true)
        
        //Get the stepper value using sender.value, round it down to a whole number then set it as the text in
        //the splitNumberLabel
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        //Set the numberOfPeople property as the value of the stepper as a whole number.
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        totalBill = Double(bill) ?? 0.0
        // calculate tips + bill per person
        let result = totalBill * (1 + tip) / Double(numberOfPeople)
        finalResult = (String(format: "%.2f", result))
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    // work with animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
            
        }
    }
    
}

