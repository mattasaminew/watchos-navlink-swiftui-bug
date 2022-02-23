//
//  Workaround.swift
//  watchOS NavLink SwiftUI Bug WatchKit Extension
//
//  Created by Matthew Asaminew on 2022-01-25.
//

import SwiftUI

struct PageView<Content: View>: View {
    private let pageSpacing: CGFloat = 5
    
    @GestureState private var translation: CGFloat = 0
    @FocusState var focusedPage: Int?
    @State var currentIndex: Int = 0
    var onPageHandlers: [(Int) -> Void] = []
    
    let pages: [IdentifiableView<Content>]
    var pageCount: Int { pages.count }
    
    init(pages: [Content]) {
        self.pages = pages.map(\.asIdentifiable)
    }
    
    private func calculatedOffset(screenWidth: CGFloat) -> CGFloat {
        let pageOffset = screenWidth * -CGFloat(currentIndex)
        let spacingOffset = pageSpacing * -CGFloat(currentIndex)
        return pageOffset + spacingOffset + translation
    }
    
    private func calculatedIndex(translation: CGFloat, screenWidth: CGFloat) -> Int {
        let offset = translation / screenWidth
        let newIndex = Int((CGFloat(currentIndex) - offset).rounded())
        let thresholdIndex = max(newIndex, 0)
        let maxIndex = pageCount - 1
        return min(thresholdIndex, maxIndex)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: pageSpacing) {
                    ForEach(pages.indices) { index in
                        pages[index]
                            .frame(width: geometry.size.width)
                            .focused($focusedPage, equals: index)
                    }
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: calculatedOffset(screenWidth: geometry.size.width))
                .animation(.interactiveSpring())
                .highPriorityGesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        let index = calculatedIndex(translation: value.translation.width, screenWidth: geometry.size.width)
                        self.currentIndex = index
                        self.focusedPage = index
                    }
                )
                
                HStack(spacing: 5) {
                    ForEach(0..<pageCount) { index in
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(.white)
                            .opacity(index == currentIndex ? 1 : 0.25)
                            
                    }
                }
                .padding(.bottom, 3)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onChange(of: focusedPage) { index in
            if let index = index {
                onPageHandlers.forEach { $0(index) }
            }
        }
    }
}

extension PageView {
    func onPage(_ callback: @escaping (Int) -> Void) -> Self {
        var copy = self
        copy.onPageHandlers.append(callback)
        return copy
    }
}

struct IdentifiableView<Content: View>: Identifiable, View {
    let id = UUID()
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}

extension View {
    var asIdentifiable: IdentifiableView<Self> {
        return IdentifiableView { self }
    }
}
