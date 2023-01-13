import 'package:article_finder/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';

import '../bloc/article_detail_bloc.dart';
import '../data/article.dart';
import 'article_detail.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    final bloc = BlocProvider.of<ArticleDetailBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Articles detail'),
        ),
        body: RefreshIndicator(
          onRefresh: bloc.refresh,
          child: Container(
            alignment: Alignment.center,
            child: _buildContent(bloc),
          ),
        ));
  }

  Widget _buildContent(ArticleDetailBloc bloc) {
    return StreamBuilder<Article?>(
      stream: bloc.articleStream,
      builder: (context, snapshot) {
        final article = snapshot.data;
        if (article == null) {
          return const Center(child: CircularProgressIndicator());
        }
        // 3
        return ArticleDetail(article);
      },
    );
  }
}
