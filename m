Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7980030BEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhBBNAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:00:31 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:51416 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230229AbhBBNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:00:18 -0500
IronPort-SDR: IxdQMYZjgfVRgXOaC0IiWQB33nPnrD4NNlG1NMBFba5anj5QieMcD5L2c+eNhpIU5rvXRucsjI
 3SmNdugOKdOhiUEd0OUVNiHZKB3JqG17BQjxOlp6ETILkpxigg8aewo5r4U9qliGqVHzzlgA/A
 ORWwoQEkq7YSbbqpWNzpBkVP2VgLiTQ0DNshajhOwNge5NuVfCUbIhB+N5HHhjhXK4wzFJGbc6
 uzjgXVBsdmy3LBEDGTCR61QtNflBc3VZ5Gfg/yGCoBP6W2tTHE17IEojwbN3wjL0LrwbDeWGic
 Es8=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="5700944"
X-IronPort-AV: E=Sophos;i="5.79,395,1602514800"; 
   d="scan'208";a="5700944"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Feb 2021 21:57:58 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 01D391F5073
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:57:58 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E2019B623
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:57:57 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id AD2985069; Tue,  2 Feb 2021 21:51:40 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v5 1/4] perf vendor events arm64: Add common and uarch event JSON
Date:   Tue,  2 Feb 2021 21:51:37 +0900
Message-Id: <20210202125140.1785583-2-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common and microarch JSON, which can be referenced from CPU JSONs.

For now, brief and public description are as event brief event
description from the ARMv8 ARM [0], D7-11.

The list of events is not complete, as not all events will be referenced
yet.

Reference document is at the following:
[0] https://documentation-service.arm.com/static/5fa3bd1eb209f547eebd4141?token=

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/armv8-common-and-microarch.json     | 248 +++++++++++++++++++++
 1 file changed, 248 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
new file mode 100644
index 0000000..75376c7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
@@ -0,0 +1,248 @@
+[
+    {
+        "PublicDescription": "Instruction architecturally executed, Condition code check pass, software increment",
+        "EventCode": "0x00",
+        "EventName": "SW_INCR",
+        "BriefDescription": "Instruction architecturally executed, Condition code check pass, software increment"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache refill",
+        "EventCode": "0x01",
+        "EventName": "L1I_CACHE_REFILL",
+        "BriefDescription": "Level 1 instruction cache refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 instruction TLB refill",
+        "EventCode": "0x02",
+        "EventName": "L1I_TLB_REFILL",
+        "BriefDescription": "Attributable Level 1 instruction TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 data cache refill",
+        "EventCode": "0x03",
+        "EventName": "L1D_CACHE_REFILL",
+        "BriefDescription": "Level 1 data cache refill"
+    },
+    {
+        "PublicDescription": "Level 1 data cache access",
+        "EventCode": "0x04",
+        "EventName": "L1D_CACHE",
+        "BriefDescription": "Level 1 data cache access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill",
+        "EventCode": "0x05",
+        "EventName": "L1D_TLB_REFILL",
+        "BriefDescription": "Attributable Level 1 data TLB refill"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed",
+        "EventCode": "0x08",
+        "EventName": "INST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed"
+    },
+    {
+        "PublicDescription": "Exception taken",
+        "EventCode": "0x09",
+        "EventName": "EXC_TAKEN",
+        "BriefDescription": "Exception taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition check pass, exception return",
+        "EventCode": "0x0a",
+        "EventName": "EXC_RETURN",
+        "BriefDescription": "Instruction architecturally executed, condition check pass, exception return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR",
+        "EventCode": "0x0b",
+        "EventName": "CID_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR"
+    },
+    {
+        "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
+        "EventCode": "0x10",
+        "EventName": "BR_MIS_PRED",
+        "BriefDescription": "Mispredicted or not predicted branch speculatively executed"
+    },
+    {
+        "PublicDescription": "Cycle",
+        "EventCode": "0x11",
+        "EventName": "CPU_CYCLES",
+        "BriefDescription": "Cycle"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed",
+        "EventCode": "0x12",
+        "EventName": "BR_PRED",
+        "BriefDescription": "Predictable branch speculatively executed"
+    },
+    {
+        "PublicDescription": "Data memory access",
+        "EventCode": "0x13",
+        "EventName": "MEM_ACCESS",
+        "BriefDescription": "Data memory access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 instruction cache access",
+        "EventCode": "0x14",
+        "EventName": "L1I_CACHE",
+        "BriefDescription": "Attributable Level 1 instruction cache access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache write-back",
+        "EventCode": "0x15",
+        "EventName": "L1D_CACHE_WB",
+        "BriefDescription": "Attributable Level 1 data cache write-back"
+    },
+    {
+        "PublicDescription": "Level 2 data cache access",
+        "EventCode": "0x16",
+        "EventName": "L2D_CACHE",
+        "BriefDescription": "Level 2 data cache access"
+    },
+    {
+        "PublicDescription": "Level 2 data refill",
+        "EventCode": "0x17",
+        "EventName": "L2D_CACHE_REFILL",
+        "BriefDescription": "Level 2 data refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data cache write-back",
+        "EventCode": "0x18",
+        "EventName": "L2D_CACHE_WB",
+        "BriefDescription": "Attributable Level 2 data cache write-back"
+    },
+    {
+        "PublicDescription": "Attributable Bus access",
+        "EventCode": "0x19",
+        "EventName": "BUS_ACCESS",
+        "BriefDescription": "Attributable Bus access"
+    },
+    {
+        "PublicDescription": "Local memory error",
+        "EventCode": "0x1a",
+        "EventName": "MEMORY_ERROR",
+        "BriefDescription": "Local memory error"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed",
+        "EventCode": "0x1b",
+        "EventName": "INST_SPEC",
+        "BriefDescription": "Operation speculatively executed"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, Condition code check pass, write to TTBR",
+        "EventCode": "0x1c",
+        "EventName": "TTBR_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, Condition code check pass, write to TTBR"
+    },
+    {
+        "PublicDescription": "Bus cycle",
+        "EventCode": "0x1D",
+        "EventName": "BUS_CYCLES",
+        "BriefDescription": "Bus cycle"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data cache allocation without refill",
+        "EventCode": "0x20",
+        "EventName": "L2D_CACHE_ALLOCATE",
+        "BriefDescription": "Attributable Level 2 data cache allocation without refill"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, branch",
+        "EventCode": "0x21",
+        "EventName": "BR_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted branch",
+        "EventCode": "0x22",
+        "EventName": "BR_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted branch"
+    },
+    {
+        "PublicDescription": "No operation issued because of the frontend",
+        "EventCode": "0x23",
+        "EventName": "STALL_FRONTEND",
+        "BriefDescription": "No operation issued because of the frontend"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend",
+        "EventCode": "0x24",
+        "EventName": "STALL_BACKEND",
+        "BriefDescription": "No operation issued due to the backend"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access",
+        "EventCode": "0x25",
+        "EventName": "L1D_TLB",
+        "BriefDescription": "Attributable Level 1 data or unified TLB access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 instruction TLB access",
+        "EventCode": "0x26",
+        "EventName": "L1I_TLB",
+        "BriefDescription": "Attributable Level 1 instruction TLB access"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 data cache allocation without refill",
+        "EventCode": "0x29",
+        "EventName": "L3D_CACHE_ALLOCATE",
+        "BriefDescription": "Attributable Level 3 data cache allocation without refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 data cache refill",
+        "EventCode": "0x2A",
+        "EventName": "L3D_CACHE_REFILL",
+        "BriefDescription": "Attributable Level 3 data cache refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 data cache access",
+        "EventCode": "0x2B",
+        "EventName": "L3D_CACHE",
+        "BriefDescription": "Attributable Level 3 data cache access"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data TLB refill",
+        "EventCode": "0x2D",
+        "EventName": "L2D_TLB_REFILL",
+        "BriefDescription": "Attributable Level 2 data TLB refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data or unified TLB access",
+        "EventCode": "0x2F",
+        "EventName": "L2D_TLB",
+        "BriefDescription": "Attributable Level 2 data or unified TLB access"
+    },
+    {
+        "PublicDescription": "Access to another socket in a multi-socket system",
+        "EventCode": "0x31",
+        "EventName": "REMOTE_ACCESS",
+        "BriefDescription": "Access to another socket in a multi-socket system"
+    },
+    {
+        "PublicDescription": "Access to data TLB causes a translation table walk",
+        "EventCode": "0x34",
+        "EventName": "DTLB_WALK",
+        "BriefDescription": "Access to data TLB causes a translation table walk"
+    },
+    {
+        "PublicDescription": "Access to instruction TLB that causes a translation table walk",
+        "EventCode": "0x35",
+        "EventName": "ITLB_WALK",
+        "BriefDescription": "Access to instruction TLB that causes a translation table walk"
+    },
+    {
+        "PublicDescription": "Attributable Last level cache memory read",
+        "EventCode": "0x36",
+        "EventName": "LL_CACHE_RD",
+        "BriefDescription": "Attributable Last level cache memory read"
+    },
+    {
+        "PublicDescription": "Last level cache miss, read",
+        "EventCode": "0x37",
+        "EventName": "LL_CACHE_MISS_RD",
+        "BriefDescription": "Last level cache miss, read"
+    }
+]
-- 
1.8.3.1

