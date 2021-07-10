import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.pressStart2pTextTheme(
        Theme.of(context).textTheme,
      )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  Color colorButtonGo = FightClubColors.greyButton;
  int yourLives = maxLives;
  int enemysLives = maxLives;
  String centerText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemyLivesCount: enemysLives,
            ),
            const SizedBox(height: 30),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ColoredBox(
                  color: FightClubColors.darkPurple,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        centerText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: FightClubColors.darkGreyText),
                      ),
                    ),
                  )),
            )),
            const SizedBox(height: 30),
            ControlsWidget(
                defendingBodyPart: defendingBodyPart,
                selectDefendingBodyPart: _selectDefendingBodyPart,
                attackingBodyPart: attackingBodyPart,
                selectAttackingBodyPart: _selectAttackingBodyPart),
            SizedBox(height: 14),
            GoButton(
              onTap: _onGoButtonClicked,
              color: colorButtonGo,
              text:
                  yourLives == 0 || enemysLives == 0 ? "Start new game" : "Go",
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
      if (attackingBodyPart != null || yourLives == 0 || enemysLives == 0) {
        colorButtonGo = FightClubColors.blackButton;
      }
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
      if (defendingBodyPart != null || yourLives == 0 || enemysLives == 0) {
        colorButtonGo = FightClubColors.blackButton;
      }
    });
  }

  void _setCenterText() {
    if (yourLives == 0 && enemysLives == 0) {
      centerText = "Draw";
    } else if (yourLives > 0 && enemysLives == 0) {
      centerText = "You won";
    } else if (yourLives == 0 && enemysLives > 0) {
      centerText = "You lost";
    } else {
      String first = attackingBodyPart == whatEnemyDefends
          ? "Your attack was blocked."
          : "You hit enemy's ${attackingBodyPart!.name.toLowerCase()}.";
      String second = defendingBodyPart == whatEnemyAttacks
          ? "Enemy's attack was blocked."
          : "Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}.";
      centerText = "$first\n$second";
    }
  }

  void _onGoButtonClicked() {
    if (yourLives == 0 || enemysLives == 0) {
      setState(() {
        yourLives = maxLives;
        enemysLives = maxLives;
        colorButtonGo = FightClubColors.greyButton;
      });
    } else if (attackingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemysLives--;
        }

        if (youLoseLife) {
          yourLives--;
        }

        _setCenterText();

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        defendingBodyPart = null;
        attackingBodyPart = null;

        colorButtonGo = yourLives == 0 || enemysLives == 0
            ? FightClubColors.blackButton
            : FightClubColors.greyButton;
      });
    }
  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 40,
        child: GestureDetector(
          onTap: onTap,
          child: ColoredBox(
            color: color,
            child: Center(
                child: Text(
              text.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: FightClubColors.whiteText),
            )),
          ),
        ),
      ),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
    Key? key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  }) : super(key: key);

  //const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Text("Defend".toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(
                height: 13,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              )
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Text("Attack".toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(
                height: 13,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              )
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemyLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ColoredBox(color: Colors.white)),
              Expanded(child: ColoredBox(color: FightClubColors.darkPurple)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: yourLivesCount,
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text("You",
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                  const SizedBox(height: 12),
                  Image.asset(
                    FightClubImages.youAvatar,
                    height: 92,
                    width: 92,
                  ),
                ],
              ),
              ColoredBox(
                color: Colors.green,
                child: SizedBox(
                  height: 44,
                  width: 44,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text("Enemy",
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                  const SizedBox(height: 12),
                  Image.asset(
                    FightClubImages.enemyAvatar,
                    height: 92,
                    width: 92,
                  ),
                ],
              ),
              LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: enemyLivesCount,
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// Виджет с жизнями
class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        // работает только во время дебага
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(overallLivesCount * 2 - 1, (index) {
          if (index % 2 == 0) {
            if (index < currentLivesCount) {
              return Center(
                  child: Image.asset(
                FightClubIcons.heartFull,
                width: 18,
                height: 18,
              ));
            } else {
              return Center(
                  child: Image.asset(
                FightClubIcons.heartEmpty,
                width: 18,
                height: 18,
              ));
            }
          } else {
            return Center(
              child: SizedBox(
                height: 4,
                width: 4,
              ),
            );
          }
        }));
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
              child: Text(bodyPart.name.toUpperCase(),
                  style: TextStyle(
                      color: selected
                          ? FightClubColors.whiteText
                          : FightClubColors.darkGreyText))),
        ),
      ),
    );
  }
}
