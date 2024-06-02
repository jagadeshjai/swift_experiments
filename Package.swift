// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let backend = ProcessInfo.processInfo.environment["SCUI_BACKEND"] ?? "GtkBackend"

let package: Package = Package(
  name: "window_app",
  dependencies: [
    .package(
      url: "https://github.com/stackotter/swift-cross-ui.git",
      branch: "main"
    ),
    .package(
      url: "https://github.com/stackotter/swift-bundler",
      revision: "d5b56cf7cc967d262ad5330b83849069fcba7821"
    ),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "window_app",
      dependencies: [
        .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
        .product(name: "SwiftBundlerRuntime", package: "swift-bundler"),
        "SelectedBackend",
      ],
      resources: [.copy("experiment.png")]),
    .target(
      name: "SelectedBackend",
      dependencies: [
        .product(name: backend, package: "swift-cross-ui")
      ]
    ),
  ]
)
