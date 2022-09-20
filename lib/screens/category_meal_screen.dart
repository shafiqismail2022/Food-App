// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodapp/dummy_category.dart';
import '../models/meals.dart';
import 'package:foodapp/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/Category-meals';
  final List<Meals> availableMeals;
   CategoryMealScreen(this.availableMeals);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meals> dispalyedMeals=DUMMY_MEALS;
  var _intData = false;
  @override
  void initState() {
//...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_intData) {
      final routeArg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArg['title'];
      final categoryId = routeArg['id'];
      final categoryMeal = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _intData = true;
    }

    super.didChangeDependencies();
  }

  void _removeState(String id) {
    setState(
      () {
        dispalyedMeals.removeWhere((meal) => meal.id == id);
      },
    );
  }

  // final String catagoryid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: dispalyedMeals[index].id,
            title: dispalyedMeals[index].title,
            imageUrl: dispalyedMeals[index].imageUrl,
            duration: dispalyedMeals[index].duration,
            complexity: dispalyedMeals[index].complexity,
            affordability: dispalyedMeals[index].affordability,
            // removeItem: _removeState,
          );
          // return Text(categoryMeal[index].title);
        },
        itemCount: dispalyedMeals.length,
      ),
    );
  }
}
