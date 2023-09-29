import Foundation
import MapLibre
import InternalUtils
import MapLibreSwiftMacros

// TODO: Other properties and their modifiers
@MLNStyleProperty<UIColor>("lineColor", supportsInterpolation: true)
@MLNRawRepresentableStyleProperty<LineCap>("lineCap")
@MLNRawRepresentableStyleProperty<LineJoin>("lineJoin")
@MLNStyleProperty<Float>("lineWidth", supportsInterpolation: true)
public struct LineStyleLayer: SourceBoundStyleLayerDefinition {
    public let identifier: String
    public var insertionPosition: LayerInsertionPosition = .aboveOthers
    public var isVisible: Bool = true
    public var maximumZoomLevel: Float? = nil
    public var minimumZoomLevel: Float? = nil

    public var source: StyleLayerSource

    public init(identifier: String, source: Source) {
        self.identifier = identifier
        self.source = .source(source)
    }

    public init(identifier: String, source: MLNSource) {
        self.identifier = identifier
        self.source = .mglSource(source)
    }

    public func makeStyleLayer(style: MLNStyle) -> StyleLayer {
        let styleSource = addSource(to: style)

        return LineStyleLayerInternal(definition: self, mglSource: styleSource)
    }
}

private struct LineStyleLayerInternal: StyleLayer {
    private var definition: LineStyleLayer
    private let mglSource: MLNSource

    public var identifier: String { definition.identifier }
    public var insertionPosition: LayerInsertionPosition {
        get { definition.insertionPosition }
        set { definition.insertionPosition = newValue }
    }
    public var isVisible: Bool {
        get { definition.isVisible }
        set { definition.isVisible = newValue }
    }
    public var maximumZoomLevel: Float? {
        get { definition.maximumZoomLevel }
        set { definition.maximumZoomLevel = newValue }
    }
    public var minimumZoomLevel: Float? {
        get { definition.minimumZoomLevel }
        set { definition.minimumZoomLevel = newValue }
    }

    init(definition: LineStyleLayer, mglSource: MLNSource) {
        self.definition = definition
        self.mglSource = mglSource
    }

    public func makeMLNStyleLayer() -> MLNStyleLayer {
        let result = MLNLineStyleLayer(identifier: identifier, source: mglSource)

        result.lineColor = definition.lineColor
        result.lineCap = definition.lineCap
        result.lineWidth = definition.lineWidth
        result.lineJoin = definition.lineJoin

        return result
    }
}
