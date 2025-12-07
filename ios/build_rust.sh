#!/bin/sh
# This script builds the Rust library for iOS

# Navigate to rust_core
cd "$PROJECT_DIR/../../rust_core"

# Determine target based on architecture and platform
if [[ "$PLATFORM_NAME" == "iphonesimulator" ]]; then
    if [[ "$ARCHS" == "arm64" ]]; then
        TARGET="aarch64-apple-ios-sim"
    else
        TARGET="x86_64-apple-ios"
    fi
else
    TARGET="aarch64-apple-ios"
fi

echo "Building Rust library for $TARGET"
# Ensure cargo is in PATH (Xcode environment might not have it)
export PATH="$HOME/.cargo/bin:$PATH"

cargo build --release --target $TARGET

# Copy the dylib to the Frameworks folder
# Note: In a real production setup, you might want to create a proper .framework structure
mkdir -p ../ios/Frameworks
cp target/$TARGET/release/librust_core.dylib ../ios/Frameworks/
