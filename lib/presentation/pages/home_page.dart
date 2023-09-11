import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRepeate = false;
  bool isPlaying = false;

  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  void initState() {
    super.initState();
    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        isPlaying = true;
      } else {
        isPlaying = false;
      }
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        position = const Duration(seconds: 0);
        audioPlayer.seek(position);
      });
    });
  }

  Future setAudio() async {
    String url =
        "https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg";
    audioPlayer.setSourceUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    print("pos: $position");

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6E6581),
              Color(0xFF322C6C),
            ],
            stops: [0.3, 1],
            begin: AlignmentDirectional(0.87, -1),
            end: AlignmentDirectional(-0.87, 1),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/svg/down.svg"),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Image.asset("assets/png/rectangle.png"),
              const SizedBox(height: 16),
              const Text(
                'Обретение центра',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 120),
              Slider(
                value: position.inSeconds.toDouble(),
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.4),
                min: 0,
                max: duration.inSeconds.toDouble() + 1,
                onChanged: (newValue) async {
                  final position2 = Duration(seconds: newValue.toInt());
                  await audioPlayer.seek(position2);
                  await audioPlayer.resume();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // '15:23',
                      formatTime(position),
                      style: const TextStyle(color: Color(0x65FFFFFF)),
                    ),
                    Text(
                      // '30:54',
                      formatTime(duration),
                      style: const TextStyle(color: Color(0x65FFFFFF)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/svg/heart_outline.svg",
                        height: 24,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    IconButton(
                      icon: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Color(0x65FFFFFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: SvgPicture.asset(
                            isRepeate
                                ? "assets/svg/repeate.svg"
                                : "assets/svg/repeate_all.svg",
                            height: 24,
                            fit: BoxFit.fitHeight,
                          )),
                      onPressed: () {
                        isRepeate = !isRepeate;
                        audioPlayer.setReleaseMode(
                          isRepeate ? ReleaseMode.loop : ReleaseMode.release,
                        );

                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Container(
                          alignment: Alignment.center,
                          height: 56,
                          width: 56,
                          decoration: const BoxDecoration(
                              color: Color(0x65FFFFFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(48))),
                          child: SvgPicture.asset(
                            isPlaying
                                ? "assets/svg/pause.svg"
                                : "assets/svg/play.svg",
                            height: 56,
                            fit: BoxFit.fitHeight,
                          )),
                      onPressed: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          await audioPlayer.resume();
                        }
                      },
                    ),
                    IconButton(
                      icon: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Color(0x65FFFFFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: SvgPicture.asset(
                            "assets/svg/next.svg",
                            height: 24,
                            fit: BoxFit.fitHeight,
                          )),
                      onPressed: () {
                        audioPlayer.stop();
                        audioPlayer.onPlayerStateChanged.listen((event) {
                          isPlaying == false;
                        });
                        position = Duration.zero;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/svg/download.svg",
                        height: 24,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  String formatTime(Duration duration) {
    String twoDigits(int digit) => digit.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes - duration.inHours * 60);
    final seconds = twoDigits(
        duration.inSeconds - duration.inMinutes * 60 - duration.inHours * 60);

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
