import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:io';
import 'menu_bloc.dart';
import 'menu.dart';
import 'about_tile.dart';
import 'profile_tile.dart';
import 'uidata.dart';

import 'room_one.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  late Size deviceSize;
  bool _switchValue = false;
  bool _switchValueTwo = false;
  bool _switchValueThree = false;
  late BuildContext _context;

void initState() {
    super.initState();
  //  _connect();
}


  Widget roomOne(BuildContext context) {
    return InkWell(
      onTap: () => _showModalBottomSheet(),
      splashColor: Colors.orange,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //image
            Image.asset(
              'assets/room1.jpg',
              fit: BoxFit.cover,
            ),

            //color
            new Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  blurRadius: 5.0,
                ),
              ]),
            ),

            //menuData

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Room 1",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget roomTwo(BuildContext context) {
    return InkWell(
      onTap: () => _showModalBottomSheetTwo(),
      splashColor: Colors.orange,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //image
            Image.asset(
              'assets/room2.jpg',
              fit: BoxFit.cover,
            ),

            //color
            new Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  blurRadius: 5.0,
                ),
              ]),
            ),

            //menuData

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Room 2",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

//all widgets

  List<Widget> allWidgets() {
    return [roomOne(context), roomTwo(context)];
  }

  //appbar
  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.black,
        pinned: true,
        elevation: 10.0,
        forceElevated: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: UIData.kitGradients)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(child: Image.asset('assets/mwangaza.png', fit: BoxFit.contain,) ),
              // SizedBox(
              //   width: 10.0,
              // ),
              Text(UIData.appName)
            ],
          ),
        ),
      );

  //bodygrid
  Widget bodyGrid() => SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(_context).orientation == Orientation.portrait ? 2 : 3,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          //return roomOne(context);
          return Container(
            child: Stack(
              children: <Widget>[roomOne(context), roomTwo(context)],
            ),
          );

          // return menuStack(context, menu[index]);
        },
        childCount: 2,
      ));

  Widget homeScaffold(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Scaffold(key: _scaffoldState, body: bodySliverList()),
      );

  Widget bodySliverList() {

    return CustomScrollView(
      slivers: <Widget>[
        appBar(),
        // bodyGrid(),
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: SliverGrid.count(
            crossAxisCount:
                MediaQuery.of(_context).orientation == Orientation.portrait
                    ? 2
                    : 3,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.0,
            children: <Widget>[roomOne(context), roomTwo(context)],
          ),
        ),
      ],
    );
    //: Center(child: CircularProgressIndicator());
    // });
  }

  Widget roomTwoheader() => Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: UIData.kitGradients2)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileTile(
                  title: "Room 2",
                  subtitle: "",
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      );
  Widget roomOneheader() => Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: UIData.kitGradients2)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileTile(
                  title: "Room 1",
                  subtitle: "",
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      );

   void _showModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
                  
                      borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(15.0),
                          topRight: new Radius.circular(15.0))),
        context: context,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Material(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                  
                      borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(15.0),
                          topRight: new Radius.circular(15.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      roomOneheader(),
                      SizedBox(
                        height: 10.0,
                      ),
                      BottomSheetSwitch(
                        switchValue: _switchValue,
                        switchValueTwo: _switchValueTwo,
                    
                        valueChanged: (value) {
                          _switchValue = value;
                        },
                        valueChangedTwo: (value) {
                          _switchValueTwo = value;
                        },
                     
                      )
                    ],
                  ));
            }));
  }

  void _showModalBottomSheetTwo() {
    showModalBottomSheet(
          shape: RoundedRectangleBorder(
                  
                      borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(15.0),
                          topRight: new Radius.circular(15.0))),
        context: context,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Material(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                  
                      borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(15.0),
                          topRight: new Radius.circular(15.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      roomTwoheader(),
                      SizedBox(
                        height: 10.0,
                      ),
                      BottomSheetSwitch(
                        switchValue: _switchValue,
                        switchValueTwo: _switchValueTwo,
                        
                        valueChanged: (value) {
                          _switchValue = value;
                        },
                        valueChangedTwo: (value) {
                          _switchValueTwo = value;
                        },
                     
                      )
                    ],
                  ));
            }));
  }

  Widget iosCardBottom(Menu menu, BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.white),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        menu.image,
                      ))),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              menu.title,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 20.0,
            ),
            FittedBox(
              child: CupertinoButton(
                onPressed: () => _showModalBottomSheet(),
                borderRadius: BorderRadius.circular(50.0),
                child: Text(
                  "Go",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                color: Colors.white,
              ),
            )
          ],
        ),
      );

  Widget menuIOS(Menu menu, BuildContext context) {
    return Container(
      height: deviceSize.height / 2,
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3.0,
        margin: EdgeInsets.all(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // menuImage(menu),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                menu.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              height: 60.0,
              child: Container(
                width: double.infinity,
                color: menu.menuColor,
                child: iosCardBottom(menu, context),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget bodyDataIOS(List<Menu> data, BuildContext context) => SliverList(
  //       delegate: SliverChildListDelegate(
  //           data.map((menu) => menuIOS(menu, context)).toList()),
  //     );

  // Widget homeBodyIOS(BuildContext context) {
  //   MenuBloc menuBloc = MenuBloc();
  //   return StreamBuilder<List<Menu>>(
  //       stream: menuBloc.menuItems,
  //       // ignore: deprecated_member_use
  //       initialData: [],
  //       builder: (context, snapshot) {
  //         return snapshot.hasData
  //             ? bodyDataIOS(snapshot.data, context)
  //             : Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //       });
  // }

  Widget homeIOS(BuildContext context) => Theme(
        data: ThemeData(
          fontFamily: '.SF Pro Text',
        ).copyWith(canvasColor: Colors.transparent),
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                border: Border(bottom: BorderSide.none),
                backgroundColor: CupertinoColors.white,
                largeTitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(UIData.appName),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: CupertinoColors.black,
                        child: FlutterLogo(
                          size: 15.0,
                         
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // homeBodyIOS(context)
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    deviceSize = MediaQuery.of(context).size;
    return  homeScaffold(context);
  }
}



class BottomSheetSwitch extends StatefulWidget {
  final bool switchValue;
  final bool switchValueTwo;
 
  final ValueChanged valueChanged;
 
  final ValueChanged valueChangedTwo;

  BottomSheetSwitch(
      {required this.switchValue,
    
      required this.valueChanged,
      required this.switchValueTwo,
      required this.valueChangedTwo});

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  bool _switchValue = false;
  bool _switchValueTwo = false;
  bool _wsvalue = false;
   bool _wsvalue2 = false;
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ic-project-smart-home.herokuapp.com'),
  );
  @override
  void initState() {
    _switchValue = widget.switchValue;
    _switchValueTwo = widget.switchValueTwo;
      _wsvalue = widget.switchValue;
    _wsvalue2 = widget.switchValueTwo;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            // return Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            // );
            // if(snapshot.hasData) {
            //   print(snapshot.data);
            //   if(snapshot.data == 'Light One is On!' && _wsvalue!= true && _switchValue !=true) {
            //     setState(() {
            //       _wsvalue = true;
            //     });
            //   }
            //    if(snapshot.data == 'Light One is Off!' && _wsvalue!= false && _switchValue !=false) {
            //     setState(() {
            //       _wsvalue = false;
            //     });
            //   }
            //   if(snapshot.data == 'Light Two is On!' && _wsvalue2!= true && _switchValueTwo !=true) {
            //     setState(() {
            //       _wsvalue2 = true;
            //     });
            //   }
            //   if(snapshot.data == 'Light Two is Off!' && _wsvalue2!= false && _switchValueTwo !=false) {
            //     setState(() {
            //       _wsvalue2 = false;
            //     });
            //   }
            // }
            
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                    child: MergeSemantics(
                        child: ListTile(
                  title: Text('Light One'),
                  trailing: CupertinoSwitch(
                      activeColor: Colors.yellowAccent,
                      value:  _switchValue,
                      onChanged: (bool value) {
                        setState(() {
                          if (value == true) {
                            channel.sink.add('Light One is On!');
                          } else if (value == false) {
                            channel.sink.add('Light One is Off!');
                          }
                          
                        
                        
                            _switchValue = value;
                              widget.valueChanged(value);
                         
                         


                          
                        });
                      }),
                ))),
                Container(
                    child: MergeSemantics(
                        child: ListTile(
                  title: Text('Light Two'),
                  trailing: CupertinoSwitch(
                      activeColor: Colors.yellowAccent,
                      value: _switchValueTwo,
                      onChanged: (bool value) {
                        setState(() {
                          _switchValueTwo = value;
                          widget.valueChangedTwo(value);

                          if (value == true) {
                            channel.sink.add('Light Two is On!');
                          } else if (value == false) {
                            channel.sink.add('Light Two is Off!');
                          }
                        });
                      }),
                ))),
              ],
            );
          },
        ),
        // _lights()
      ],
    );
  }
}
