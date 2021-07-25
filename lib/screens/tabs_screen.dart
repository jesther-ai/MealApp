import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';
import 'dart:io';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites'
      },
    ];
    super.initState();
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              _pages[_selectedPageIndex]['title'] as String,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.gear_alt),
                ),
              ],
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: Text(_pages[_selectedPageIndex]['title'] as String),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
