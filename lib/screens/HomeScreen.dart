import 'package:flutter/material.dart';
import 'package:naive_bayes/models/QuestionModel.dart';
import 'package:naive_bayes/services/NaiveBayes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final questions = [
    QuestionModel(
      'Ingresos mensuales',
      ['3,000 - 6,000', '7,000 - 10,000', '11,000 - N'],
    ),
    QuestionModel(
      'Gastos mensaules',
      ['1,000 - 6,000', '7,000 - 10,000', '11,000 - N'],
    ),
    QuestionModel(
      '¿Discapacidad?',
      ['Si', 'No'],
    ),
    QuestionModel(
      '¿Trabajas?',
      ['Si', 'No'],
    ),
    QuestionModel(
      'Estado civil',
      ['Soltero', 'Casado'],
    ),
    QuestionModel(
      'No. Hijos',
      ['0 - 1', '2 - N'],
    ),
    QuestionModel(
      'Procedencia indigena',
      ['Si', 'No'],
    ),
  ];
  late List<Map<String, dynamic>> selectedValues;
  String totalSi = '0';
  String totalNo = '0';
  bool result = false;
  @override
  void initState() {
    super.initState();
    selectedValues =
        questions.map((e) => {e.question: e.values.first}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculo de becados',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: size.height * 0.6,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            question.question,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.question_answer_rounded,
                              color: Colors.deepPurple,
                            ),
                          )
                        ],
                      ),
                      DropdownButton(
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.deepPurple,
                          size: 40,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        value: selectedValues[index][question.question],
                        underline: Container(
                          height: 3,
                          color: Colors.deepPurple,
                        ),
                        items: question.values
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (newValue) {
                          this.setState(() => selectedValues[index]
                              [question.question] = newValue!);
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await NaiveBayes(selectedValues).resolveAlgorim();
                setState(() {
                  totalSi = res.totalSi.toString();
                  totalNo = res.totalNo.toString();
                  result = res.response!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Calular',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Total si: ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalSi',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Total no: ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalNo',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              result ? 'Becado' : 'No Becado',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: result ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
