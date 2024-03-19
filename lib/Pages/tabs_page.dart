import 'package:flutter/material.dart';

import '../Widgets/main_drawer.dart';
import '../models/meal.dart';
import 'categories_page.dart';
import 'favorite_page.dart';

class TabsPages extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsPages(this.favoriteMeals);

  @override
  State<TabsPages> createState() => _TabsPagesState();
}

class _TabsPagesState extends State<TabsPages> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {
        "page": CategoryPage(),
        "title": "Category",
      },
      {
        "page": FavoritePage(widget.favoriteMeals),
        "title": "Your Favorite",
      },
    ];
    super.initState();
  }

  void _SelectePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _SelectePage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category),
              label: "Category",
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.star),
              label: "Favorite",
            ),
          ]),
    );
  }
}
