Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3F3569C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351120AbhDGKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:37:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16382 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346751AbhDGKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:37:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFglR1l5zzjYhg;
        Wed,  7 Apr 2021 18:35:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 18:37:10 +0800
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
Subject: [PATCH v3 2/6] perf test: Handle metric reuse in pmu-events parsing test
Date:   Wed, 7 Apr 2021 18:32:46 +0800
Message-ID: <1617791570-165223-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
References: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
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

Tested-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/pmu-events.c | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0ca6a5a53523..cb5b25d2fb27 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -12,6 +12,7 @@
 #include "util/evlist.h"
 #include "util/expr.h"
 #include "util/parse-events.h"
+#include "metricgroup.h"
 
 struct perf_pmu_test_event {
 	/* used for matching against events from generated pmu-events.c */
@@ -471,6 +472,71 @@ static void expr_failure(const char *msg,
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
+			pe = metricgroup__find_metric(cur->key, map);
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
+			break; /* The hashmap has been modified, so restart */
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
@@ -488,7 +554,9 @@ static int test_parsing(void)
 			break;
 		j = 0;
 		for (;;) {
+			struct metric *metric, *tmp;
 			struct hashmap_entry *cur;
+			LIST_HEAD(compound_list);
 			size_t bkt;
 
 			pe = &map->table[j++];
@@ -504,6 +572,13 @@ static int test_parsing(void)
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
@@ -519,6 +594,11 @@ static int test_parsing(void)
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
@@ -527,6 +607,7 @@ static int test_parsing(void)
 		}
 	}
 	/* TODO: fail when not ok */
+exit:
 	return ret == 0 ? TEST_OK : TEST_SKIP;
 }
 
-- 
2.26.2

