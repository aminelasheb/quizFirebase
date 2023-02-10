import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizfirebase/Providers/questions.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  bool _isLoading = false;

  Future<void> getQuiz() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<questions>(context, listen: false).getQuests();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getQuiz();
    super.initState();
  }

  int index = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading
          ? CircularProgressIndicator()
          : Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: ListView(children: [
                SizedBox(
                  height: sizee.height * 0.1,
                ),
                Container(
                  child: Text(
                    'Score ${score}/${Provider.of<questions>(context, listen: false).quests.length} :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sizee.width * 0.08),
                  ),
                ),
                Container(
                  child: Text(
                    'Question ${index + 1} :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sizee.width * 0.08),
                  ),
                ),
                SizedBox(
                  height: sizee.height * 0.05,
                ),
                Container(
                  child: Text(
                    Provider.of<questions>(context, listen: false)
                        .quests[index]
                        .text!,
                    style: TextStyle(fontSize: sizee.width * 0.07),
                  ),
                ),
                SizedBox(
                  height: sizee.height * 0.05,
                ),
                Container(
                  height: sizee.height * 0.65,
                  child: ListView.builder(
                    itemCount: Provider.of<questions>(context, listen: false)
                        .quests[index]
                        .replies!
                        .length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          if (Provider.of<questions>(context, listen: false)
                                  .quests[index]
                                  .replies![i] ==
                              Provider.of<questions>(context, listen: false)
                                  .quests[index]
                                  .reply) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Réponse vrai'),
                            ));
                            setState(() {
                              score = score + 1;
                              if (index <
                                  Provider.of<questions>(context, listen: false)
                                          .quests
                                          .length -
                                      1) {
                                index = index + 1;
                              } else {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('jeu fini'),
                                          content: Text(
                                              'votre score est $score / ${Provider.of<questions>(context, listen: false).quests.length}'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const quiz()));
                                              },
                                              child: const Text('Rejouer'),
                                            ),
                                          ],
                                        ));
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Réponse faux'),
                            ));
                            setState(() {
                              if (index <
                                  Provider.of<questions>(context, listen: false)
                                          .quests
                                          .length -
                                      1) {
                                index = index + 1;
                              } else {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('jeu fini'),
                                          content: Text(
                                              'votre score est $score / ${Provider.of<questions>(context, listen: false).quests.length}'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const quiz()));
                                              },
                                              child: const Text('Rejouer'),
                                            ),
                                          ],
                                        ));
                              }
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: sizee.height * 0.05),
                          width: sizee.width * 0.7,
                          height: sizee.height * 0.07,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                            Provider.of<questions>(context, listen: false)
                                .quests[index]
                                .replies![i],
                            style: TextStyle(fontSize: sizee.width * 0.05),
                          )),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
    );
  }
}
