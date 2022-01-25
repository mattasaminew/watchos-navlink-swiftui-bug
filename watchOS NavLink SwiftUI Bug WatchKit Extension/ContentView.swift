//
//  ContentView.swift
//  watchOS NavLink SwiftUI Bug WatchKit Extension
//
//  Created by Matthew Asaminew on 2022-01-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView() {
            TabView {
                NavigationLink(destination: {
                    Text("Hello, world 1")
                        .navigationTitle("New Page 1")
                }, label: {
                    Text("Go to page 1")
                })
                
                NavigationLink(destination: {
                    Text("Hello, world 2")
                        .navigationTitle("New Page 2")
                }, label: {
                    Text("Go to page 2")
                })
                
                NavigationLink(destination: {
                    Text("Hello, world 3")
                        .navigationTitle("New Page 3")
                }, label: {
                    Text("Go to page 3")
                })
            }
            .navigationTitle("Home")
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
