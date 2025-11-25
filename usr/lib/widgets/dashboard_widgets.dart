import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class RiskIndicator extends StatelessWidget {
  final double score;
  final double size;

  const RiskIndicator({super.key, required this.score, this.size = 200});

  Color _getColor(double score) {
    if (score < 40) return Colors.green;
    if (score < 70) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 15,
              backgroundColor: Colors.grey.shade200,
              color: _getColor(score),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                score.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.bold,
                  color: _getColor(score),
                ),
              ),
              Text(
                "Risk Skoru",
                style: TextStyle(
                  fontSize: size * 0.08,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RiskFactorCard extends StatelessWidget {
  final String factor;
  final int index;

  const RiskFactorCard({super.key, required this.factor, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: Text(
            "${index + 1}",
            style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          factor,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              Icon(Icons.more_horiz, color: Colors.grey.shade400),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
