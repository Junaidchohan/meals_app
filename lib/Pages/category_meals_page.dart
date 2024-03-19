// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import '../Widgets/meals_iteam.dart';
import '../models/meal.dart';

class CategoryMealsPage extends StatefulWidget {
  final List<Meal> availableMeal;

  CategoryMealsPage(this.availableMeal);

  static const routName = "/Category_meals";

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var loadedInitData = false;
  @override
  void initState() {
    // TODO: implement initState
    // ignore: unused_local_variable

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // !loadedInitData = use for if (loadedInitData = false){}
    if (!loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
      final CategoryId = routeArgs?["id"];
      categoryTitle = routeArgs?["title"] ?? "Default Title";
      //here is _availableMeal from main.dart through via constructor
      displayedMeals = widget.availableMeal.where((element) {
        return element.categories.contains(CategoryId);
      }).toList();
      loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  // final String CategoryId;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealsItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
