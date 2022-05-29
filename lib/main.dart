import 'package:flutter/material.dart';
import 'buttons.dart'; 
import 'package:math_expressions/math_expressions.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
     var userInput = '';
     var answer = '';

// Array of button
final List<String> buttons = [
	'C','+/-','%','DEL',
	'7','8','9','/',
  '4','5','6','x',
	'1','2','3','-',
	'0','.','=','+',
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: new AppBar(
		title: new Text("BENO-CALCO"),
	), //AppBar


       backgroundColor: Colors.grey[200],
       body: Column(
		children: <Widget>[
		Expanded(
			child: Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Container(
					padding: EdgeInsets.all(20),
					alignment: Alignment.centerLeft,
					child: Text(
						userInput,
						style: TextStyle(fontSize: 44, color: Colors.black),
					),
					),
					Container(
					padding: EdgeInsets.all(15),
					alignment: Alignment.centerRight,
					child: Text(
						answer,
						style: TextStyle(
							fontSize: 50,
							color: Colors.black,
							fontWeight: FontWeight.bold),
					),
					)
				]),
			),
		),
		Expanded(
			flex: 3,

                  //test decoration
                  child: Container(
          decoration: BoxDecoration(
            boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8), 
            spreadRadius: 5,
            blurRadius: 10,
           offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),



      child: ClipRRect(
         borderRadius: BorderRadius.circular(25),




         
        /* boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent[200],
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ], */


			  child: Container(
			child: GridView.builder(
				itemCount: buttons.length,
				gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
					crossAxisCount: 4),
				itemBuilder: (BuildContext context, int index) {
					
          // Clear Button
					if (index == 0) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput = '';
							answer = '0';
						});
						},
						buttonText: buttons[index],
						color: Colors.red,
						textColor: Colors.white,
					);
					}

					// +/- button
					else if (index == 1) {
					return MyButton(
            buttontapped: () {
						setState(() {

            Parser p = Parser();
            userInput = '-'+userInput;

						});
            },

						buttonText: buttons[index],
						color: Colors.blue[50],
						textColor: Colors.black,
					);
					}

					// % Button
					else if (index == 2) {
					return MyButton(
						buttontapped: () {
						setState(() {

            Parser p = Parser();
            Expression exp = p.parse(userInput+'/100');
            ContextModel cm = ContextModel();
            double eval = exp.evaluate(EvaluationType.REAL, cm);
            userInput = eval.toString();

						});
						},
						buttonText: buttons[index],
						color: Colors.blue[50],
						textColor: Colors.black,
					);
					}
					// Delete Button
					else if (index == 3) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput =
								userInput.substring(0, userInput.length - 1);
						});
						},
						buttonText: buttons[index],
						color: Colors.red[200],
						textColor: Colors.white,
					);
					}
					// Equal_to Button
					else if (index == 18) {
					return MyButton(
						buttontapped: () {
						setState(() {
							equalPressed();
						});
						},
						buttonText: buttons[index],
						color: Colors.green[700],
						textColor: Colors.white,
					);
					}

					// other buttons
					else {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput += buttons[index];
						});
						},
						buttonText: buttons[index],
						color: isOperator(buttons[index])
							? Colors.deepPurple
							: Colors.white,
						textColor: isOperator(buttons[index])
							? Colors.white
							: Colors.black,
					);
					}
				}), // GridView.builder
			),
      ),
		  ),
    ),
		],
	),
	);

  }
  bool isOperator(String x) {
	if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
	return true;
	}
	return false;
}

// function to calculate the input operation
void equalPressed() {
	String finaluserinput = userInput;
	finaluserinput = userInput.replaceAll('x', '*');

	Parser p = Parser();
	Expression exp = p.parse(finaluserinput);
	ContextModel cm = ContextModel();
	double eval = exp.evaluate(EvaluationType.REAL, cm);
	answer = eval.toString();
}
} 