import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Item Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  /// Controllers
  final PageController _imageSlideController = PageController();
  final PageController _titleSlideController = PageController();
  final PageController _overlaySlideController = PageController(
    initialPage: itemList.length - 1,
  );

  int _currentPage = 0; 

  /// Handle page change
  void _onChangePage(int page) {
    setState(() => _currentPage = page);

    _titleSlideController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInExpo,
    );
  }

  @override
  void initState() {
    super.initState();
    _imageSlideController.addListener(() {
      if (_overlaySlideController.hasClients) {
        final maxScroll = _imageSlideController.position.maxScrollExtent;
        final offset = _imageSlideController.offset;
        _overlaySlideController.jumpTo(maxScroll - offset);
      }
    });
  }

  @override
  void dispose() {
    _titleSlideController.dispose();
    _overlaySlideController.dispose();
    _imageSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          
          ///  Background gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.linear,
            width: screen.width,
            height: screen.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.3,
                colors: [Colors.white, itemList[_currentPage].color],
              ),
            ),
          ),

          /// Item Title Text
          Positioned(
            top: 160,
            child: SizedBox(
              height: 60,
              width: screen.width,
              child: Center(
                child: ItemTitlePageView(controller: _titleSlideController),
              ),
            ),
          ),

          /// Overlay blur items
          AnimatedBuilder(
            animation: _overlaySlideController,
            builder: (context, child) {
              return ItemOverlayPageView(controller: _overlaySlideController);
            },
          ),

          /// Item Main Images
          AnimatedBuilder(
            animation: _imageSlideController,
            builder: (context, child) {
              return ItemImagePageView(
                controller: _imageSlideController,
                onPageChanged: _onChangePage,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Item Title Texts 
class ItemTitlePageView extends StatelessWidget {
  final PageController controller;
  const ItemTitlePageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: itemList.length,
      controller: controller,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Text(
          itemList[index].name,
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              letterSpacing: 0.8,
            ),
          ),
        );
      },
    );
  }
}

/// Item Blurred Background Overlays
class ItemOverlayPageView extends StatelessWidget {
  final PageController controller;
  const ItemOverlayPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: itemList.length,
      scrollDirection: Axis.vertical,
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final image = itemList[itemList.length - index - 1].overlayImage;

        return Stack(
          children: [
            Positioned(
              top: -20,
              left: -30,
              child: _blurredImage(image, 120, sigma: 3),
            ),
            Positioned(
              top: 70,
              right: 40,
              child: Transform.rotate(
                angle: 135,
                child: _blurredImage(image, 70, sigma: 5),
              ),
            ),
            Positioned(
              top: 200,
              left: 40,
              child: Image.asset(
                image,
                width: 70,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.red.shade300,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: -80,
              bottom: 100,
              child: Transform.rotate(
                angle: 135,
                child: _blurredImage(image, 180, sigma: 4),
              ),
            ),
            Positioned(
              left: -70,
              bottom: -50,
              child: Transform.rotate(
                angle: 80,
                child: _blurredImage(image, 180, sigma: 4),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _blurredImage(String asset, double width, {double sigma = 4}) {
    final image = Image.asset(
      asset,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            color: Colors.red.shade200,
            shape: BoxShape.circle,
          ),
        );
      },
    );

    // Skip ImageFilter on web to avoid performance issues
    // Use opacity instead for a similar visual effect
    if (kIsWeb) {
      return Opacity(opacity: 0.6, child: image);
    }

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: image,
    );
  }
}

/// Item Main Images 
class ItemImagePageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const ItemImagePageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: itemList.length,
      scrollDirection: Axis.vertical,
      controller: controller,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        double value = 0.0;

        if (controller.position.haveDimensions) {
          value = index.toDouble() - (controller.page ?? 0);
          value = (value * 0.7).clamp(-1, 1);
        }

        return Transform.rotate(
          angle: value * 5,
          child: Transform.scale(
            scale: 1.2,
            child: Image.asset(
              itemList[index].image,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.cake,
                  size: 200,
                  color: itemList[index].color,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
