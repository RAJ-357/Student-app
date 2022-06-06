import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:WORKSPACE/domain/audio_metadata.dart';
import 'package:WORKSPACE/screens/commons/player_buttons.dart';
import 'package:WORKSPACE/screens/commons/palylist.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://ia600805.us.archive.org/0/items/LofiHipHopMixChillHiphopMusicPulse8/lofi%20hip%20hop%20mix%20%20chill%20hiphop%20music%20-%20pulse8.mp3"),
      tag: AudioMetadata(
        title: "Lofi Beats",
        artwork: "https://upload.wikimedia.org/wikipedia/en/2/23/Lofi_girl_logo.jpg"
      ),
      ),
      AudioSource.uri(Uri.parse(
          "https://ia802508.us.archive.org/8/items/thru-it-pdrrvn/Kiko%20Kaid%20-%20Thru%20It.mp3"),
        tag: AudioMetadata(
            title: "Thru It",
            artwork: "https://ia802508.us.archive.org/8/items/thru-it-pdrrvn/cover_itemimage.jpg"
        ),
      ),
      AudioSource.uri(Uri.parse(
          "https://ia902207.us.archive.org/28/items/haha-okay-w6gknl/Kiko%20Kaid%3B%20H%20A%20C%20E%20-%20haha%20okay.mp3"),
        tag: AudioMetadata(
            title: "Haha Okay",
            artwork: "https://ia802207.us.archive.org/28/items/haha-okay-w6gknl/cover_itemimage.jpg?"
        ),
      ),
      AudioSource.uri(Uri.parse(
          "https://ia802204.us.archive.org/10/items/feldspar-ft-spiral-sounds-2-wng9yx/H%20A%20C%20E%20-%20Feldspar%20%28ft.%20Spiral%20Sounds%29.mp3"),
        tag: AudioMetadata(
            title: "Feldspar (ft. Spiral Sounds)",
            artwork: "https://ia802204.us.archive.org/10/items/feldspar-ft-spiral-sounds-2-wng9yx/cover_itemimage.jpg"
        ),
      ),
      AudioSource.uri(Uri.parse(
          "https://ia902309.us.archive.org/35/items/v-mw6glp/Autophader%20-%20V%E5%81%B4%20-%2001%20ADM.mp3"),
        tag: AudioMetadata(
            title: "ADM",
            artwork: "https://ia902309.us.archive.org/35/items/v-mw6glp/cover_itemimage.jpg"
        ),
      ),AudioSource.uri(Uri.parse(
    "https://ia802309.us.archive.org/35/items/v-mw6glp/Autophader%20-%20V%E5%81%B4%20-%2002%20Cello.mp3"),
    tag: AudioMetadata(
    title: "CELLO",
    artwork: "https://ia902309.us.archive.org/35/items/v-mw6glp/cover_itemimage.jpg"
     ),
    ),
    AudioSource.uri(Uri.parse(
    "https://ia804500.us.archive.org/32/items/boardwalk-bumps-2-wjbr6g/Engelwood%20-%20Boardwalk%20Bumps%202%20-%2002%20Miller%20Time%20%28ft.%20Ian%20Ewing%29.mp3"),
    tag: AudioMetadata(
    title: "Miller Time ft.Ian Ewing",
    artwork: "https://ia804500.us.archive.org/32/items/boardwalk-bumps-2-wjbr6g/cover_itemimage.jpg"
    ),
    ),
        ]
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Container(
          decoration:  BoxDecoration(
          border: Border.all(color: Color(0xff282828)),
            color: Color(0xff282828),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),


            child: SafeArea(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Playlist(_audioPlayer),
                    )),
                    PlayerButtons(_audioPlayer),
                  ]
                )
              ),
          ),
        )
        ),
      );
  }
}
class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

T? ambiguate<T>(T? value) => value;

