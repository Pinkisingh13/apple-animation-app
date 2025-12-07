import 'package:flutter/material.dart';

class Item {
  final String name;
  final String image;
  final String overlayImage;
  final Color color;

  Item({
    required this.name,
    required this.image,
    required this.overlayImage,
    required this.color,
  });
}

final List<Item> itemList = [

  Item(
    name: 'RED APPLE',
    image: 'assets/apple.png',
    overlayImage: 'assets/apple.png',
    color: const Color.fromARGB(255, 255, 73, 73),
  ),
  Item(
    name: 'ONE LEAF APPLE',
    image: 'assets/apple_single_leaf.png',
    overlayImage: 'assets/apple_single_leaf.png',
    color: const Color.fromARGB(255, 255, 73, 73),
  ),
  Item(
    name: 'TWO-LEAF APPLE',
    image: 'assets/apple_two_leaves.png',
    overlayImage: 'assets/apple_two_leaves.png',
    color: const Color(0xFFFF4081),
  ),
];
