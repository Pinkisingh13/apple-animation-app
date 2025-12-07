# Apple Animation App

A beautiful Flutter application featuring smooth 3D-like animations of rotating apples with dynamic background gradients and blur effects.

## Demo

![App Demo](.github/assets/apple_animate_gif.gif)

*Swipe vertically to see smooth animations with rotating apples and gradient transitions*

## Features

- **3D-Like Rotation Effects** - Apple images rotate smoothly during page transitions
- **Dynamic Background Gradients** - Radial gradients that change color based on the current item
- **Blur Overlay Effects** - Aesthetic blurred apple overlays positioned throughout the screen
- **Smooth Page Transitions** - Synchronized animations between titles, images, and overlays
- **Cross-Platform Support** - Works on iOS, Android, Web, macOS, Windows, and Linux
- **Web-Optimized** - Special rendering optimizations for smooth web performance

## Technologies Used

- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Google Fonts** - Bebas Neue typography
- **PageView** - Smooth scrolling animations
- **AnimatedBuilder** - Reactive animation updates
- **ImageFilter** - Blur effects (mobile/desktop)

## Prerequisites

- Flutter SDK (>=3.9.2)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ)

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/YOUR_USERNAME/apple-animation-app.git
   cd apple-animation-app/frontend
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   For mobile/desktop:

   ```bash
   flutter run
   ```

   For web:

   ```bash
   flutter run -d chrome
   ```

## How It Works

The app uses three synchronized `PageView` widgets:

1. **Title PageView** - Displays apple names with vertical scrolling
2. **Image PageView** - Main apple images with rotation animations
3. **Overlay PageView** - Blurred background elements (scrolls in reverse)

When you swipe vertically, all three views animate in coordination:

- The main image rotates based on scroll position
- The background gradient transitions to a new color
- The title slides to show the current item name
- Overlay images move in the opposite direction for parallax effect

## Key Components

- **HomePage** - Main stateful widget managing controllers
- **ItemTitlePageView** - Vertical scrolling titles
- **ItemOverlayPageView** - Background blur overlays
- **ItemImagePageView** - Main rotating images with 3D effect

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.1.0
```

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests

## Acknowledgments

- Apple images and design inspiration
- Flutter team for the amazing framework
- Google Fonts for Bebas Neue typography

---

**Made with ❤️ using Flutter**
