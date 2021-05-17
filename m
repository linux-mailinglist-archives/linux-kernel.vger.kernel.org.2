Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694A6383DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbhEQTzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:55:40 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:36820 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhEQTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:55:31 -0400
Received: by mail-oo1-f45.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so1730531ool.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXkctgCwm/IAdi2ZLHTIL1knInQKvU+i/vax1sYN2Gs=;
        b=Jvl4428QyTPor61+bu7KatXWcb9TJqApLoMKAjvRiHXgpmY9tcs7EgqAOBgfTaYGPP
         LPPzxUhEJCdnyGydVP4Mnn2JnQBeU3LO8Q1f4YzkMhvcfoz8y5ezKYpPsRyE05lTai2S
         MjDd4R2R35XHxl+QyPA0+vQp7aP64PusPPMaQ6zLGqm8dmip/T+tUug9o6eWXIj5Xk5U
         pph9p0PupXlZJg1Aq2fWuY+jwWeTpcb09PWWt6iYD3+TSf+YIG7fJP2IR0tVDNGvnK+V
         8NGRMOh1VRBdTA8GHMBn2rlAjMhnv9QLj7/gH81l24KVjcpteSrrMlE5DS2rZGuinlMv
         YEaw==
X-Gm-Message-State: AOAM532xbERJqAOE1N7CONLk+YUG/+kp5uwIHsDTTHvDMiLlg4gTf7vj
        xttdkdLGWYoRmQKUGeYklQ==
X-Google-Smtp-Source: ABdhPJx2d/scCNWjel+JJJBazUxlF68gm7rbRyFg4gXapgS6sCVM6dW2+qSxLZ34Rq/Ei0GwO+nPNA==
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr1239536oos.85.1621281253717;
        Mon, 17 May 2021 12:54:13 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m81sm2920758oig.43.2021.05.17.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:54:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/5] arm64: perf: Enable PMU counter userspace access for perf event
Date:   Mon, 17 May 2021 14:54:03 -0500
Message-Id: <20210517195405.3079458-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517195405.3079458-1-robh@kernel.org>
References: <20210517195405.3079458-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm PMUs can support direct userspace access of counters which allows for
low overhead (i.e. no syscall) self-monitoring of tasks. The same feature
exists on x86 called 'rdpmc'. Unlike x86, userspace access will only be
enabled for thread bound events. This could be extended if needed, but
simplifies the implementation and reduces the chances for any
information leaks (which the x86 implementation suffers from).

When an event is capable of userspace access and has been mmapped, userspace
access is enabled when the event is scheduled on a CPU's PMU. There's some
additional overhead clearing counters when disabled in order to prevent
leaking disabled counter data from other tasks.

Unlike x86, enabling of userspace access must be requested with a new
attr bit: config1:1. If the user requests userspace access and 64-bit
counters, then chaining will be disabled and the user will get the
maximum size counter the underlying h/w can support. The modes for
config1 are as follows:

config1 = 0 : user access disabled and always 32-bit
config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
config1 = 2 : user access enabled and always 32-bit
config1 = 3 : user access enabled and counter size matches underlying counter.

Based on work by Raphael Gault <raphael.gault@arm.com>, but has been
completely re-written.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v8:
 - Rework user access tracking and enabling to be done on task
   context changes using sched_task() hook. This avoids the need for any
   IPIs, mm_switch hooks or undef instr handler.
 - Only support user access when explicitly requested on open and
   only for a thread bound events. This avoids some of the information
   leaks x86 has and simplifies the implementation.

v7:
 - Clear disabled counters when user access is enabled for a task to
   avoid leaking other tasks counter data.
 - Rework context switch handling utilizing sched_task callback
 - Add armv8pmu_event_can_chain() helper
 - Rework config1 flags handling structure
 - Use ARMV8_IDX_CYCLE_COUNTER_USER define for remapped user cycle
   counter index

v6:
 - Add new attr.config1 rdpmc bit for userspace to hint it wants
   userspace access when also requesting 64-bit counters.

v5:
 - Only set cap_user_rdpmc if event is on current cpu
 - Limit enabling/disabling access to CPUs associated with the PMU
   (supported_cpus) and with the mm_struct matching current->active_mm.

v2:
 - Move mapped/unmapped into arm64 code. Fixes arm32.
 - Rebase on cap_user_time_short changes

Changes from Raphael's v4:
  - Drop homogeneous check
  - Disable access for chained counters
  - Set pmc_width in user page

[1] https://lore.kernel.org/lkml/CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com/
---
 arch/arm64/kernel/perf_event.c | 141 +++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |   7 ++
 2 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f594957e29bd..dc79cf7b58ee 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -288,15 +288,22 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
+PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
 	return event->attr.config1 & 0x1;
 }
 
+static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
+{
+	return event->attr.config1 & 0x2;
+}
+
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_long.attr,
+	&format_attr_rdpmc.attr,
 	NULL,
 };
 
@@ -332,7 +339,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 #define	ARMV8_IDX_CYCLE_COUNTER	0
 #define	ARMV8_IDX_COUNTER0	1
-
+#define	ARMV8_IDX_CYCLE_COUNTER_USER	32
 
 /*
  * We unconditionally enable ARMv8.5-PMU long event counter support
@@ -344,6 +351,15 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 	return (cpu_pmu->pmuver >= ID_AA64DFR0_PMUVER_8_5);
 }
 
+static inline bool armv8pmu_event_can_chain(struct perf_event *event)
+{
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+
+	return !(event->hw.flags & ARMPMU_EL0_RD_CNTR) &&
+	       armv8pmu_event_is_64bit(event) &&
+	       !armv8pmu_has_long_event(cpu_pmu);
+}
+
 /*
  * We must chain two programmable counters for 64 bit events,
  * except when we have allocated the 64bit cycle counter (for CPU
@@ -353,11 +369,9 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 {
 	int idx = event->hw.idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 
 	return !WARN_ON(idx < 0) &&
-	       armv8pmu_event_is_64bit(event) &&
-	       !armv8pmu_has_long_event(cpu_pmu) &&
+	       armv8pmu_event_can_chain(event) &&
 	       (idx != ARMV8_IDX_CYCLE_COUNTER);
 }
 
@@ -688,6 +702,32 @@ static inline u32 armv8pmu_getreset_flags(void)
 	return value;
 }
 
+static void armv8pmu_disable_user_access(void)
+{
+	write_sysreg(0, pmuserenr_el0);
+}
+
+static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
+{
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
+
+	if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
+		int i;
+		/* Don't need to clear assigned counters. */
+		bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
+
+		for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
+			if (i == ARMV8_IDX_CYCLE_COUNTER)
+				write_sysreg(0, pmccntr_el0);
+			else
+				armv8pmu_write_evcntr(i, 0);
+		}
+		bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
+	}
+
+	write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
+}
+
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	/*
@@ -848,13 +888,16 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
 		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
 			return ARMV8_IDX_CYCLE_COUNTER;
+		else if (armv8pmu_event_is_64bit(event) &&
+			   armv8pmu_event_want_user_access(event) &&
+			   !armv8pmu_has_long_event(cpu_pmu))
+				return -EAGAIN;
 	}
 
 	/*
 	 * Otherwise use events counters
 	 */
-	if (armv8pmu_event_is_64bit(event) &&
-	    !armv8pmu_has_long_event(cpu_pmu))
+	if (armv8pmu_event_can_chain(event))
 		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
@@ -866,8 +909,60 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	int idx = event->hw.idx;
 
 	clear_bit(idx, cpuc->used_mask);
-	if (armv8pmu_event_is_chained(event))
+	set_bit(idx, cpuc->dirty_mask);
+	if (armv8pmu_event_is_chained(event)) {
 		clear_bit(idx - 1, cpuc->used_mask);
+		set_bit(idx - 1, cpuc->dirty_mask);
+	}
+}
+
+static int armv8pmu_access_event_idx(struct perf_event *event)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return 0;
+
+	/*
+	 * We remap the cycle counter index to 32 to
+	 * match the offset applied to the rest of
+	 * the counter indices.
+	 */
+	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
+		return ARMV8_IDX_CYCLE_COUNTER_USER;
+
+	return event->hw.idx;
+}
+
+void armv8pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	if (sched_in && atomic_read(&ctx->nr_user))
+		armv8pmu_enable_user_access(to_arm_pmu(ctx->pmu));
+	else
+		armv8pmu_disable_user_access();
+}
+
+static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
+		return;
+
+	if (atomic_inc_return(&event->ctx->nr_user) == 1) {
+		unsigned long flags;
+		atomic_inc(&event->pmu->sched_cb_usage);
+		local_irq_save(flags);
+		armv8pmu_enable_user_access(to_arm_pmu(event->pmu));
+		local_irq_restore(flags);
+	}
+}
+
+static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
+		return;
+
+	if (atomic_dec_and_test(&event->ctx->nr_user)) {
+		atomic_dec(&event->pmu->sched_cb_usage);
+		armv8pmu_disable_user_access();
+	}
 }
 
 /*
@@ -963,9 +1058,22 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
-	if (armv8pmu_event_is_64bit(event))
+	/*
+	 * At this point, the counter is not assigned. If a 64-bit counter is
+	 * requested, we must make sure the h/w has 64-bit counters if we set
+	 * the event size to 64-bit because chaining is not supported with
+	 * userspace access. This may still fail later on if the CPU cycle
+	 * counter is in use.
+	 */
+	if (armv8pmu_event_is_64bit(event) &&
+	    (!armv8pmu_event_want_user_access(event) ||
+	     armv8pmu_has_long_event(armpmu) || (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	/* Userspace counter access only enabled if requested and a per task event */
+	if (armv8pmu_event_want_user_access(event) && event->hw.target)
+		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1097,6 +1205,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
+	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
+	cpu_pmu->pmu.sched_task		= armv8pmu_sched_task;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
@@ -1271,6 +1384,18 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = !!userpg->index;
+
+	if (userpg->cap_user_rdpmc) {
+		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+
+		if (armv8pmu_event_is_64bit(event) &&
+		    (armv8pmu_has_long_event(cpu_pmu) ||
+		     (userpg->index == ARMV8_IDX_CYCLE_COUNTER_USER)))
+			userpg->pmc_width = 64;
+		else
+			userpg->pmc_width = 32;
+	}
 
 	do {
 		rd = sched_clock_read_begin(&seq);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 505480217cf1..02ab0010c6d0 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -26,6 +26,7 @@
  */
 /* Event uses a 64bit counter */
 #define ARMPMU_EVT_64BIT		1
+#define ARMPMU_EL0_RD_CNTR		2
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
@@ -54,6 +55,12 @@ struct pmu_hw_events {
 	 */
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
 
+	/*
+	 * A 1 bit for an index indicates that the counter has been used for
+	 * an event and has not been cleared.
+	 */
+	DECLARE_BITMAP(dirty_mask, ARMPMU_MAX_HWEVENTS);
+
 	/*
 	 * Hardware lock to serialize accesses to PMU registers. Needed for the
 	 * read/modify/write sequences.
-- 
2.27.0

