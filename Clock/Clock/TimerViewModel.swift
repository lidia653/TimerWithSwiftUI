//
//  TimerViewModel.swift
//  Clock
//
//  Created by Lidia Michela Ambrosanio on 15/11/23.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var hours = 0
    @Published var minutes = 0
    @Published var seconds = 0
    
    @Published var time = "00:00:00"
    @Published var isActive = false
    @Published var isPaused = false
    @Published var progress = 0.0
    //Represents the formatted remaining time of the countdown in the format "HH:MM:SS
    
    private var initialHours = 0
    private var initialMinutes = 0
    private var initialSeconds = 0
    private var timerDuration = 0.0
    private var endDate = Date()
    
    
    private var pausedTimeRemaining: TimeInterval = 0.0
    
    
    private var pausedHours = 0
    private var pausedMinutes = 0
    private var pausedSeconds = 0
    private var pasuedProgress = 0.0
    
    @Published var timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    func start() {
        isActive = true
        
        let calendar = Calendar.current
        endDate = Date()
        
        endDate = calendar.date(byAdding: .hour, value: hours, to: endDate)!
        endDate = calendar.date(byAdding: .minute, value: minutes, to: endDate)!
        endDate = calendar.date(byAdding: .second, value: seconds, to: endDate)!
        
        initialHours = hours
        initialMinutes = minutes
        initialSeconds = seconds
        
        timerDuration = endDate.timeIntervalSince1970 - Date().timeIntervalSince1970
        
        timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
        
        update()
        //When the start() method is called, it sets the endDate to the current date and adds the specified hours, minutes, and seconds to it, creating the endpoint for the countdown
        
        //The remaining time difference obtained from endDate and the current time is formatted into hours, minutes, and seconds using the Date and Calendar components. Then, it updates the time property with the formatted remaining time.
    }
    func reset() {
        isActive = false
        hours = initialHours
        minutes = initialMinutes
        seconds = initialSeconds
        progress =  0
        timer.upstream.connect().cancel()
        
    }
    
    
    
    func update()
    {
        //If the Date instance represents a date and time before the reference date, this is a negative number. timeIntervalSince1970. Returns the number of seconds between the date and time represented by the Date instance and the start of the Unix epoch, January 1, 1970 at 00:00:00 UTC
        let diff = endDate.timeIntervalSince1970 - Date().timeIntervalSince1970
        
        if diff <= 0 { //when it arrives to 0 it stops the countdown
            isActive = false
            return
        }
        
        var date = Date(timeIntervalSince1970: diff)
        
        // if ora solare <
        // sottrai 1 ora
        
        date = Calendar.current.date(byAdding: .hour, value: -1, to: date)!
        
        let calendar = Calendar.current
        
        let remaininghours =  Int(diff/60/60)//calendar.component(.hour, from: date)
        let remainingminutes =  calendar.component(.minute, from: date)
        let remainingseconds =  calendar.component(.second, from: date)
        
        print(remaininghours, remainingminutes, remainingseconds)
        
        progress = diff / timerDuration
        time = String(format: "%02d:%02d:%02d", remaininghours, remainingminutes, remainingseconds)
    }
    //The action is either a method or closure property that does something when a user clicks or taps the button. The label is a view that describes the button's action — for example, by showing text, an icon, or both.
    
    


    
func pause() {
    timer.upstream.connect().cancel()
    isPaused = true
    
    let diff = endDate.timeIntervalSince1970 - Date().timeIntervalSince1970
    pausedTimeRemaining = max(diff, 0)
}

func resume() {
    isPaused = false
    
    endDate = Date().addingTimeInterval(pausedTimeRemaining)
    timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
}

    
}
    
    /*   func pause(){
     timer.upstream.connect().cancel()
     isPaused = true
     
     let calendar = Calendar.current
     let currentDate = Date()
     
     let diff = endDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970
     let remainingDate = Date(timeIntervalSince1970: diff)
     
     pausedHours = calendar.component(.hour, from: remainingDate)
     pausedMinutes = calendar.component(.minute, from: remainingDate)
     pausedSeconds = calendar.component(.second, from: remainingDate)
     pasuedProgress = diff / timerDuration
     
     
     }
     
     func resume() {
     isPaused = false
     
     let calendar = Calendar.current
     let currentDate = Date()
     
     let diff = endDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970
     let remainingDate = Date(timeIntervalSince1970: diff)
     
     
     
     pausedHours = calendar.component(.hour, from: remainingDate)
     pausedHours = pausedHours-1
     pausedMinutes = calendar.component(.minute, from: remainingDate)
     pausedSeconds = calendar.component(.second, from: remainingDate)
     pasuedProgress = diff / timerDuration
     
     // Calculate the remaining time in seconds
     let remainingTime = TimeInterval((pausedHours * 3600) + (pausedMinutes * 60) + pausedSeconds)
     
     // Update endDate by adding the remaining time to the current date
     
     endDate = calendar.date(byAdding: .second, value: Int(remainingTime), to: currentDate)!
     // Restart the timer with the updated endDate
     timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
     }
     
     
     
     
     
     
     }
     
     
     func resume() {
      isPaused = false // Mark the timer as active when resumed
      
      _ = Calendar.current
      let currentDate = Date()
      
      // Calculate the remaining time based on the paused time components
      let remainingTimeInterval = TimeInterval((pausedHours * 3600) + (pausedMinutes * 60) + pausedSeconds)
      endDate = currentDate.addingTimeInterval(remainingTimeInterval)
      
      _ = endDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970
      progress = pasuedProgress // Set the progress to the paused progress
      
      // Restart the timer
      timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
      
      // Update the countdown
      update()
      }
      
      
      
      
      }*/
     
     
