Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949BB348E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCYKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:38:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14898 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCYKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5hNj5D3KzkfTc;
        Thu, 25 Mar 2021 18:36:37 +0800 (CST)
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
Subject: [PATCH v2 3/6] perf pmu: Add pmu_events_map__find()
Date:   Thu, 25 Mar 2021 18:33:15 +0800
Message-ID: <1616668398-144648-4-git-send-email-john.garry@huawei.com>
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

Add a function to find the common PMU map for the system.

For arm64, a special variant is added. This is because arm64 supports
heterogeneous CPU systems. As such, it cannot be guaranteed that the cpumap
is same for all CPUs. So in case of heterogeneous systems, don't return
a cpumap.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/arch/arm64/util/Build  |  1 +
 tools/perf/arch/arm64/util/pmu.c  | 25 +++++++++++++++++++++++++
 tools/perf/tests/pmu-events.c     |  2 +-
 tools/perf/util/metricgroup.c     |  7 +++----
 tools/perf/util/pmu.c             |  5 +++++
 tools/perf/util/pmu.h             |  1 +
 tools/perf/util/s390-sample-raw.c |  4 +---
 7 files changed, 37 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/pmu.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index ead2f2275eee..9fcb4e68add9 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -2,6 +2,7 @@ perf-y += header.o
 perf-y += machine.o
 perf-y += perf_regs.o
 perf-y += tsc.o
+perf-y += pmu.o
 perf-y += kvm-stat.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
new file mode 100644
index 000000000000..d3259d61ca75
--- /dev/null
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../../util/cpumap.h"
+#include "../../util/pmu.h"
+
+struct pmu_events_map *pmu_events_map__find(void)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!is_pmu_core(pmu->name))
+			continue;
+
+		/*
+		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
+		 * not support some events or have different event IDs.
+		 */
+		if (pmu->cpus->nr != cpu__max_cpu())
+			return NULL;
+
+		return perf_pmu__find_map(pmu);
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 20b6bf14f7f7..9fe2455b355b 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -538,7 +538,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 
 static int test_parsing(void)
 {
-	struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *cpus_map = pmu_events_map__find();
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	int i, j, k;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 71a13406e0bd..e6e787e94f91 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -618,7 +618,7 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *map = pmu_events_map__find();
 	struct pmu_event *pe;
 	int i;
 	struct rblist groups;
@@ -1254,8 +1254,7 @@ int metricgroup__parse_groups(const struct option *opt,
 			      struct rblist *metric_events)
 {
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
-
+	struct pmu_events_map *map = pmu_events_map__find();
 
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, map);
@@ -1274,7 +1273,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 
 bool metricgroup__has_metric(const char *metric)
 {
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *map = pmu_events_map__find();
 	struct pmu_event *pe;
 	int i;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88da5cf6aee8..419ef6c4fbc0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -717,6 +717,11 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
+struct pmu_events_map *__weak pmu_events_map__find(void)
+{
+	return perf_pmu__find_map(NULL);
+}
+
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8164388478c6..012317229488 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -114,6 +114,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 			     struct pmu_events_map *map);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
+struct pmu_events_map *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index cfcf8d534d76..08ec3c3ae0ee 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -160,11 +160,9 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
 	struct pmu_events_map *map;
-	struct perf_pmu pmu;
 	u64 *p;
 
-	memset(&pmu, 0, sizeof(pmu));
-	map = perf_pmu__find_map(&pmu);
+	map = pmu_events_map__find();
 	while (offset < len) {
 		cep = (struct cf_ctrset_entry *)(buf + offset);
 
-- 
2.26.2

