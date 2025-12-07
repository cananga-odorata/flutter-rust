plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.my_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.my_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Build Rust library for Android
tasks.register<Exec>("cargoBuild") {
    // Ensure cargo-ndk is in your PATH or specify full path
    // We use the full path we found earlier or assume it's in PATH if user fixes it
    // For now, let's assume it's in PATH or user will fix environment
    commandLine("cargo", "ndk", "-o", "../android/app/src/main/jniLibs", "build", "--release")
    workingDir("../../rust_core")
}

tasks.whenTaskAdded { task ->
    if (task.name == "mergeDebugJniLibFolders" || task.name == "mergeReleaseJniLibFolders") {
        task.dependsOn("cargoBuild")
    }
}

flutter {
    source = "../.."
}
