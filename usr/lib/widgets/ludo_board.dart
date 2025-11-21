import 'package:flutter/material.dart';

class LudoBoard extends StatelessWidget {
  const LudoBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Top Section (Green Yard, Vertical Track, Red Yard)
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(flex: 6, child: _buildYard(const Color(0xFF007229))), // Green (Sudan)
                Expanded(flex: 3, child: _buildVerticalTrack(false)),
                Expanded(flex: 6, child: _buildYard(const Color(0xFFD21034))), // Red (Sudan)
              ],
            ),
          ),
          
          // Middle Section (Horizontal Track, Center, Horizontal Track)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(flex: 6, child: _buildHorizontalTrack(true)),
                Expanded(flex: 3, child: _buildCenterHome()),
                Expanded(flex: 6, child: _buildHorizontalTrack(false)),
              ],
            ),
          ),
          
          // Bottom Section (Black Yard, Vertical Track, Yellow Yard)
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(flex: 6, child: _buildYard(const Color(0xFF000000))), // Black (Sudan)
                Expanded(flex: 3, child: _buildVerticalTrack(true)),
                Expanded(flex: 6, child: _buildYard(Colors.orange)), // Yellow/Orange (Standard)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYard(Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double pieceSize = constraints.maxWidth / 3;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPiecePlaceholder(color, pieceSize),
                    _buildPiecePlaceholder(color, pieceSize),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPiecePlaceholder(color, pieceSize),
                    _buildPiecePlaceholder(color, pieceSize),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPiecePlaceholder(Color color, double size) {
    return Container(
      width: size * 0.6,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(1, 1))
        ],
      ),
    );
  }

  Widget _buildVerticalTrack(bool isBottom) {
    return Column(
      children: List.generate(6, (index) {
        Color cellColor = Colors.white;
        // تلوين المسار الآمن
        if (isBottom && index == 0) cellColor = Colors.grey[300]!; // Safe spot
        if (isBottom && index > 0) cellColor = Colors.orange.withOpacity(0.3); // Home path
        
        if (!isBottom && index == 5) cellColor = Colors.grey[300]!; // Safe spot
        if (!isBottom && index < 5) cellColor = const Color(0xFFD21034).withOpacity(0.3); // Home path (Red)

        // Simple grid representation
        return Expanded(
          child: Row(
            children: [
              Expanded(child: _buildCell(Colors.white)),
              Expanded(child: _buildCell(cellColor)), // Middle column is usually home path
              Expanded(child: _buildCell(Colors.white)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHorizontalTrack(bool isLeft) {
    return Row(
      children: List.generate(6, (index) {
        Color cellColor = Colors.white;
        // Logic for coloring home paths would go here
        return Expanded(
          child: Column(
            children: [
              Expanded(child: _buildCell(Colors.white)),
              Expanded(child: _buildCell(isLeft ? const Color(0xFF007229).withOpacity(0.3) : Colors.white)), // Green path
              Expanded(child: _buildCell(Colors.white)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCell(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
    );
  }

  Widget _buildCenterHome() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Stack(
        children: [
          // Triangles for the center
          CustomPaint(
            size: Size.infinite,
            painter: CenterHomePainter(),
          ),
          const Center(
            child: Icon(Icons.star, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class CenterHomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);

    // Green Triangle (Left)
    paint.color = const Color(0xFF007229);
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(center.dx, center.dy);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    // Red Triangle (Top)
    paint.color = const Color(0xFFD21034);
    path = Path();
    path.moveTo(0, 0);
    path.lineTo(center.dx, center.dy);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);

    // Yellow/Orange Triangle (Right)
    paint.color = Colors.orange;
    path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(center.dx, center.dy);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);

    // Black Triangle (Bottom)
    paint.color = const Color(0xFF000000);
    path = Path();
    path.moveTo(0, size.height);
    path.lineTo(center.dx, center.dy);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
