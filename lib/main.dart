import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patient/about.dart';
import 'package:patient/appointment.dart';
import 'package:patient/completed.dart';
import 'package:patient/pcanceled.dart';
import 'package:patient/update_insert.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyB5j-4ez764sMtWom7MMVX7aYh3-8EHSis',
          appId: '1:1023324841806:android:480dbc28933d8ab8baa01f',
          messagingSenderId: '1023324841806',
          projectId: 'patient-da61e'));

  runApp( const MaterialApp(home: LoginForm(), debugShowCheckedModeBanner: false));
}
  int auth = 0;
  int status = 0;
 var username = TextEditingController();
  var password = TextEditingController();
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
 
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (auth == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      });
    }
  }

  void login() {
    if (username.text == "admin" && password.text == "admin") {
      setState(() {
        auth = 1; 
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      setState(() {
        errorMessage = "Invalid username or password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        color: const Color.fromARGB(171, 27, 176, 106),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 170,
              height: 170,
              image: AssetImage('drlogo.png'),
              fit: BoxFit.contain,
            ),
            TextField(
              controller: username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'UserName',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 191, 197, 9),
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
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Icon(Icons.login_rounded, size: 30, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}





//main page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
     const WaitingList(),
      const EditPage(patientid: 'Patient_id'),
      const appointment(),
      const pcompleted(),
      const pcanceled(),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(171, 27, 176, 106),
        title: const Text('Patient Management',
            style: TextStyle(color: Color.fromARGB(255, 6, 6, 6))),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: 250,
        backgroundColor: Color.fromARGB(171, 27, 176, 106),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(171, 27, 176, 106),
              ),
              child: Text(
                'Patients\nManager',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, size: 30, color: Color.fromARGB(255, 222, 221, 216)),
              title: const Text('Home', style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18)),
              onTap: () {
                setState(() {
                  index = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_sharp, size: 30, color: Color.fromARGB(255, 4, 16, 180)),
              title: const Text('Add Patient', style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18)),
              onTap: () {
                setState(() {
                  index = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.hourglass_bottom_sharp, size: 30, color: Color.fromARGB(255, 236, 108, 3)),
              title: const Text('Appointment', style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18)),
              onTap: () {
                setState(() {
                  index = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.done_all_rounded, size: 30, color: Color.fromARGB(255, 3, 204, 63)),
              title: const Text('Completed', style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18)),
              onTap: () {
                setState(() {
                  index = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.done_all_rounded, size: 30, color: Colors.red),
              title: const Text('Canceled', style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18)),
            onTap: () {
                setState(() {
                  index = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.done_all_rounded, size: 30, color: Color.fromARGB(255, 6, 182, 231)),
              title: const Text('About', style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18)),
              onTap: () {
                setState(() {
                  auth = 0;
                  username.clear();
                  password.clear();
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, size: 30, color: Color.fromARGB(255, 210, 7, 7)),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color.fromARGB(255, 219, 212, 212), fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  auth = 0;
                  username.clear();
                  password.clear();
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: pages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: index,
  backgroundColor: Color.fromARGB(171, 27, 176, 106),
  selectedItemColor: Colors.amber, 
  unselectedItemColor: Colors.white, 
  onTap: (i) {
    if (i < pages.length) { 
      setState(() {
        index = i;
        print("Bottom Nav tapped: $index");
      });
    }
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.blue), 
      label: 'WaitingList',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle_sharp, color: Colors.green), 
      label: 'AddPatient',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info, color: Colors.orange), 
      label: 'Appointment',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.done_all_rounded, color: Colors.purple), 
      label: 'Completed',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.cancel, color: Colors.red), 
      label: 'Canceled',
    ),
  ],
),

    );
  }
}












//WaitingList
class WaitingList extends StatelessWidget {
  const WaitingList({super.key});

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
    color: const Color.fromARGB(171, 27, 176, 106),
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

      //0 tawaw nabwa 1tawaw bwa 2-dwa xra 3-halwshaiawa
      rows: snapshot.data!.docs.where((doc) => doc['pstatus'] == 0).map((doc) {
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
                  Icons.done,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  String patientid = doc.id;
                  FirebaseFirestore.instance
                      .collection('patient')
                      .doc(patientid)
                      .update({
                    "pstatus": 1,
                  }).catchError((error) {
                    // Handle error
                    print("Error updating status: $error");
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.timer,
                  color: Color.fromARGB(255, 236, 108, 3),
                ),
                onPressed: () {
                  String patientid = doc.id;
                  FirebaseFirestore.instance
                      .collection('patient')
                      .doc(patientid)
                      .update({
                    "pstatus": 2,
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
                  status = 1;
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





