

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://grvlptxnlktalizxzwik.supabase.co',  // Ganti dengan URL proyek Supabase Anda
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdydmxwdHhubGt0YWxpenh6d2lrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM0NTA3MDUsImV4cCI6MjA0OTAyNjcwNX0.8paB6oLZNF1_VlezNwjVqCGazpM23pyD4bRd414TuyA',  // Ganti dengan anon key dari Supabase
    );
  }
}
