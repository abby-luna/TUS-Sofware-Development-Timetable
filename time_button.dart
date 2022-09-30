import 'dart:async';

import 'package:flutter/material.dart';
import 'time_page.dart';

class TheTimeButton extends StatefulWidget{
  const TheTimeButton({Key? key,required this.classroom ,this.border = const Color.fromRGBO(255, 0, 255, 1.0) , this.text = "bee,wasp",required this.stamp, required this.endStamp, required this.day, required this.id}) : super(key: key);
  final String stamp;
  final String endStamp;
  final String text;
  final String day;
  final String id;
  final String classroom;
  final Color border;

  @override
  State<TheTimeButton> createState() => TimeButton();

}

class TimeButton extends State<TheTimeButton>{

  String? tRemain;

  String minusTimes(int sHr, int sMin, int cHr, int cMin){
    int tStamp = 60 - DateTime.now().second;
    if(tStamp == 60){
      tStamp = 0;
    }
    String tString = "";
    int eHr = 0;
    int eMin = 0;

    if(sMin - cMin < 0) {
      eHr -= 1;
      eMin = 60 + (sMin - cMin);

    }else{
      eMin = sMin - cMin;

    }

    eHr += sHr - cHr;

    if(tStamp / 10 >= 1){
      tString = tStamp.toString();
    }else{

      tString = "0$tStamp";
    }

    if(eMin / 10 >= 1){
      return "$eHr:$eMin:$tString";
    }
    return "$eHr:0$eMin:$tString";
  }
  bool timeRemaining(){

    TimeOfDay time = TimeOfDay.now();
    List<String> endHrMin = widget.endStamp.split(":");
    List<String> startHrMin = widget.stamp.split(":");

    if( int.parse(startHrMin[0]) < time.hour || (int.parse(startHrMin[1]) < time.minute && int.parse(startHrMin[0]) == time.hour )) {
      if( int.parse(endHrMin[0]) > time.hour || (int.parse(endHrMin[1]) > time.minute && int.parse(endHrMin[0]) == time.hour )) {

        tRemain = minusTimes(int.parse(endHrMin[0]), int.parse(endHrMin[1]), time.hour, time.minute);
        return true;

      }

    }

    return false;


    }

  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer){

      if(!timeRemaining()){
        tRemain = null;

      }
    });

    }

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: widget.border, width: 5),
          borderRadius: const BorderRadius.all(Radius.circular(15)),

        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("${widget.text} (${widget.classroom})", style: const TextStyle(fontFamily: "buttonTitle",  fontSize: 20)),
            const SizedBox(height:5),
            Text(
                tRemain != null ? "$tRemain" : "${widget.stamp} - ${widget.endStamp}",

                style: const TextStyle(fontFamily: "buttonSubtitle",  fontSize: 15))
          ],

        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: widget.text, stamp: widget.stamp, id: int.parse(widget.id))));
      },
    );


  }

}