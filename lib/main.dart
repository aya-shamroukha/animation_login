import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  await RiveFile.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //SMINumber? numLook;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMIInput<double>? numLook;
  StateMachineController? stateMachineController;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  void moveEye(val) {
    numLook?.change(val.length.toDouble());
  }

  void lookOnTheField() {
    if (isHandsUp != null) {
      isHandsUp!.change(false);
    }
    if (isChecking == null) return;

    isChecking!.change(true);
    numLook?.change(0);
    // moveEye(value);
  }

  void handsUP() {
    if (isChecking != null) {
      isChecking!.change(false);
    }
    if (isHandsUp == null) return;

    isHandsUp!.change(true);
  }

  void logIn() async {
    await isChecking!.change(false);
    await isHandsUp!.change(false);
    if (email.text == "aya@gmail.com" && password.text == "12345") {
      trigSuccess!.change(true);
    } else {
      trigFail!.change(true);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //if (teddyArtboard != null)
            SizedBox(
              width: 500,
              height: 500,
              child: RiveAnimation.asset(
                fit: BoxFit.cover,
                "assets/animated_login_character.riv",
                stateMachines: const ["Login Machine"],
                onInit: (artboard) {
                  stateMachineController = StateMachineController.fromArtboard(
                      artboard, "Login Machine");
                  if (stateMachineController == null) return;

                  artboard.addController(stateMachineController!);
                  numLook = stateMachineController?.findInput("numLook");
                  isChecking = stateMachineController?.findInput("isChecking");
                  isHandsUp = stateMachineController?.findInput("isHandsUp");
                  trigSuccess =
                      stateMachineController?.findInput("trigSuccess");
                  trigFail = stateMachineController?.findInput("trigFail");
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 500,
              height: 250,
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15 * 2,
                    ),
                    TextField(
                      onTap: lookOnTheField,
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 14),
                      cursorColor: const Color(0xffb04863),
                      decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffb04863)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffb04863)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: const Color(0xffb04863),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xffb04863),
                              ))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      onTap: handsUP,
                      onChanged: (value) {},
                      obscureText: true,
                      controller: password,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 14),
                      cursorColor: const Color(0xffb04863),
                      decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffb04863)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffb04863)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: const Color(0xffb04863),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xffb04863),
                              ))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffb04863),
                          ),
                          onPressed: logIn,
                          child: const Text(
                            'LogIn',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
