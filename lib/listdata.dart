import 'package:flutter/material.dart';
import 'package:crudsq/adddata.dart';
import 'package:crudsq/model.dart';
import 'package:crudsq/databasehelper.dart';

class ListPegawai extends StatefulWidget {
  const ListPegawai({super.key});
  @override
  State<ListPegawai> createState() => _ListPegawaiState();
}
class _ListPegawaiState extends State<ListPegawai> {
  DatabaseHelper db = DatabaseHelper();
  List<ModelPegawai> itemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAllPegawai().then((value) {
      setState(() {
        for (var item in value!) {
          itemList.add(ModelPegawai.froMap(item));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Pegawai"),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(color: Colors.white,
        fontSize: 14),
        actions: [
          IconButton(
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (_) => const
                AddPegawai()
              )
            );
          },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            )
          )
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
        ModelPegawai data = itemList[index];
        return Padding(
          padding: const EdgeInsets.only(left: 16, top: 16,right: 16),
          child: Card(
            child: ListTile(
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddPegawai(data:
                      data)
                    )
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                showDialog(
                context: context,
                builder: (context) {
                return AlertDialog(
                title: Text(
                  "Anda yakin menghapus data ${data.firstname}"
                ),
                actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No" "")
                ),
                TextButton(
                  onPressed: () {
                  db.deletePegawai(data.id).then((_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const
                        ListPegawai()
                      ),
                      (route) => false
                    );
                  }
                  );
                  },
                  child: const Text("Yes""")
                )
              ],
              );
              });
              },
              title: Text(data.firstname),
              subtitle: Text(data.emailId),
             ),
            ),
          );
        }
      ),
    );
  }
}
