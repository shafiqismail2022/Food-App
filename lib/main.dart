// ignore_for_file: deprecated_member_use, missing_return
import 'package:flutter/material.dart';
import './dummy_category.dart';
import './models/meals.dart';
import './screens/filtered_Screen.dart';
import './screens/tabs_Screen.dart';
import './screens/categories.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_meal_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'lactose': false,
    'vegaterian': false,
  };
  List<Meals> _availableMeals = DUMMY_MEALS;
  List<Meals> favoriteMeal = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegaterian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        favoriteMeal.indexWhere(((meal) => meal.id == mealId));
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeal.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', //default Route
      routes: {
        '/': (ctx) =>
            TabsScreen(favoriteMeal), //Another way of writing home route
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_availableMeals),
        mealDetailScreen.routeName: (ctx) => mealDetailScreen(_toggleFavorite,isMealFavorite),
        FilteredScreen.routeName: (ctx) =>
            FilteredScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: ((context) => CategoriesScreen()));
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const Text('Error 401'));
      },
    );
  }
}
