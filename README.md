form reset is not working in two cases
_fbKey.currentState.reset();

1) when used input type number
```keyboardType: TextInputType.number```
works fine with 
```keyboardType: TextInputType.text```

2) also when used form dropdown menu
```
static var milktype = {
    {"name": "Cow", "val": "Cow"},
    {"name": "Buffalow", "val": "Buffalo"},
   
  };
```
```   
  FormBuilderDropdown(
    attribute: "milkType",
    decoration: InputDecoration(
      labelText: "Milk Type",      
    ),
    hint: Text('Select Milk Type'),
    validators: [FormBuilderValidators.required()],
    items: milktype.map((item) {
        return new DropdownMenuItem(
          child: new Text(item["name"]),
                  value: item["val"].toString(),
          );
      }).toList(),                    
    ),
```