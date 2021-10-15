Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6442FA01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhJORYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbhJORX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:23:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF41C06176F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:21:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so11832284ybr.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/xKHqgi5sjCNt/W6KDg/ghnn+rjznis60PZn3x9PAI0=;
        b=BLUhEFeaSsPFTJfwODK/yn0spgpAenCi7X7sy4OthHCY2ojp5fzRZZX+o531dwZPUg
         lVmBUEVVdLxA+qPW9UpPMKdOZd4Syxb88+24iHVu34Z+jV4AC2b7M4+JaOh4xjoPUWCW
         3TTZk99UjmHyd0msd3G10HAYVorf9H4RRbNr7DHdMd53ePwG3jEI0ua9tkpsuPMpZ0NG
         1GcjZmF4nvGmmEBVQgAnn3K+ddSsBlnfCQSL4Qbkrn6xu6z9UlIsf3viX4ShXzPKOrha
         pWXv8Vgc5AcY/ckrT5HZ4qIrWKIiqq/yLU4UW6uJMcMYfk2YLLQbvKI38dJ4FkFE33q9
         iUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/xKHqgi5sjCNt/W6KDg/ghnn+rjznis60PZn3x9PAI0=;
        b=a76y3oEnU8RtwiUW86EZV3kp4yPg8RUKqsX1YpFMBapBlstkZAfenaNqyBE+WwEwbf
         z6y8V6i4xjZjC+rImw3sC9r44/77MvItLISPATbyJBfntIeEw2dqaBYXh2Xdj6n6Rloy
         LEEhQVpt/WNRGgc5PxrJ5YgoO4sYQxn8/Q0uBdwMUoHdA/+pQCKRXH4IcJaL/TM7lt6w
         rKRalWGi3oOfXULdExOWUm6aaHbArFkiQY10aa+JeW1KBJm5proOLiOk9pcs0Mfx12VK
         9GiLLhEJUQnaecGXG8vX3oFax/7E50YdyyLPib8eCw9vDZlKW255XGHzafqwIyI+MvJr
         ex/A==
X-Gm-Message-State: AOAM532zjpQLzEnnB2h3XioJa10m4EmJEBHLDZlhnvxwdeazzHmfGBD3
        5Gm/qh8MXsJgOqDvVKSIV0EIBFkuwB7B
X-Google-Smtp-Source: ABdhPJwogJPeeVYDzklLSf2S4OBBu4MnRYlZbcrnEx5H4RPVdJFsoUtxKABxj+OOtopi++/Va41Zdq4ur6Gj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:6884:: with SMTP id
 d126mr13926373ybc.533.1634318510097; Fri, 15 Oct 2021 10:21:50 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:16 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-6-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 05/21] perf metric: Move runtime value to the expr context
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime value is needed when recursively parsing metrics, currently
a value of 1 is passed which is incorrect. Rather than add more
arguments to the bison parser, add runtime to the context. Fix call
sites not to pass a value. The runtime value is defaulted to 0, which is
arbitrary. In some places this replaces a value of 1, which was also
arbitrary. This shouldn't affect anything other than PPC. The use of
0 or 1 shouldn't matter as a proper runtime value would be needed in a
case that it did matter.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 15 ++++++++-------
 tools/perf/tests/pmu-events.c | 10 +++++-----
 tools/perf/util/expr.c        | 15 ++++++++-------
 tools/perf/util/expr.h        |  5 +++--
 tools/perf/util/metricgroup.c |  7 +++----
 tools/perf/util/stat-shadow.c |  7 ++++---
 6 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index f1d8411fce12..3c16f3df1980 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -56,7 +56,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 {
 	double val;
 
-	if (expr__parse(&val, ctx, e, 1))
+	if (expr__parse(&val, ctx, e))
 		TEST_ASSERT_VAL("parse test failed", 0);
 	TEST_ASSERT_VAL("unexpected value", val == val2);
 	return 0;
@@ -104,17 +104,17 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	}
 
 	p = "FOO/0";
-	ret = expr__parse(&val, ctx, p, 1);
+	ret = expr__parse(&val, ctx, p);
 	TEST_ASSERT_VAL("division by zero", ret == -1);
 
 	p = "BAR/";
-	ret = expr__parse(&val, ctx, p, 1);
+	ret = expr__parse(&val, ctx, p);
 	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
-					ctx, 1) == 0);
+					ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR",
 						    (void **)&val_ptr));
@@ -124,9 +124,10 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 						    (void **)&val_ptr));
 
 	expr__ctx_clear(ctx);
+	ctx->runtime = 3;
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
-					NULL, ctx, 3) == 0);
+					NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3/",
 						    (void **)&val_ptr));
@@ -137,7 +138,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1 if #smt_on else EVENT2",
-				NULL, ctx, 0) == 0);
+				NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
 						  smt_on() ? "EVENT1" : "EVENT2",
@@ -147,7 +148,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
-			NULL, ctx, 0) == 0);
+			NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 
 	expr__ctx_free(ctx);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index cc5cea141beb..71b08c296410 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -866,7 +866,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 			ref->metric_expr = pe->metric_expr;
 			list_add_tail(&metric->list, compound_list);
 
-			rc = expr__find_ids(pe->metric_expr, NULL, pctx, 0);
+			rc = expr__find_ids(pe->metric_expr, NULL, pctx);
 			if (rc)
 				goto out_err;
 			break; /* The hashmap has been modified, so restart */
@@ -916,7 +916,7 @@ static int test_parsing(void)
 			if (!pe->metric_expr)
 				continue;
 			expr__ctx_clear(ctx);
-			if (expr__find_ids(pe->metric_expr, NULL, ctx, 0) < 0) {
+			if (expr__find_ids(pe->metric_expr, NULL, ctx) < 0) {
 				expr_failure("Parse find ids failed", map, pe);
 				ret++;
 				continue;
@@ -949,7 +949,7 @@ static int test_parsing(void)
 				free(metric);
 			}
 
-			if (expr__parse(&result, ctx, pe->metric_expr, 0)) {
+			if (expr__parse(&result, ctx, pe->metric_expr)) {
 				expr_failure("Parse failed", map, pe);
 				ret++;
 			}
@@ -989,7 +989,7 @@ static int metric_parse_fake(const char *str)
 		pr_debug("expr__ctx_new failed");
 		return TEST_FAIL;
 	}
-	if (expr__find_ids(str, NULL, ctx, 0) < 0) {
+	if (expr__find_ids(str, NULL, ctx) < 0) {
 		pr_err("expr__find_ids failed\n");
 		return -1;
 	}
@@ -1010,7 +1010,7 @@ static int metric_parse_fake(const char *str)
 		}
 	}
 
-	if (expr__parse(&result, ctx, str, 0))
+	if (expr__parse(&result, ctx, str))
 		pr_err("expr__parse failed\n");
 	else
 		ret = 0;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index db2445677c8c..62fb39fd4d9d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -246,7 +246,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 			data->ref.metric_name);
 		pr_debug("processing metric: %s ENTRY\n", id);
 		data->kind = EXPR_ID_DATA__REF_VALUE;
-		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr, 1)) {
+		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr)) {
 			pr_debug("%s failed to count\n", id);
 			return -1;
 		}
@@ -284,6 +284,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 
 	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
 	ctx->parent = NULL;
+	ctx->runtime = 0;
 	return ctx;
 }
 
@@ -314,10 +315,10 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 
 static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
-	      bool compute_ids, int runtime)
+	      bool compute_ids)
 {
 	struct expr_scanner_ctx scanner_ctx = {
-		.runtime = runtime,
+		.runtime = ctx->runtime,
 	};
 	YY_BUFFER_STATE buffer;
 	void *scanner;
@@ -345,15 +346,15 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 }
 
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
-		const char *expr, int runtime)
+		const char *expr)
 {
-	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
+	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false) ? -1 : 0;
 }
 
 int expr__find_ids(const char *expr, const char *one,
-		   struct expr_parse_ctx *ctx, int runtime)
+		   struct expr_parse_ctx *ctx)
 {
-	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
+	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true);
 
 	if (one)
 		expr__del_id(ctx, one);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index b20513f0ae59..124475a4f245 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -21,6 +21,7 @@ struct expr_id {
 struct expr_parse_ctx {
 	struct hashmap	*ids;
 	struct expr_id	*parent;
+	int runtime;
 };
 
 struct expr_id_data;
@@ -52,10 +53,10 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
-		const char *expr, int runtime);
+		const char *expr);
 
 int expr__find_ids(const char *expr, const char *one,
-		struct expr_parse_ctx *ids, int runtime);
+		   struct expr_parse_ctx *ids);
 
 double expr_id_data__value(const struct expr_id_data *data);
 struct expr_id *expr_id_data__parent(struct expr_id_data *data);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b60ccbbf0829..139f4a793f92 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -124,7 +124,6 @@ struct metric {
 	const char *metric_unit;
 	struct list_head metric_refs;
 	int metric_refs_cnt;
-	int runtime;
 	bool has_constraint;
 };
 
@@ -391,7 +390,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		expr->metric_name = m->metric_name;
 		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
-		expr->runtime = m->runtime;
+		expr->runtime = m->pctx->runtime;
 		list_add(&expr->nd, &me->head);
 	}
 
@@ -812,7 +811,7 @@ static int __add_metric(struct list_head *metric_list,
 		m->metric_name = pe->metric_name;
 		m->metric_expr = pe->metric_expr;
 		m->metric_unit = pe->unit;
-		m->runtime = runtime;
+		m->pctx->runtime = runtime;
 		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 		INIT_LIST_HEAD(&m->metric_refs);
 		m->metric_refs_cnt = 0;
@@ -862,7 +861,7 @@ static int __add_metric(struct list_head *metric_list,
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_ids(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
+	if (expr__find_ids(pe->metric_expr, NULL, m->pctx) < 0) {
 		if (m->metric_refs_cnt == 0) {
 			expr__ctx_free(m->pctx);
 			free(m);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9bc841e09a0c..20f1b9d0f272 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -394,7 +394,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 		if (!metric_events) {
 			if (expr__find_ids(counter->metric_expr,
 					   counter->name,
-					   ctx, 1) < 0)
+					   ctx) < 0)
 				continue;
 
 			metric_events = calloc(sizeof(struct evsel *),
@@ -894,13 +894,14 @@ static void generic_metric(struct perf_stat_config *config,
 	if (!pctx)
 		return;
 
+	pctx->runtime = runtime;
 	i = prepare_metric(metric_events, metric_refs, pctx, cpu, st);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
 	}
 	if (!metric_events[i]) {
-		if (expr__parse(&ratio, pctx, metric_expr, runtime) == 0) {
+		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
 			char *unit;
 			char metric_bf[64];
 
@@ -951,7 +952,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu, st) < 0)
 		goto out;
 
-	if (expr__parse(&ratio, pctx, mexp->metric_expr, 1))
+	if (expr__parse(&ratio, pctx, mexp->metric_expr))
 		ratio = 0.0;
 
 out:
-- 
2.33.0.1079.g6e70778dc9-goog

