import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget { 
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Marker> allMarkers = [];

  setMarkers() {

    return allMarkers;
  }

  addToList() async { 
    // final query = "State Bridge Road, Johns Creek";
    final query = "4180 Old Milton Parkway, Alpharetta";
    // final query = "9770 Autrey Mill Rd, Johns Creek";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    setState(() {
      allMarkers.add(
        new Marker(             
                width: 40.0,
                height: 45.0,
                point: new LatLng(first.coordinates.latitude, first.coordinates.longitude),
                builder: (context) => new Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45.0,
                    onPressed: () {
                      print(first.featureName);
                    },
                  ),
       ) ));
     } );
  }
   
     
  Future addMarker() async {
    await showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('Add Marker',
          style: new TextStyle(fontSize: 17.0),
          ),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('Add it', 
              style: new TextStyle(color: Colors.blue)),
              onPressed: () {
                addToList();
                Navigator.of(context).pop();
              },
              ),
          ]
            );
        
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: new Text('VDart Eco Smart Transit Map'),
        leading: new IconButton(
          icon: Icon(Icons.add),
          onPressed: addMarker,
        ),
        centerTitle: true,
        ),
        body: new FlutterMap(
          options: 
          new MapOptions(
            center: new LatLng(34.05, -84.22),
            minZoom: 10.0
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            ),
            new MarkerLayerOptions(
              markers: setMarkers()
              
              
        )
           ]));
  }
}
  

