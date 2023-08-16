import XCTest
import Mapbox
@testable import MapLibreSwiftUI

final class ShapeSourceTests: XCTestCase {
    func testShapeSourcePolylineShapeBuilder() throws {
        // Ideally in a style context, these colud be tested at compile time to
        // ensure there are no duplicate IDs.
        let shapeSource = ShapeSource(identifier: "foo") {
            MGLPolyline(coordinates: samplePedestrianWaypoints)
        }

        XCTAssertEqual(shapeSource.identifier, "foo")

        switch shapeSource.data {
        case .shapes(let shapes):
            XCTAssertEqual(shapes.count, 1)
        default:
            XCTFail("Expected a shape source")
        }
    }

    func testShapeSourcePolylineFeatureBuilder() throws {
        let shapeSource = ShapeSource(identifier: "foo") {
            MGLPolylineFeature(coordinates: samplePedestrianWaypoints)
        }

        XCTAssertEqual(shapeSource.identifier, "foo")

        switch shapeSource.data {
        case .features(let features):
            XCTAssertEqual(features.count, 1)
        default:
            XCTFail("Expected a feature source")
        }
    }
}
