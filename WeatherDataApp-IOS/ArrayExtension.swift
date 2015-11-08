//
//  ArrayExtension.swift
//  WeatherDataApp-IOS
//
//  Created by Justin Ferre on 11/7/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import Foundation


extension Array {
    
    func calculateMean() -> Double {
        //is array a double
        if self.first is Double {
            
            // cast from generic to double
            
            let doubleArray = self.map { $0 as! Double }
            
            // add all together
            
            let total = doubleArray.reduce(0.0, combine: {$0 + $1 })
            
            let meanAvg = total / Double(self.count)
            return meanAvg
            
        } else {
            
            return Double.NaN
        }
        
    }
    
    
    func calculateMedian() -> Double {
        if self.first is Double {
            
            // cast from generic to double
            
            let doubleArray = self.map { $0 as! Double }
            
            // sort the array
            
          let newArray =  doubleArray.sort{ $0 < $1}
            var medianAvg: Double?
    
            
            if newArray.count % 2 == 0 {
                
                let halfway = newArray.count/2
                
                medianAvg = (newArray[halfway] + newArray[halfway - 1]) / 2
                
                
                
                
            } else {
                
                medianAvg = newArray[newArray.count/2]
                
            }
             return medianAvg!
          
            
            
            
            
            
            
            
        } else {
            
            return Double.NaN
        }
    }
    
        
    


    
}