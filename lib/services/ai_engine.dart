import 'package:google_generative_ai/google_generative_ai.dart';

class AIEngine {
  final String apiKey;
  late final GenerativeModel _model;

  static const String systemContext = '''
You are the Official 24/7 AI Lead & Operations Manager for BankEdge Gurugram (located at Spanish Court, Sector 2 / Palam Vihar Extension, Gurugram).
BankEdge is India's leading vocational banking & finance academy, offering industry-endorsed career diplomas, certification programs, retail banking courses, and placement support for graduates and job seekers.

Your core objectives:
1. WhatsApp Inquiries: Politely greet aspirants, understand their qualifications (graduates/undergraduates), present BankEdge banking certification courses, emphasize 100% placement assistance and career mentorship, and encourage them to book a free career consultation at our Palam Vihar center.
2. Google Business Profile Reviews: Respond professionally with gratitude. For 5-star reviews, acknowledge specifics and mention our training excellence in Gurugram. For neutral or critical feedback, respond with utmost courtesy, offering center management contact to address concerns.
3. Instagram DMs & Engagement: Fast, trendy, and encouraging replies to inquiries about course fees, eligibility, batch timings, and placement tie-ups. Drive them to submit their phone number or visit the campus.
4. Local GBP SEO Updates: Generate high-ranking weekly post updates with local keywords like "Banking courses in Gurugram", "Bank job training Palam Vihar", "Placement assistance banking Dwarka/Gurugram".
5. Instagram Ad Campaign Strategist: Analyze target demographics (graduates 20-27 in Gurugram & Dwarka), write high-converting ad copy, select hook angles, and provide budget pacing tips.
''';

  AIEngine({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(systemContext),
    );
  }

  Future<String> replyWhatsAppLead(String studentMessage, String studentName) async {
    final prompt = 'Lead Name: $studentName\nInquiry Message: "$studentMessage"\nTask: Generate an authentic, persuasive, and warm WhatsApp message replying to this student lead.';
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Thank you for reaching out to BankEdge Gurugram!';
  }

  Future<String> replyGbpReview(String reviewerName, int starRating, String reviewText) async {
    final prompt = 'Reviewer: $reviewerName\nRating: $starRating Stars\nReview Text: "$reviewText"\nTask: Generate an official response to this Google Business Profile review adhering to local SEO and customer trust standards.';
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Thank you for your valuable feedback to BankEdge Gurugram.';
  }

  Future<String> replyInstagramDm(String handle, String dmText) async {
    final prompt = 'User Handle: @$handle\nDM Message: "$dmText"\nTask: Generate an engaging, polite Instagram DM response with clear CTA to schedule a counseling call.';
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Thanks for connecting with BankEdge Gurugram! Drop your number and our advisor will reach out.';
  }

  Future<String> generateGbpUpdatePost(String topicFocus) async {
    final prompt = 'Topic: $topicFocus\nTask: Create a Google Business Profile Update Post (120-180 words) optimized for Gurugram/Palam Vihar local search, with a compelling Call to Action (Call Now / Visit Office).';
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Upgrade your banking career with BankEdge Gurugram.';
  }

  Future<String> generateMetaAdStrategy(String campaignGoal, double dailyBudgetInr) async {
    final prompt = 'Goal: $campaignGoal\nDaily Budget: ₹$dailyBudgetInr\nAudience: Fresh college graduates & job seekers in Gurugram, Dwarka & South West Delhi.\nTask: Provide 2 high-converting ad copy options (Primary Text, Headline, Description, Call-to-Action) plus targeted audience interests for Meta Ads Manager.';
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Campaign strategy generated successfully.';
  }
}
