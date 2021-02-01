Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7274E30A9D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBAOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhBAOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:33:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221EC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/6Jhlr5rUwwDE3cJVP0+nEd2R6egrnAmrtNfNtrLC1U=; b=gixQuj9vo7YEJkllQqm0OfJjPy
        KIMHKS6zysp73ufWxas2nK28yrGPgLRBvj83o6FVfQuCDqJAH28oXyh4yyhK1E2WqLtqPoMLw3vwA
        syfX3AO0tp8f2rXYcYBj/1lAVe9CyyJBeVI/wImwJriDr+vbaMyi54u1vTU2B90wE70psZcJu897+
        afIotmMO3jNbqDI+SlY70WBkh6XYuwy2jW0+3FTyWMaGGuc0J0OlvfGGOKhW+LIoLMV97xtnTjfIU
        mWZyms7ZfhkEaOu3vIqLWriEOKgTdTBssB4imXBBWA3QEHnfmVSsa1TI3SwVrGlbBg6s8zB+v2o0w
        49lt0SIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6aFa-00DsiM-FH; Mon, 01 Feb 2021 14:32:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 891F33003D8;
        Mon,  1 Feb 2021 15:30:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F8622C2D9644; Mon,  1 Feb 2021 15:30:57 +0100 (CET)
Date:   Mon, 1 Feb 2021 15:30:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH V3 0/5] perf core PMU support for Sapphire Rapids (Kernel)
Message-ID: <YBgQoWRxpyoHDsmp@hirez.programming.kicks-ass.net>
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I made the below changes, does that work?

---

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3627,6 +3627,15 @@ static int core_pmu_hw_config(struct per
 	return intel_pmu_bts_config(event);
 }
 
+#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
+					 ((x86_pmu.num_topdown_events - 1) << 8))
+
+static bool is_available_metric_event(struct perf_event *event)
+{
+	return is_metric_event(event) &&
+		event->attr.config <= INTEL_TD_METRIC_AVAILABLE_MAX;
+}
+
 static inline bool is_mem_loads_event(struct perf_event *event)
 {
 	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0xcd, .umask=0x01);
@@ -3711,7 +3720,7 @@ static int intel_pmu_hw_config(struct pe
 		if (event->attr.config & X86_ALL_EVENT_FLAGS)
 			return -EINVAL;
 
-		if (is_metric_event(event)) {
+		if (is_available_metric_event(event)) {
 			struct perf_event *leader = event->group_leader;
 
 			/* The metric events don't support sampling. */
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -87,7 +87,14 @@ static inline bool is_topdown_count(stru
 	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
 }
 
-static inline bool is_metric_event(struct perf_event *event);
+static inline bool is_metric_event(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
+		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
+}
 
 static inline bool is_slots_event(struct perf_event *event)
 {
@@ -901,18 +908,6 @@ static struct perf_pmu_events_ht_attr ev
 struct pmu *x86_get_pmu(void);
 extern struct x86_pmu x86_pmu __read_mostly;
 
-#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
-					 ((x86_pmu.num_topdown_events - 1) << 8))
-
-static inline bool is_metric_event(struct perf_event *event)
-{
-	u64 config = event->attr.config;
-
-	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
-		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
-		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_AVAILABLE_MAX);
-}
-
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -284,10 +284,12 @@ struct x86_pmu_capability {
 #define INTEL_TD_METRIC_BAD_SPEC		0x8100	/* Bad speculation metric */
 #define INTEL_TD_METRIC_FE_BOUND		0x8200	/* FE bound metric */
 #define INTEL_TD_METRIC_BE_BOUND		0x8300	/* BE bound metric */
-#define INTEL_TD_METRIC_HEAVY_OPS		0x8400	/* Heavy Operations metric */
-#define INTEL_TD_METRIC_BR_MISPREDICT		0x8500	/* Branch Mispredict metric */
-#define INTEL_TD_METRIC_FETCH_LAT		0x8600	/* Fetch Latency metric */
-#define INTEL_TD_METRIC_MEM_BOUND		0x8700	/* Memory bound metric */
+/* Level 2 metrics */
+#define INTEL_TD_METRIC_HEAVY_OPS		0x8400  /* Heavy Operations metric */
+#define INTEL_TD_METRIC_BR_MISPREDICT		0x8500  /* Branch Mispredict metric */
+#define INTEL_TD_METRIC_FETCH_LAT		0x8600  /* Fetch Latency metric */
+#define INTEL_TD_METRIC_MEM_BOUND		0x8700  /* Memory bound metric */
+
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -908,7 +908,6 @@ enum perf_event_type {
 	 *			u32	var1_dw;
 	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
 	 *	#endif
-	 *
 	 *	 }
 	 *	}
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
@@ -1276,29 +1275,23 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
-#if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_sample_weight {
 	__u64		full;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	struct {
 		__u32	var1_dw;
 		__u16	var2_w;
 		__u16	var3_w;
 	};
-};
-
 #elif defined(__BIG_ENDIAN_BITFIELD)
-
-union perf_sample_weight {
-	__u64		full;
 	struct {
 		__u16	var3_w;
 		__u16	var2_w;
 		__u32	var1_dw;
 	};
-};
-
 #else
 #error "Unknown endianness"
 #endif
+};
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
