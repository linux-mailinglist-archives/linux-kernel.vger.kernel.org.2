Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC436330BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCHKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:54:12 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:62174 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230323AbhCHKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:53:51 -0500
IronPort-SDR: JcoAtY7PkjQXR174m+Tk9MKEhQcI4bZdIhfRylA5l7Ea3uZ0y147aQYqIfliB+iTgHH0LmXlJB
 hDeBKjaO+iAPLhlP+vEPiS5Pj7IQ9zwr3xiUmQkQw8XOA+HHmmPPmS799BFztsn6Vn6xmzmX1W
 Xbekx2OP8BashMJRoYi1xEDZkVOFr9ph4xJa7AoKJ3NAm8U5yUgPXkB+tKir/eCgmvqw412xjO
 vSq0g/+jZh+2mAyMCCiqJe8iS+Wm6cLu3U4PZHyuoa/YuvFUJ3ZjTNpqzm5QlVZObF27+8W+CQ
 ShY=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="22144090"
X-IronPort-AV: E=Sophos;i="5.81,232,1610377200"; 
   d="scan'208";a="22144090"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 08 Mar 2021 19:53:48 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 871F5A80C1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:53:47 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D76C2C9CEA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:53:46 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id CEFFE4005E9C0;
        Mon,  8 Mar 2021 19:53:46 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/2] perf vendor events arm64: Add more common and uarch events
Date:   Mon,  8 Mar 2021 19:53:40 +0900
Message-Id: <20210308105342.746940-2-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308105342.746940-1-nakamura.shun@fujitsu.com>
References: <20210308105342.746940-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following events.[1]

Common architectural events:
  - L2I_TLB_REFILL
  - L2I_TLB
  - SIMD_INST_RETIRED
  - SVE_INST_RETIRED

Common microarchitectural events:
  - UOP_SPEC
  - SVE_MATH_SPEC
  - FP_SPEC
  - FP_FMA_SPEC
  - FP_RECPE_SPEC
  - FP_CVT_SPEC
  - ASE_SVE_INT_SPEC
  - SVE_PRED_SPEC
  - SVE_MOVPRFX_SPEC
  - SVE_MOVPRFX_U_SPEC
  - ASE_SVE_LD_SPEC
  - ASE_SVE_ST_SPEC
  - PRF_SPEC
  - BASE_LD_REG_SPEC
  - BASE_ST_REG_SPEC
  - SVE_LDR_REG_SPEC
  - SVE_STR_REG_SPEC
  - SVE_LDR_PREG_SPEC
  - SVE_STR_PREG_SPEC
  - SVE_PRF_CONTIG_SPEC
  - ASE_SVE_LD_MULTI_SPEC
  - ASE_SVE_ST_MULTI_SPEC
  - SVE_LD_GATHER_SPEC
  - SVE_ST_SCATTER_SPEC
  - SVE_PRF_GATHER_SPEC
  - SVE_LDFF_SPEC
  - FP_SCALE_OPS_SPEC
  - FP_FIXED_OPS_SPEC
  - FP_HP_SCALE_OPS_SPEC
  - FP_HP_FIXED_OPS_SPEC
  - FP_SP_SCALE_OPS_SPEC
  - FP_SP_FIXED_OPS_SPEC
  - FP_DP_SCALE_OPS_SPEC
  - FP_DP_FIXED_OPS_SPEC

Reference document is at the following:
[1] https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_PMU_Events_v1.2.pdf

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 .../arm64/armv8-common-and-microarch.json     | 228 ++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
index 75376c7cc072..913fb200ea52 100644
--- a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
@@ -209,12 +209,24 @@
         "EventName": "L2D_TLB_REFILL",
         "BriefDescription": "Attributable Level 2 data TLB refill"
     },
+    {
+        "PublicDescription": "Attributable Level 2 instruction TLB refill.",
+        "EventCode": "0x2E",
+        "EventName": "L2I_TLB_REFILL",
+        "BriefDescription": "Attributable Level 2 instruction TLB refill."
+    },
     {
         "PublicDescription": "Attributable Level 2 data or unified TLB access",
         "EventCode": "0x2F",
         "EventName": "L2D_TLB",
         "BriefDescription": "Attributable Level 2 data or unified TLB access"
     },
+    {
+        "PublicDescription": "Attributable Level 2 instruction TLB access.",
+        "EventCode": "0x30",
+        "EventName": "L2I_TLB",
+        "BriefDescription": "Attributable Level 2 instruction TLB access."
+    },
     {
         "PublicDescription": "Access to another socket in a multi-socket system",
         "EventCode": "0x31",
@@ -244,5 +256,221 @@
         "EventCode": "0x37",
         "EventName": "LL_CACHE_MISS_RD",
         "BriefDescription": "Last level cache miss, read"
+    },
+    {
+        "PublicDescription": "SIMD Instruction architecturally executed.",
+        "EventCode": "0x8000",
+        "EventName": "SIMD_INST_RETIRED",
+        "BriefDescription": "SIMD Instruction architecturally executed."
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, SVE.",
+        "EventCode": "0x8002",
+        "EventName": "SVE_INST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, SVE."
+    },
+    {
+        "PublicDescription": "Microarchitectural operation, Operations speculatively executed.",
+        "EventCode": "0x8008",
+        "EventName": "UOP_SPEC",
+        "BriefDescription": "Microarchitectural operation, Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE Math accelerator Operations speculatively executed.",
+        "EventCode": "0x800E",
+        "EventName": "SVE_MATH_SPEC",
+        "BriefDescription": "SVE Math accelerator Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Floating-point Operations speculatively executed.",
+        "EventCode": "0x8010",
+        "EventName": "FP_SPEC",
+        "BriefDescription": "Floating-point Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Floating-point FMA Operations speculatively executed.",
+        "EventCode": "0x8028",
+        "EventName": "FP_FMA_SPEC",
+        "BriefDescription": "Floating-point FMA Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Floating-point reciprocal estimate Operations speculatively executed.",
+        "EventCode": "0x8034",
+        "EventName": "FP_RECPE_SPEC",
+        "BriefDescription": "Floating-point reciprocal estimate Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "floating-point convert Operations speculatively executed.",
+        "EventCode": "0x8038",
+        "EventName": "FP_CVT_SPEC",
+        "BriefDescription": "floating-point convert Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE integer Operations speculatively executed.",
+        "EventCode": "0x8043",
+        "EventName": "ASE_SVE_INT_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE integer Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE predicated Operations speculatively executed.",
+        "EventCode": "0x8074",
+        "EventName": "SVE_PRED_SPEC",
+        "BriefDescription": "SVE predicated Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE MOVPRFX Operations speculatively executed.",
+        "EventCode": "0x807C",
+        "EventName": "SVE_MOVPRFX_SPEC",
+        "BriefDescription": "SVE MOVPRFX Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE MOVPRFX unfused Operations speculatively executed.",
+        "EventCode": "0x807F",
+        "EventName": "SVE_MOVPRFX_U_SPEC",
+        "BriefDescription": "SVE MOVPRFX unfused Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE load Operations speculatively executed.",
+        "EventCode": "0x8085",
+        "EventName": "ASE_SVE_LD_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE load Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE store Operations speculatively executed.",
+        "EventCode": "0x8086",
+        "EventName": "ASE_SVE_ST_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE store Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Prefetch Operations speculatively executed.",
+        "EventCode": "0x8087",
+        "EventName": "PRF_SPEC",
+        "BriefDescription": "Prefetch Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "General-purpose register load Operations speculatively executed.",
+        "EventCode": "0x8089",
+        "EventName": "BASE_LD_REG_SPEC",
+        "BriefDescription": "General-purpose register load Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "General-purpose register store Operations speculatively executed.",
+        "EventCode": "0x808A",
+        "EventName": "BASE_ST_REG_SPEC",
+        "BriefDescription": "General-purpose register store Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE unpredicated load register Operations speculatively executed.",
+        "EventCode": "0x8091",
+        "EventName": "SVE_LDR_REG_SPEC",
+        "BriefDescription": "SVE unpredicated load register Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE unpredicated store register Operations speculatively executed.",
+        "EventCode": "0x8092",
+        "EventName": "SVE_STR_REG_SPEC",
+        "BriefDescription": "SVE unpredicated store register Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE load predicate register Operations speculatively executed.",
+        "EventCode": "0x8095",
+        "EventName": "SVE_LDR_PREG_SPEC",
+        "BriefDescription": "SVE load predicate register Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE store predicate register Operations speculatively executed.",
+        "EventCode": "0x8096",
+        "EventName": "SVE_STR_PREG_SPEC",
+        "BriefDescription": "SVE store predicate register Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE contiguous prefetch element Operations speculatively executed.",
+        "EventCode": "0x809F",
+        "EventName": "SVE_PRF_CONTIG_SPEC",
+        "BriefDescription": "SVE contiguous prefetch element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE contiguous load multiple vector Operations speculatively executed.",
+        "EventCode": "0x80A5",
+        "EventName": "ASE_SVE_LD_MULTI_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE contiguous load multiple vector Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE contiguous store multiple vector Operations speculatively executed.",
+        "EventCode": "0x80A6",
+        "EventName": "ASE_SVE_ST_MULTI_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE contiguous store multiple vector Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE gather-load Operations speculatively executed.",
+        "EventCode": "0x80AD",
+        "EventName": "SVE_LD_GATHER_SPEC",
+        "BriefDescription": "SVE gather-load Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE scatter-store Operations speculatively executed.",
+        "EventCode": "0x80AE",
+        "EventName": "SVE_ST_SCATTER_SPEC",
+        "BriefDescription": "SVE scatter-store Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE gather-prefetch Operations speculatively executed.",
+        "EventCode": "0x80AF",
+        "EventName": "SVE_PRF_GATHER_SPEC",
+        "BriefDescription": "SVE gather-prefetch Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "SVE First-fault load Operations speculatively executed.",
+        "EventCode": "0x80BC",
+        "EventName": "SVE_LDFF_SPEC",
+        "BriefDescription": "SVE First-fault load Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Scalable floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C0",
+        "EventName": "FP_SCALE_OPS_SPEC",
+        "BriefDescription": "Scalable floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Non-scalable floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C1",
+        "EventName": "FP_FIXED_OPS_SPEC",
+        "BriefDescription": "Non-scalable floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Scalable half-precision floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C2",
+        "EventName": "FP_HP_SCALE_OPS_SPEC",
+        "BriefDescription": "Scalable half-precision floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Non-scalable half-precision floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C3",
+        "EventName": "FP_HP_FIXED_OPS_SPEC",
+        "BriefDescription": "Non-scalable half-precision floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Scalable single-precision floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C4",
+        "EventName": "FP_SP_SCALE_OPS_SPEC",
+        "BriefDescription": "Scalable single-precision floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Non-scalable single-precision floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C5",
+        "EventName": "FP_SP_FIXED_OPS_SPEC",
+        "BriefDescription": "Non-scalable single-precision floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Scalable double-precision floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C6",
+        "EventName": "FP_DP_SCALE_OPS_SPEC",
+        "BriefDescription": "Scalable double-precision floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Non-scalable double-precision floating-point element Operations speculatively executed.",
+        "EventCode": "0x80C7",
+        "EventName": "FP_DP_FIXED_OPS_SPEC",
+        "BriefDescription": "Non-scalable double-precision floating-point element Operations speculatively executed."
     }
 ]
-- 
2.25.1

