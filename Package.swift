// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XSLabsSwift",
    products: [
        .library(
            name: "XSLabsSwift",
            targets: [ "XSLabsSwift" ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XSLabsSwift",
            dependencies: [],
            exclude: []
        ),
        .testTarget(
            name: "XSLabsSwiftTests",
            dependencies: [ "XSLabsSwift" ]
        ),
    ]
)
