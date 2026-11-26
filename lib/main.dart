
import 'package:flutter/material.dart';

void main() {
  runApp(const SmartAdsApp());
}

class SmartAdsApp extends StatelessWidget {
  const SmartAdsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Ads AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF172B4D),
          primary: const Color(0xFF172B4D),
          secondary: const Color(0xFFD4AF37),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final productController = TextEditingController();
  final priceController = TextEditingController();
  final budgetController = TextEditingController(text: '10');

  String region = 'كل مناطق إسرائيل';
  String goal = 'رسائل واتساب';
  String language = 'العبرية';

  @override
  void dispose() {
    productController.dispose();
    priceController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void createCampaign() {
    if (productController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال اسم المنتج والسعر'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم تجهيز الحملة'),
        content: Text(
          'المنتج: ${productController.text}\n'
          'السعر: ${priceController.text} شيكل\n'
          'المنطقة: $region\n'
          'الهدف: $goal\n'
          'اللغة: $language\n'
          'الميزانية اليومية المقترحة: ${budgetController.text} شيكل\n\n'
          'هذه معاينة فقط. لم يتم نشر إعلان أو خصم أي مبلغ.',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسنًا'),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172B4D),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget dropdownField(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF172B4D),
          foregroundColor: Colors.white,
          title: const Text(
            'Smart Ads AI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF172B4D),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.campaign,
                      color: Color(0xFFD4AF37),
                      size: 45,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'منصة إعلانية ذكية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'جهّز حملتك الإعلانية واستهدف عملاءك في إسرائيل',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              sectionTitle('تفاصيل المنتج', Icons.shopping_bag),
              inputField(
                'اسم المنتج',
                productController,
                hint: 'مثال: رافعة أثاث مع عجلات',
              ),
              inputField(
                'السعر بالشيكل',
                priceController,
                hint: 'مثال: 150',
                keyboardType: TextInputType.number,
              ),

              sectionTitle('إعدادات الإعلان', Icons.settings),
              dropdownField(
                'المنطقة المستهدفة',
                region,
                [
                  'كل مناطق إسرائيل',
                  'القدس',
                  'حيفا',
                  'تل أبيب',
                  'الناصرة',
                  'الخليل',
                  'مناطق أخرى',
                ],
                (value) => setState(() => region = value!),
              ),
              dropdownField(
                'هدف الحملة',
                goal,
                [
                  'رسائل واتساب',
                  'زيارات الموقع',
                  'التعريف بالمنتج',
                ],
                (value) => setState(() => goal = value!),
              ),
              dropdownField(
                'لغة الإعلان',
                language,
                ['العبرية', 'العربية', 'العبرية والعربية'],
                (value) => setState(() => language = value!),
              ),

              sectionTitle('الميزانية المقترحة', Icons.account_balance_wallet),
              inputField(
                'الميزانية اليومية بالشيكل',
                budgetController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: createCampaign,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('تجهيز الحملة الإعلانية'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF172B4D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 18),
              const Text(
                'ملاحظة: هذه نسخة تجريبية لواجهة التطبيق. '
                'لا تنشر إعلانات حقيقية ولا تخصم أموالًا حاليًا.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
