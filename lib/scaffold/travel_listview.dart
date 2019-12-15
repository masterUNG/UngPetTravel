import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravelListView extends StatefulWidget {
  final String category;
  TravelListView({Key key, this.category}) : super(key: key);

  @override
  _TravelListViewState createState() => _TravelListViewState();
}

class _TravelListViewState extends State<TravelListView> {
  // Field
  String currentCategory, currentLanguage;

  // Method
  @override
  void initState() {
    super.initState();

    currentCategory = widget.category;
  }

  Future<void> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    currentLanguage = preferences.getString('Language');
    readFireStore();
  }

  Future<void> readFireStore() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel List'),
      ),
      body: Text('body'),
    );
  }
}
