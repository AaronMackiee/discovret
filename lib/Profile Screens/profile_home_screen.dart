import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/Compliments/compliments_screen.dart';
import 'package:discovret1_0/Profile%20Screens/FriendsList%20Screen/homeFriends_screen.dart';
import 'package:discovret1_0/Profile Screens/Info_Screens/info_screen.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/photos_screen.dart';
import 'package:discovret1_0/Profile Screens/Wallet_Screens/wallet_screen.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;

class ProfileScreen extends StatefulWidget {
  static const String id = 'ProfileScreen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Firestore _db = Firestore.instance;
  // User loggedInUser;

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // AnimationController controller;

  @override
  void initState() {
    super.initState();

    // urlImage = _fs.downloadProfilePhoto();
    // getCurrentUser();

    // controller = AnimationController(
    //   animationBehavior: AnimationBehavior.normal,
    //   upperBound: 100.0,
    //   duration: Duration(seconds: 3),
    //   vsync: this,
    // );
    // controller.forward();
    // controller.addListener(() {
    //   setState(() {});
    //   print(controller.value);
    // });
  }

  // void setAlert() {
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "Info",
  //     desc:
  //         "According to the Discovret privacy aggreement we can't disclose your exact percentage for the privacy and safety of others.",
  //     buttons: [
  //       DialogButton(
  //         color: kDiscovretGreen,
  //         child: Text(
  //           "Okay",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () => Navigator.pop(context),
  //         width: 120,
  //       )
  //     ],
  //   ).show();
  // }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
    // final DbUserProfileInfo dbUserProfileSearchInfo =
    //     Provider.of<DbUserProfileInfo>(context);
    var size = MediaQuery.of(context).size;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    return DiscovretScaffold(
      index: 2,
      searchIconActive: Icon(Icons.person_search,
          color: kDiscovretYellow, size: kactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kDiscovretBlue, size: kactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kDiscovretGreen, size: kactiveIconSize),
      settingsIconColor: kinactiveIconColor,
      settingsIconSize: kinactiveIconSize,
      qrIconColor: kinactiveIconColor,
      qrIconSize: kinactiveIconSize,
      body: DiscovretBackground(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePhotosScreen.id);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: deviceHeight * .10 + 5,
                    child: CircleAvatar(
                      radius: deviceHeight * .10,
                      backgroundImage:
                          NetworkImage(dbUserProfileInfo.profilePicture!),
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 35,
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '${dbUserProfileInfo.firstName ?? ''} ${dbUserProfileInfo.lastName ?? ''}',
                      style: TextStyle(
                          fontFamily: 'Syne Mono',
                          // fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),

                // SizedBox(height: 1),
                // CircularHeaderBox(
                //   color: null,
                //   textString: 'Personal',
                // ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: GestureDetector(
                    onTap: () {
                      print(userProfileInfo.bio);
                      print(userProfileInfo.religions);
                      print(userProfileInfo.selectedReligions);
                      print(userProfileInfo.listOtherLanguages);
                      // print(userProfileInfo.selectedReligions);
                      // print(userProfileInfo.listWorldReligions);
                      // _db.collection('UserProfileSearchInfo').doc('hello').set({
                      //   'OtherLanguages':
                      //       FieldValue.arrayUnion(['spanish', 'english', 'yapese']),
                      //   'cultures': FieldValue.arrayUnion(['aaron', 'nati'])
                      // }, SetOptions(merge: true));

                      Navigator.pushNamed(context, ComplimentsList.id);
                    },
                    child: Container(
                      height: 39,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kclearContainer,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'Compliments',
                            child: Icon(
                              Icons.thumb_up_off_alt_outlined,
                              size: 30,
                              color: kDiscovretYellow,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Compliments',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: kTextSize15,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: GestureDetector(
                //     onTap: () {
                //       setAlert();
                //     },
                //     child: Container(
                //       height: 40,
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //         color: kclearContainer,
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(
                //             Icons.star_border_rounded,
                //             size: 39,
                //             color: kDiscovretGreen,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 5),
                //             child: Text(
                //               'Rating: Excellent! 95-100% ',
                //               // textAlign: TextAlign.left,
                //               style: TextStyle(
                //                   fontSize: kTextSize15,
                //                   letterSpacing: 0,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.black),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: ProfileInfoCard(
                          onpress: () {
                            setState(() {
                              Navigator.pushNamed(
                                  context, ProfilePhotosScreen.id);
                            });
                          },
                          cardBody: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'Photos',
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: kProfileIconSize,
                                  color: kinactiveIconColor,
                                ),
                              ),
                              Text(
                                'Photos',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: kTextSize15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoCard(
                          onpress: () {
                            setState(() {
                              Navigator.pushNamed(context, DiscovretWallet.id);
                            });
                          },
                          cardBody: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: kProfileIconSize,
                                color: kinactiveIconColor,
                              ),
                              Text(
                                'Wallet',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: kTextSize15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoCard(
                          onpress: () {
                            setState(() {
                              Navigator.pushNamed(context, ProfileInfo.id);
                            });
                          },
                          cardBody: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'Profile Info',
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  size: kProfileIconSize,
                                  color: kinactiveIconColor,
                                ),
                              ),
                              Text(
                                'Info',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: kTextSize15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // CircularHeaderBox(color: null, textString: 'Discovered'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kclearContainer,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.transparent, width: 2.5),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Discovered',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: ProfileInfoCard(
                          onpress: () {
                            setState(() {
                              Navigator.pushNamed(context, FriendsList.id);
                              
                            });
                          },
                          cardBody: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'Friends',
                                child: Icon(
                                  Icons.people_outline,
                                  size: kProfileIconSize,
                                  color: kinactiveIconColor,
                                ),
                              ),
                              Text(
                                'Friends',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: kTextSize15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                '${dbUserProfileInfo.allFriends!.length}',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: kDiscovretGreen),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoCard(
                          onpress: () {},
                          cardBody: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pin_drop_outlined,
                                size: kProfileIconSize,
                                color: kinactiveIconColor,
                              ),
                              Text(
                                'Places',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: kTextSize15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                '${dbUserProfileInfo.allPlaces!.length}',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: kDiscovretGreen),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ProfileInfoCard(
                          onpress: () {},
                          cardBody: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.store_outlined,
                                  size: kProfileIconSize,
                                  color: kinactiveIconColor,
                                ),
                                Container(
                                  height: kTextSize16,
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Businesses',
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: kTextSize15,
                                          // fontSize: kProfileIconTextSize,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${dbUserProfileInfo.allBusinesses!.length}',
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: kDiscovretGreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class FirebaseUser {}

// Column(
//         children: [
//           SizedBox(
//             height: 30,
//           ),
//           child
//         ],
//       )

// child: CircleAvatar(
//           radius: 125,
//           backgroundColor: Colors.white,
//           child: CircleAvatar(
//             onBackgroundImageError: null,
//             radius: 120.0,
//             backgroundImage: AssetImage('assets/Profile.jpg'),
//           ),
//         ),
