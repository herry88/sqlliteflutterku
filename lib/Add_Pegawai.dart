import 'package:flutter/material.dart';
import 'package:sqflite_flutter/ListPegawai.dart';
import 'package:sqflite_flutter/db_helper.dart';
import 'package:sqflite_flutter/model_pegawai.dart';

class AddPegawai extends StatefulWidget {
  final ModelPegawai modelPegawai;
  AddPegawai(this.modelPegawai);

  @override
  _AddPegawaiState createState() => _AddPegawaiState();
}

class _AddPegawaiState extends State<AddPegawai> {
  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = ["item 1,item 2,item 3"];
  DatabaseHelper db = new DatabaseHelper();
  String selected = null;

  void loadData() {
    listDrop = [];
    listDrop = drop
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();

    listDrop.add(new DropdownMenuItem(
      child: new Text('Item 1'),
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text('Item 2'),
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text('Item 3'),
    ));
  }

  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _mobileNo;
  TextEditingController _emailId;
  @override
  void initState() {
    //ToDO : implements initState
    super.initState();
    _firstName = new TextEditingController(text: widget.modelPegawai.firstname);
    _lastName = new TextEditingController(text: widget.modelPegawai.lastname);
    _mobileNo = new TextEditingController(text: widget.modelPegawai.mobileno);
    _emailId = new TextEditingController(text: widget.modelPegawai.emailid);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pegawai'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _firstName,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: 'First name',
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                ),
              ),
              TextField(
                controller: _lastName,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Last Name',
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                ),
              ),
              TextField(
                controller: _mobileNo,
                decoration: InputDecoration(
                  labelText: 'Mobile No',
                  hintText: 'Mobile No',
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                ),
              ),
              TextField(
                controller: _emailId,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                ),
              ),
              RaisedButton(
//              child: (widget.modelPegawai.id != null), ? Text('Update') : Text('Add'),

                child: (widget.modelPegawai.id != null)
                    ? Text('Update')
                    : Text('Add'),
                onPressed: () {
                  if (widget.modelPegawai.id != null) {
                      db.updatePegawai(ModelPegawai.fromMap({
                          'id' : widget.modelPegawai.id,
                          'firstname' : _firstName.text,
                          'lastname'  : _lastName.text,
                          'mobileno'  : _mobileNo.text,
                          'emailid'   : _emailId.text,

                      })) .then((_){
                        Navigator.pop(context, 'update');
                      });
                  } else {
                    db
                        .savePegawai(ModelPegawai(_firstName.text,
                            _lastName.text, _mobileNo.text, _emailId.text))
                        .then((_) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ListPegawai()));
                    });
                  }
                },
//              onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
