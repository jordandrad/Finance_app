import 'package:flutter/material.dart';

   Widget card(
            int index, String cardNumber, String cardHolder, String expDate) =>
        GestureDetector(
          child: Container(
            width: 250,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 180),
                  child: Image.asset(
                    "images/mastercard.png",
                    height: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, bottom: 15),
                  child: Text(
                    cardNumber,
                    style: TextStyle(
                        fontFamily: 'sfpromedium',
                        fontSize: 18,
                        color: Colors.white,
                       //♫ fontWeight: FontWeight.bold
                       ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Card Holder",
                            style: TextStyle(
                                fontFamily: 'sfpromedium',
                                fontSize: 8,
                                color: Colors.white),
                          ),
                          Text(
                            cardHolder,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Exp. Date",
                            style: TextStyle(
                                fontFamily: 'sfpromedium',
                                fontSize: 8,
                                color: Colors.white),
                          ),
                          Text(
                            expDate,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      Image.asset(
                        "images/chipCard.png",
                        height: 50,
                      )
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff112A54),
            ),
          ),
        );