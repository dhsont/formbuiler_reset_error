import 'package:example/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sailor/sailor.dart';

class MyHomePage extends StatelessWidget {
  bool autoValidate = true;
  bool readOnly = false;
  static GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);

  static var milktype = {
    {"name": "Cow", "val": "Cow"},
    {"name": "Buffalow", "val": "Buffalo"},
   
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FormBuilder Example"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                // context,
                key: _fbKey,
                autovalidate: true,

                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "age",
                      //keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Age",
                      ),
                      onChanged: _onChanged,
                      valueTransformer: (text) => num.tryParse(text),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70),
                      ],
                    ),

                    // // //milkType
                    FormBuilderDropdown(
                      attribute: "milkType",
                      decoration: InputDecoration(
                        labelText: "Milk Type",
                       // icon: Icon(Icons.ac_unit),
                      ),
                      hint: Text('Select Milk Type'),
                      validators: [FormBuilderValidators.required()],
                      items: milktype.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item["name"]),
                          value: item["val"].toString(),
                        );
                      }).toList(),
                      //initialValue: "0",
                    ),

                    //   FormBuilderTextField

                    FormBuilderTextField(
                      attribute: "name",
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                      onChanged: _onChanged,
                      valueTransformer: (text) => num.tryParse(text),
                      validators: [
                        FormBuilderValidators.max(70),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_fbKey.currentState.saveAndValidate()) {
                          print(_fbKey.currentState.value);
                        } else {
                          print(_fbKey.currentState.value);
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState.reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
