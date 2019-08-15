import 'package:flutter/material.dart';
import 'package:sqflite_flutter/db_helper.dart';
import 'package:sqflite_flutter/model_pegawai.dart';
import 'package:sqflite_flutter/Add_Pegawai.dart';

class ListPegawai extends StatefulWidget {
  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  List<ModelPegawai> items = new List();
  DatabaseHelper db = new DatabaseHelper();

//  var pegawais;
  @override
  void initState() {
    //TODO : implement initState
    super.initState();
    db.getAllPegawai().then((pegawais) {
      setState(() {
        pegawais.forEach((pegawai) {
          items.add(ModelPegawai.fromMap(pegawai));
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pegawai'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, positin) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '${items[positin].emailid}',
                    style: TextStyle(fontSize: 20.0, color: Colors.orange),
                  ),
                  subtitle: Text(
                    '${items[positin].lastname}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 15.0,
                        child: Text(
                          '${items[positin].id}',
                          style: TextStyle(fontSize: 22.0, color: Colors.white),
                        ),
                      ),
                      //icon untuk delete
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _deletePegawai(context, items[positin],positin),
                      )
                    ],
                  ),
                  onTap:() => _navigateToPegawai(context, items[positin]),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _createNewPegawai(context)),
    );
  }

  void _deletePegawai(BuildContext context, ModelPegawai pegawai, int positin) async{
    db.deleteDataPegawai(pegawai.id).then((pegawais){
      setState(() {
        items.removeAt(positin);
      });
    });
  }

  void _navigateToPegawai(BuildContext context, ModelPegawai pegawai)async{
    String result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPegawai(pegawai)),
    );
    if(result == 'update'){
      db.getAllPegawai().then((pegawais){
      setState(() {
        items.clear();
        pegawais.forEach((pegawai){
          items.add(ModelPegawai.fromMap(pegawai));
        });
      });
      });
    }
  }

  //untuk menambah data
  void _createNewPegawai(BuildContext context) async {
    String result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => AddPegawai(ModelPegawai('', '', '', ''))),
    );
    if (result == 'save') {
      db.getAllPegawai().then((pegawais) {
        setState(() {
          items.clear();
          pegawais.forEach((pegawai) {
            items.add(ModelPegawai.fromMap(pegawai));
          });
        });
      });
    }
  }
}

