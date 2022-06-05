// playlist.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// A list of tiles showing all the audio sources added to the audio player.
///
/// Audio sources are displayed with a `ListTile` with a leading image (the
/// artwork), and the title of the audio source.
class Playlist extends StatelessWidget {
  const Playlist(this._audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: _audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final sequence = state?.sequence ?? [];
        return ListView(
          children: [
            for (var i = 0; i < sequence.length; i++)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                  selected: i == state?.currentIndex,
                  leading: Image.network(sequence[i].tag.artwork,),
                  title: Text(sequence[i].tag.title, style: TextStyle( fontSize: 15.0),),
                  onTap: () {
                    _audioPlayer.seek(Duration(minutes: 3), index: i);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
