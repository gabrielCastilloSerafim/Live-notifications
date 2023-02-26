//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by Gabriel Castillo Serafim on 26/2/23.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct OrderStatus : Widget {
    
    var body: some WidgetConfiguration {
        
        ActivityConfiguration(for: OrderAttributes.self) { context in
            
            // Live activity view
            
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("Main").gradient)
                
                // Order status UI
                VStack {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55, height: 55)
                        
                        // Primary title
                        Text("Servicio de manitas")
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: -2) {
                            ForEach(["Home","Manitas"], id: \.self) { image in
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .background {
                                        Circle()
                                            .fill(Color("Main"))
                                            .padding(-2)
                                    }
                                    .background {
                                        Circle()
                                            .stroke(.white, lineWidth: 1.5)
                                            .padding(-2)
                                    }
                            }
                        }
                    }
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .leading, spacing: 4) {
                            // Secondary Title
                            Text(message(status: context.state.status))
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                            // Subtitle + timer
                            if context.state.status != .ready {
                                Text("\(subMessage(status: context.state.status))\(timer(status: context.state.status, endTime: context.state.endTime), style: .timer)")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                                    .fixedSize(horizontal: false, vertical: true)
                            } else {
                                Text("\(subMessage(status: context.state.status))")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: 13)
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            ForEach(Status.allCases, id: \.self) { type in
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundColor(context.state.status == type ? Color("Main") : .white.opacity(0.7))
                                    .frame(width: context.state.status == type ? 45 : 32,
                                           height: context.state.status == type ? 45 : 32)
                                    .background {
                                        Circle()
                                            .fill(context.state.status == type ? .white : .white.opacity(0.2))
                                    }
                                    // Bottom arrow to look like bubble
                                    .background(alignment: .bottom, content: {
                                        bottomArrow(status: context.state.status, type: type)
                                    })
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .overlay(alignment: .bottom, content: {
                            // Image size = 45 + Trailing Padding = 10
                            // 55/2 = 27.5
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height: 2)
                                .offset(y: 12)
                                .padding(.horizontal, 27.5)
                        })
                        .padding(.leading, 15)
                        .padding(.trailing, -10)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
                }
                .padding(15)
            }
            
        } dynamicIsland: { context in
            
            // Dynamic island view
            
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.leading) {
                    // ..
                }
                DynamicIslandExpandedRegion(.trailing) {
                    // ..
                }
                DynamicIslandExpandedRegion(.center) {
                    // ..
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // ..
                }
                
            } compactLeading: {
                // ..
            } compactTrailing: {
                // ..
                
            } minimal: {
                // ..
            }
        }
    }
    
    // bottomArrow that looks like an arrow
    @ViewBuilder
    func bottomArrow(status: Status, type: Status) -> some View {
        
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment: .bottom) {
                Circle()
                    .fill(.white)
                    .frame(width: 5, height: 5)
                    .offset(y: 13)
            }
    }
    
    // Main title
    func message(status: Status) -> String {
        
        switch status {
            
        case .received:
            return "Empieza pronto"
            
        case .progress:
            return "En andamiento"
            
        case .ready:
            return "Servicio finalizado"
        }
    }
    
    // Sub title
    func subMessage(status: Status) -> String {
        
        switch status {
            
        case .received:
            return "Dentro de: "
            
        case .progress:
            return "Termina en: "
            
        case .ready:
            return "Ya puedes valorar tu servicio!"
        }
    }
    
    // Timer string
    func timer(status: Status, endTime: Date) -> Date {
        
        switch status {
            
        case .received:
            return endTime
            
        case .progress:
            return endTime
            
        case .ready:
            return endTime
        }
    }
    
    
    
}
