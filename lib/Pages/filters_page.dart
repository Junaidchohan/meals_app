import 'package:flutter/material.dart';
import '../Widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routName = "/filters";

  void Function(Map<String, bool> filters) saveFilters;
  final Map<String, bool> currentFilters;

  FiltersPage(this.saveFilters, this.currentFilters);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenfree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenfree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactosefree = widget.currentFilters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String text,
    String description,
    bool currentValue,
    void Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(text),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        actions: [
          IconButton(
              onPressed: () {
                final _selectedFilters = {
                  'gluten': _glutenfree,
                  'lactose': _lactosefree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(_selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: (Text(
              "Adjust your meal selection",
              style: (Theme.of(context).textTheme.titleMedium),
            )),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                'Gluten-free',
                'only include gluten-free meal.',
                _glutenfree,
                (newValue) {
                  setState(() {
                    _glutenfree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Lactose-free',
                'only include lactose-free meal.',
                _lactosefree,
                (newValue) {
                  setState(() {
                    _lactosefree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'only include vegetarian meal.',
                _vegetarian,
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'vegan-free',
                'only include vegan meal.',
                _vegan,
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
