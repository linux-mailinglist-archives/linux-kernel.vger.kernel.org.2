Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926063569C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351080AbhDGKhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:37:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16380 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbhDGKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:37:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFglQ6yN0zjYGy;
        Wed,  7 Apr 2021 18:35:30 +0800 (CST)
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
Subject: [PATCH v3 4/6] perf vendor events arm64: Add Hisi hip08 L1 metrics
Date:   Wed, 7 Apr 2021 18:32:48 +0800
Message-ID: <1617791570-165223-5-git-send-email-john.garry@huawei.com>
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

Add L1 metrics. Formula is as consistent as possible with MAN pages
description for these metrics.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
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

