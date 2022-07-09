import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCardHolder = TextEditingController();
  TextEditingController _controllerCardNumber = TextEditingController();
  TextEditingController _controllerCardDate = TextEditingController();
  TextEditingController _controllerCardCode = TextEditingController();
  var spotifyImage = Image.asset("images/spotifyIcon.png");
  var netflixImage = Image.asset("images/netflixIcon.png");
  var appleImage = Image.asset("images/appleIcon.png");
  int cardsCount = 2;
  int billsCount = 4;
  var darkGreen = Color(0xff31a46f);
  var lightGreen = Color(0xffddee4a);
  final white = Colors.white;
  var colorBillDefault = Colors.grey;

  var _totalSpend = "1760.58";
  double _progress = 0.8;
  bool usersChoice = true;
  int geneerateRandom() {
    int random = Random().nextInt(9999) + 1000;
    return random;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildCard(
            int index, String cardNumber, String cardHolder, String expDate) =>
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              cardsCount--;
            });
          },
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
                        fontFamily: 'kardust',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
                                fontFamily: 'kardust',
                                fontSize: 8,
                                color: Colors.black),
                          ),
                          Text(
                            cardHolder,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Exp. Date",
                            style: TextStyle(
                                fontFamily: 'kardust',
                                fontSize: 8,
                                color: Colors.black),
                          ),
                          Text(
                            expDate,
                            style: TextStyle(fontSize: 12, color: Colors.black),
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
              color: darkGreen,
            ),
          ),
        );
    void saveCard() {
      setState(() {
        cardsCount++;
      });
    }

    void clearController() {
      setState(() {
        _controllerCardHolder.text = "";
        _controllerCardNumber.text = "";
        _controllerCardHolder.text = "";
        _controllerCardDate.text = "";
      });
    }

    Widget buildBill(int index, String title, var image, String price,
            String cents, String day, String month, String year) =>
        Container(
          width: 135,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff2a2a2a),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 50, top: 20),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontSize: 13, fontFamily: 'kardust'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 50, top: 1), child: image),
              Padding(
                  padding: EdgeInsets.only(right: 50, top: 10),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'kardust',
                              color: Colors.white),
                          children: [
                        TextSpan(text: "\$$price."),
                        TextSpan(
                            text: cents,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'kardust',
                                color: Colors.white))
                      ]))),
              Padding(
                padding: EdgeInsets.only(right: 32, top: 10),
                child: Text("$day $month $year",
                    style: TextStyle(
                        fontFamily: 'kardust',
                        fontSize: 10,
                        color: Color.fromARGB(255, 112, 109, 109))),
              )
            ],
          ),
        );

    Widget buildBillWhite(int index, String title, String price) => Container(
          width: 135,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 50, top: 20),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 13,
                      fontFamily: 'kardust'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 50, top: 1),
                  child: spotifyImage),
              Padding(
                  padding: EdgeInsets.only(right: 45, top: 10),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'kardust',
                              color: Colors.black),
                          children: [
                        TextSpan(text: "\$12."),
                        TextSpan(
                            text: "90",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'kardust',
                                color: Colors.black))
                      ]))),
              Padding(
                padding: EdgeInsets.only(right: 32, top: 10),
                child: Text("13 Jan 2022",
                    style: TextStyle(
                        fontFamily: 'kardust',
                        fontSize: 10,
                        color: Color.fromARGB(255, 112, 109, 109))),
              )
            ],
          ),
        );

    Widget buildConnect(int index) => Container(
          height: 100,
          width: 50,
          child: GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      backgroundColor: Color(0xff2a2a2a),
                      titlePadding: EdgeInsets.all(20),
                      title: Text(
                        "Card info",
                        style: TextStyle(
                            color: lightGreen,
                            fontFamily: 'kardust',
                            fontSize: 15),
                      ),
                      content: SingleChildScrollView(
                        child: Container(
                          height: 390,
                          width: 200,
                          child: Column(
                            children: [
                              TextField(
                                keyboardType: TextInputType.text,
                                controller: _controllerCardHolder,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Card Holder",
                                    labelStyle: TextStyle(
                                        fontFamily: 'kardust',
                                        color: Color.fromARGB(
                                            255, 112, 109, 109))),
                              ),
                              TextField(
                                controller: _controllerCardNumber,
                                keyboardType: TextInputType.number,
                                maxLength: 16,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Card number",
                                    labelStyle: TextStyle(
                                        fontFamily: 'kardust',
                                        color: Color.fromARGB(
                                            255, 112, 109, 109))),
                              ),
                              TextField(
                                controller: _controllerCardDate,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Exp. Date",
                                    labelStyle: TextStyle(
                                        fontFamily: 'kardust',
                                        color: Color.fromARGB(
                                            255, 112, 109, 109))),
                              ),
                              TextField(
                                controller: _controllerCardCode,
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "CVV",
                                    labelStyle: TextStyle(
                                        fontFamily: 'kardust',
                                        color: Color.fromARGB(
                                            255, 112, 109, 109))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40, left: 150),
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveCard();
                                    buildCard(
                                        index,
                                        _controllerCardNumber.text,
                                        _controllerCardHolder.text,
                                        _controllerCardDate.text);
                                    Navigator.pop(context);
                                   
                                  },
                                  child: Text("Save"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 0, 87, 3)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                }),
            child: Padding(
                padding: EdgeInsets.all(14),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            "Connect card",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: darkGreen,
                                fontFamily: 'kardust',
                                fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ))),
          ),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: darkGreen)),
        );

    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 7),
                child: Text(
                  "\$$_totalSpend",
                  style: TextStyle(
                      color: lightGreen, fontSize: 45, fontFamily: 'kardust'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Total month spend",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50, left: 16, right: 16),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey,
                  minHeight: 6,
                  valueColor: AlwaysStoppedAnimation(lightGreen),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: SizedBox(
                    height: 170,
                    width: 400,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardsCount,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 12,
                          );
                        },
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(
                              width: 12,
                            );
                          }
                          if (index == 1) {
                            {
                              return buildConnect(1);
                            }
                          } else {
                            return buildCard(
                                index,
                                _controllerCardNumber.text,
                                _controllerCardHolder.text,
                                _controllerCardDate.text);
                          }
                        }),
                  )),
              Padding(
                padding: EdgeInsets.only(
                  right: 180,
                ),
                child: Text(
                  "Upcoming bills",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'kardust', fontSize: 22),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  child: SizedBox(
                    height: 200,
                    width: 400,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: billsCount,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 12,
                          );
                        },
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(
                              width: 12,
                            );
                          }
                          if (index == 1) {
                            {
                              return buildBillWhite(index, "Spotify", "30");
                            }
                          }
                          if (index == 2) {
                            return buildBill(index, "Netflix", netflixImage,
                                "7", "50", "2", "Jun", "2022");
                          } else {
                            return buildBill(index, "Apple", appleImage, "19",
                                "00", "10", "Aug", "2022");
                          }
                        }),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 35, left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Expense",
                        style: TextStyle(
                          fontSize: 13
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 17, 0)),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Income"),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 0, 87, 3)),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Bill"),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 0, 38, 69)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
