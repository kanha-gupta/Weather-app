import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main () => runApp(
    MaterialApp(
      title: "Weather app",
      home: Home() ,
    )
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var tempconversion;

  Future getWeather() async {
    http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=kanpur%20&units=imperial&appid=b7cb4f139ea740695205e1647dda4192"));
    var results=jsonDecode(response.body);
    setState(() {
      this.temp=results['main']['temp'];
      this.description=results['weather'][0]['description'];
      this.currently=results['weather'][0]['main'];
      this.humidity=results['main']['humidity'];
      this.windspeed=results['wind']['speed'];
      this.tempconversion=0.55*(temp-32);
    });
  }
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height /3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:EdgeInsets.only(bottom: 10.0),
                  child:Text(
                    "Currently in Kanpur, Uttar pradesh",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  tempconversion!= null ? tempconversion.toStringAsFixed(2) + "°C"  : "loading",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top: 10.0),
                  child:Text(
                    currently!=null ? currently.toString() : "loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(tempconversion!= null ? tempconversion.toStringAsFixed(2) + "°C"  : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("weather"),
                    trailing: Text(description!= null ? description.toString() : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.moon),
                    title: Text("Humidity"),
                    trailing: Text(humidity!= null ? humidity.toString() : "loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("wind speed"),
                    trailing: Text(windspeed!= null ? windspeed.toString() +'km/h': "loading"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
