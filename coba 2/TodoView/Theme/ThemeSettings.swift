//
//  ThemeSettings.swift
//  coba2
//  kami cinta venti tapi dia cwk
//  Created by Ahmad Miftah Syakir on 25/02/21.
//

// get = ngambil data
// set = memproses data

import SwiftUI

public class ThemeSettings: ObservableObject {
    @Published public var  themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
    private init () {}
    public static let shared = ThemeSettings()//Keqing wangy wangy
}
