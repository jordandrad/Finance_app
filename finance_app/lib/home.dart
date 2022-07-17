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
  TextEditingController _controllerbillName = TextEditingController();

  TextEditingController _controllerbillPrice = TextEditingController();
  TextEditingController _controllerbillDate = TextEditingController();
  TextEditingController _controllerIncomeDesc = TextEditingController();
  TextEditingController _controllerIncomeValue = TextEditingController();
  TextEditingController _controllerIncomeDate = TextEditingController();
  TextEditingController _controllerMonthProfit = TextEditingController();
  TextEditingController _controllerExpenseDesc = TextEditingController();
  TextEditingController _controllerExpenseValue = TextEditingController();
  TextEditingController _controllerExpenseDate = TextEditingController();

  List<String> cardHolder = [];
  List<String> cardNumber = [];
  List<String> cardDate = [];
  List<String> cardCode = [];
  List<String> billTitle = [];
  List<String> billPrice = [];
  List<String> billDate = [];
  List<String> incomeDesc = [];
  List<String> incomeValue = [];
  List<String> incomeDate = [];
  List<String> expenseDesc = [];
  List<String> expenseValue = [];
  List<String> expenseDate = [];

  var defaultImage = Image.asset('images/billImage.png');

  int cardsCount = 2;
  int billsCount = 1;
  int saved = 0;
  int addBill = 0;
  int addIncome = 0;
  int incomeCount = 0;
  int addExpense = 0;
  int expenseCount = 0;
  var darkGreen = Color(0xff31a46f);
  var lightGreen = Color(0xffddee4a);
  var colorButtonSave = Color.fromARGB(255, 0, 87, 3);
  var colorBillDefault = Colors.grey;
  var goalProfit = 0;
  var cost = 3597;
  double currentProfit = 0;

  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    Widget buildCard(
            int index, String cardNumber, String cardHolder, String expDate) =>
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              cardsCount--;
              saved--;
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
    void saveIncome() {
      setState(() {
        incomeCount++;
        addIncome++;
      });
    }

    void saveExpense() {
      setState(() {
        expenseCount++;
        addExpense++;
      });
    }

    void addGoal() {
      setState(() {
        goalProfit = int.parse(_controllerMonthProfit.text);
      });
      _controllerMonthProfit.clear();
    }

    void saveBill() {
      setState(() {
        billsCount++;
        addBill++;
      });
      print("Bills Count: " + billsCount.toString());
      print("Add Bill: " + addBill.toString());
    }

    void addNewExpense() {
      setState(() {
        currentProfit -= double.parse(expenseValue[addExpense - 1]);
      });
    }

    void addNewIncome() {
      setState(() {
        currentProfit += double.parse(incomeValue[addIncome - 1]);
      });
    }

    void saveCard() {
      setState(() {
        cardsCount++;
        saved++;
      });
      print("Saved value in saveCard: " + saved.toString());
    }

    void verify() {
      if (saved > 3) {
        setState(() {
          colorButtonSave = Colors.grey;
        });
      } else {
        setState(() {
          colorButtonSave = Color.fromARGB(255, 0, 87, 3);
        });
      }
    }

    void deleteBill() {
      setState(() {
        billsCount--;
        addBill--;
      });
    }

    void calculateIncome() {
      var splitProfit = currentProfit / goalProfit;
      if (goalProfit != 0) {
        setState(() {
          _progress = splitProfit;
        });
      }
      print(splitProfit);
    }

    void calculateExpense() {
      var splitExpense =
          double.parse(expenseValue[addExpense - 1]) / goalProfit;
      if (goalProfit != 0) {
        setState(() {
          currentProfit - double.parse(expenseValue[addExpense - 1]);
          _progress -= splitExpense;
        });
      }
      print(splitExpense);
    }

    void addToListIncome() {
      incomeDesc.add(_controllerIncomeDesc.text);
      _controllerIncomeDesc.clear();
      incomeValue.add(_controllerIncomeValue.text);
      _controllerIncomeValue.clear();
      incomeDate.add(_controllerIncomeDate.text);
      _controllerIncomeDate.clear();
    }

    void addToListExpense() {
      expenseDesc.add(_controllerExpenseDesc.text);
      _controllerExpenseDesc.clear();
      expenseValue.add(_controllerExpenseValue.text);
      _controllerExpenseValue.clear();
      expenseDate.add(_controllerExpenseDate.text);
      _controllerExpenseDate.clear();
    }

    void addToListBill() {
      billTitle.add(_controllerbillName.text);
      _controllerbillName.clear();
      billPrice.add(_controllerbillPrice.text);
      _controllerbillPrice.clear();
      billDate.add(_controllerbillDate.text);
      _controllerbillDate.clear();
    }

    void addToList() {
      cardHolder.add(_controllerCardHolder.text);
      _controllerCardHolder.clear();
      cardNumber.add(_controllerCardNumber.text);
      _controllerCardNumber.clear();
      cardDate.add(_controllerCardDate.text);
      _controllerCardDate.clear();
      cardCode.add(_controllerCardCode.text);
      _controllerCardCode.clear();
    }

    Widget buildBill(
            int index, String title, var image, String price, String date) =>
        GestureDetector(
          onDoubleTap: deleteBill,
          child: Container(
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
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'kardust'),
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
                          TextSpan(text: "\$$price"),
                        ]))),
                Padding(
                  padding: EdgeInsets.only(right: 32, top: 10),
                  child: Text(date,
                      style: TextStyle(
                          fontFamily: 'kardust',
                          fontSize: 10,
                          color: Color.fromARGB(255, 112, 109, 109))),
                )
              ],
            ),
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
                      backgroundColor: Colors.white,
                      // Color(0xff2a2a2a)
                      titlePadding: EdgeInsets.all(20),
                      title: Text(
                        "Card info",
                        style: TextStyle(
                            color: Colors.black,
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
                                style: TextStyle(color: Colors.black),
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
                                style: TextStyle(color: Colors.black),
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
                                style: TextStyle(color: Colors.black),
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
                                style: TextStyle(color: Colors.black),
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
                                    addToList();
                                    verify();
                                    print(cardHolder);
                                    print(cardNumber);
                                    print(cardDate);
                                    print(cardCode);

                                    Navigator.pop(context);
                                  },
                                  child: Text("Save"),
                                  style: ElevatedButton.styleFrom(
                                      primary: colorButtonSave),
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
                  "\$$currentProfit",
                  style: TextStyle(
                      color: lightGreen, fontSize: 45, fontFamily: 'kardust'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Balance",
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
                            return buildConnect(1);
                          }
                          if (index == 2) {
                            print("CardHolder returned");
                            return buildCard(index, cardNumber[0],
                                cardHolder[0], cardDate[0]);
                          }
                          if (index == 3) {
                            print("CardHolder1 returned");
                            return buildCard(index, cardNumber[1],
                                cardHolder[1], cardDate[1]);
                          }
                          if (index == 4) {
                            print("CardHolder2 returned");
                            return buildCard(index, cardNumber[2],
                                cardHolder[2], cardDate[2]);
                          }
                          if (index == 5) {
                            print("CardHolder3 returned");
                            return buildCard(index, cardNumber[3],
                                cardHolder[3], cardDate[3]);
                          } else {
                            return SizedBox(
                              width: 1,
                            );
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
                          print(index);
                          if (index == 0) {
                            return SizedBox(
                              width: 12,
                            );
                          }
                          if (index == 1) {
                            return buildBill(
                                index,
                                billTitle[index - 1],
                                defaultImage,
                                billPrice[index - 1],
                                billDate[index - 1]);
                          }
                          if (index == 2) {
                            return buildBill(
                                index,
                                billTitle[index - 1],
                                defaultImage,
                                billPrice[index - 1],
                                billDate[index - 1]);
                          } else {
                            return buildBill(
                                index,
                                billTitle[index - 1],
                                defaultImage,
                                billPrice[index - 1],
                                billDate[index - 1]);
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
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  "New Expense",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'kardust',
                                      fontSize: 18),
                                ),
                                content: SingleChildScrollView(
                                    child: Container(
                                  height: 290,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerExpenseDesc,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Description",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _controllerExpenseValue,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Expense value",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerExpenseDate,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Date",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 40, left: 150),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            saveExpense();
                                            addToListExpense();
                                            print(expenseDesc);
                                            print(expenseValue);
                                            print(expenseDate);
                                            addNewExpense();
                                            calculateExpense();
                                          },
                                          child: Text("Add"),
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 0, 87, 3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              );
                            }),
                        child: Text(
                          "Expense",
                          style: TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 87, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  "New Income",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'kardust',
                                      fontSize: 18),
                                ),
                                content: SingleChildScrollView(
                                    child: Container(
                                  height: 290,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerIncomeDesc,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Description",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _controllerIncomeValue,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Income value",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerIncomeDate,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Date",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 40, left: 150),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            saveIncome();
                                            addToListIncome();
                                            addNewIncome();
                                            calculateIncome();
                                          },
                                          child: Text("Add"),
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 0, 87, 3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              );
                            }),
                        child: Text("Income"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 0, 87, 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  "New Bill",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'kardust',
                                      fontSize: 18),
                                ),
                                content: SingleChildScrollView(
                                    child: Container(
                                  height: 290,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerbillName,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Bill name",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _controllerbillPrice,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Price",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerbillDate,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Date",
                                            labelStyle: TextStyle(
                                                fontFamily: 'kardust',
                                                color: Color.fromARGB(
                                                    255, 112, 109, 109))),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 40, left: 150),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            saveBill();
                                            addToListBill();
                                          },
                                          child: Text("Add"),
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 0, 87, 3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              );
                            }),
                        child: Text("Bill"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 1, 0, 83),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  height: 30,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              "Personal info",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'kardust',
                                  fontSize: 18),
                            ),
                            content: SingleChildScrollView(
                                child: Container(
                              height: 220,
                              width: 200,
                              child: Column(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _controllerMonthProfit,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        labelText: "Month earnings goal",
                                        labelStyle: TextStyle(
                                            fontFamily: 'kardust',
                                            color: Color.fromARGB(
                                                255, 112, 109, 109))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Goal",
                                          style: TextStyle(
                                              fontFamily: 'kardust',
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Profits",
                                          style: TextStyle(
                                              fontFamily: 'kardust',
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              goalProfit.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'kardust',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 30,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.green,
                                          ),
                                        ),
                                        Container(
                                            child: Center(
                                              child: Text(
                                                currentProfit.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'kardust',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            height: 30,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: Colors.blue,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 40, left: 150),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        addGoal();
                                        calculateIncome();
                                      },
                                      child: Text("Save"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 0, 87, 3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                          );
                        }),
                    child: Text(
                      "Personal info",
                      style: TextStyle(fontSize: 13),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 51, 1, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
