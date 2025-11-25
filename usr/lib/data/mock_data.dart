import 'package:flutter/material.dart';

// Veri Modelleri
class RiskScore {
  final double totalScore; // 0-100
  final double pscRisk;
  final double technicalRisk;
  final double environmentalRisk;
  final String predictionLabel; // Düşük, Orta, Yüksek
  final List<String> riskFactors; // XAI Çıktıları

  RiskScore({
    required this.totalScore,
    required this.pscRisk,
    required this.technicalRisk,
    required this.environmentalRisk,
    required this.predictionLabel,
    required this.riskFactors,
  });
}

class SensorData {
  final double engineLoad; // %
  final double fuelConsumption; // MT/day
  final double speed; // Knots
  final String position; // Lat/Long
  final DateTime timestamp;

  SensorData({
    required this.engineLoad,
    required this.fuelConsumption,
    required this.speed,
    required this.position,
    required this.timestamp,
  });
}

class ComplianceAlert {
  final String title;
  final String description;
  final String severity; // Critical, Warning, Info
  final DateTime date;

  ComplianceAlert({
    required this.title,
    required this.description,
    required this.severity,
    required this.date,
  });
}

// Mock Servis
class MockDataService {
  static RiskScore getCurrentRiskScore() {
    return RiskScore(
      totalScore: 78.5,
      pscRisk: 65.0,
      technicalRisk: 82.0,
      environmentalRisk: 45.0,
      predictionLabel: "Yüksek",
      riskFactors: [
        "Yağ basıncı dalgalanması (Teknik)",
        "Mürettebat sertifika geçerlilik süresi < 30 gün (PSC)",
        "NOx emisyonu sınır değerine yakın (Çevresel)",
        "Son 5 liman denetiminde 2 eksiklik (Tarihsel)"
      ],
    );
  }

  static List<SensorData> getRealTimeSensorData() {
    return [
      SensorData(
        engineLoad: 85.4,
        fuelConsumption: 24.5,
        speed: 14.2,
        position: "34.0522° N, 118.2437° W",
        timestamp: DateTime.now(),
      ),
    ];
  }

  static List<ComplianceAlert> getRecentAlerts() {
    return [
      ComplianceAlert(
        title: "Emisyon Sınırı Uyarısı",
        description: "Anlık NOx seviyesi %95 eşiğini aştı. RCM modülü tetiklendi.",
        severity: "Critical",
        date: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      ComplianceAlert(
        title: "Pompa Bakım Tahmini",
        description: "P-PMS: 2 numaralı yakıt pompası için arıza öngörüsü. İş emri oluşturuldu.",
        severity: "Warning",
        date: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }
}
