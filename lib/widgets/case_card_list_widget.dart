import 'package:flutter/material.dart';

import '../widgets/case_card_widget.dart';

class CaseCardListWidget extends StatefulWidget {
  final List<Map<String, Object>> caseList;

  CaseCardListWidget(this.caseList);

  @override
  _CaseCardListWidgetState createState() => _CaseCardListWidgetState();
}

class _CaseCardListWidgetState extends State<CaseCardListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          ...widget.caseList
              .map((caseCard) => CaseCardWidget(
                    caseTitle: caseCard["caseTitle"],
                    caseNumber: caseCard["caseNumber"],
                    caseColor: caseCard["caseColor"],
                  ))
              .toList(),
        ],
      ),
    );
  }
}
