//
//  ViewController.swift
//  LemonStand
//
//  Created by Morgan Le Gal on 8/5/15.
//  Copyright (c) 2015 Morgan Le Gal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonStockLabel: UILabel!
    @IBOutlet weak var iceCubeStockLabel: UILabel!
    
    @IBOutlet weak var lemonsToBuyLabel: UILabel!
    @IBOutlet weak var iceCubesToBuyLabel: UILabel!

    @IBOutlet weak var lemonsToMixLabel: UILabel!
    @IBOutlet weak var iceCubesToMixLabel: UILabel!

    @IBOutlet weak var weatherImageView: UIImageView!
    
    var money = 10
    var lemonsStock = 1
    var iceCubesStock = 1
    
    var lemonsToBuy = 0
    var iceCubesToBuy = 0
    
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    var moneyEarned = 0
    
    var customerVariationDueToWeather = 0

    func updateWeather()
    {
        var randomWeather = Int(arc4random_uniform(UInt32(4)))
        
        switch randomWeather
        {
            case 0:
                weatherImageView.image = UIImage(named: "Cold")
                customerVariationDueToWeather = -3
            case 1:
                weatherImageView.image = UIImage(named: "Mild")
                customerVariationDueToWeather = 0
            case 2:
                weatherImageView.image = UIImage(named: "Warm")
                customerVariationDueToWeather = 4
            default:
                weatherImageView.image = UIImage(named: "Mild")
                customerVariationDueToWeather = 0
        }
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton)
    {
        var lemonadeRatio = Double(lemonsToMix) / Double(iceCubesToMix)
        var customersNumber = Int(arc4random_uniform(UInt32(11)))
        
        if customersNumber > abs(customerVariationDueToWeather){
           customersNumber + customerVariationDueToWeather
        }
        else{
            customersNumber = 0
        }
        var customersFavorsAcidicLemonade = 0
        var customersFavorsNeutralLemonade = 0
        var customersFavorsDilutedLemonade = 0
        var customerPreference:[Double] = []
        
        
        for var customer = 1; customer <= customersNumber; customer++
        {
            var randomPreference = Double(arc4random_uniform(UInt32(11))) / 10.0
            customerPreference.append(randomPreference)
            
            if randomPreference < 0.4
            {
                customersFavorsAcidicLemonade++
                if lemonadeRatio > 1
                {
                    moneyEarned += 1
                }
            }
            else if randomPreference >= 0.4 && randomPreference < 0.6
            {
                customersFavorsNeutralLemonade++
                if lemonadeRatio == 1
                {
                    moneyEarned += 1
                }
            }
            else
            {
                customersFavorsDilutedLemonade++
                if lemonadeRatio < 1
                {
                    moneyEarned += 1
                }
            }
        }
        
        if moneyEarned > 0
        {
            self.showAlertWithText(header: "Congratulations", message: "You won $\(moneyEarned)!")
        }
        else
        {
            self.showAlertWithText(header: "Try Again", message: "You didn't win any money...")
        }
        
        //println(customersNumber)
        //println(customerPreference)
        //println(customersFavorsAcidicLemonade)
        //println(customersFavorsNeutralLemonade)
        //println(customersFavorsDilutedLemonade)
        //println(moneyEarned)
        
        self.resetValuesAfterDay()
        self.updateLabels()
        self.updateWeather()
        
    }
    
    @IBAction func moreLemonsToBuyButtonPressed(sender: AnyObject) {
        if money >= 2
        {
            lemonsStock += 1
            money -= 2
            lemonsToBuy += 1
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "Not enough money")
        }
    }
    
    @IBAction func lessLemonsToBuyButtonPressed(sender: UIButton) {
        if lemonsToBuy > 0 && lemonsStock > 0
        {
            lemonsToBuy -= 1
            lemonsStock -= 1
            money += 2
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "No more Lemons in the basket")
        }
    }
    
    @IBAction func moreIceCubesToBuyButtonPressed(sender: UIButton) {
        if money >= 1
        {
            iceCubesStock += 1
            money -= 1
            iceCubesToBuy += 1
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "No more money")
        }
    }
    
    @IBAction func lessIceCubesToBuyButtonPressed(sender: UIButton) {
        if iceCubesToBuy > 0 && iceCubesStock > 0
        {
            iceCubesToBuy -= 1
            iceCubesStock -= 1
            money += 1
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "No more Ice Cubes in the basket")
        }
    }
    
    @IBAction func moreLemonsToMixButtonPressed(sender: UIButton) {
        if lemonsStock >= 1
        {
            lemonsStock -= 1
            lemonsToMix += 1
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "No more lemons in stock")
        }
    }
    
    @IBAction func lessLemonsToMixButtonPressed(sender: UIButton) {
        if lemonsToMix >= 1
        {
            lemonsStock += 1
            lemonsToMix -= 1
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "No more lemons in basket")
        }
    }
    
    @IBAction func moreIceCubesToMixButtonPressed(sender: UIButton) {
        if iceCubesStock >= 1
        {
            iceCubesStock -= 1
            iceCubesToMix += 1
            
            self.updateLabels()
        }
        else
        {
            println("warning: no more ice cubes in stock")
        }
    }
    
    @IBAction func lessIceCubesToMixButtonPressed(sender: UIButton) {
        if iceCubesToMix >= 1
        {
            iceCubesStock += 1
            iceCubesToMix -= 1
            
            self.updateLabels()
        }
        else
        {
            self.showAlertWithText(message: "No more Ice Cubes in the basket")
        }
    }
    
    func resetValuesAfterDay()
    {
        money += moneyEarned
        
        iceCubesToMix = 0
        lemonsToMix = 0
        
        lemonsToBuy = 0
        iceCubesToBuy = 0
    }
    
    func updateLabels()
    {
        moneyLabel.text = "$\(money)"
        
        lemonStockLabel.text = "\(lemonsStock) Lemons"
        lemonsToMixLabel.text = "\(lemonsToMix)"
        lemonsToBuyLabel.text = "\(lemonsToBuy)"
        
        iceCubeStockLabel.text = "\(iceCubesStock) Ice Cubes"
        iceCubesToMixLabel.text = "\(iceCubesToMix)"
        iceCubesToBuyLabel.text = "\(iceCubesToBuy)"
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

