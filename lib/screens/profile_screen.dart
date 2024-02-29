import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message_app/api/apis.dart';
import 'package:message_app/helper/dialogs.dart';
import 'package:message_app/main.dart';
import 'package:message_app/models/chat_user.dart';
import 'package:message_app/screens/auth/login_screen.dart';

//profile screen khi user login vào với tk google
class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //app bar
        appBar: AppBar(title: const Text('Profile')),
        //floating button to add new user
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              Dialogs.showProgressbar(context);
              await APIs.auth.signOut().then(
                    (value) async => {
                      await GoogleSignIn().signOut().then(
                            (value) => {
                              Navigator.pop(context),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()),
                              )
                            },
                          ),
                    },
                  );
            },
            icon: const Icon(Icons.logout),
            label: Text('Logout'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              //tạo khoảng trống cho các phía của pic profile user
              SizedBox(width: mq.width, height: mq.height * .03),
              //user profile picture
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.height * .15,
                      height: mq.height * .15,
                      fit: BoxFit.fill,
                      imageUrl: widget.user.image,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0.5,
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {},
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              //spacing
              SizedBox(height: mq.height * .03),

              Text(widget.user.email,
                  style: const TextStyle(color: Colors.black54, fontSize: 16)),
              //spacing
              SizedBox(height: mq.height * .05),

              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'eg. Happy Signh',
                    label: const Text('Name')),
              ),
              //spacing
              SizedBox(height: mq.height * .02),

              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'eg. Happy Signh',
                    label: const Text('About')),
              ),

              //spacing
              SizedBox(height: mq.height * .02),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size(mq.width * .4, mq.height * .055),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 28,
                ),
                label: const Text(
                  'UPDATE',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
