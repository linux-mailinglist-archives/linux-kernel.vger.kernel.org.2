Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199EF3569C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351096AbhDGKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:37:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16381 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbhDGKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:37:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFglR0LjrzjYJj;
        Wed,  7 Apr 2021 18:35:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 18:37:11 +0800
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
Subject: [PATCH v3 5/6] perf vendor events arm64: Add Hisi hip08 L2 metrics
Date:   Wed, 7 Apr 2021 18:32:49 +0800
Message-ID: <1617791570-165223-6-git-send-email-john.garry@huawei.com>
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

Add L2 metrics.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/arm64/hisilicon/hip08/metrics.json   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index dc5ff3051639..dda898d23c2d 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -27,4 +27,46 @@
         "MetricGroup": "TopDownL1",
         "MetricName": "backend_bound"
     },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x201d@ / CPU_CYCLES",
+        "PublicDescription": "Fetch latency bound L2 topdown metric",
+        "BriefDescription": "Fetch latency bound L2 topdown metric",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "fetch_latency_bound"
+    },
+    {
+        "MetricExpr": "frontend_bound - fetch_latency_bound",
+        "PublicDescription": "Fetch bandwidth bound L2 topdown metric",
+        "BriefDescription": "Fetch bandwidth bound L2 topdown metric",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "fetch_bandwidth_bound"
+    },
+    {
+        "MetricExpr": "(bad_speculation * BR_MIS_PRED) / (BR_MIS_PRED + armv8_pmuv3_0@event\\=0x2013@)",
+        "PublicDescription": "Branch mispredicts L2 topdown metric",
+        "BriefDescription": "Branch mispredicts L2 topdown metric",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "branch_mispredicts"
+    },
+    {
+        "MetricExpr": "bad_speculation - branch_mispredicts",
+        "PublicDescription": "Machine clears L2 topdown metric",
+        "BriefDescription": "Machine clears L2 topdown metric",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "machine_clears"
+    },
+    {
+        "MetricExpr": "(EXE_STALL_CYCLE - (MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@)) / CPU_CYCLES",
+        "PublicDescription": "Core bound L2 topdown metric",
+        "BriefDescription": "Core bound L2 topdown metric",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "core_bound"
+    },
+    {
+        "MetricExpr": "(MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@) / CPU_CYCLES",
+        "PublicDescription": "Memory bound L2 topdown metric",
+        "BriefDescription": "Memory bound L2 topdown metric",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "memory_bound"
+    },
 ]
-- 
2.26.2

