import 'package:flutter/material.dart';
import '../Pages/category_meals_page.dart';
import '../dummy_data.dart';
import 'Pages/filters_page.dart';
import 'Pages/meal_detail_page.dart';
import 'Pages/tabs_page.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeal = DUMMY_MEALS;
  final List<Meal> _favoriteMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        // if (_filters["gluten"] && !meal.isGlutenFree) {
        //   return false;
        // }
        if (_filters["gluten"] == true && meal.isGlutenFree == false) {
          return false;
        }
        if (_filters["lactose"] == true && meal.isLactoseFree == false) {
          return false;
        }
        if (_filters["vegan"] == true && meal.isVegan == false) {
          return false;
        }
        if (_filters["vegetarian"] == true && meal.isVegetarian == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId);

    setState(() {
      if (existingIndex >= 0) {
        _favoriteMeal.removeAt(existingIndex);
      } else {
        final selectedMeal =
            DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
        _favoriteMeal.add(selectedMeal);
      }
    });
  }

  bool _isMealFavorites(String id) {
    return _favoriteMeal.any((meal) => meal.id == id);
  }
  // bool isFavorite(String mealId) {
  //   return _isMealFavorites.any((meal) => meal.id == mealId);
  // }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    debugShowCheckedModeBanner: false,

      // title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
        //     .copyWith(secondary: Colors.amber),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: const TextStyle(
                fontSize: 24,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => TabsPages(_favoriteMeal),
        CategoryMealsPage.routName: (context) =>
            CategoryMealsPage(_availableMeal),
        MealDetailPage.routName: (context) =>
            MealDetailPage(_toggleFavorite, _isMealFavorites),
        FiltersPage.routName: (context) => FiltersPage(
              _setFilters, // Use named parameter syntax
              _filters,
            ),

        // "/" : (context) => const MealDetailPage(),
      },
    );
  }
}
