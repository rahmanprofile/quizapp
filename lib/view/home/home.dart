import 'package:flutter/material.dart';
import 'package:quizapp/model/question_list.dart';
import 'package:quizapp/view/page/score_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isPressed = false;
  bool answered = false;
  bool btnPressed = false;
  PageController? controller = PageController();
  Color btnColor = Colors.yellow;
  Color isCorrect = Colors.green;
  Color isWrong = Colors.red;
  int score = 0;
  PageController? _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuizApp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: PageView.builder(
          controller: _controller,
          onPageChanged: (page) {
            setState(() {
              isPressed = false;
            });
          },
          itemCount: Questions.questions.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Questions: ${index + 1} / ${Questions.questions.length.toString()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Divider(
                  height: 8.0,
                  thickness: 1.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 15.0),
                Text(
                  Questions.questions[index].question.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30.0),
                for (int i = 0;
                    i < Questions.questions[index].answers!.length;
                    i++)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 18.0),
                    child: MaterialButton(
                      onPressed: isPressed
                          ? () {}
                          : () {
                              setState(() {
                                isPressed = true;
                              });
                              if (Questions.questions[index].answers!.entries
                                  .toList()[i]
                                  .value) {
                                score += 1;
                                print(score);
                              }
                            },
                      color: isPressed
                          ? Questions.questions[index].answers!.entries
                                  .toList()[i]
                                  .value
                              ? isCorrect
                              : isWrong
                          : Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        Questions.questions[index].answers!.keys.toList()[i],
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                const SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_controller!.page?.toInt() ==
                              Questions.questions.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScorePage(score: score),
                              ),
                            );
                          } else {
                            _controller!.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                            );
                          }
                        },
                        child: Container(
                          height: 46,
                          width: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white),
                          child: const Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
