import 'package:snapd/snapd.dart';
import 'package:software/pages/apps_model.dart';
import 'package:software/pages/snap_section.dart';

class ExploreModel extends AppsModel {
  bool _searchActive;
  bool get searchActive => _searchActive;
  set searchActive(bool value) {
    if (value == _searchActive) return;
    _searchActive = value;
    if (_searchActive == false) {
      searchQuery = '';
    }
    notifyListeners();
  }

  String _searchQuery;
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    if (value == _searchQuery) return;
    _searchQuery = value;
    notifyListeners();
  }

  final Map<SnapSection, bool> filters;

  void setFilter({required List<SnapSection> snapSections}) {
    for (var snapSection in snapSections) {
      filters[snapSection] = !filters[snapSection]!;
    }
    notifyListeners();
  }

  ExploreModel(super.client)
      : _searchActive = false,
        _searchQuery = '',
        filters = {
          SnapSection.art_and_design: false,
          SnapSection.books_and_reference: false,
          SnapSection.development: true,
          SnapSection.devices_and_iot: false,
          SnapSection.education: false,
          SnapSection.entertainment: false,
          SnapSection.featured: false,
          SnapSection.finance: false,
          SnapSection.games: false,
          SnapSection.health_and_fitness: false,
          SnapSection.music_and_audio: false,
          SnapSection.news_and_weather: false,
          SnapSection.personalisation: false,
          SnapSection.photo_and_video: false,
          SnapSection.productivity: false,
          SnapSection.science: false,
          SnapSection.security: false,
          SnapSection.server_and_cloud: false,
          SnapSection.social: false,
          SnapSection.utilities: false,
        };

  Future<List<Snap>> findSnapsBySection({String? section}) async {
    final snaps = await client.find(section: section);
    return snaps;
  }

  Future<List<Snap>> findSnapsByQuery() async {
    return searchQuery.isEmpty ? [] : await client.find(query: _searchQuery);
  }

  Future<Snap> findSnapByName(String name) async {
    final snaps = await client.find(name: name);
    return snaps.first;
  }
}
