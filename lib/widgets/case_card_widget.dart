import 'package:flutter/material.dart';

class CaseCardWidget extends StatefulWidget {
  final String caseTitle;
  final String caseNumber;
  final Color caseColor;

  CaseCardWidget({
    this.caseTitle,
    this.caseNumber,
    this.caseColor,
  });

  @override
  _CaseCardWidgetState createState() => _CaseCardWidgetState();
}

class _CaseCardWidgetState extends State<CaseCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: widget.caseColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.caseTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              // numberFormat.format(confirmed),
              widget.caseNumber,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
