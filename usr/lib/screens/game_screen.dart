import 'package:flutter/material.dart';
import '../widgets/ludo_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // محاكاة لرمي الزهر
  int diceValue = 1;
  bool isRolling = false;

  void rollDice() async {
    if (isRolling) return;

    setState(() {
      isRolling = true;
    });

    // محاكاة وقت الرمي
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        diceValue = (DateTime.now().millisecondsSinceEpoch % 6) + 1;
      });
    }

    setState(() {
      isRolling = false;
      // هنا يمكن إضافة كود تشغيل نغمة سودانية عند ظهور رقم معين
      // playSudaneseSound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ليدو اوكسجين'),
        centerTitle: true,
        backgroundColor: const Color(0xFFD21034), // أحمر
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // منطقة معلومات اللاعبين العلوية
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPlayerInfo("اللاعب 1", const Color(0xFFD21034)), // أحمر
                _buildPlayerInfo("اللاعب 2", const Color(0xFF007229)), // أخضر
              ],
            ),
          ),

          // رقعة الليدو
          const Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: LudoBoard(),
              ),
            ),
          ),

          // منطقة معلومات اللاعبين السفلية
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPlayerInfo("اللاعب 4", const Color(0xFF000000)), // أسود
                _buildPlayerInfo("اللاعب 3", Colors.orange), // أصفر (للتنويع)
              ],
            ),
          ),

          // منطقة التحكم والزهر
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "دور: الامين احمد",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: rollDice,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Center(
                      child: isRolling
                          ? const CircularProgressIndicator()
                          : Text(
                              "$diceValue",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.person, color: color),
          const SizedBox(width: 5),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
