import 'dart:ui';

import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color bgcolor;
  const Category(
      {@required this.id, @required this.title, this.bgcolor = Colors.orange});
}
