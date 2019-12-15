import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungpettravel/models/travel_model.dart';

class TravelListView extends StatefulWidget {
  final String category;
  TravelListView({Key key, this.category}) : super(key: key);

  @override
  _TravelListViewState createState() => _TravelListViewState();
}

class _TravelListViewState extends State<TravelListView> {
  // Field
  String currentCategory, currentLanguage;
  List<TravelModel> travelModels = List();

  // Method
  @override
  void initState() {
    super.initState();
    currentCategory = widget.category;
    getLanguage();
  }

  Future<void> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    currentLanguage = preferences.getString('Language');
    readFireStore();
  }

  Future<void> readFireStore() async {
    print('Lang = $currentLanguage, Category = $currentCategory');
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Travel');

    await collectionReference
        .document(currentLanguage)
        .collection('Category')
        .document(currentCategory)
        .collection('MenuItem')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      List<DocumentSnapshot> snapshots = querySnapshot.documents;
      for (var map in snapshots) {
        print('map = ${map.data}');

        TravelModel travelModel = TravelModel.fromJSON(map.data);
        setState(() {
          travelModels.add(travelModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(travelModels[index].path),
    );
  }

  Widget showName(int index){
    return Text(travelModels[index].name);
  }

  Widget showDetail(int index){
    String string = travelModels[index].detail;
    if (string.length >= 20) {
      string = string.substring(0, 19);
      string = '$string ...';
    }
    return Text(string);
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Column(children: <Widget>[showName(index), showDetail(index),],),
    );
  }

  Widget showListTravel() {
    return ListView.builder(
      itemCount: travelModels.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel List'),
      ),
      body: showListTravel(),
    );
  }
}
