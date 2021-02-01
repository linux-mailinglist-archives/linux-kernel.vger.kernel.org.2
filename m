Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992ED30A667
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBALVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:21:50 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:21069 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhBALVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:21:46 -0500
IronPort-SDR: TFztpMdjKbl3mGG5n+bBwDt6vkknP3d4ODicaL913yDBnQY+58/Yh5/iysx58usX7ZilicGR1R
 v+XQHHNhk17ddjYxKV313eTcf5OrYN56tQFs93xsmx89Ibjb1eX+ckFvZQzfjZavSBpNSIqshs
 3Jnpg9ZonpyF2ayYyj0YPfJkPpajcbr9NxXlRPEwUhiEpfgyMIUx5Xmc4eqivLUYxbKcb/ns/o
 Qr7Kapy2mDKSR1Q0o9g6FOjPkmRN6ORzdeGeLG+JhPZdLLR1uK1d2+3NIAsoA32JPAa7vaA5mm
 oKk=
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="17479410"
X-IronPort-AV: E=Sophos;i="5.79,392,1602514800"; 
   d="scan'208";a="17479410"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Feb 2021 20:19:28 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 076F0EC7AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:19:27 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 587B21D95C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:19:26 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 827F51C09; Mon,  1 Feb 2021 20:13:12 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nakamura.shun@fujitsu.com,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v4 1/4] perf vendor events arm64: Add common and uarch event JSON
Date:   Mon,  1 Feb 2021 20:13:07 +0900
Message-Id: <20210201111310.3231469-2-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
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

