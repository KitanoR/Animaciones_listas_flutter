import 'package:flutter/material.dart';
import 'package:list_animate/src/models/alimentos_model.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart' as wheel;

class WhelsPage extends StatefulWidget {

  @override
  _WhelsPageState createState() => _WhelsPageState();
}

class _WhelsPageState extends State<WhelsPage> {
  wheel.FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = wheel.FixedExtentScrollController();
    _controller.addListener(_listListener);
  }
  @override
  void dispose() {
    _controller?.removeListener(_listListener);
    _controller?.dispose();
    super.dispose();
  }
  
  void _listListener() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return wheel.CircleListScrollView.useDelegate(
        childDelegate: wheel.CircleListChildBuilderDelegate(
          builder: (context, index) {
            int currentIndex = 0;
            try {
              currentIndex = _controller.selectedItem;
            } catch (_) {}
            final resizeFactor =
                (1 - (((currentIndex - index).abs() * 0.3).clamp(0.0, 1.0)));
            return CirclePelotaItem(
              resizeFactor: 1,
              pelota: pelotas2List[index],
            );
          },
          childCount: pelotas2List.length,
        ),
        physics: wheel.CircleFixedExtentScrollPhysics(),
        controller: _controller,
        axis: Axis.vertical,
        itemExtent: 120,
        radius: MediaQuery.of(context).size.width * 0.8,
      );
  }
}


class CirclePelotaItem extends StatelessWidget {
  final double resizeFactor;
  final PelotasModel pelota;
  CirclePelotaItem({
    this.resizeFactor,
    this.pelota
  });
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              pelota.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22 * resizeFactor
              ),
            ),
          ),
          Container(
            width: 120 * resizeFactor,
            height: 120 * resizeFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white
            ),
            child: Align(
              child: Container(
                child: Image.asset(pelota.avatar, fit: BoxFit.contain,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.blue
                ),
                height: 110 * resizeFactor,
                width: 110 * resizeFactor,
              ),
            ),
          )
        ],
      ),
    );
  }
}