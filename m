Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A454E32BFC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhCCSFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:05:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13117 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378968AbhCCP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:28:26 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrHqV3vFFz16Fyy;
        Wed,  3 Mar 2021 23:24:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 23:26:28 +0800
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
Subject: [PATCH 4/5] perf vendor events arm64: Add Hisi hip08 L2 metrics
Date:   Wed, 3 Mar 2021 23:22:17 +0800
Message-ID: <1614784938-27080-5-git-send-email-john.garry@huawei.com>
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

Add L2 metrics.

Signed-off-by: John Garry <john.garry@huawei.com>
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

