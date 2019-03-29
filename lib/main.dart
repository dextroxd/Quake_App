import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() async {
  Map _quakedata = await getJson();
  List _metadata = _quakedata['features'];
  final f = new DateFormat.yMMMd("en_US").add_jm();
  runApp(
    new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: new Text(
          "Quakes",
          style: new TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      body: new ListView.builder(
        itemCount: _metadata.length,
        itemBuilder: (BuildContext context, int position) {
          if (position == 0)
            return new ListTile(
              title: new Text(
                f.format(new DateTime.fromMicrosecondsSinceEpoch(
                        _metadata[position]['properties']['time'] * 1000)),
                style: new TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
//                fontStyle: FontStyle.italic,
                ),
              ),
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Text(
                  _metadata[position]['properties']['mag'].toString(),
                  style: new TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
              subtitle: new Text(
                _metadata[position]['properties']['place'].toString(),
                style: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              onTap: (){_showOnClick(context,"${_metadata[position]['properties']['title'].toString()}");},
            );
          else {
            return new Column(
              children: <Widget>[
                new Divider(),
                new ListTile(
                  title: new Text(
                    f.format(new DateTime.fromMicrosecondsSinceEpoch(
                            _metadata[position]['properties']['time'] * 1000)),
                    style: new TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
//                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.green,
                    child: new Text(
                      _metadata[position]['properties']['mag'].toString(),
                      style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  subtitle: new Text(
                    _metadata[position]['properties']['place'].toString(),
                    style: new TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onTap: (){_showOnClick(context,"${_metadata[position]['properties']['title'].toString()}");},
                )
              ],
            );
          }
        },
      ),
    )),
  );
}

Future<Map> getJson() async {
  String apiUrl =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
void _showOnClick(BuildContext context,String message)
{
  var alert = new AlertDialog(
    title: new Text('Quakes',style:
      new TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 19.9,
      ),),
    content: new Text(message,style:
    new TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.9,
    ),),
    actions: <Widget>[
      new FlatButton(onPressed: (){Navigator.pop(context);} , child:new Text('OK')),
    ],
  );
  showDialog(context: context,builder: (context)=>alert);
}