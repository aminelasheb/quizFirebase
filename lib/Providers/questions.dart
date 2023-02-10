import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class question {
  String? id;
  String? text;
  String? reply;
  List<dynamic>? replies;

  question({
    required this.id,
    required this.text,
    required this.reply,
    required this.replies,
    // required this.menu,
  });
}

class questions extends ChangeNotifier {
  List<question> quests = [];

  Future<void> getQuests() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection("questions").get();

      final docs = data.docs;

      Map<String, dynamic> holder;
      quests.clear();
      for (var element in docs) {
        var id = element.id;
        holder = element.data();
        print(holder.toString());
        quests.add(question(
            id: id,
            text: holder['text'],
            reply: holder['reply'],
            replies: holder['replies']));
      }
    } catch (e) {
      rethrow;
    }
  }
}
