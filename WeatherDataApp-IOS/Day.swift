//
//  Day.swift
//  WeatherDataApp-IOS
//
//  Created by Justin Ferre on 11/7/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import Foundation
import Firebase


struct Day {
    var date: NSDate
    
    //arrays to hold all readings for one day
    
    var windSpeedReadings = [Double]()
    var barometricPressureReading = [Double]()
    var airTemperatureReading = [Double]()
    
    init(initialDate: NSDate){
        
        self.date = initialDate
    }
    
    
}