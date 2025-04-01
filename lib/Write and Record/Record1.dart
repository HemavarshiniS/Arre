import 'package:arrre/Home%20Page/HomePage.dart';
import 'package:arrre/Write%20and%20Record/RecordPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class Record1 extends StatefulWidget {
  const Record1({super.key});

  @override
  State<Record1> createState() => _Record1State();
}

class _Record1State extends State<Record1> {

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;

  double _progress = 0.4;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  Future<void> _startRecording() async {
    _filePath = 'recording.aac';
    await _recorder.startRecorder(toFile: _filePath);
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() => _isRecording = false);
  }

  Future<void> _playAudio() async {
    if (_filePath != null) {
      await _player.startPlayer(fromURI: _filePath!, whenFinished: () {
        setState(() => _isPlaying = false);
      });
      setState(() => _isPlaying = true);
    }
  }

  Future<void> _stopAudio() async {
    await _player.stopPlayer();
    setState(() => _isPlaying = false);
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Color(0xff074a65),),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Recordpage()));
          },
        ),
        actions: [

          Padding(padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: 98,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff074a65),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                Container(
                  width: 98,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff074a65),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.close,color: Color(0xff343330),),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
                  },
                ),



              ],
            ),
          )

        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Text(
              "What do you plan to do today?",
              style: TextStyle(fontSize: 18, fontFamily: "MonaSans",fontWeight: FontWeight.w900),
            ),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [

                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Name your clip",
                      style: TextStyle(
                        fontFamily: "MonaSans",
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  SizedBox(height: 20,),


                  Container(
                    height: 2,
                    width: 334,
                    child: Slider(
                      value: _progress,
                      onChanged: (newValue) {
                        setState(() {
                          _progress = newValue;
                        });
                      },
                      min: 0,
                      max: 1,
                      activeColor: Color(0xff074a65),
                      inactiveColor: Color(0xffbdcac9),
                    ),
                  ),

                  SizedBox(height: 5,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Text("00:00",style: TextStyle(fontFamily: 'MonaSans'),),

                      Text("00:14",style: TextStyle(fontFamily: 'MonaSans'),),
                      
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.graphic_eq, color: Color(0xff074a65)),
                      Container(
                        height: 32,
                        width: 153,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.replay_5,size: 35, color: Color(0xff232C36)),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow,size: 35, color: Color(0xff074a65)),
                              onPressed: _isPlaying ? _stopAudio : _playAudio,
                            ),
                            IconButton(
                              icon: Icon(Icons.forward_5,size: 35, color: Colors.black87),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),

                ],
              )
            ),

          ],
        ),

      ),

      floatingActionButton: Padding(padding: EdgeInsets.only(left: 40,bottom: 40),
        child: Align(
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {},
          backgroundColor: Color(0xffFFFFFF),
          child: Icon(Icons.add),
        ),
      ),
      ),

    );
  }
}
