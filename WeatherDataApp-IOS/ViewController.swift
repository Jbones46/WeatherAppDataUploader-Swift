//
//  ViewController.swift
//  WeatherDataApp-IOS
//
//  Created by Justin Ferre on 11/7/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import UIKit
import Firebase
let root_URL = "https://weatherdataapp.firebaseio.com"
let rootURL = "https://resplendent-inferno-6149.firebaseio.com"

// Create a reference to a Firebase location
var myRootRef = Firebase(url: root_URL)!
// Write data to Firebase
func testFireBase() {
  
    myRootRef.childByAppendingPath("/test").setValue("this is a test")
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collapseToSingleDays(file: String) -> [Day] {
        //create an array to hold data
        
        var daysArray = [Day]()
        
        //get file path of file
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "txt")
        //create and convert a date formatter
        print(path)
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "PST")
        formatter.dateFormat = "yyyy_MM_dd"
        
        
        //read file as a string
        
        do {  let fultext = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            
            let readings = fultext.componentsSeparatedByString("\n") as [String]!
            
            
            for i in 1..<readings.count {
                // break apart the array into new arrays by tabs "/t"
                let weatherData = readings[i].componentsSeparatedByString("\t")
                let dateTime = weatherData[0]
                let adjust = dateTime.startIndex.advancedBy(10)
                let justDate = String(dateTime.substringToIndex(adjust))
                
                
                
                //
                let dateOfCurrentReading = formatter.dateFromString(justDate)
                
                // get weather values, convert from string to double
                
                let tempuratureValue = NSNumberFormatter().numberFromString(weatherData[1])!.doubleValue
                let pressureValue = NSNumberFormatter().numberFromString(weatherData[2])!.doubleValue
                let windPressureValue = NSNumberFormatter().numberFromString(weatherData[7])!.doubleValue
                
                // checking if day is empty or if starting a new day
                
                
                if daysArray.count == 0 || (daysArray[daysArray.count - 1].date != dateOfCurrentReading) {
                    //create new day struct and append to days array
                    
                    let newDay = Day(initialDate: dateOfCurrentReading!)
                    daysArray.append(newDay)
                    
                    
                    
                    
                }
                
                //add current readings to the most recent day
                
                daysArray[daysArray.count - 1].barometricPressureReading.append(pressureValue)
                daysArray[daysArray.count - 1].windSpeedReadings.append(windPressureValue)
                daysArray[daysArray.count - 1].airTemperatureReading.append(tempuratureValue)
                
                
                
                
                
            }
           
            
        } catch {
            print(error)
        }
        
        return daysArray
        
    }
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        testFireBase()
//        let test = collapseToSingleDays("weatherdata")
//        print(test)
    }
    

}

