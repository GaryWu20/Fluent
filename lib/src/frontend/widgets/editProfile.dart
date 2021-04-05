import 'dart:io';
import 'package:fluent/src/backend/models/fluency.dart';
import 'package:fluent/src/backend/services/base/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditProfilePage extends StatefulWidget {
  final String pfp;
  EditProfilePage({Key key, @required this.pfp}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = "";
  String age = "";

  List<String> chipList = [
    "Male",
    "Female",
    "Other",
  ];
  List<String>fluencyRating  = [
    "1","2","3","4","5"
  ];

  static String gender = "";

  String language = "";
  static int fluency;
  String bio = "";

  // so the language selection buttons will change colors on pressed
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;

  DateTime selectedDate = DateTime.now();

  File _image;

  _imgFromCamera() async {
    var image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    var image = await  ImagePicker.platform.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(image.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context, name) async {
    final storage = ServicesProvider.of(context).services.storage;
    return storage.ref('uploads/$name').putFile(_image);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightBlueAccent,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (_image == null)
                                ? NetworkImage(widget.pfp) //Default Picture
                                : FileImage(_image),
                          )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(5.0),
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              _showPicker(context);
                            },
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(
                height: 35,
              ),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select Birthdate'),
              ),
              SizedBox(
                height: 35,
              ),

              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:<Widget>[
                    Text(
                    'Gender',
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ), Wrap(
                    //spacing: 5.0,
                    //runSpacing: 5.0,
                      alignment: WrapAlignment.center,
                    children: <Widget>[
                      choiceChipWidget(chipList,gender),
                    ],
                  )]),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ExpansionTile(
                      title: Text(
                        "Language Selection",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              language = "Spanish";
                              pressAttention1 = !pressAttention1;
                            });
                          },

                          padding: const EdgeInsets.symmetric(horizontal:100, vertical: 4),
                          child: new Text(
                            "Spanish",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),

                          ),
                          color: pressAttention3 ? Colors.lightBlueAccent : Colors.grey,
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(30))),

                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              language = "French";
                              pressAttention2 = !pressAttention2;
                            });
                          },

                          padding: const EdgeInsets.symmetric(horizontal:100, vertical: 4),
                          child: new Text(
                            "French",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),

                          ),
                          color: pressAttention3 ? Colors.lightBlueAccent : Colors.grey,
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(30))),

                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              language = "Mandarin";
                              pressAttention3 = !pressAttention3;
                            });
                          },

                          padding: const EdgeInsets.symmetric(horizontal:100, vertical: 4),
                          child: new Text(
                            "Mandarin",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),

                          ),
                          color: pressAttention3 ? Colors.lightBlueAccent : Colors.grey,
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(30))),

                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:<Widget>[
                    Text(
                      'Fluency',
                      style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ), Wrap(
                      //spacing: 5.0,
                      //runSpacing: 5.0,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        choiceChipWidgett(fluencyRating, fluency),
                      ],
                    )]),

              // bio
              new TextField(
                decoration: InputDecoration(
                    hintText: 'Bio',
                    border: OutlineInputBorder()
                ),
                maxLines: 10,
                onChanged: (val) {
                  setState(() => bio = val);
                },
              ),

              SizedBox(height: 10.0),

              Container(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  width: 200.0,
                  child: RaisedButton(
                    onPressed: () async {
                      await uploadImageToFirebase(context, FirebaseAuth.instance.currentUser.uid);
                      ServicesProvider.of(context).services.profiles.createProfile(
                        uid: FirebaseAuth.instance.currentUser.uid,
                        username: "gary2",  //need username
                        name: name,
                        birthDate: selectedDate,
                        gender: gender,
                        bio: bio,
                        language: language,
                        fluency: parseFluency(fluency),
                      );
                    },
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class choiceChipWidget extends StatefulWidget {
  List<String> reportList;
  String gender;

  choiceChipWidget(this.reportList, this.gender);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String select = "";
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(20),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Colors.lightBlueAccent,
          selected: select == item,
          onSelected: (selected) {
            setState((){
              select = item;
              _EditProfilePageState.gender = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}


class choiceChipWidgett extends StatefulWidget{
  final List <String> reportList;
  final int fluency;

  choiceChipWidgett(this.reportList, this.fluency);

  @override
  _choiceChipWidgetStatee createState() => new _choiceChipWidgetStatee();
}

class _choiceChipWidgetStatee extends State<choiceChipWidgett> {
  String select = "";

  set fluency(String fluency) {}

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(16),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Colors.lightBlueAccent,
          selected: select == item,
          onSelected: (selected) {
            fluency = item;
            setState(() {
              select = item;
              _EditProfilePageState.fluency = int.parse(item);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
