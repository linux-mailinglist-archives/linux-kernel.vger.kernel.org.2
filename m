Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38551348E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCYKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:38:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14900 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCYKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5hNk02YtzkfWX;
        Thu, 25 Mar 2021 18:36:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 18:38:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>
CC:     <linuxarm@huawei.com>, <kjain@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <pc@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/6] perf test: Handle metric reuse in pmu-events parsing test
Date:   Thu, 25 Mar 2021 18:33:14 +0800
Message-ID: <1616668398-144648-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmu-events parsing test does not handle metric reuse at all.

Introduce some simple handling to resolve metrics who reference other
metrics.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/pmu-events.c | 80 +++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0ca6a5a53523..20b6bf14f7f7 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -12,6 +12,7 @@
 #include "util/evlist.h"
 #include "util/expr.h"
 #include "util/parse-events.h"
+#include "metricgroup.h"
 
 struct perf_pmu_test_event {
 	/* used for matching against events from generated pmu-events.c */
@@ -471,6 +472,70 @@ static void expr_failure(const char *msg,
 	pr_debug("On expression %s\n", pe->metric_expr);
 }
 
+struct metric {
+	struct list_head list;
+	struct metric_ref metric_ref;
+};
+
+static int resolve_metric_simple(struct expr_parse_ctx *pctx,
+				 struct list_head *compound_list,
+				 struct pmu_events_map *map,
+				 const char *metric_name)
+{
+	struct hashmap_entry *cur, *cur_tmp;
+	struct metric *metric, *tmp;
+	size_t bkt;
+	bool all;
+	int rc;
+
+	do {
+		all = true;
+		hashmap__for_each_entry_safe((&pctx->ids), cur, cur_tmp, bkt) {
+			struct metric_ref *ref;
+			struct pmu_event *pe;
+
+			pe = metrcgroup_find_metric(cur->key, map);
+			if (!pe)
+				continue;
+
+			if (!strcmp(metric_name, (char *)cur->key)) {
+				pr_warning("Recursion detected for metric %s\n", metric_name);
+				rc = -1;
+				goto out_err;
+			}
+
+			all = false;
+
+			/* The metric key itself needs to go out.. */
+			expr__del_id(pctx, cur->key);
+
+			metric = malloc(sizeof(*metric));
+			if (!metric) {
+				rc = -ENOMEM;
+				goto out_err;
+			}
+
+			ref = &metric->metric_ref;
+			ref->metric_name = pe->metric_name;
+			ref->metric_expr = pe->metric_expr;
+			list_add_tail(&metric->list, compound_list);
+
+			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
+			if (rc)
+				goto out_err;
+		}
+	} while (!all);
+
+	return 0;
+
+out_err:
+	list_for_each_entry_safe(metric, tmp, compound_list, list)
+		free(metric);
+
+	return rc;
+
+}
+
 static int test_parsing(void)
 {
 	struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
@@ -488,7 +553,9 @@ static int test_parsing(void)
 			break;
 		j = 0;
 		for (;;) {
+			struct metric *metric, *tmp;
 			struct hashmap_entry *cur;
+			LIST_HEAD(compound_list);
 			size_t bkt;
 
 			pe = &map->table[j++];
@@ -504,6 +571,13 @@ static int test_parsing(void)
 				continue;
 			}
 
+			if (resolve_metric_simple(&ctx, &compound_list, map,
+						  pe->metric_name)) {
+				expr_failure("Could not resolve metrics", map, pe);
+				ret++;
+				goto exit; /* Don't tolerate errors due to severity */
+			}
+
 			/*
 			 * Add all ids with a made up value. The value may
 			 * trigger divide by zero when subtracted and so try to
@@ -519,6 +593,11 @@ static int test_parsing(void)
 					ret++;
 			}
 
+			list_for_each_entry_safe(metric, tmp, &compound_list, list) {
+				expr__add_ref(&ctx, &metric->metric_ref);
+				free(metric);
+			}
+
 			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
 				expr_failure("Parse failed", map, pe);
 				ret++;
@@ -527,6 +606,7 @@ static int test_parsing(void)
 		}
 	}
 	/* TODO: fail when not ok */
+exit:
 	return ret == 0 ? TEST_OK : TEST_SKIP;
 }
 
-- 
2.26.2

