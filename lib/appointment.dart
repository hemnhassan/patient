import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient/update_insert.dart';


//appointment
class appointment extends StatelessWidget {
  const appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("patient")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }
       return SingleChildScrollView(
  child: Container(
    width: double.infinity,
    color: Color.fromARGB(171, 27, 176, 106),
    child: DataTable(
      columns: const [
        DataColumn(
            label: Text(
          'ID',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
        DataColumn(
            label: Text(
          'P_Name',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )),
        DataColumn(
            label: Text(
          'Phone',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )),
        DataColumn(
            label: Text(
          'Stage',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )),
        DataColumn(
            label: Text(
          'Actions',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )),
      ],
      rows: snapshot.data!.docs.where((doc) => doc['pstatus'] == 2).map((doc) {
        return DataRow(cells: [
          DataCell(Text(
            doc['pid'].toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 249, 248, 246)),
          )),
          DataCell(Text(
            doc['pname'].toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 249, 248, 246)),
          )),
          DataCell(Text(
            doc['pphone'].toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 249, 248, 246)),
          )),
          DataCell(Text(
            doc['ptime'].toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 249, 248, 246)),
          )),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  String Patientid = doc.id;
                  FirebaseFirestore.instance
                      .collection('patient')
                      .doc(Patientid)
                      .update({
                    "pstatus": 0,
                  }).catchError((error) {
                    print("Error updating status: $error");
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Color.fromARGB(255, 232, 129, 2),
                ),
                onPressed: () {
                  String Patientid = doc.id;
                  FirebaseFirestore.instance
                      .collection('patient')
                      .doc(Patientid)
                      .update({
                    "pstatus": 3,
                  }).catchError((error) {
                    print("Error updating status: $error");
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 198, 163, 6),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(patientid: doc.id),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 164, 8, 24),
                ),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("patient")
                      .doc(doc.id)
                      .delete();
                },
              ),
            ],
          )),
        ]);
      }).toList(),
    ),
  ),
);

      },
    );
  }
}
