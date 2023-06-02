import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/Screens/EditProfile.dart';
import '../models/User.dart';
import 'ContactUs.dart';
import 'NearestBuilding.dart';
import 'SetupProfile3.dart';
import 'profile.dart';
import 'welcome_page.dart';
import 'Guidance.dart';
import 'home.dart';
import 'travelScan.dart';
import '../Constants/Dimensions.dart';
import '../Constants/DocumentButton.dart';
import '../Constants/ServiceNeeds.dart';
import 'package:gradproj/Constants/designConstants.dart';

class ServiceNeeds extends StatefulWidget {
  final String uid;
  final User user;
  const ServiceNeeds({Key? key, required this.uid, required this.user})
      : super(key: key);

  @override
  State<ServiceNeeds> createState() => _ServiceNeedsState();
}

class _ServiceNeedsState extends State<ServiceNeeds> {
  Future<Uint8List> getImageData() async {
    //await widget.uploadInfo();

    String imagePath = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get('imagePath') as String;
    });

    Uint8List? imageData =
        await FirebaseStorage.instance.ref(imagePath).getData();

    if (imageData != null) {
      return imageData;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(),
      appBar: new AppBar(
        backgroundColor: Color(0xFF00CDD0),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
            size: MyDim.fontSizebetween,
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image(
                image: ResizeImage(AssetImage('Assets/images/blackLogo.png'),
                    width: 1000, height: 800),
              ),
              // child: Text('Monkez',style: TextStyle(fontSize: MyDim.fontSizebetween, fontWeight: FontWeight.w700),),
              decoration: BoxDecoration(
                // image: 'Assets/images/logoblack.png',
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text(
                'Family Community',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => userprofile(
                              user: widget.user,
                              uid: widget.uid,
                              getImageData: getImageData,
                            )));
              },
            ),
            ListTile(
              title: Text(
                'Travel Guide',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TravelGuide(
                              uid: widget.uid,
                              user: widget.user,
                            )));
              },
            ),
            ListTile(
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContactUS(uid: widget.uid, user: widget.user)));
              },
            ),
            ListTile(
              title: Text(
                'Nearest Building',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NearestBuilding(
                            user: widget.user, uid: widget.uid)));
              },
            ),
            ListTile(
              title: Text(
                'Guidance',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Guidance(user: widget.user, uid: widget.uid)));
              },
            ),
            ListTile(
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(uid: widget.uid)));
              },
            ),
            ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async => false,
                        child: AlertDialog(
                          title: Text('Logout'),
                          content: Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF00CDD0), width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: ResizeImage(
                            AssetImage('Assets/images/img_13.png'),
                            width: 50,
                            height: 70),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Service Needs',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Choose the service that you need",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.2,
              endIndent: MyDim.paddingUnit * 3,
              indent: MyDim.paddingUnit * 3,
            ),
            SizedBox(
              height: MyDim.SizedBoxtiny * 1,
            ),
            DocumentButton(
                image: 'Assets/images/IDNeeds.png',
                label: 'National ID',
                clickdoc: openDialogID),
            SizedBox(
              height: MyDim.SizedBoxtiny * 1,
            ),
            DocumentButton(
                image: 'Assets/images/driver.png',
                label: 'Driver’s license',
                clickdoc: openDialogDriver),
            SizedBox(
              height: MyDim.SizedBoxtiny * 1,
            ),
            DocumentButton(
                image: 'Assets/images/birthNeeds.png',
                label: 'Birth Certificate',
                clickdoc: openDialogBirth),
            SizedBox(
              height: MyDim.SizedBoxtiny * 1,
            ),
            DocumentButton(
                image: 'Assets/images/pass.png',
                label: 'Passport',
                clickdoc: openDialogPassport),
            SizedBox(
              height: MyDim.SizedBoxsmall,
            ),
          ],
        ),
      ),
    );
  }

  Future openDialogID() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: NationalID()));

  Future openDialogDriver() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: DriverLisence()));
  Future openDialogBirth() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: BirthCertificate()));
  Future openDialogPassport() => showDialog(
      context: context,
      builder: (context) =>
          InstructionsPopUp(onpressed: Done, steps: Passport()));

  void Done() {
    Navigator.of(context).pop();
  }
}
