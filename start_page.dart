
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'time_button.dart';
import 'save_page.dart';
import 'dart:async';
import 'package:intl/intl.dart';


class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Select a date",
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepOrange,
          )
        ),

        home:const TheStartPage()

    );
  }
}


class TheStartPage extends StatefulWidget{
  const TheStartPage({Key? key}) : super(key: key);

  @override
  State<TheStartPage> createState() => StartPage();
}



class StartPage extends State<TheStartPage> {

  List<Widget> buttons = [];
  // final List<String>? items = prefs.getStringList('items');




  Future<void> _getData() async{
    final prefs = await SharedPreferences.getInstance();


    final List<String>? ids = prefs.getStringList('ids');
    final List<String>? titles = prefs.getStringList('subjects');
    final List<String>? days = prefs.getStringList('days');
    final List<String>? eTimes = prefs.getStringList('eTimes');
    final List<String>? sTimes = prefs.getStringList('sTimes');
    final List<String>? rooms = prefs.getStringList('rooms');

    if (titles == null || days == null || ids == null || eTimes == null || sTimes == null || rooms == null) {
      return;
    }


    setState(() {
      buttons = [const SizedBox(height: 10), const Text("K Number: K00286554", textAlign: TextAlign.center, style:  TextStyle(fontFamily: "buttonSubtitle",  fontSize: 15))];
      for(var i = 0; i < ids.length; i++){

        List<String> hrMin = eTimes[i].split(":");
        TimeOfDay time = TimeOfDay.now();
        if(DateFormat('EEEE').format(DateTime.now()) == days[i]) {
          if( int.parse(hrMin[0]) > time.hour || (int.parse(hrMin[1]) > time.minute && int.parse(hrMin[0]) == time.hour )){
            buttons.add(TheTimeButton(
                stamp: sTimes[i],
                text: titles[i],
                id: ids[i],
                endStamp: eTimes[i],
                day: days[i],
                border: const Color.fromRGBO(155, 0, 255, .75),
                classroom:rooms[i],
              )
            );
          }else{
            buttons.add(TheTimeButton(
                stamp: sTimes[i],
                text: titles[i],
                id: ids[i],
                endStamp: eTimes[i],
                day: days[i],
                border: const Color.fromRGBO(255, 50, 30, .75),
                classroom: rooms[i],
              )
            );

          }
        }

      }
    });
  }

  @override
  void initState(){
    super.initState();
    _getData();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _getData();
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("University Timetable"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: buttons
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {

          Navigator.push(context, MaterialPageRoute(builder: (context) => const ConstructSavePage()))

        },
        tooltip: 'Add Date',
        child: const Icon(Icons.add),
      ),
    );
  }


}