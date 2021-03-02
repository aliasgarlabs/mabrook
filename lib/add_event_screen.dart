import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatelessWidget {
  TextEditingController dateTextFieldController = TextEditingController();
  GlobalKey<FormState> eventFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add event',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (eventFormKey.currentState.validate()) {
                  Navigator.pop(context, dateTextFieldController.text);
                }
              },
            )
          ],
        ),
        body: Form(
          key: eventFormKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title cannot be empty';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please pick a date';
                  }

                  return null;
                },
                controller: dateTextFieldController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Pick a date'),
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');
                  dateTextFieldController.text = formatter.format(pickedDate);
                  print(pickedDate.toIso8601String());
                },
              ),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Event Type'
                  ),
                  onTap: () async {
                List<String> eventTypes = <String>[
                  'Birthday',
                  'Waras',
                  'Anniversary',
                  'Eid',
                  'Other',
                ];

                showMaterialScrollPicker(
                  context: context,
                  title: "Event type",
                  items: eventTypes,
                  onChanged: (value) {
                    // Save event type here
//      setState(() => selectedUsState = value);
                  },
                );
              })
            ],
          ),
        ));
  }
}
