//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Chau Nguyen on 5/1/16.
//  Copyright © 2016 chautnguyen.com.github. All rights reserved.
//

import Foundation

class TipCalculatorModel {
  
  var total: Double
  var taxPct: Double
  
  // computed property
  var subtotal: Double {
    get {
      return total / (taxPct + 1)
    }
  }
  
  init(total: Double, taxPct: Double) {
    self.total = total
    self.taxPct = taxPct
  }
  
  func calcTipWithTipPct(tipPct: Double) -> (tipAmt: Double, total: Double) {
    let tipAmt = subtotal * tipPct
    let finalTotal = total + tipAmt
    return (tipAmt, finalTotal)
  }
  
  func returnPossibleTips() -> [Int: (tipAmt: Double, total: Double)] {
    let possibleTipsInferred = [0.15, 0.18, 0.20]
    
    var dictTips = [Int: (tipAmt: Double, total: Double)]() // Dictionary declaration
    for possibleTip in possibleTipsInferred {
      let intPct = Int(possibleTip*100)
      dictTips[intPct] = calcTipWithTipPct(possibleTip)
    }
    
    return dictTips
  }
  
}
