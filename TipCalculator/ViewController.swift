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
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "default.tippercent")
        let billRefDate = UserDefaults.standard.object(forKey: "defaults.billDate") as? NSDate
        let peopleRefDate = UserDefaults.standard.object(forKey: "defaults.peopleDate") as? NSDate
        if ((billRefDate != nil && integer_t(NSDate().timeIntervalSince(billRefDate! as Date)) < 600) || (peopleRefDate != nil && integer_t(NSDate().timeIntervalSince(peopleRefDate! as Date)) < 600)){
            billField.text = UserDefaults.standard.object(forKey: "defaults.billValue") as? String
            numPeopleField.text = UserDefaults.standard.object(forKey: "default.numPeopleValue") as? String

        }
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func persistBillValue() {
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "defaults.billValue")
        defaults.set(numPeopleField.text, forKey: "defaults.numPeopleValue")
        defaults.set(NSDate(), forKey: "defaults.billDate")
        defaults.set(NSDate(), forKey: "defaults.peopleDate")
        defaults.synchronize()
    }
    
    @IBAction func CalculateTip(_ sender: Any) {
        persistBillValue()

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
        currencyFormatter.locale = NSLocale.current
        
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))
        avgTipLabel.text = currencyFormatter.string(from: NSNumber(value: avgTip))
        avgTotalLabel.text = currencyFormatter.string(from: NSNumber(value: avgTotal))

    }

    
}

