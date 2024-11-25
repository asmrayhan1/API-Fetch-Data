class Resources{
  late int id;
  late String description;
  late String url;
  late List<String> types;
  late List<String> topic;
  late List<String> level;
  
  // Constructor 
  Resources({required this.id, required this.description, required this.url, required this.types, required this.topic, required this.level});
  
  factory Resources.fromJson(Map<String, dynamic> json){
    return Resources(
        id: json['id'] as int,
        description: json['description'] as String,
        url: json['url']! as String, // Handle nullable url
        types: List<String>.from(json['types'] as List),
        topic: List<String>.from(json['topics'] as List),
        level: List<String>.from(json['levels'] as List),
    );
  }
}
