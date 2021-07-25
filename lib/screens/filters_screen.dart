import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen(this.currentFilters, this.saveFilters);
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree;
  var _vegetarian;
  var _vegan;
  var _lactoseFree;
  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: (currentValue) {
        updateValue(currentValue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              }),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Lactose-free', 'Only lactose-free meal', _lactoseFree,
                    (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile('Vegan', 'Only Vegan Meal', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only Vegetarian Meal', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Gluten Free', 'Only Gluten-Free Meal', _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
