Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB932BFC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhCCSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:05:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13119 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbhCCP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:28:19 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrHqV4LBnz16Fyp;
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
Subject: [PATCH 3/5] perf vendor events arm64: Add Hisi hip08 L1 metrics
Date:   Wed, 3 Mar 2021 23:22:16 +0800
Message-ID: <1614784938-27080-4-git-send-email-john.garry@huawei.com>
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

Add L1 metrics. Formula is as consistent as possible with standard.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/metrics.json   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
new file mode 100644
index 000000000000..dc5ff3051639
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -0,0 +1,30 @@
+[
+    {
+        "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
+        "PublicDescription": "Frontend bound L1 topdown metric",
+        "BriefDescription": "Frontend bound L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "frontend_bound"
+    },
+    {
+        "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
+        "PublicDescription": "Bad Speculation L1 topdown metric",
+        "BriefDescription": "Bad Speculation L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "bad_speculation"
+    },
+    {
+        "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
+        "PublicDescription": "Retiring L1 topdown metric",
+        "BriefDescription": "Retiring L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "retiring"
+    },
+    {
+        "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)",
+        "PublicDescription": "Backend Bound L1 topdown metric",
+        "BriefDescription": "Backend Bound L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "backend_bound"
+    },
+]
-- 
2.26.2

