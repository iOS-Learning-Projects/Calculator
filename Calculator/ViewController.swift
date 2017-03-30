//
//  ViewController.swift
//  Calculator
//
//  Created by Eduardo Vital Alencar Cunha on 27/03/17.
//  Copyright © 2017 Vital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTyping = false
    var valueIsAnInteger = true


    @IBAction func touchDecimalPoint(_ sender: UIButton) {
        if valueIsAnInteger {
            if userIsInTheMiddleOfTyping {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + "."
            } else {
                display.text = "0."
                userIsInTheMiddleOfTyping = true
            }
            valueIsAnInteger = false;
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    private var brain = CalculatorBrain()

    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            valueIsAnInteger = true
        }

        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }

        if let result = brain.result {
            displayValue = result
        }
    }
}
