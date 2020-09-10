import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../widgets/case_card_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String confirmed = "a";
  String deaths = "s";
  String recovered = "d";
  bool isLoading = false;
  bool isTodayChecked = false;
  bool isTotalChecked = false;

  Future<void> getTodayData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("https://api.covid19api.com/summary");
    final responseJson = json.decode(response.body);

    setState(() {
      confirmed = responseJson["Global"]["NewConfirmed"].toString();
      deaths = responseJson["Global"]["NewDeaths"].toString();
      recovered = responseJson["Global"]["NewRecovered"].toString();
      isLoading = false;
      isTodayChecked = true;
      isTotalChecked = false;
    });
  }

  Future<void> getTotalData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("https://api.covid19api.com/summary");
    final responseJson = json.decode(response.body);

    setState(() {
      confirmed = responseJson["Global"]["TotalConfirmed"].toString();
      deaths = responseJson["Global"]["TotalDeaths"].toString();
      recovered = responseJson["Global"]["TotalRecovered"].toString();
      isLoading = false;
      isTotalChecked = true;
      isTodayChecked = false;
    });
  }

  @override
  void initState() {
    getTodayData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> caseList = [
      {
        "caseTitle": "Confirmed",
        "caseNumber": confirmed,
        "caseColor": confirmedColor,
      },
      {
        "caseTitle": "Death",
        "caseNumber": deaths,
        "caseColor": deathsColor,
      },
      {
        "caseTitle": "Recovered",
        "caseNumber": recovered,
        "caseColor": recoveredColor,
      },
    ];
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              Text(
                "COVID-19 Tracker",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "World",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 30, left: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: getTodayData,
                      child: Text(
                        "Today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: isTodayChecked
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: getTotalData,
                      child: Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: isTotalChecked
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation(Colors.white),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      )
                    : CaseCardListWidget(caseList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
