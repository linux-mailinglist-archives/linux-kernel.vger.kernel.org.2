Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C669E348E28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCYKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:38:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14897 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCYKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5hNj4dxFzkfSr;
        Thu, 25 Mar 2021 18:36:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 18:38:08 +0800
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
Subject: [PATCH v2 5/6] perf vendor events arm64: Add Hisi hip08 L2 metrics
Date:   Thu, 25 Mar 2021 18:33:17 +0800
Message-ID: <1616668398-144648-6-git-send-email-john.garry@huawei.com>
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

