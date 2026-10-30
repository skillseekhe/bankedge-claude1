import 'package:flutter/material.dart';
import '../services/ai_engine.dart';

class HomeDashboard extends StatefulWidget {
  final String apiKey;
  const HomeDashboard({Key? key, required this.apiKey}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  late AIEngine _aiEngine;
  int _currentIndex = 0;
  bool _isLoading = false;
  String _generatedOutput = '';

  final _leadNameController = TextEditingController(text: 'Rohan Sharma');
  final _messageController = TextEditingController(text: 'Sir, I finished B.Com this year. What is the fees and placement record for banking training?');
  final _reviewerNameController = TextEditingController(text: 'Priya Verma');
  final _reviewController = TextEditingController(text: 'Best banking training center in Gurugram! The trainers gave real core banking software experience.');
  int _starRating = 5;
  final _adBudgetController = TextEditingController(text: '1500');

  @override
  void initState() {
    super.initState();
    _aiEngine = AIEngine(apiKey: widget.apiKey);
  }

  Future<void> _handleGenerate(Future<String> Function() action) async {
    setState(() {
      _isLoading = true;
      _generatedOutput = '';
    });
    try {
      final res = await action();
      setState(() => _generatedOutput = res);
    } catch (e) {
      setState(() => _generatedOutput = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BankEdge AI Command Center', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF0F3460),
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (idx) => setState(() {
              _currentIndex = idx;
              _generatedOutput = '';
            }),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.chat), label: Text('WhatsApp')),
              NavigationRailDestination(icon: Icon(Icons.star_rate), label: Text('GBP Reviews')),
              NavigationRailDestination(icon: Icon(Icons.camera_alt), label: Text('Instagram')),
              NavigationRailDestination(icon: Icon(Icons.trending_up), label: Text('Local SEO')),
              NavigationRailDestination(icon: Icon(Icons.campaign), label: Text('Meta Ads')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPanelHeader(),
                  const SizedBox(height: 16),
                  _buildActivePanel(),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_generatedOutput.isNotEmpty)
                    _buildResultCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPanelHeader() {
    final titles = [
      'WhatsApp 24/7 Lead Converter',
      'Google Business Profile Review Automation',
      'Instagram DM Auto-Responder',
      'Local GBP SEO & Post Generator',
      'Instagram / Meta Ads Campaign Manager'
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        titles[_currentIndex],
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF16213E)),
      ),
    );
  }

  Widget _buildActivePanel() {
    switch (_currentIndex) {
      case 0:
        return Column(
          children: [
            TextField(controller: _leadNameController, decoration: const InputDecoration(labelText: 'Lead Name', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: _messageController, maxLines: 3, decoration: const InputDecoration(labelText: 'WhatsApp Incoming Message', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460), foregroundColor: Colors.white),
              icon: const Icon(Icons.send_rounded),
              label: const Text('Generate Instant AI Reply'),
              onPressed: () => _handleGenerate(() => _aiEngine.replyWhatsAppLead(_messageController.text, _leadNameController.text)),
            )
          ],
        );
      case 1:
        return Column(
          children: [
            TextField(controller: _reviewerNameController, decoration: const InputDecoration(labelText: 'Reviewer Name', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: _reviewController, maxLines: 3, decoration: const InputDecoration(labelText: 'Google Business Review', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: _starRating,
              decoration: const InputDecoration(labelText: 'Star Rating', border: OutlineInputBorder()),
              items: [5, 4, 3, 2, 1].map((s) => DropdownMenuItem(value: s, child: Text('$s Stars'))).toList(),
              onChanged: (val) => setState(() => _starRating = val ?? 5),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460), foregroundColor: Colors.white),
              icon: const Icon(Icons.verified),
              label: const Text('Generate GBP Official Response'),
              onPressed: () => _handleGenerate(() => _aiEngine.replyGbpReview(_reviewerNameController.text, _starRating, _reviewController.text)),
            )
          ],
        );
      case 2:
        return Column(
          children: [
            TextField(controller: _leadNameController, decoration: const InputDecoration(labelText: 'Instagram Handle (e.g. rohan_01)', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: _messageController, maxLines: 3, decoration: const InputDecoration(labelText: 'Instagram Direct Message', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460), foregroundColor: Colors.white),
              icon: const Icon(Icons.bolt),
              label: const Text('Generate Instagram DM Reply'),
              onPressed: () => _handleGenerate(() => _aiEngine.replyInstagramDm(_leadNameController.text, _messageController.text)),
            )
          ],
        );
      case 3:
        return Column(
          children: [
            const Text('Generate high-ranking local updates with Gurugram keywords for Spanish Court center:'),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460), foregroundColor: Colors.white),
              icon: const Icon(Icons.public),
              label: const Text('Create SEO Post (Banking Diploma Intake)'),
              onPressed: () => _handleGenerate(() => _aiEngine.generateGbpUpdatePost('New Batch Starting for Professional Banking Diploma in Gurugram')),
            )
          ],
        );
      case 4:
      default:
        return Column(
          children: [
            TextField(controller: _adBudgetController, decoration: const InputDecoration(labelText: 'Daily Ad Budget (INR)', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460), foregroundColor: Colors.white),
              icon: const Icon(Icons.ads_click),
              label: const Text('Generate High-Converting Ad Creative & Target Rules'),
              onPressed: () => _handleGenerate(() => _aiEngine.generateMetaAdStrategy('High Intent Graduate Leads for Banking Diploma', double.tryParse(_adBudgetController.text) ?? 1500)),
            )
          ],
        );
    }
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('AI Output & Action Preview', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F3460))),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copy',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard!')));
                  },
                )
              ],
            ),
            const Divider(),
            SelectableText(_generatedOutput, style: const TextStyle(fontSize: 14, height: 1.4)),
          ],
        ),
      ),
    );
  }
}
