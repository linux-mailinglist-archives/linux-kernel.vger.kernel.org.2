Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005B1410471
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbhIRGh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbhIRGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:37:07 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F61C0613E2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:35:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso106320284qvw.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9ysNhuUjQsWUA9Jp53PxdUGiJvZ2svrUkuKVKC/jn2A=;
        b=Q6Dj73lq2IbSWTC4BaC0Y2G4rakUT65Kk+nG/i8iHwcnXOOP/ZLLvgKK4JapmOpFgw
         /UiAynV7YvfAc5P0VZcMIyGBZkYh1zPQFe66DL+v9tDUKMj49emiyA90QWeDhKOHwyHo
         eAJ8TAwhNss1Rx7pY6gQUIyUC/6I05x1Xit7Ek0v3HRMoH554VKZOnzYrkx82qNNqHzP
         f5mgX1J+jXc7sZohHD3U4y7ef9HTPYR/FNpfBsT+EY1sTL5nF0DaLukz5MUwVKPtIzUQ
         qOXACZmMr6caz+Ys9JYixFBuWC+SM7HWu9dXOWNTdYgeFXCKRLCyRVjb8THEXtqJ9U1V
         0TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9ysNhuUjQsWUA9Jp53PxdUGiJvZ2svrUkuKVKC/jn2A=;
        b=KE4le5jFUkNIwiN4BYX95Dythmg0vJuFwbiJAkIaXiyzyE7dVzJWjwzjDoQGz26lZz
         rGxAyFFOlfGv5zKBT7pFZHp7YA5CX4Ky8x1qqUksWbFuBWAU1S1ypVGLX2hXdaiDUNAV
         mOdoWhk9hSqzdoY2Vqbdw7tQoHHctv37Ub2rpE21sGcpxVEmsYHBzwGrQsR1AmzQB+JB
         7MygrFtRJCqbtAWR/Xvi7shViPivcH9M+5weP776HfDC0xiQc3uKs0apjyrqlTt9J7JA
         hrQO7x3Jp/vXaf9t0dUN2Wn63zvRIxEIW5uvorf6LovgcGUi1xfkefcMtGwDc0yrfs3I
         lgZQ==
X-Gm-Message-State: AOAM531zjZeV9NwatGN926ruK39v7h/4T3Yjb87jae7zqxhZKhtts2WP
        wsVd+AFGbnooyy/amZOcwdkQtMVGFA1Q
X-Google-Smtp-Source: ABdhPJx1xXSJj5x54JBm9M2PBsxTwjpas6i9MUTtSAdTW05NsPDapEjHWjk/nxdYR08sf/MlRFa6fsuxV1Tp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:a05:6214:706:: with SMTP id
 b6mr15023961qvz.29.1631946939899; Fri, 17 Sep 2021 23:35:39 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:35:12 -0700
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Message-Id: <20210918063513.2356923-8-irogers@google.com>
Mime-Version: 1.0
References: <20210918063513.2356923-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 7/8] perf metric: Don't compute unused events.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a metric like:
  EVENT1 if #smt_on else EVENT2

currently EVENT1 and EVENT2 will be measured and then when the metric is
reported EVENT1 or EVENT2 will be printed depending on the value from
smt_on() during the expr parsing. Computing both events is unnecessary and
can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies the expression parsing code by:
 - getting rid of the "other" parsing and introducing a boolean argument
   to say whether ids should be computed or not.
 - expressions are changed so that a pair of value and ids are returned.
 - when computing the metric value the ids are unused.
 - when computing the ids, constant values and smt_on are assigned to
   the value.
 - If the value is from an event ID then the event is added to the ids
   hashmap and the value set to bottom (encoded as NAN).
 - Typically operators union IDs for their inputs and set the value to
   bottom, however, if the inputs are constant then these are computed and
   propagated as the value.
 - If the input is constant to certain operators like:
 IDS1 if CONST else IDS2
   then the result will be either IDS1 or IDS2 depending on CONST (which
   may be evaluated from an entire expression), and so IDS1 or IDS2 may
   be discarded avoiding events from being programmed.
 - The ids at the end of parsing are added to the context.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c |   9 +-
 tools/perf/util/expr.h |   1 -
 tools/perf/util/expr.l |   9 --
 tools/perf/util/expr.y | 237 ++++++++++++++++++++++++++++++++++-------
 4 files changed, 203 insertions(+), 53 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 34b51ca5e87f..e9396a309fb7 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -330,10 +330,9 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 
 static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
-	      int start, int runtime)
+	      bool compute_ids, int runtime)
 {
 	struct expr_scanner_ctx scanner_ctx = {
-		.start_token = start,
 		.runtime = runtime,
 	};
 	YY_BUFFER_STATE buffer;
@@ -353,7 +352,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	expr_set_debug(1, scanner);
 #endif
 
-	ret = expr_parse(val, ctx, scanner);
+	ret = expr_parse(val, ctx, compute_ids, scanner);
 
 	expr__flush_buffer(buffer, scanner);
 	expr__delete_buffer(buffer, scanner);
@@ -364,13 +363,13 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime)
 {
-	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
+	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
 }
 
 int expr__find_ids(const char *expr, const char *one,
 		   struct expr_parse_ctx *ctx, int runtime)
 {
-	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
+	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
 
 	if (one)
 		expr__del_id(ctx, one);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index a3508c5a427a..eb4cd9563b1a 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,7 +26,6 @@ struct expr_parse_ctx {
 struct expr_id_data;
 
 struct expr_scanner_ctx {
-	int start_token;
 	int runtime;
 };
 
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 13e5e3c75f56..702fdf6456ca 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -91,15 +91,6 @@ symbol		({spec}|{sym})+
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
 
-	{
-		int start_token = sctx->start_token;
-
-		if (sctx->start_token) {
-			sctx->start_token = 0;
-			return start_token;
-		}
-	}
-
 d_ratio		{ return D_RATIO; }
 max		{ return MAX; }
 min		{ return MIN; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 51f4f0aa1955..907fe135c080 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <assert.h>
 #include <math.h>
 #include "util/debug.h"
 #include "smt.h"
@@ -12,15 +13,43 @@
 
 %parse-param { double *final_val }
 %parse-param { struct expr_parse_ctx *ctx }
+%parse-param { bool compute_ids }
 %parse-param {void *scanner}
 %lex-param {void* scanner}
 
 %union {
 	double	 num;
 	char	*str;
+	struct ids {
+		/*
+		 * When creating ids, holds the working set of event ids. NULL
+		 * implies the set is empty.
+		 */
+		struct hashmap *ids;
+		/*
+		 * The metric value. When not creating ids this is the value
+		 * read from a counter, a constant or some computed value. When
+		 * creating ids the value is either a constant or BOTTOM. NAN is
+		 * used as the special BOTTOM value, representing a "set of all
+		 * values" case. Consider:
+		 *   1.0 if event1 > 50.0 else 2.0
+		 * The set of values {1.0, 2.0} is possible from this
+		 * expression, but we conservatively use BOTTOM to say any value
+		 * is possible. By tracking constants an expression like:
+		 *   1.0 if event1 > 50.0 else 1.0
+		 * can avoid computing event1 as only the value 1.0 is a
+		 * possible value.
+		 * It is much more likely we're evaluating:
+		 *   EVENT1 if #smt_on else EVENT2
+		 * where we don't want to compute two events, but we track
+		 * constants in a more general framework to allow for more
+		 * complicated expressions.
+		 */
+		double val;
+	} ids;
 }
 
-%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR EXPR_PARSE EXPR_OTHER
+%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -32,65 +61,150 @@
 %type <num> NUMBER
 %type <str> ID
 %destructor { free ($$); } <str>
-%type <num> expr if_expr
+%type <ids> expr if_expr
+%destructor { ids__free($$.ids); } <ids>
 
 %{
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
+		       bool compute_ids __maybe_unused,
 		       void *scanner,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
 }
 
+/*
+ * During compute ids, the special "bottom" value uses NAN to represent the set
+ * of all values. NAN is selected as it isn't a useful constant value.
+ */
+#define BOTTOM NAN
+
+/* During computing ids, does val represent a constant (non-BOTTOM) value? */
+static bool is_const(double val)
+{
+	return isfinite(val);
+}
+
+static struct ids union_expr(struct ids ids1, struct ids ids2)
+{
+	struct ids result = {
+		.val = BOTTOM,
+		.ids = ids__union(ids1.ids, ids2.ids),
+	};
+	return result;
+}
+
+/*
+ * If we're not computing ids or $1 and $3 are constants, compute the new
+ * constant value using OP. Its invariant that there are no ids.  If computing
+ * ids for non-constants union the set of IDs that must be computed.
+ */
 #define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
-	RESULT = (long)LHS OP (long)RHS;
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
+		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
+		RESULT.ids = NULL;					\
+	} else {							\
+	        RESULT = union_expr(LHS, RHS);				\
+	}
 
 #define BINARY_OP(RESULT, OP, LHS, RHS)					\
-	RESULT = LHS OP RHS;
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
+		RESULT.val = LHS.val OP RHS.val;			\
+		RESULT.ids = NULL;					\
+	} else {							\
+	        RESULT = union_expr(LHS, RHS);				\
+	}
 
 %}
 %%
 
-start:
-EXPR_PARSE all_expr
-|
-EXPR_OTHER all_other
-
-all_other: all_other other
-|
-
-other: ID
+start: if_expr
 {
-	expr__add_id(ctx, $1);
-}
-|
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-|
-'<' | '>' | D_RATIO
+	if (compute_ids)
+		ctx->ids = ids__union($1.ids, ctx->ids);
 
-all_expr: if_expr			{ *final_val = $1; }
+	if (final_val)
+		*final_val = $1.val;
+}
+;
 
 if_expr: expr IF expr ELSE expr
 {
-	$$ = $3 ? $1 : $5;
+	if (fpclassify($3.val) == FP_ZERO) {
+		/*
+		 * The IF expression evaluated to 0 so treat as false, take the
+		 * ELSE and discard everything else.
+		 */
+		$$.val = $5.val;
+		$$.ids = $5.ids;
+		ids__free($1.ids);
+		ids__free($3.ids);
+	} else if (!compute_ids || is_const($3.val)) {
+		/*
+		 * If ids aren't computed then treat the expression as true. If
+		 * ids are being computed and the IF expr is a non-zero
+		 * constant, then also evaluate the true case.
+		 */
+		$$.val = $1.val;
+		$$.ids = $1.ids;
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else if ($1.val == $5.val) {
+		/*
+		 * LHS == RHS, so both are an identical constant. No need to
+		 * evaluate any events.
+		 */
+		$$.val = $1.val;
+		$$.ids = NULL;
+		ids__free($1.ids);
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else {
+		/*
+		 * Value is either the LHS or RHS and we need the IF expression
+		 * to compute it.
+		 */
+		$$ = union_expr($1, union_expr($3, $5));
+	}
 }
 | expr
 ;
 
 expr: NUMBER
 {
-	$$ = $1;
+	$$.val = $1;
+	$$.ids = NULL;
 }
 | ID
 {
-	struct expr_id_data *data;
+	if (!compute_ids) {
+		/*
+		 * Compute the event's value from ID. If the ID isn't known then
+		 * it isn't used to compute the formula so set to NAN.
+		 */
+		struct expr_id_data *data;
 
-	$$ = NAN;
-	if (expr__resolve_id(ctx, $1, &data) == 0)
-		$$ = expr_id_data__value(data);
+		$$.val = NAN;
+		if (expr__resolve_id(ctx, $1, &data) == 0)
+			$$.val = expr_id_data__value(data);
 
-	free($1);
+		$$.ids = NULL;
+		free($1);
+	} else {
+		/*
+		 * Set the value to BOTTOM to show that any value is possible
+		 * when the event is computed. Create a set of just the ID.
+		 */
+		$$.val = BOTTOM;
+		$$.ids = ids__new();
+		if (!$$.ids || ids__insert($$.ids, $1, ctx->parent))
+			YYABORT;
+	}
 }
 | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
 | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
@@ -102,31 +216,59 @@ expr: NUMBER
 | expr '*' expr { BINARY_OP($$, *, $1, $3); }
 | expr '/' expr
 {
-	if ($3 == 0) {
+	if (fpclassify($3.val) == FP_ZERO) {
 		pr_debug("division by zero\n");
 		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = $1.val / $3.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($1, $3);
 	}
-	$$ = $1 / $3;
 }
 | expr '%' expr
 {
-	if ((long)$3 == 0) {
+	if (fpclassify($3.val) == FP_ZERO) {
 		pr_debug("division by zero\n");
 		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = (long)$1.val % (long)$3.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($1, $3);
 	}
-	$$ = (long)$1 % (long)$3;
 }
 | D_RATIO '(' expr ',' expr ')'
 {
-	if ($5 == 0) {
-		$$ = 0;
+	if (fpclassify($5.val) == FP_ZERO) {
+		/*
+		 * Division by constant zero always yields zero and no events
+		 * are necessary.
+		 */
+		assert($5.ids == NULL);
+		$$.val = 0.0;
+		$$.ids = NULL;
+		ids__free($3.ids);
+	} else if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val / $5.val;
+		$$.ids = NULL;
 	} else {
-		$$ = $3 / $5;
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($3, $5);
 	}
 }
 | '-' expr %prec NEG
 {
-	$$ = -$2;
+	$$.val = -$2.val;
+	$$.ids = $2.ids;
 }
 | '(' if_expr ')'
 {
@@ -134,14 +276,33 @@ expr: NUMBER
 }
 | MIN '(' expr ',' expr ')'
 {
-	$$ = $3 < $5 ? $3 : $5;
+	if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val < $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($3, $5);
+	}
 }
 | MAX '(' expr ',' expr ')'
 {
-	$$ = $3 > $5 ? $3 : $5;
+	if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val > $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($3, $5);
+	}
 }
 | SMT_ON
 {
-	$$ = smt_on() > 0 ? 1.0 : 0.0;
+	$$.val = smt_on() > 0 ? 1.0 : 0.0;
+	$$.ids = NULL;
 }
 ;
+
+%%
-- 
2.33.0.464.g1972c5931b-goog

