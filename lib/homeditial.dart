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
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
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
      appBar: AppBar(
        title: Text('VideoPlay'),
      ),
      body: Column(children: <Widget>[
        Container(child: fetchVideoPlay(),height: 200,),
        Expanded(child: Padding(
          child: fetchNextVideoPlay(),
          padding: EdgeInsets.only(top: 6),),
        flex: 1,
        ),

      ],)
    );
  }
  fetchVideoPlay() {
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
  fetchNextVideoPlay() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: ((BuildContext context,int position){
          return Container(
            height: 100,
            child: Card( 
              child: Padding(
              padding: EdgeInsets.only(left:8,top: 4),
              child: Column(children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],) ,
              ) 
            ,),
          );
        }),
    );
  }
  
}