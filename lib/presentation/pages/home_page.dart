import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? sliderValue;
  bool isRepeate = false;
  bool isPlaying = false;

  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  Widget build(BuildContext context) {
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
                max: duration.inSeconds.toDouble(),
                onChanged: (newValue) async {
                  newValue = double.parse(newValue.toStringAsFixed(2));
                  sliderValue = newValue;
                  setState(() {});
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '15:23',
                      style: TextStyle(color: Color(0x65FFFFFF)),
                    ),
                    Text(
                      '30:54',
                      style: TextStyle(color: Color(0x65FFFFFF)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(40, 40, 40, 40),
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
                                ? "assets/svg/repeate_all.svg"
                                : "assets/svg/repeate.svg",
                            height: 24,
                            fit: BoxFit.fitHeight,
                          )),
                      onPressed: () {
                        isRepeate = !isRepeate;
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
                                ? "assets/svg/play.svg"
                                : "assets/svg/pause.svg",
                            height: 56,
                            fit: BoxFit.fitHeight,
                          )),
                      onPressed: () {
                        isPlaying = !isPlaying;
                        setState(() {});
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
                        sliderValue = 100;
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
}
