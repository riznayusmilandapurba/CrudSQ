import 'package:flutter/material.dart';
import 'package:crudsq/listdata.dart';
import 'package:crudsq/model.dart';
import 'package:crudsq/databasehelper.dart';

class AddPegawai extends StatefulWidget {
final ModelPegawai? data;
const AddPegawai({super.key, this.data});
@override
State<AddPegawai> createState() => _AddPegawaiState();
}
class _AddPegawaiState extends State<AddPegawai> {
DatabaseHelper db = DatabaseHelper();
TextEditingController firstname = TextEditingController();
TextEditingController lastname = TextEditingController();
TextEditingController mobilePhone = TextEditingController();
TextEditingController email = TextEditingController();
@override
void initState() {
// TODO: implement initState
super.initState();
firstname = TextEditingController(text: widget.data?.firstname);
lastname = TextEditingController(text: widget.data?.lastname);
mobilePhone = TextEditingController(text:
widget.data?.mobileNo);
email = TextEditingController(text: widget.data?.emailId);
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.data?.id != null ? "Update Pegawai" :
"Add Pegawai"),
backgroundColor: Colors.green,
titleTextStyle: const TextStyle(color: Colors.white,
fontSize: 14),
iconTheme: const IconThemeData(color: Colors.white),
),
body: Padding(
padding: const EdgeInsets.all(32.0),
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
TextFormField(
controller: firstname,
decoration: const InputDecoration(hintText:
"Firstname"),
),
const SizedBox(
height: 8,
),
TextFormField(
controller: lastname,
decoration: const InputDecoration(hintText:
"Lastname"),
),
const SizedBox(
height: 8,
),
TextFormField(
controller: mobilePhone,
decoration: const InputDecoration(hintText: "MobilePhone"),
),
const SizedBox(
height: 8,
),
TextFormField(
controller: email,
decoration: const InputDecoration(hintText:
"Email"),
),
const SizedBox(
height: 25,
),
MaterialButton(
minWidth: 200,
color: Colors.green,
height: 45,
onPressed: () {
if (widget.data?.id != null) {
db
.updatePegawai(ModelPegawai.froMap({
"id": widget.data?.id,
'firstname': firstname.text,
'lastname': lastname.text,
'mobileno': mobilePhone.text,
'emailid': email.text
}))
.then((value) {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (_) => const ListPegawai()),
(route) => false);
});
} else {
db
.savePegawai(ModelPegawai(firstname.text,
lastname.text,
mobilePhone.text, email.text))
.then((_) {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (_) => const ListPegawai()),
(route) => false);
});
}
},
child: Text(widget.data?.id != null ? "EDIT" :
"SIMPAN"),
)
],
),
),
),
);
}
}

