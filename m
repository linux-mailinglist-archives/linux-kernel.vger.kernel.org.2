Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422684258A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhJGRAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbhJGRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA3C061794
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:57:58 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so5677688qkp.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lZVRifLp/eRUS0DShn151xIzv9a2WbCBrno0ZLFegHE=;
        b=IQ1SryqbvdpfWluKATITSox+B3WaWfqIg33eM4v/qZNpWQp229xeNM+g9B3tUfOvbj
         wA23vEIk8gpGKJl3gsDkKfe3TVYP2gIfFo5tL2zon2zJik1w0K91dU7UatK2YH6t7jWP
         9hgq50fTQXB62kFkvt/jFX2z1ZxsmOFqvmzyvvQ3oOtZ8mxXWpjKl5Jsj224KvYQTkvp
         JFNzsX9qDp9wMGs5tXAjKBraukPQFAkuJCDbyiKhNe0XyYh8GcYIMw0RdhGPkzMtMkG5
         CJ7JtIXnakFeI9sXXrPmvZtCRJKyag/pZlnnrbBHRe8/T/l142IUoBBYRnTdHggVtcb2
         yxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lZVRifLp/eRUS0DShn151xIzv9a2WbCBrno0ZLFegHE=;
        b=eCSR6W/7TY7Bx2a21Lo9rwtby6s4M7LOv6NS1pKlG9tcxuIzLlj4e+Z/MvaEqmvI9i
         Lv/f0XnLkGv3S/K8zxBLSrO0AE9gieCpD0KTn7ajUgNtfzmPON0qx5nLwS/dUb9IAonM
         T7LvnuEu3fMcKpN4OOsCGz3wQSjYw8JTCe7Yyqg0fJH7hmmPeREMkzmXEylQpVH9yuP7
         bCevmkaQb/Idpz8xAGsjBvcYz/mdjZoNzVuNQlF/GdwVu8lXdLFSf5EjnCcMvA6pVWQy
         Eb52R3VHUsjw+t8Zi7+dqWszp5Z1SZcYEsmt4929RziHc/hJUs5mkuaTAlQmZnDIa8mI
         1vlg==
X-Gm-Message-State: AOAM533rttr63+k12DGW3ywzUDfCgWYF8ef6AfkIpty2gIWe0U5Ot+He
        c0o6GV0VwewZ1Cxoq6+n8nZY6ZL8eve5
X-Google-Smtp-Source: ABdhPJxxbdsEKkTSX/TY4qops1XUyhrL+NWbIdlukxoKdh4uaFSxcqtA86nTFzwiydOBR9VgLcoT1aUjraqf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a05:622a:1793:: with SMTP id
 s19mr6418711qtk.231.1633625877477; Thu, 07 Oct 2021 09:57:57 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:38 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-13-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 12/21] perf metric: Simplify metric_refs calculation.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't build a list and then turn to an array, just directly build the
array. The size of the array is known due to the search for a duplicate.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 77 +++++++++++------------------------
 1 file changed, 23 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 632867cedbae..b48836d7c080 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -137,10 +137,8 @@ struct metric {
 	 * output.
 	 */
 	const char *metric_unit;
-	/** The list of metrics referenced by this one. */
-	struct list_head metric_refs;
-	/** The size of the metric_refs list. */
-	int metric_refs_cnt;
+	/** Optional null terminated array of referenced metrics. */
+	struct metric_ref *metric_refs;
 	/**
 	 * Is there a constraint on the group of events? In which case the
 	 * events won't be grouped.
@@ -202,20 +200,14 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	m->metric_unit = pe->unit;
 	m->pctx->runtime = runtime;
 	m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
-	INIT_LIST_HEAD(&m->metric_refs);
-	m->metric_refs_cnt = 0;
+	m->metric_refs = NULL;
 
 	return m;
 }
 
 static void metric__free(struct metric *m)
 {
-	struct metric_ref_node *ref, *tmp;
-
-	list_for_each_entry_safe(ref, tmp, &m->metric_refs, list) {
-		list_del(&ref->list);
-		free(ref);
-	}
+	free(m->metric_refs);
 	expr__ctx_free(m->pctx);
 	free(m);
 }
@@ -393,7 +385,6 @@ static int metricgroup__setup_events(struct list_head *groups,
 
 	list_for_each_entry (m, groups, nd) {
 		struct evsel **metric_events;
-		struct metric_ref *metric_refs = NULL;
 		const size_t ids_size = hashmap__size(m->pctx->ids);
 
 		metric_events = calloc(sizeof(void *),
@@ -427,36 +418,8 @@ static int metricgroup__setup_events(struct list_head *groups,
 			break;
 		}
 
-		/*
-		 * Collect and store collected nested expressions
-		 * for metric processing.
-		 */
-		if (m->metric_refs_cnt) {
-			struct metric_ref_node *ref;
-
-			metric_refs = zalloc(sizeof(struct metric_ref) * (m->metric_refs_cnt + 1));
-			if (!metric_refs) {
-				ret = -ENOMEM;
-				free(metric_events);
-				free(expr);
-				break;
-			}
-
-			i = 0;
-			list_for_each_entry(ref, &m->metric_refs, list) {
-				/*
-				 * Intentionally passing just const char pointers,
-				 * originally from 'struct pmu_event' object.
-				 * We don't need to change them, so there's no
-				 * need to create our own copy.
-				 */
-				metric_refs[i].metric_name = ref->metric_name;
-				metric_refs[i].metric_expr = ref->metric_expr;
-				i++;
-			}
-		}
-
-		expr->metric_refs = metric_refs;
+		expr->metric_refs = m->metric_refs;
+		m->metric_refs = NULL;
 		expr->metric_expr = m->metric_expr;
 		expr->metric_name = m->metric_name;
 		expr->metric_unit = m->metric_unit;
@@ -936,7 +899,6 @@ static int __add_metric(struct list_head *metric_list,
 			const struct visited_metric *visited,
 			const struct pmu_events_map *map)
 {
-	struct metric_ref_node *ref;
 	const struct visited_metric *vm;
 	int ret;
 	bool is_root = !root_metric;
@@ -962,19 +924,25 @@ static int __add_metric(struct list_head *metric_list,
 			return -ENOMEM;
 
 	} else {
+		int cnt = 0;
+
 		/*
 		 * This metric was referenced in a metric higher in the
 		 * tree. Check if the same metric is already resolved in the
 		 * metric_refs list.
 		 */
-		list_for_each_entry(ref, &root_metric->metric_refs, list) {
-			if (!strcmp(pe->metric_name, ref->metric_name))
-				return 0;
+		if (root_metric->metric_refs) {
+			for (; root_metric->metric_refs[cnt].metric_name; cnt++) {
+				if (!strcmp(pe->metric_name,
+					    root_metric->metric_refs[cnt].metric_name))
+					return 0;
+			}
 		}
 
-		/* Create reference */
-		ref = malloc(sizeof(*ref));
-		if (!ref)
+		/* Create reference. Need space for the entry and the terminator. */
+		root_metric->metric_refs = realloc(root_metric->metric_refs,
+						(cnt + 2) * sizeof(struct metric_ref));
+		if (!root_metric->metric_refs)
 			return -ENOMEM;
 
 		/*
@@ -983,11 +951,12 @@ static int __add_metric(struct list_head *metric_list,
 		 * need to change them, so there's no need to create
 		 * our own copy.
 		 */
-		ref->metric_name = pe->metric_name;
-		ref->metric_expr = pe->metric_expr;
+		root_metric->metric_refs[cnt].metric_name = pe->metric_name;
+		root_metric->metric_refs[cnt].metric_expr = pe->metric_expr;
 
-		list_add(&ref->list, &root_metric->metric_refs);
-		root_metric->metric_refs_cnt++;
+		/* Null terminate array. */
+		root_metric->metric_refs[cnt+1].metric_name = NULL;
+		root_metric->metric_refs[cnt+1].metric_expr = NULL;
 	}
 
 	/*
-- 
2.33.0.882.g93a45727a2-goog

