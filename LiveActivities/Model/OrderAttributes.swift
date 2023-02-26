//
//  OrderAttributes.swift
//  LiveActivities
//
//  Created by Gabriel Castillo Serafim on 26/2/23.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    
    typealias ContentState = ContententState
    
    struct ContententState: Codable, Hashable {
        // Live activities will update its view when content state is updated
        var status: Status = .received
        var endTime: Date
    }
    
    // Other properties
    var orderNumber: Int
    var orderItems: String
    var timerName: String
    
}

//MARK: - Order status
enum Status: String, CaseIterable, Codable, Equatable {
    
    // String values are SFSymbol images
    case received = "flag.checkered.2.crossed"
    case progress = "forward"
    case ready = "line.horizontal.star.fill.line.horizontal"
}
