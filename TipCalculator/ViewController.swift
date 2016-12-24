//
//  ViewController.swift
//  TipCalculator
//
//  Created by Zixing Li on 12/24/16.
//  Copyright © 2016 Zixing Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var numPeopleField: UITextField!
    @IBOutlet weak var avgTotalLabel: UILabel!
    @IBOutlet weak var avgTipLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // make billField the first reponder with keyboard showing up
        self.billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func CalculateTip(_ sender: AnyObject) {
        
        let percentages = [0.15, 0.18, 0.20]
        
        let bill = Double(billField.text!) ?? 0
        let numPeople = Double(numPeopleField.text!) ?? 1
        let tip = bill * percentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let avgTip = tip / numPeople
        let avgTotal = total / numPeople
        
        // locale specific symbols:
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = NSLocale.current
        
//        tipLabel.text = String(format: "$%.2f", tip)
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))
//        totalLabel.text = String(format: "$%.2f", total)
//        avgTipLabel.text = String(format: "$%.2f", avgTip)
//        avgTotalLabel.text = String(format: "$%.2f", avgTotal)
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))
        avgTipLabel.text = currencyFormatter.string(from: NSNumber(value: avgTip))
        avgTotalLabel.text = currencyFormatter.string(from: NSNumber(value: avgTotal))

    }

    
}

