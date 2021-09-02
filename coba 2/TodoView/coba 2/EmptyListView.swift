//
//  EmptyListView.swift
//  coba 2
//
//  Created by Ahmad Miftah Syakir on 18/02/21.
//

import SwiftUI

struct EmptyListView: View {
    @State private var  isAnimated : Bool = false
    
    let images :  [String] = [
        "illustration-no1",
        "illustration-no2",
        "illustration-no3"
    ]
    
    let tips : [String] = [
        "jangan bunuh diri",
        "apabila kamu berjanji laksanakanlh",
        "Kamu bodoh",
        "Bermainlah untuk relax",
        "push jgn tengah malam",
        "rachel lucu bet njir"
    ]
    var body: some View {
        ZStack{
            VStack(alignment: .center , spacing: 20){
                Image("\(images.randomElement() ?? self.images[0])")
                    .resizable()
                    .frame(minWidth: 265, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                Text("\(tips.randomElement() ?? self.tips[0])").font(.system(.headline, design: .rounded))
            }
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)  //bentuk if else lbih singkat
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration:  1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }
        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
        .background(Color("colorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
