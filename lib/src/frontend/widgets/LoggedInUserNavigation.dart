import 'package:fluent/src/backend/models/match.dart';
import 'package:flutter/material.dart';
import 'package:fluent/src/frontend/pages.dart';
import 'package:fluent/src/backend/services/base/services.dart';
import 'package:fluent/src/backend/models/match.dart';

class BottomNavBar extends StatefulWidget {
  // final MatchProfile currentUser;
  //   //
  //   // // constructor for ChatScreen to initialize the User
  //   // BottomNavBar({this.currentUser});

  final String pfp;
  BottomNavBar({Key key, @required this.pfp}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int set = 0;

  _onTabTapped(int index) {
    setState(() {
      set = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<WidgetBuilder> _navBarPages = [
      (context) => MatchingPage.create(context),
      (context) => MatchRequestPage(pfp: widget.pfp),
      (context) => InboxScreen(pfp: widget.pfp),
    ];

    return Scaffold(
      body: _navBarPages[set](context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: set,
        items:[
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Match')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism),
              title: Text('Match Requests')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Inbox')
          ),
        ],
        onTap: _onTabTapped,
      ),
    );
  }
}