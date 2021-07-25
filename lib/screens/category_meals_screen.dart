import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'dart:io';

class CategoryMealsScreen extends StatefulWidget {
  CategoryMealsScreen(this.availableMeals);
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((element) {
        return element.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              categoryTitle,
              style: TextStyle(fontSize: 22),
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: Text(
              categoryTitle,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemBuilder: (contex, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
