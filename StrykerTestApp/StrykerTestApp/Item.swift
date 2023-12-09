//
//  Item.swift
//  StrykerTestApp
//
//  Created by Mudit Jain on 09/12/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    let id = UUID()
    var name: String
    var location: String
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
