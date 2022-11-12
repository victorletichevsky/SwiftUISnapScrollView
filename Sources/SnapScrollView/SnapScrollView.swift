import SwiftUI

@available(iOS 14.0, *)
public struct SnapScrollView<Content: View>: View {
    
    public enum Alignments {
        case vertical, horizontal
    }
    
    var alignment: Alignments
    
    var content: Content
    
    public init(alignment: Alignments, @ViewBuilder _ content: () -> Content) {
        self.alignment = alignment
        self.content = content()
    }
    
    public var body: some View {
        snapScrollView(alignment: alignment)
    }

    public var vertical: some View {
        GeometryReader { proxy in
            TabView {
                Group {
                    content
                }
                .frame(width: proxy.size.height, height: proxy.size.height)
                .rotationEffect(.degrees(270))
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    public var horizontal: some View {
        GeometryReader { proxy in
            TabView {
                Group {
                   content
                }
                .frame(width: proxy.size.width, height: proxy.size.height + 50)
                .rotationEffect(.degrees(0))
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    @ViewBuilder
    public func snapScrollView(alignment: Alignments) -> some View {
        switch alignment {
        case .vertical:
            vertical
        case .horizontal:
            horizontal
        }
    }
}
