Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3475332BFA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835757AbhCCSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:04:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13121 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379393AbhCCPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:31:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrHqV5DbZz16G08;
        Wed,  3 Mar 2021 23:24:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 23:26:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <irogers@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <qiangqing.zhang@nxp.com>,
        <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] perf metricgroup: Support printing metrics for arm64
Date:   Wed, 3 Mar 2021 23:22:14 +0800
Message-ID: <1614784938-27080-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
References: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling perf_pmu__find_map(NULL) returns the cpumap for the common CPU
PMU. However arm64 supports heterogeneous-CPU based systems, and so there
may be no common CPU PMU. As such, perf_pmu__find_map(NULL) returns NULL
for arm64.

To support printing metrics for arm64, iterate through all PMUs, looking
for a CPU PMU, and use the cpumap there for determining supported metrics.

For heterogeneous systems (like arm big.LITTLE), supporting metrics has
potential challenges, like not all CPUs in a system not supporting a
specific metric event. So just don't support it for now.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 26c990e32378..9a2a23093961 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -6,6 +6,7 @@
 /* Manage metrics and groups of metrics from JSON files */
 
 #include "metricgroup.h"
+#include "cpumap.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -615,10 +616,31 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
 				     d->details, d->groups, d->metriclist);
 }
 
+static struct pmu_events_map *find_cpumap(void)
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
+		if (pmu->cpus && pmu->cpus->nr != cpu__max_cpu())
+			return NULL;
+
+		return perf_pmu__find_map(pmu);
+	}
+
+	return NULL;
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *map = find_cpumap();
 	struct pmu_event *pe;
 	int i;
 	struct rblist groups;
-- 
2.26.2

