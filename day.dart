import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SubjectList{

  List<Subject> subList;
  List<Widget> buttons = [];

  SubjectList(this.subList){
    for(int i = 0; i < subList.length; i++){
      buttons.add(
        Text(subList[i].subjectName)
      );
    }
  }

}

class Subject extends Modules{

  String sTime;
  String eTime;
  int subjectID;
  String subjectName = "";

  Subject(this.sTime, this.eTime, this.subjectID){
    subjectName = super.moduleList[subjectID];
  }



}

class Modules{

  List<String> moduleList = ["Interpersonal Skills",
                             "Computer Mathematics",
                             "Web Development" ,
                             "Data Essentials",
                             "Computer Architecture"
                             "Introduction to programming"
                            ];
}