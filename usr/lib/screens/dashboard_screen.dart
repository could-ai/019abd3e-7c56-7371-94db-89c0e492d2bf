import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late RiskScore riskData;
  late List<SensorData> sensorData;
  late List<ComplianceAlert> alerts;

  @override
  void initState() {
    super.initState();
    // Verileri yükle
    riskData = MockDataService.getCurrentRiskScore();
    sensorData = MockDataService.getRealTimeSensorData();
    alerts = MockDataService.getRecentAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.anchor, color: Color(0xFF0A2342)),
            const SizedBox(width: 8),
            const Text(
              'NaviSpect AI',
              style: TextStyle(
                color: Color(0xFF0A2342),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF0A2342),
            child: Text('C', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Bilgi Kartı
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0A2342),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pilot Gemi: MV OCEAN STAR",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "IMO: 9123456 | Konum: ${sensorData[0].position}",
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: riskData.predictionLabel == "Yüksek" ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Risk: ${riskData.predictionLabel}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Ana Risk Göstergesi ve Detaylar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "NaviSpect Risk Skoru",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0A2342)),
                        ),
                        const SizedBox(height: 20),
                        RiskIndicator(score: riskData.totalScore),
                        const SizedBox(height: 20),
                        const Text(
                          "Gemi Tutulma Olasılığı (30 Gün)",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      _buildRiskComponentBar("PSC Riski", riskData.pscRisk, Colors.orange),
                      const SizedBox(height: 12),
                      _buildRiskComponentBar("Teknik Risk", riskData.technicalRisk, Colors.red),
                      const SizedBox(height: 12),
                      _buildRiskComponentBar("Çevresel Risk", riskData.environmentalRisk, Colors.green),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              "Gerçek Zamanlı Veriler (Real-Time)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A2342)),
            ),
            const SizedBox(height: 16),

            // Sensör Verileri Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: [
                MetricCard(
                  title: "Makine Performansı",
                  value: "${sensorData[0].engineLoad}%",
                  icon: Icons.speed,
                  color: Colors.blue,
                ),
                MetricCard(
                  title: "Yakıt Tüketimi",
                  value: "${sensorData[0].fuelConsumption} MT",
                  icon: Icons.local_gas_station,
                  color: Colors.orange,
                ),
                MetricCard(
                  title: "Seyir Hızı",
                  value: "${sensorData[0].speed} kn",
                  icon: Icons.directions_boat,
                  color: Colors.teal,
                ),
                MetricCard(
                  title: "Son Veri",
                  value: "Şimdi",
                  icon: Icons.access_time,
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              "XAI: Risk Faktörleri & Açıklamalar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A2342)),
            ),
            const SizedBox(height: 8),
            const Text(
              "Yüksek risk skorunu etkileyen temel faktörler:",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // XAI Listesi
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: riskData.riskFactors.length,
              itemBuilder: (context, index) {
                return RiskFactorCard(
                  factor: riskData.riskFactors[index],
                  index: index,
                );
              },
            ),

            const SizedBox(height: 24),
            const Text(
              "RCM & P-PMS Uyarıları",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A2342)),
            ),
            const SizedBox(height: 16),

            // Uyarılar Listesi
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return Card(
                  elevation: 0,
                  color: alert.severity == "Critical" ? Colors.red.shade50 : Colors.orange.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: alert.severity == "Critical" ? Colors.red.shade200 : Colors.orange.shade200,
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              alert.severity == "Critical" ? Icons.warning : Icons.build,
                              color: alert.severity == "Critical" ? Colors.red : Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              alert.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: alert.severity == "Critical" ? Colors.red.shade900 : Colors.orange.shade900,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${alert.date.hour}:${alert.date.minute}",
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          alert.description,
                          style: const TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskComponentBar(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text("${value.toInt()}/100", style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey.shade100,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
