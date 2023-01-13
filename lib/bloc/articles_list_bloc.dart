import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:article_finder/bloc/bloc.dart';
import '../data/article.dart';
import '../data/rw_client.dart';

class ArticleListBloc implements Bloc {
  // 1
  final _client = RWClient();
  // 2
  final _searchQueryController = StreamController<String?>();
  // 3
  Sink<String?> get searchQuery => _searchQueryController.sink;
  // 4
  late Stream<List<Article>?> articlesStream;

  ArticleListBloc() {
    // 5
    articlesStream = _searchQueryController.stream
        .startWith(null)
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap(
          (value) => _client.fetchArticles(value).asStream().startWith(null),
        );
  }

  // 6
  @override
  void dispose() {
    _searchQueryController.close();
  }
}
