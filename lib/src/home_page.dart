import 'package:flutter/material.dart';
import 'package:list_animate/src/models/alimentos_model.dart';


const sizeCard = 150.0;


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onListener);
  }
  @override
  void dispose() {
    scrollController.removeListener(onListener);
    super.dispose();
  }

  void onListener() {
    setState(() { });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Placeholder(
                fallbackHeight: 100.0,
              ),
            ),
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              title: Text(
                'Pelotas',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pelota = pelotasList[index];
                  final itemPositionOffset = index * (sizeCard * 0.7);
                  final diferencia = scrollController.offset - itemPositionOffset;
                  final percent = 1 - (diferencia / (sizeCard * 0.7));
                  double opacity = percent;
                  double scale = percent;
                  if(opacity > 1.0 ) opacity = 1.0;
                  if(opacity < 0.0) opacity = 0.0;
                  if(percent > 1.0) scale = 1.0;
                  
                  return Align(
                    heightFactor: 0.7,
                    child: Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, scale),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )
                          ),
                          color: pelota.color,
                          elevation: 5,
                          child: SizedBox(
                            height: sizeCard,
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      pelota.title,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Image.asset(pelota.avatar)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: pelotasList.length
              ),
            )
          ],
        ),
      );
  
  }
}


class CustomHeader extends SliverPersistentHeaderDelegate {

  
    @override
    // TODO: implement maxExtent
    double get maxExtent => 100.0;
  
    @override
    // TODO: implement minExtent
    double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Text('hola');
  }
  
 

}