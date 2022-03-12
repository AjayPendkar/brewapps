import 'dart:ffi';

import 'package:flutter/material.dart';

class Productscreen extends StatefulWidget {
  final String title;
  final String relesedate;
  final String bgimage;
  final String popularity;
  final String shortnotes;
  const Productscreen(
      {Key key,
      @required this.title,
      this.bgimage,
      this.relesedate,
      this.popularity,
      this.shortnotes})
      : super(key: key);

  // const Productscreen.info({
  //   Key key,
  //   this.title,
  // });

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[300],
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.bgimage), fit: BoxFit.fill)),
          ),
          Positioned(
            // The Positioned widget is used to position the text inside the Stack widget
            bottom: 50,
            right: 30,
            child: Container(
              height: 300,
              // We use this Container to create a black box that wraps the white text so that the user can read the text even when the image is white
              width: 300,
              color: Colors.black54,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.relesedate.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.popularity.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.shortnotes,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
