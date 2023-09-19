import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatmessage extends StatelessWidget {
  const Chatmessage({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticateuser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("created_at", descending: true)
            .snapshots(),
        builder: (ctx, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshots.hasError) {
            return const Center(
              child: Text("nimadir noto'g'ri bajarildi"),
            );
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(child: Text("Hozircha xabarlar mavjud emas"));
          }

          final loadmessage = snapshots.data!.docs;
          return ListView.builder(
              padding: const EdgeInsets.only(left: 13, right: 13, bottom: 40),
              reverse: true,
              itemCount: loadmessage.length,
              itemBuilder: (ctx, index) {
                final chatmessages = loadmessage[index].data();
                final nextchatmessage = index + 1 < loadmessage.length
                    ? loadmessage[index + 1].data()
                    : null;

                final currentmessageUserId = chatmessages["user"];
                final nextmessageUsernameUserId =
                    nextchatmessage != null ? nextchatmessage["user"] : null;
                final nextUserIsSame =
                    nextmessageUsernameUserId == currentmessageUserId;

                if (nextUserIsSame) {
                  return MessageBubble.next(
                      message: chatmessages["text"],
                      isMe: authenticateuser.uid == currentmessageUserId);
                } else {
                  return MessageBubble.first(
                      userImage: chatmessages["userimage"],
                      username: chatmessages["username"],
                      message: chatmessages["text"],
                      isMe: authenticateuser.uid == currentmessageUserId);
                }
              });
        });
  }
}
