Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4880F348E29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCYKiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:38:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14899 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhCYKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5hNj6dZczkfW1;
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
Subject: [PATCH v2 6/6] perf vendor events arm64: Add Hisi hip08 L3 metrics
Date:   Thu, 25 Mar 2021 18:33:18 +0800
Message-ID: <1616668398-144648-7-git-send-email-john.garry@huawei.com>
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

Add L3 metrics.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/metrics.json   | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index dda898d23c2d..dda8e59149d2 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -69,4 +69,165 @@
         "MetricGroup": "TopDownL2",
         "MetricName": "memory_bound"
     },
+    {
+        "MetricExpr": "(((L2I_TLB - L2I_TLB_REFILL) * 15) + (L2I_TLB_REFILL * 100)) / CPU_CYCLES",
+        "PublicDescription": "Idle by itlb miss L3 topdown metric",
+        "BriefDescription": "Idle by itlb miss L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "idle_by_itlb_miss"
+    },
+    {
+        "MetricExpr": "(((L2I_CACHE - L2I_CACHE_REFILL) * 15) + (L2I_CACHE_REFILL * 100)) / CPU_CYCLES",
+        "PublicDescription": "Idle by icache miss L3 topdown metric",
+        "BriefDescription": "Idle by icache miss L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "idle_by_icache_miss"
+    },
+    {
+        "MetricExpr": "(BR_MIS_PRED * 5) / CPU_CYCLES",
+        "PublicDescription": "BP misp flush L3 topdown metric",
+        "BriefDescription": "BP misp flush L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "bp_misp_flush"
+    },
+    {
+        "MetricExpr": "(armv8_pmuv3_0@event\\=0x2013@ * 5) / CPU_CYCLES",
+        "PublicDescription": "OOO flush L3 topdown metric",
+        "BriefDescription": "OOO flush L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "ooo_flush"
+    },
+    {
+        "MetricExpr": "(armv8_pmuv3_0@event\\=0x1001@ * 5) / CPU_CYCLES",
+        "PublicDescription": "Static predictor flush L3 topdown metric",
+        "BriefDescription": "Static predictor flush L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "sp_flush"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x1010@ / BR_MIS_PRED",
+        "PublicDescription": "Indirect branch L3 topdown metric",
+        "BriefDescription": "Indirect branch L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "indirect_branch"
+    },
+    {
+        "MetricExpr": "(armv8_pmuv3_0@event\\=0x1014@ + armv8_pmuv3_0@event\\=0x1018@) / BR_MIS_PRED",
+        "PublicDescription": "Push branch L3 topdown metric",
+        "BriefDescription": "Push branch L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "push_branch"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x100c@ / BR_MIS_PRED",
+        "PublicDescription": "Pop branch L3 topdown metric",
+        "BriefDescription": "Pop branch L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "pop_branch"
+    },
+    {
+        "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1014@ - armv8_pmuv3_0@event\\=0x1018@ - armv8_pmuv3_0@event\\=0x100c@) / BR_MIS_PRED",
+        "PublicDescription": "Other branch L3 topdown metric",
+        "BriefDescription": "Other branch L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "other_branch"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x2012@ / armv8_pmuv3_0@event\\=0x2013@",
+        "PublicDescription": "Nuke flush L3 topdown metric",
+        "BriefDescription": "Nuke flush L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "nuke_flush"
+    },
+    {
+        "MetricExpr": "1 - nuke_flush",
+        "PublicDescription": "Other flush L3 topdown metric",
+        "BriefDescription": "Other flush L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "other_flush"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x2010@ / CPU_CYCLES",
+        "PublicDescription": "Sync stall L3 topdown metric",
+        "BriefDescription": "Sync stall L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "sync_stall"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x2004@ / CPU_CYCLES",
+        "PublicDescription": "Rob stall L3 topdown metric",
+        "BriefDescription": "Rob stall L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "rob_stall"
+    },
+    {
+        "MetricExpr": "(armv8_pmuv3_0@event\\=0x2006@ + armv8_pmuv3_0@event\\=0x2007@ + armv8_pmuv3_0@event\\=0x2008@) / CPU_CYCLES",
+        "PublicDescription": "Ptag stall L3 topdown metric",
+        "BriefDescription": "Ptag stall L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "ptag_stall"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x201e@ / CPU_CYCLES",
+        "PublicDescription": "SaveOpQ stall L3 topdown metric",
+        "BriefDescription": "SaveOpQ stall L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "saveopq_stall"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x2005@ / CPU_CYCLES",
+        "PublicDescription": "PC buffer stall L3 topdown metric",
+        "BriefDescription": "PC buffer stall L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "pc_buffer_stall"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x7002@ / CPU_CYCLES",
+        "PublicDescription": "Divider L3 topdown metric",
+        "BriefDescription": "Divider L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "divider"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x7003@ / CPU_CYCLES",
+        "PublicDescription": "FSU stall L3 topdown metric",
+        "BriefDescription": "FSU stall L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "fsu_stall"
+    },
+    {
+        "MetricExpr": "core_bound - divider - fsu_stall",
+        "PublicDescription": "EXE ports util L3 topdown metric",
+        "BriefDescription": "EXE ports util L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "exe_ports_util"
+    },
+    {
+        "MetricExpr": "(MEM_STALL_ANYLOAD - MEM_STALL_L1MISS) / CPU_CYCLES",
+        "PublicDescription": "L1 bound L3 topdown metric",
+        "BriefDescription": "L1 bound L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "l1_bound"
+    },
+    {
+        "MetricExpr": "(MEM_STALL_L1MISS - MEM_STALL_L2MISS) / CPU_CYCLES",
+        "PublicDescription": "L2 bound L3 topdown metric",
+        "BriefDescription": "L2 bound L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "l2_bound"
+    },
+    {
+        "MetricExpr": "MEM_STALL_L2MISS / CPU_CYCLES",
+        "PublicDescription": "Mem bound L3 topdown metric",
+        "BriefDescription": "Mem bound L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "mem_bound"
+    },
+    {
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x7005@ / CPU_CYCLES",
+        "PublicDescription": "Store bound L3 topdown metric",
+        "BriefDescription": "Store bound L3 topdown metric",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "store_bound"
+    },
 ]
-- 
2.26.2

