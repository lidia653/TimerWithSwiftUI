//
//  ButtonStyleView.swift
//  Clock
//
//  Created by Lidia Michela Ambrosanio on 14/11/23.
//

import SwiftUI

struct ButtonStyleView: View {
    var buttonText = "Button"
    var buttonColor = Color(.green)
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .foregroundColor(buttonColor)
                .opacity(0.4)
            Text(buttonText)
                .bold()
                
            
            Circle()
                .stroke(lineWidth: 3 )
                .frame(width: 110, height: 110)
                .foregroundColor(buttonColor)
                .opacity(0.4)
         
            
        }
    }
}
#Preview {
    ButtonStyleView()
}
