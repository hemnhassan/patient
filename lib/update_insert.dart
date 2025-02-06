import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient/main.dart';

//update or add
class EditPage extends StatefulWidget {
  final String patientid;

  const EditPage({super.key, required this.patientid});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var id = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var time = TextEditingController();
  String? successMessage;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('patient')
        .doc(widget.patientid)
        .get()
        .then((doc) {
      if (doc.exists && status == 1) {
        id.text = doc['pid'];
        name.text = doc['pname'];
        phone.text = doc['pphone'];
        time.text = doc['ptime'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 244, 245, 246),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 244, 245, 246),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Color.fromARGB(171, 27, 176, 106),
                padding: const EdgeInsets.all(10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Patient Controller',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                  controller: id,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'patient ID')),
              const SizedBox(height: 10),
              TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Full Name')),
              const SizedBox(height: 10),
              TextField(
                controller: phone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Phone'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: time,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Time',
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      time.text = pickedTime.format(context);
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              if (successMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 3, 98, 6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        successMessage!,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () =>
                              setState(() => successMessage = null),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                ),

              if (status == 1)
                ElevatedButton(
                  onPressed: () {
                    if (id.text.isNotEmpty &&
                        name.text.isNotEmpty &&
                        phone.text.isNotEmpty &&
                        time.text.isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection('patient')
                          .doc(widget.patientid)
                          .update({
                        "patientid": id.text,
                        "pname": name.text,
                        "pphone": phone.text,
                        "ptime": time.text,
                      }).then((_) {
                        setState(() {
                          successMessage = "Patient Saved successfully!";
                          id.clear();
                          name.clear();
                          phone.clear();
                          time.clear();
                          status = 0;
                        });
                      }).catchError((error) {
                        setState(() {
                          successMessage = "Failed : $error";
                        });
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(171, 27, 176, 106),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        'Update  ',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Icon(Icons.edit, size: 30, color: Colors.white),
                    ],
                  ),
                ),
              SizedBox(
                height: 10,
              ),

//add button

              ElevatedButton(
                onPressed: () async {
                  if (id.text.isNotEmpty &&
                      name.text.isNotEmpty &&
                      phone.text.isNotEmpty &&
                      time.text.isNotEmpty) {
                    var patientRef = FirebaseFirestore.instance
                        .collection('patient')
                        .doc(id.text);

                    var docSnapshot = await patientRef.get();

                    if (docSnapshot.exists) {
                      setState(() {
                        successMessage = "Patient already exists!";
                      });
                    } else {
                      patientRef.set({
                        "pid": id.text,
                        "pname": name.text,
                        "pphone": phone.text,
                        "ptime": time.text,
                        "pstatus": 0,
                      }).then((_) {
                        setState(() {
                          successMessage = "Patient added successfully!";
                          id.clear();
                          name.clear();
                          phone.clear();
                          time.clear();
                          status = 0;
                        });
                      }).catchError((error) {
                        setState(() {
                          successMessage = "Failed to add Patient: $error";
                        });
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(171, 27, 176, 106),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 8),
                    const Text(
                      'Add Patient',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Icon(Icons.add, size: 30, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
