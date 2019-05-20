import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeDetial extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeDetial> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=d_m5csmrf7I',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: fetchVideoPlay(),
          width: MediaQuery.of(context).size.width,
          height: 200,
        ),
        Container(
          
          color: Colors.black,
          child: IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: () {
              setState(() {
                // If the video is playing, pause it.
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // If the video is paused, play it
                  _controller.play();
                }
              });
            },
          ),
        ),
        
        Expanded(
          child: ListView(
            children: <Widget>[fetchVideoInfo(), fetchNextVideoPlay()],
          ),
        ),
      ],
    ));
  }

  Widget fetchVideoPlay() {
    // Use a FutureBuilder to display a loading spinner while you wait for the
// VideoPlayerController to finish initializing.
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the Aspect Ratio of the VideoPlayer
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video
            child: VideoPlayer(_controller),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget fetchVideoInfo() {
    return ListTile(
      // trailing: Icon(Icons.more_vert),
      title: Text('Hello borther welcome'),
      subtitle: Text('50 M'),
    );
  }

  Widget fetchNextVideoPlay() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: ((BuildContext context, int position) {
        return Container(
          height: 100,
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4),
              child: Column(
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle:
                        Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
