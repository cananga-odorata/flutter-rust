# Flutter + Rust Integration Template

This project demonstrates a high-performance integration between **Flutter** (UI) and **Rust** (Business Logic) using `flutter_rust_bridge`.

It is configured and ready for deployment on **macOS**, **Android**, and **iOS**.

## 🚀 Features

*   **Flutter:** Handles the UI and user interaction.
*   **Rust:** Handles computationally intensive tasks or underlying logic.
*   **flutter_rust_bridge:** Type-safe FFI generation, automating the communication layer.
*   **Multi-Platform Ready:** Configured for macOS, Android (with `cargo-ndk`), and iOS.

## 🛠 Prerequisites

Before running the project, ensure you have the following installed:

1.  **Flutter SDK:** [Install Flutter](https://docs.flutter.dev/get-started/install)
2.  **Rust:** (Must be installed via `rustup`)
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ```
3.  **Xcode:** (For macOS/iOS development)
    *   Ensure Command Line Tools are installed: `xcode-select --install`
    *   Ensure you have opened Xcode at least once to agree to license terms.
4.  **Android Studio & SDK:** (For Android development)
    *   Ensure NDK is installed via SDK Manager.

## ⚙️ One-Time Setup

If you cloned this project for the first time on a new machine, run these commands to prepare the Rust environments:

### 1. Install Rust Mobile Targets

```bash
# Android Targets
rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android

# iOS Targets
rustup target add aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim
```

### 2. Install Code Generator (Optional but recommended for dev)

```bash
cargo install flutter_rust_bridge_codegen
```

## 📱 How to Run

### macOS (Desktop)

```bash
flutter run -d macos
```

### Android

Ensure your Android device is connected or Emulator is running.

```bash
flutter run -d android
```

### iOS

1.  Connect your iPhone or start a Simulator.
2.  **Important for Physical Devices:**
    *   You must enable **Developer Mode** on your iPhone (Settings > Privacy & Security > Developer Mode).
    *   You may need to **Trust** the developer app in Settings > General > VPN & Device Management after first installation.
    *   You may need to configure **Signing Team** in Xcode (`ios/Runner.xcworkspace`).

```bash
flutter run -d ios
# Or use specific device ID
flutter run -d <DEVICE_ID>
```

## 📂 Project Structure

*   `lib/`: Flutter/Dart code.
    *   `lib/src/rust/`: Generated Dart bindings for Rust.
*   `rust_core/`: Rust library source code.
    *   `src/api/simple.rs`: Where you write your Rust functions exposed to Flutter.
    *   `src/lib.rs`: Rust crate entry point.

## 📝 Development Workflow

1.  **Modify Rust Code:** Edit files in `rust_core/src/api/`.
2.  **Generate Bindings:**
    ```bash
    flutter_rust_bridge_codegen generate
    ```
3.  **Call from Flutter:** Use the generated Dart classes in `lib/`.
4.  **Run:** `flutter run` will automatically rebuild the Rust library (configured in `android/app/build.gradle.kts` and `ios/Runner.xcodeproj`).

## ⚠️ Troubleshooting

*   **iOS Signing Error:** Open `ios/Runner.xcworkspace` in Xcode, go to **Signing & Capabilities**, and ensure a valid **Team** is selected and **Bundle Identifier** is unique.
*   **Rustup command not found:** Ensure `~/.cargo/bin` is in your PATH (`source $HOME/.cargo/env`).
*   **Xcode failed to load:** Try opening Xcode via Finder or use `open -a Xcode ios/Runner.xcworkspace`.
