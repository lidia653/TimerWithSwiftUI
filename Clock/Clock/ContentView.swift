//
//  ContentView.swift
//  Clock
//
//  Created by Lidia Michela Ambrosanio on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var TimerVM  = TimerViewModel()
    
    @State private var hours: Int=0
    @State private var minutes: Int=0
    @State private var seconds: Int=0
    //creates a local state where you can store your numbers, you need a variable for each picker otherwise it doesn't work.
    
    //the $ symbol is like a pointer in C++
    
    var body: some View {
        
        
        
        VStack(spacing: 30) {
            Text("Timers")
            
            
            
            
            
            if TimerVM.isActive{
                
             
                TimerCountdownView(TimerVM: TimerVM)
                    .frame(width: 350)
                    .font(.largeTitle)
                    .fontWeight(.light)
                
              
                HStack {
                    ButtonStyleView(buttonText: "cancel", buttonColor: .gray)
                        .padding()
                        .onTapGesture {
                            TimerVM.reset()
                        }
                    
                    
                    Spacer()
                    
                    if TimerVM.isPaused == false {
                        ButtonStyleView(buttonText: "pause", buttonColor: .orange)
                            .padding()
                            .onTapGesture {
                                TimerVM.pause()
                            }
                    } else{
                        
                        ButtonStyleView(buttonText: "resume", buttonColor: .green)
                            .padding()
                            .onTapGesture {
                                TimerVM.resume()
                            }
                    }
                    
                }
                
                
                
            } else {
                VStack{
                    TimerPicker(TimerVM: TimerVM)
                    HStack {
                        ButtonStyleView(buttonText: "cancel", buttonColor: .gray)
                            .padding()
                            .onTapGesture {
                                TimerVM.reset()
                            }
                        
                        Spacer()
                        
                        ButtonStyleView(buttonText: "start", buttonColor: .green)
                            .padding()
                            .onTapGesture {
                                TimerVM.start()
                            }
                        
                    }
                }
                
                
                
            }
            
     
            
            
        }
    }
}

struct CircleProgressView: View {
    @ObservedObject var TimerVM: TimerViewModel
    var body: some View {
        ZStack{
            Circle()
                .stroke(
                    .gray.opacity(0.2),
                    style: StrokeStyle(lineWidth: 10)
                )
            Circle()
                .trim(from:0, to: TimerVM.progress)
                .stroke(
                    .orange,
                    style: StrokeStyle(lineWidth: 10,
                                       lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            //makes the animation start at teh center of the screen
        }
    }
}








struct TimerPicker: View {
    
    @ObservedObject var TimerVM: TimerViewModel
    
    var body: some View {
        HStack{
            //picker for hours
            ZStack {
                Text("hours")
                    .bold()
                    .offset(x:45)
                
                Picker("hours", selection: $TimerVM.hours){
                    ForEach(0...59, id:\.self) {number in
                        Text("\(number)")
                        // .tag(hours)
                    }
                    
                }
                .pickerStyle(.wheel)
                .padding(.trailing, -16)
            }
            
            //picker for minutes
            ZStack {
                Text("min")
                    .bold()
                    .offset(x:50)
                Picker("minutes", selection: $TimerVM.minutes){
                    ForEach(0...60, id:\.self) {number in
                        Text("\(number)")
                        //                                    .tag(minutes)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.trailing, -16)
            }
            
            //picker for seconds
            ZStack {
                Text("sec")
                    .bold()
                    .offset(x:45)
                Picker("seconds", selection: $TimerVM.seconds){
                    ForEach(0...60, id:\.self) {number in
                        Text("\(number)")
                        //.tag(TimerVM.seconds)
                        //   Use this modifier to differentiate among certain selectable views, like the possible values of a Picker or the tabs of a TabView
                    }
                }
                .pickerStyle(.wheel)
                .padding(.trailing, -16)
            }
        }
        
    }
}





struct TimerCountdownView: View {
    
    @ObservedObject var TimerVM: TimerViewModel
    
    
    
    var body: some View {
        ZStack(){
            CircleProgressView(TimerVM: TimerVM)
                .padding()
            
            Text(TimerVM.time)
                .onReceive(TimerVM.timer) { _ in
                    TimerVM.update()
            }
        }
        
       
        
      /*  VStack {
            Text(TimerVM.time)
                .onReceive(timer) { _ in
                    TimerVM.update()
            }
            ButtonStyleView(buttonText: "resume", buttonColor: .green)
                .padding()
                .onTapGesture {
                    TimerVM.reset()
                }
            
        
        }*/
    }
}
//Whenever the timer fires (every second in this case), it triggers the update() method in the TimerViewModel to update the time displayed in the view.





struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
            .preferredColorScheme(.dark)
    }
}

