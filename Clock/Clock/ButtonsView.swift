//
//  ButtonsView.swift
//  Clock
//
//  Created by Lidia Michela Ambrosanio on 14/11/23.
//

import SwiftUI

struct ButtonsView: View {
        
    
    var StartButton: some View {
        Circle()
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
            .foregroundColor(.green)
            .padding()
           
    }
}

#Preview {
    ButtonsView()
}
