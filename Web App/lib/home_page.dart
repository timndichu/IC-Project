import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class HomePageOld extends StatefulWidget {
  const HomePageOld({Key? key}) : super(key: key);

  @override
  _HomePageOldState createState() => _HomePageOldState();
}

class _HomePageOldState extends State<HomePageOld> {
  bool _switchValue = false;
  bool _switchValueTwo = false;
  bool _switchValueThree = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Smart Home')),
        body: Center(
          child: Container(
              child: BottomSheetSwitch(
            switchValue: _switchValue,
            switchValueTwo: _switchValueTwo,
            switchValueThree: _switchValueThree,
            valueChanged: (value) {
              _switchValue = value;
            },
            valueChangedTwo: (value) {
              _switchValueTwo = value;
            },
            valueChangedThree: (value) {
              _switchValueThree = value;
            },
          )),
        ));
  }
}

class BottomSheetSwitch extends StatefulWidget {
  final bool switchValue;
  final bool switchValueTwo;
  final bool switchValueThree;
  final ValueChanged valueChanged;
  final ValueChanged valueChangedThree;
  final ValueChanged valueChangedTwo;

  BottomSheetSwitch(
      {required this.switchValue,
      required this.switchValueThree,
      required this.valueChangedThree,
      required this.valueChanged,
      required this.switchValueTwo,
      required this.valueChangedTwo});

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  bool _switchValue = false;
  bool _switchValueTwo = false;
  bool _switchValueThree = false;
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ic-project-smart-home.herokuapp.com'),
  );
  @override
  void initState() {
    _switchValue = widget.switchValue;
    _switchValueTwo = widget.switchValueTwo;
    _switchValueThree = widget.switchValueThree;
    super.initState();
  }

  Widget _lights(AsyncSnapshot snapshot) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
            child: MergeSemantics(
                child: ListTile(
          title: Text('Light One'),
          trailing: CupertinoSwitch(
              activeColor: Colors.yellowAccent,
              value: _switchValue,
              onChanged: (bool value) {
                setState(() {
                  _switchValue = value;

                  widget.valueChanged(value);

                  if (value == true) {
                    channel.sink.add('Light One is On!');
                  } else if (value == false) {
                    channel.sink.add('Light One is Off!');
                  }
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
            if(snapshot.hasData) {
              print(snapshot.data);
              if(snapshot.data == 'Light One is On!') {
                setState(() {
                  _switchValue = true;
                });
              }
               if(snapshot.data == 'Light One is Off!') {
                setState(() {
                  _switchValue = false;
                });
              }
              if(snapshot.data == 'Light Two is On!') {
                setState(() {
                  _switchValue = true;
                });
              }
              if(snapshot.data == 'Light Two is Off!') {
                setState(() {
                  _switchValue = false;
                });
              }
            }
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                    child: MergeSemantics(
                        child: ListTile(
                  title: Text('Light One'),
                  trailing: CupertinoSwitch(
                      activeColor: Colors.yellowAccent,
                      value: _switchValue,
                      onChanged: (bool value) {
                        setState(() {
                          _switchValue = value;

                          widget.valueChanged(value);

                          if (value == true) {
                            channel.sink.add('Light One is On!');
                          } else if (value == false) {
                            channel.sink.add('Light One is Off!');
                          }
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
