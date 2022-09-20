import 'package:flutter/material.dart';
import 'package:foodapp/widgets/main_drawer.dart';

class FilteredScreen extends StatefulWidget {
  static const routeName = '/Filterd-Data';
  final Function filteredSet;
  final Map<String, bool> currentFilter;
  FilteredScreen(this.currentFilter, this.filteredSet);

  @override
  State<FilteredScreen> createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  var _isLactoseFree = false;
  var _isVegan = false;
  var _vegeterian = false;
  var _isGlutenFree = false;
  @override
  initState() {
    _isLactoseFree = widget.currentFilter['gluten'];
    _isVegan = widget.currentFilter['vegan'];
    _vegeterian = widget.currentFilter['vegaterian'];
    _isGlutenFree = widget.currentFilter['gluten'];
    super.initState();
  }

  Widget _bulidSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: _isGlutenFree,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilter = {
                'gluten': _isGlutenFree,
                'vegan': _isVegan,
                'lactose': _isLactoseFree,
                'vegaterian': _vegeterian,
              };
              widget.filteredSet(selectedFilter);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Select your Filter',
                style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _bulidSwitchListTile(
                'Gluten-Free',
                'Only Gluten Free meals',
                _isGlutenFree,
                (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                },
              ),
              _bulidSwitchListTile(
                'Lactose-Free',
                'Only include Lactose meals ',
                _isLactoseFree,
                (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                },
              ),
              _bulidSwitchListTile(
                'Vegaterian',
                'Only include Vegaterian Meals',
                _vegeterian,
                (newValue) {
                  setState(() {
                    _vegeterian = newValue;
                  });
                },
              ),
              _bulidSwitchListTile(
                'Vegan',
                'Only include Vegan Meals',
                _isVegan,
                (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
