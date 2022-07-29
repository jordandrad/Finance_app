import 'package:flutter/material.dart';

 Widget bill(
            int index, String title, var image, String price, String date) =>
        GestureDetector(
          child: Container(
            width: 135,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xff112A54), width: 3),
              color: Color(0xffDDE9FC),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30, top: 20, left: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Color(0xff020B1D),
                        fontSize: 15,
                        fontFamily: 'sfpromedium'),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 50, top: 1), child: image),
                Padding(
                    padding: EdgeInsets.only(right: 45, top: 10, left: 10),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'sfpromedium',
                                fontWeight: FontWeight.bold,
                                color: Color(0xff020B1D)),
                            children: [
                          TextSpan(text: "\$$price"),
                        ]))),
                Padding(
                  padding: EdgeInsets.only(right: 35, top: 15),
                  child: Text(date,
                      style: TextStyle(
                          fontFamily: 'sfpromedium',
                          fontSize: 10,
                          color: Color(0xff020B1D))),
                )
              ],
            ),
          ),
        );