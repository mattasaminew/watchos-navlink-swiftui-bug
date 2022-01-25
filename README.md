#  SwiftUI Bug using NavigationLink inside a TabView on watchOS 8.1+
When a `NavigationLink` is triggered from inside of a `TabView` on watchOS 8.1+, it is producing unexpected results.

## watchOS 8.0
NavigationLink goes to the expected destination. Navigates back to home screen via navigation bar. (expected result)

![Alt Text](https://github.com/mattasaminew/watchos-navlink-swiftui-bug/blob/main/watchOS%208.0%20Simulator.gif)

## watchOS 8.3
NavigationLink attempts to go to expected destination but immediately pops from stack (unexpected result)

![Alt Text](https://github.com/mattasaminew/watchos-navlink-swiftui-bug/blob/main/watchOS%208.3%20Simulator.gif)
