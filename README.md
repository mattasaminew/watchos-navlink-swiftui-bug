#  SwiftUI Bug using NavigationLink inside a TabView on watchOS 8.1+
When a `NavigationLink` is triggered from inside of a `TabView` on watchOS 8.1+, it is producing unexpected results.

## watchOS 8.0
NavigationLink goes to the expected destination (expected result)

## watchOS 8.3
NavigationLink attempts to go to expected destination but immediately pops from stack (unexpected result)

