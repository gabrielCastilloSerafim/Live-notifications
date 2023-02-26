//
//  OrderStatusBundle.swift
//  OrderStatus
//
//  Created by Gabriel Castillo Serafim on 26/2/23.
//

import WidgetKit
import SwiftUI

struct OrderStatusBundle: WidgetBundle {
    var body: some Widget {
        OrderStatus()
        OrderStatusLiveActivity()
    }
}
