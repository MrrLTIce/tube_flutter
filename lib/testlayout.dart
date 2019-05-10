import 'package:flutter/material.dart';

class Testing2 extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      child: Container(
                        color: Colors.orange,
                      )),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            flex: 2,
                            child: Container(
                              color: Colors.blue,
                            )),
                        Flexible(child: Container(color: Colors.green))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
}