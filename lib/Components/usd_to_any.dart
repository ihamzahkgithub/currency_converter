import 'package:flutter/material.dart';
import '../Models/fetch_rates.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;

  const UsdToAny({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _UsdToAnyState createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'AUD';
  String answer = 'Converted Currency will be shown here :)';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'USD to Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: ValueKey('usd'),
              controller: usdController,
              decoration: InputDecoration(
                hintText: 'Enter USD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      answer = usdController.text +
                          ' USD = ' +
                          convertusd(
                              widget.rates, usdController.text, dropdownValue) +
                          ' ' +
                          dropdownValue;
                    });
                  },
                  child:
                      Text('Convert', style: TextStyle(color: Colors.yellow)),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Text(answer),
          ],
        ),
      ),
    );
  }
}
