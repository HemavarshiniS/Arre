import 'dart:async';
import 'dart:math';
import 'package:arrre/Write%20and%20Record/Record1.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Home Page/Homepage.dart';

class Recordpage extends StatefulWidget {
  const Recordpage({super.key});

  @override
  State<Recordpage> createState() => _RecordpageState();
}

class _RecordpageState extends State<Recordpage> {

  bool isRecording = true;
  bool isPlaying = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  List<double> waveData = [];
  Timer? _waveTimer;
  late final RecorderController _recorderController;


  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _recorderController = RecorderController();
      // ..waveStyle = WaveStyle(
      //   waveColor: Colors.white,
      //   extendWaveform: true,
      // );
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }


  void _startRecording() async {
    setState(() => _isRecording = true);
    await _recorder.startRecorder(toFile: 'recording.aac');
    _startWaveformUpdate();
  }

  void _startWaveformUpdate() {
    _waveTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!_isRecording) {
        timer.cancel();
        return;
      }
      setState(() {
        waveData.add(Random().nextDouble()); // Simulating waveform data
        if (waveData.length > 100) waveData.removeAt(0);
      });
    });
  }

  void _stopRecording() async {
    setState(() => _isRecording = false);
    await _recorder.stopRecorder();
    waveData.clear();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.closeRecorder();
    super.dispose();
  }


  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Color(0xff074a65),),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
          },
        ),
        actions: [

          Row(
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
                  color: Color(0xffd9d9d9),
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
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),
            const Text(
              "What do you plan to do today?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              isPlaying ? "Start recording..." : "Recording stopped",
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            Padding(padding: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {},
                backgroundColor: Color(0xffFFFFFF),
                child: Icon(Icons.add),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 51,
                    width: 378,
                    decoration: BoxDecoration(
                      color: Color(0xff074a65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,
                              size: 35,
                            ),
                            onPressed: () {
                              _isRecording ? _stopRecording : _startRecording;
                            },
                          ),

                          Expanded(
                            child: AudioWaveforms(
                              recorderController: _recorderController,
                              size: Size(double.infinity, 100),
                              enableGesture: true,
                              waveStyle: WaveStyle(
                                waveColor: Colors.white,
                                extendWaveform: true,
                                showMiddleLine: false,
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            _formatTime(_seconds),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.mic,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                ),
                IconButton(
                  icon: Container(height: 56, width: 56, decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff074a65)),child: Icon(Icons.check,color: Colors.white,),),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Record1()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

    );
  }
}
