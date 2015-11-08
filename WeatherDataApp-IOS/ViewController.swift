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
let meanURL = "https://weatherdataapp.firebaseio.com/Data"
let medianURL = "https://weatherdataapp.firebaseio.com/Data/Median"

// Create a reference to a Firebase location
var myRootRef = Firebase(url: root_URL)!
var myMeanRef = Firebase(url: meanURL)
var myMedianRef = Firebase(url: medianURL)
// Write data to Firebase


func testFireBase() {
  
    myRootRef.childByAppendingPath("/test").setValue("this is a test")
}

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        
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
//        let myMean = createMeanDictionary()
//        print(myMean)
        let myMedian = createMedianDictionary()
////        print(myMedian)
//        
//        myMeanRef.childByAppendingPath("Mean").setValue(myMean)
        myMeanRef.childByAppendingPath("Median").setValue(myMedian)
       // myMedianRef.setValue(myMedian)
//        for mean in myMean {
//            if mean != nil {  myMeanRef.childByAppendingPath("Mean").setValue(mean)
//            }
//        }
//       for median in myMedian {
//        if median != nil {
//            
//            myMedianRef.setValuesForKeysWithDictionary(median)
//        }
//        
//        }
        
        
    }
    
    func createMeanDictionary() -> ([[String: AnyObject]!]){
        let myData = collapseToSingleDays("weatherdata")
        var dates: [NSDate]
        var meanDictionary: [String: AnyObject]!
        var meanDictionaryArray = [meanDictionary]
                for data in myData {
            
            
            meanDictionary = [String(data.date): ["Temp": data.airTemperatureReading.calculateMean(), "Barometric": data.barometricPressureReading.calculateMean(), "WindSpeed": data.windSpeedReadings.calculateMean()]]
        
            meanDictionaryArray.append(meanDictionary)
            
        }
        
        meanDictionaryArray.removeFirst()
        
        
         return meanDictionaryArray
       
        
    }
    
    func createMedianDictionary() -> ([[String: AnyObject]!]) {
        
        let myData = collapseToSingleDays("weatherdata")
        var dates: [NSDate]
        var medianDictionary: [String: AnyObject]!
        var medianDictionaryArray = [medianDictionary]
        for data in myData {
            
            
            medianDictionary = [String(data.date): ["Temp": data.airTemperatureReading.calculateMedian(), "Barometric": data.barometricPressureReading.calculateMedian(), "WindSpeed": data.windSpeedReadings.calculateMedian()]]
            
            medianDictionaryArray.append(medianDictionary)
            
        }
        
        medianDictionaryArray.removeFirst()
        
        return medianDictionaryArray
        
        
    }

    
    

}

