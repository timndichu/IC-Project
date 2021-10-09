import 'package:flutter/material.dart';

class Menu {
  String title;
  IconData icon;
  String image;


  Color menuColor;

  Menu(
      {required this.title,
      required this.icon,
      required this.image,
  
      this.menuColor = Colors.black});
}
