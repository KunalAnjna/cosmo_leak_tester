// widgets/cosmo_logo.dart
// CosmoAppBarLogo — shows assets/images/cosmo_logo.png
// Falls back to painted version if PNG not placed yet.
// No ClipRRect — no white box artefact.

import 'dart:math';
import 'package:flutter/material.dart';

class CosmoAppBarLogo extends StatelessWidget {
  final double size;
  const CosmoAppBarLogo({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  size,
      height: size,
      child: Image.asset(
        'assets/images/cosmo_logo.jpeg',
        width:  size,
        height: size,
        fit:    BoxFit.contain,
        errorBuilder: (_, __, ___) => CosmoLogoPainted(size: size),
      ),
    );
  }
}

class CosmoLogoPainted extends StatelessWidget {
  final double size;
  const CosmoLogoPainted({super.key, this.size = 48});
  @override
  Widget build(BuildContext context) =>
      SizedBox(width: size, height: size, child: CustomPaint(painter: _P()));
}

class _P extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final cx = s.width / 2, cy = s.height / 2;
    final r  = min(s.width, s.height) / 2;

    canvas.drawCircle(Offset(cx, cy), r * 0.97,
        Paint()..color = const Color(0xFF0D47A1));

    canvas.drawCircle(Offset(cx, cy), r * 0.87,
        Paint()
          ..color       = const Color(0xFF1976D2)
          ..style       = PaintingStyle.stroke
          ..strokeWidth = r * 0.12);

    final tick = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = r * 0.045
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 8; i++) {
      final a = (i * 45 - 90) * pi / 180;
      canvas.drawLine(Offset(cx + r * 0.72 * cos(a), cy + r * 0.72 * sin(a)),
                      Offset(cx + r * 0.87 * cos(a), cy + r * 0.87 * sin(a)), tick);
    }

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.50),
      -pi * 0.72, pi * 1.64, false,
      Paint()
        ..color = Colors.white
        ..strokeWidth = r * 0.22
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round);

    final ea = -pi * 0.72 + pi * 1.64;
    final dx = cx + r * 0.50 * cos(ea), dy = cy + r * 0.50 * sin(ea);
    canvas.drawCircle(Offset(dx, dy), r * 0.18,
        Paint()..color = const Color(0xFF29B6F6).withOpacity(0.35));
    canvas.drawCircle(Offset(dx, dy), r * 0.11,
        Paint()..color = const Color(0xFF64B5F6));
    canvas.drawCircle(Offset(cx, cy), r * 0.09,
        Paint()..color = Colors.white.withOpacity(0.75));
  }
  @override bool shouldRepaint(_P _) => false;
}
