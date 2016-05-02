//
//  ViewController.swift
//  TipCalculator
//
//  Created by Chau Nguyen on 5/1/16.
//  Copyright © 2016 chautnguyen.com.github. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

  @IBOutlet var totalTextField : UITextField!
  @IBOutlet var taxPctSlider : UISlider!
  @IBOutlet var taxPctLabel : UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
  
  var possibleTips = Dictionary<Int, (tipAmt: Double, total: Double)>()
  var sortedKeys:[Int] = []
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sortedKeys.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
    
    let tipPct = sortedKeys[indexPath.row]
    let tipAmt = possibleTips[Int(tipPct)]!.tipAmt
    let total = possibleTips[Int(tipPct)]!.total
    
    cell.textLabel?.text = "\(tipPct)%:"
    cell.detailTextLabel?.text = String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
    
    return cell
  }
  
  @IBAction func calculateTapped(sender : AnyObject) {
    tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
    possibleTips = tipCalc.returnPossibleTips()
    sortedKeys = Array(possibleTips.keys).sort()
    tableView.reloadData()
  }
  
  @IBAction func taxPercentageChanged(sender : AnyObject) {
    tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
    refreshUI()
  }
  
  @IBAction func viewTapped(sender : AnyObject) {
    totalTextField.resignFirstResponder()
  }
  
  private func refreshUI() {
    totalTextField.text = String(format: "%0.2f", tipCalc.total)
    taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
    taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%):"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    refreshUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

