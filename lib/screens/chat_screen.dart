import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore=FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRout = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController=TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? message;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages()async{
  //   final messages=await _fireStore.collection('messages ').get();
  //   for(var i in messages.docs){
  //     print(i.data());
  //   }
  // }
  void getMessageStream()async{
    await for(var snapshot in _fireStore.collection('messages').snapshots()){
      for(var i in snapshot.docs){
        print(i.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset(
              'assets/images/sent.png',
              height: 25.0,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('MessageMe'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                // ignore: prefer_const_constructors
                border: Border(
                  // ignore: prefer_const_constructors
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child:
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Expanded(
                        child: TextField(
                       controller: messageTextController,
                       onChanged: (value) {
                         message=value;
                    },
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      // ignore: prefer_const_constructors
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      hintText: 'Write your message here...',
                      border: InputBorder.none,
                         ),
                       ),
                     ),
                    TextButton(
                       onPressed: () {
                         messageTextController.clear();
                     _fireStore.collection('messages').add({
                       'text':message,
                       'sender':signedInUser.email,
                       'time':FieldValue.serverTimestamp(),
                     });
                  },
                  // ignore: prefer_const_constructors
                      child: Text(
                    'send',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 10, 51, 95)),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('messages').orderBy('time').snapshots(),
        builder:(context, snapshot) {
          List<MessageLine> messageWidgets=[];
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages=snapshot.data!.docs.reversed;
          for(var message in messages){
            final messageText=message.get('text');
            final messageSender=message.get('sender');
            final currentUser=signedInUser.email;
            final messageWidget=MessageLine(
              sender: messageSender,
              text: messageText,
              isMe: currentUser==messageSender,
            );
            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageWidgets,
            ),
          );
        }

    );
  }
}


 class MessageLine extends StatelessWidget {
   const MessageLine({this.text,this.sender,required this.isMe,Key? key}) : super(key: key);
    final String? sender;
    final String? text;
    final bool isMe;
   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(10.0),
       child: Column(
         crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
         children: [
           Text(
               '$sender',
            style: TextStyle(
              fontSize: 12,
              color: Colors.yellow[900],
            ),
           ),
           Material(
             borderRadius:isMe? const BorderRadius.only(
               topLeft: Radius.circular(30),
               bottomLeft: Radius.circular(30),
               bottomRight: Radius.circular(30),
             ):const BorderRadius.only(
               topRight: Radius.circular(30),
               bottomLeft: Radius.circular(30),
               bottomRight: Radius.circular(30),
             ),
             color: isMe?Colors.blue[800]:Color(0xffbfbfbf) ,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               child: Text(
                   '$text',
                 style: TextStyle(
                     fontSize: 15,
                   color: isMe ? Colors.white:Colors.black45,
                 ),
               ),
             ),
           ),
         ],
       ),
     );
   }
 }
