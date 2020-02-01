//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import Swift
import SwiftUI
import UIKit

/// A SwiftUI port of `UIPageControl`.
public struct PageControl {
    public let numberOfPages: Int
    public let currentPage: Binding<Int>
    
    public init(numberOfPages: Int, currentPage: Binding<Int>) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
    }
}

// MARK: - Protocol Implementations -

extension PageControl: UIViewRepresentable {
    public class Coordinator: NSObject {
        public var parent: PageControl
        
        public init(_ parent: PageControl) {
            self.parent = parent
        }
        
        @objc public func updateCurrentPage(sender: UIViewType) {
            parent.currentPage.wrappedValue = sender.currentPage
        }
    }
    
    public typealias UIViewType = UIPageControl
    
    public func makeUIView(context: Context) -> UIViewType {
        let uiView = UIPageControl()
        
        uiView.numberOfPages = numberOfPages
        uiView.pageIndicatorTintColor = Color.accentColor.toUIColor()
        
        uiView.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
        
        return uiView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.currentPage = currentPage.wrappedValue
        uiView.numberOfPages = numberOfPages
    }
    
    public func makeCoordinator() -> Coordinator {
        .init(self)
    }
}

#endif
