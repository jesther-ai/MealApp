import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../dummy_data.dart';
import 'dart:io';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);
  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 250,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((element) {
      return element.id == mealId;
    });

    PreferredSizeWidget _buildAppBar() {
      return Platform.isIOS
          ? CupertinoNavigationBar(
              middle: Text(
                selectedMeal.title,
                style: TextStyle(fontSize: 22),
              ),
            ) as PreferredSizeWidget
          : AppBar(
              title: Text(selectedMeal.title),
            );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          selectedMeal.ingredients[index],
                        ),
                      ));
                },
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '#${index + 1}',
                          ),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
