import Foundation
import SelectedBackend
import SwiftBundlerRuntime
import SwiftCrossUI

// Just to experiment with with split view.
enum WindowResizable {
  case enabled
  case disabled
}

class WindowAppState: Observable {
  @Observed var isResizable: WindowResizable = WindowResizable.disabled;
  @Observed var title: String = "My window"
}

@main
@HotReloadable
struct WindowApp: App {
  let identifier: String = "dev.WindowApp.experiment"

  let state: WindowAppState = WindowAppState()

  var body: some Scene {
    WindowGroup(state.title) {
      #hotReloadable {

        HStack {
          Button("Get Started") {
            // Action for "Get Started" button
          }
          Button("Blog") {
            // Action for "Blog" button
          }
          Button("Documentation") {
            // Action for "Documentation" button
          }
          Button("Packages") {
            // Action for "Packages" button
          }
          Button("Community") {
            // Action for "Community" button
          }
          Button("Download") {
            // Action for "Download" button
          }
        }
        .padding(10)  // Add padding around the HStack
        .foregroundColor(.blue)  // Set the text color to red

        VStack {
          VStack {
            Image(Bundle.module.bundleURL.appendingPathComponent("experiment.png").path)
              .frame(minWidth: 100, minHeight: 100)
          }
          Spacer()  // Push items to the edges
          Slider(minimum: 0, maximum: 100)  // Add a slider
        }

        VStack {
          Button(state.isResizable == .enabled ? "Disable resizing" : "Enable resizing") {
            state.isResizable = state.isResizable == .disabled ? .enabled : .disabled
          }
        }
        .padding(10)  // Add padding around the HStack

        // Just Call the |doubleColumn| view to experiment
        doubleColumn

      }
    }
    .defaultSize(width: 500, height: 500)
    .windowResizability(state.isResizable == .enabled ? .contentMinSize : .contentSize)
  }

  /// Example view for a two column NavigationSplitView
  var doubleColumn: some View {
    NavigationSplitView {
      VStack {

        VStack {
          Button("Enable Resizing") { state.isResizable = .enabled }
          Button("Disable Resizing") { state.isResizable = .disabled }
        }
        Spacer()
      }.padding(10)
    } detail: {
      VStack {
        switch state.isResizable {
        case .enabled:
          Text("Resizing Enabled")
            .padding(.bottom, 10)
        case .disabled:
          Text("Resizing Disabled")
            .padding(.bottom, 10)
        }
      }.padding(10)
    }
  }

}
