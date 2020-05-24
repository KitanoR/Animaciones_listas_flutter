import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';


// Investigar smartFlareAction

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class FlarePage extends StatefulWidget {

  @override
  _FlarePageState createState() => _FlarePageState();
}

class _FlarePageState extends State<FlarePage> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 102, 18, 222),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SmartFlareAnimation(),
      )
   );
  }
}


class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  final  double AnimationWidth = 295.0;
  final  double AnimationHeight = 252.0;

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;

  // Flare animation controls
  final FlareControls animationControls = FlareControls();

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo) {
              
           
              var localTouchPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(tapInfo.globalPosition);

              var topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;

              var leftSideTouched = localTouchPosition.dx < AnimationWidth / 3;

              var rightSideTouched =
                  localTouchPosition.dx > (AnimationWidth / 3) * 2;

              var middleTouched = !leftSideTouched && !rightSideTouched;

              if(leftSideTouched && topHalfTouched){
                print('top left');
                _setAnimationToPlay(AnimationToPlay.CameraTapped);
              }else if (middleTouched && topHalfTouched){
                print('top middle');
                _setAnimationToPlay(AnimationToPlay.PulseTapped);
              }else if(rightSideTouched && topHalfTouched){
                print('top right');
                _setAnimationToPlay(AnimationToPlay.ImageTapped);
              }else {
                if(isOpen){
                  _setAnimationToPlay(AnimationToPlay.Deactivate);
                }else {
                  _setAnimationToPlay(AnimationToPlay.Activate);
                }
                isOpen = !isOpen;
              }
        },
        child: FlareActor('assets/MultiOptionButton.flr',
              controller: animationControls, animation: 'deactivate'),
      ),
    );
  }

  
  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains("_tapped");
    if (isTappedAnimation &&
        _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    _lastPlayedAnimation = animation;
  }
}

