//
//  ContentView.swift
//  LiveActivities
//
//  Created by Gabriel Castillo Serafim on 26/2/23.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ContentView: View {
    
    //MARK: - Updating live activity
    
    @State var currentID: String = ""
    @State var currentSelection: Status = .received
    
    var body: some View {
        VStack {
            
            Picker(selection: $currentSelection) {
                Text("About To Start")
                    .tag(Status.received)
                Text("In Progress")
                    .tag(Status.progress)
                Text("Done")
                    .tag(Status.ready)
            } label: {}
                .labelsHidden()
                .pickerStyle(.segmented)

            
           // Initializing Activity
            Button("Start Activity") {
                addLiveActivity()
            }
            .padding(.top)
            
            // Removing activity
            Button("Remove Activity") {
                removeActivity()
            }
            .padding(.top)
            
            // Removing activity
            Button("Change Time") {
                updateActivity()
            }
            .padding(.top)
        }
        .navigationTitle("Live activities")
        .padding(15)
        .onChange(of: currentSelection) { newValue in
            
            // Retrieving current activity from list of phone activities
            if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
                activity.id == currentID
            }) {
                print("Activity found")
                
                // Since we need to show animation set Im delaying action for 2 seconds IN REAL CASE SCENARIO REMOVE DELAY
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    
                    var updatedState = activity.contentState
                    updatedState.status = currentSelection
                    Task {
                        await activity.update(using: updatedState)
                    }
                })
            }
            
        }
    }
    
    func removeActivity() {
        
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }) {
            Task {
                await activity.end(using: activity.contentState, dismissalPolicy: .immediate)
            }
        }
    }
    
    func addLiveActivity() {
        let orderAttributes = OrderAttributes(orderNumber: 1234, orderItems: "Burger & Milk Shake", timerName: "some timer name")
        // Since it does not requires any initial values
        // If your content state struct contains initializers then you must pass it here
        let initialContentState = OrderAttributes.ContentState(endTime: Date().addingTimeInterval(60 * 30))
        
        do {
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, contentState: initialContentState, pushType: nil)
            
            // Storing currentID for updating activity
            currentID = activity.id
            
            print("Activity added successfully. id: \(activity.id)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateActivity() {
        
        let newEndTime =  Date().addingTimeInterval(60 * 120)
        
        // Retrieving current activity from list of phone activities
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }) {
            print("Activity found")
            
            // Since we need to show animation set Im delaying action for 2 seconds IN REAL CASE SCENARIO REMOVE DELAY
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                
                var updatedState = activity.contentState
                updatedState.endTime = newEndTime
                Task {
                    await activity.update(using: updatedState)
                }
            })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
