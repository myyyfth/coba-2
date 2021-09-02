//
//  SettingsView.swift
//  coba 2
//
//  Created by Ahmad Miftah Syakir on 22/02/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    @state private var isThemeChanged: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Form{
                    
                    Section(header: Text("Choose the app icon")){
                                      Picker(selection: $iconSettings.currentIndex, label: Text("App Icons")){
                                         ForEach(0..<iconSettings.iconNames.count){index in
                                            HStack{
                                               Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                                  .renderingMode(.original)
                                                  .resizable()
                                                  .scaledToFit()
                                                  .frame(width: 44,height: 44)
                                                  .cornerRadius(8)
                                               
                                               Spacer().frame(width: 8)
                                               
                                               Text(self.iconSettings.iconNames[index] ?? "Blue")
                                                  .frame(alignment: .leading)
                                            }
                                            .padding(3)
                                         }
                                      }
                                      .onReceive([self.iconSettings.currentIndex].publisher.first()){
                                         (value) in
                                         let index = self.iconSettings.iconNames.firstIndex(of:
                                                                                               UIApplication.shared.alternateIconName) ?? 0
                                         if index != value {
                                            UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){
                                               error in
                                               if let error = error {
                                                  print(error.localizedDescription)
                                               }else{
                                                  print("Success")
                                               }
                                            }
                                         }
                                      }
                                   }
                    
                    .padding(.vertical,3)
                    
                    Section(header:
                                HStack{
                                    Text("Choose the app theme")
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 10,height: 10)
                                        .foregroundColor(themes[self.theme.ThemeSettings].themeColor)
                                    
                                }
                    ){
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standart.set(self.theme.themeSettings, forkey:"Theme")
                                    self.isThemeChanged.toggle()
                                }){
                                    HStack{
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        
                                        Text(item.themeName)
                                    }
                                    
                                }.accentColor(Color.primary)
                            }
                        }
                    }
                    .padding(.vertical,3)
                    .alert(isPresented: $isthemeChanged) {
                        Alert(
                            title: Text("Success"),
                            message: Text("tema sudah keganti menjadi\(themes[self.theme.themeSettings].themeName)!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    
                    Section(header: Text("follow anjir GC otak udang")){
                        FormRowLinkView(icon: "globe", color: Color.blue, text: "My website", link: "https://www.instagram.com/myyyfth__s/?hl=id")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twiter:", link: "https://twitter.com/p21112749")
                        FormRowLinkView(icon: "checkmark.seal", color: Color.purple, text: "instagram", link: "https://www.instagram.com/myyyfth__s/?hl=id")
                    }
                    .padding(.vertical,3)
                    
                    Section(header: Text("about the application")){
                        FormRowStaticView(icon: "gear", fristText: "UIApplication", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", fristText: "Compatibility", secondText: "iphone,ipad")
                        FormRowStaticView(icon: "keyboard", fristText: "Devoloper", secondText: "GW")
                        FormRowStaticView(icon: "flag", fristText: "version", secondText: "1.1.0")
                    }
                    .padding(.vertical,3)
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)//style horizontal yang tepi kanan dan kiri ny ga rapet ke kanan ke kiri.kalo styleyang lain nama nya .compact = fungsi ny kebalikan yg regulary
                
                Text("Copyright all rihgts reserved. less code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(.secondary)
            }
            
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }){
                                        Image(systemName: "xmark")
                                    }
            )            .navigationBarTitle("settings",displayMode: .inline)
            .background(Color("ColorBase")).edgesIgnoringSafeArea(.all)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
