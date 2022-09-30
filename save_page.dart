import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Modules{

  List<String> moduleList = ["Interpersonal Skills",
    "Computer Mathematics",
    "Web Development" ,
    "Data Essentials",
    "Computer Architecture",
    "Introduction to programming"
  ];

  /*
  DropdownMenuItem(
  value: items,
  child: Text(items),
  );
  */
  List<DropdownMenuItem> dItems(){

    List<DropdownMenuItem> dropItems = [];
    for(int i = 0; i < moduleList.length; i++){

      dropItems.add(DropdownMenuItem(
        value: moduleList[i],
        child: Text(moduleList[i]),
      ));
    }

    return dropItems;


  }

}

class ConstructSavePage extends StatefulWidget{
  const ConstructSavePage({Key? key}) : super(key: key);


  @override
  State<ConstructSavePage> createState() => SavePage();
}


class SavePage extends State<ConstructSavePage>{

  String? day;
  String sTime = "";
  String eTime = "";
  String? title;
  Modules mod = Modules();


  @override
  void initState(){
    super.initState();

  }

  Future<void> submit() async{


    if(day != null &&  title != null){

      final prefs = await SharedPreferences.getInstance();


       List<String>? sTimes = prefs.getStringList('sTimes');
       List<String>? eTimes = prefs.getStringList('eTimes');
       List<String>? days = prefs.getStringList('days');
       List<String>? subjects = prefs.getStringList('subjects');
       List<String>? ids = prefs.getStringList('ids');
      List<String>? rooms = prefs.getStringList('rooms');

      if (sTimes == null || eTimes == null || days == null || subjects == null || ids == null || rooms == null) {
        sTimes = [sTime];
        eTimes = [eTime];
        days = ["$day"];
        subjects = ["$title"];
        ids = ["1"];
        rooms = ["1"];
      }else{
        sTimes.add(sTime);
        eTimes.add(eTime);
        days.add("$day");
        subjects.add("$title");
        ids.add("${sTimes.length}");
        rooms.add("${sTimes.length}");


      }

      prefs.setStringList('sTimes', sTimes);
      prefs.setStringList('eTimes', eTimes);
      prefs.setStringList('days', days);
      prefs.setStringList('subjects', subjects);
      prefs.setStringList('ids', ids);
      prefs.setStringList('rooms', rooms);

    }

  }

  Future<void> timeDialog() async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    sTime = "";
    if (time != null) {
      setState(() {

        var hr = time.hour;
        if ( (hr/10).floor() == 0){
          sTime += "0$hr:";
        }else{
          sTime += "$hr:";
        }

        var mi = time.minute;
        if ( (mi/10).floor() == 0){
          sTime += "0$mi";
        }else{
          sTime += "$mi";
        }

      });
    }
  }

  Future<void> timeDialog2() async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      setState(() {
        eTime = "";
        var hr = time.hour;
        if ( (hr/10).floor() == 0){
          eTime += "0$hr:";
        }else{
          eTime += "$hr:";
        }

        var mi = time.minute;
        if ( (mi/10).floor() == 0){

          eTime += "0$mi";
        }else{
          eTime += "$mi";
        }

      });
    }
  }


  Future<void> clear() async {

    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList('sTimes', []);
    prefs.setStringList('eTimes', []);
    prefs.setStringList('days', []);
    prefs.setStringList('subjects', []);
    prefs.setStringList('ids', []);
    prefs.setStringList('rooms', []);


  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Choose a Date"),
      ),

      body: Center(

        child: Column(

        children: <Widget>[

          DropdownButton(
            value: title,
            items: mod.dItems(),
            onChanged: (value) {
              setState(() {

                title = value;
              });

            },



          ),

          DropdownButton(
            value: day,
            items: const [DropdownMenuItem(
              value: "Monday",
              child: Text("Monday"),
            ),DropdownMenuItem(
              value: "Tuesday",
              child: Text("Tuesday"),
            ),DropdownMenuItem(
              value: "Wednesday",
              child: Text("Wednesday"),
            ),DropdownMenuItem(
              value: "Thursday",
              child: Text("Thursday"),
            ),DropdownMenuItem(
              value: "Friday",
              child: Text("Friday"),
            )],
            onChanged: (value) {
              setState(() {

                day = value;
              });

            },


          ),

          Text(
            sTime != ""
                ? sTime
                : 'Start Time',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: timeDialog,
              child: const Text('Show Time Picker'),
            ),
          ),
          Text(
            eTime != ""
                ? eTime
                : 'End Time',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: timeDialog2,
              child: const Text('Show Time Picker'),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(


              onPressed: submit,
              child: const Text('Submit'),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: clear,
              child: const Text('DELETE EVERYTHING'),
            ),
          ),
        ]
      )

    )

    );
  }

}
