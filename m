Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5F3650B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhDTDQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:16:03 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35351 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhDTDPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:15:50 -0400
Received: by mail-ot1-f45.google.com with SMTP id 35-20020a9d05260000b029029c82502d7bso3187589otw.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPb96bCHO6UBQ4SB1KTZWZUP+l1ge4k8NJIqqRrSe1w=;
        b=DQ1dDLne0feXDx1lLfJJSzZq8H4xtaYF6WqXM737EO5TuNU/DTxLR8/S4Z+E4xhHkE
         6I4s/CtwY1XguSvfvIbVlclAttNMw3/vAklK9AdJhcO/eYivo2e3rN9cfa5BcJY96sZl
         fG+XRDu9fWuO68NHDjCVy7v/aMvy83StE+9t/YH7uPkS6f8D+hpMkD3zHF2O+9kRDWmv
         3tMf/r3AS0hJyPfkgV/wceH0xBk+WW07qNSi27uA1LsUqq/nO5S9PT1mw3JfBKXbJIdS
         h0vsRBcECJGaYEwHLKrWUp60cw2jibseI+G/W4OThn4HwPp8RzkkwU+oAAmarVoWV0Vf
         kIsQ==
X-Gm-Message-State: AOAM532iikd2COydUcfED/RhNbFqAgiJmtQGSTZ+KZewGIREQO3Gswb4
        P71cyqnCGAgRZxj8LChmAw==
X-Google-Smtp-Source: ABdhPJyeGBptuBpD92o4w8ME0ak/mPYETiphPeHOVcANjz37HXYWDibOXVrT63Eg8K09NmajALzqXQ==
X-Received: by 2002:a9d:5541:: with SMTP id h1mr16502380oti.246.1618888519233;
        Mon, 19 Apr 2021 20:15:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/9] arm64: perf: Enable PMU counter direct access for perf event
Date:   Mon, 19 Apr 2021 22:15:05 -0500
Message-Id: <20210420031511.2348977-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Keep track of event opened with direct access to the hardware counters
and modify permissions while they are open.

The strategy used here is the same which x86 uses: every time an event
is mapped, the permissions are set if required. The atomic field added
in the mm_context helps keep track of the different event opened and
de-activate the permissions when all are unmapped.
We also need to update the permissions in the context switch code so
that tasks keep the right permissions.

In order to enable 64-bit counters for userspace when available, a new
config1 bit is added for userspace to indicate it wants userspace counter
access. This bit allows the kernel to decide if chaining should be
disabled and chaining and userspace access are incompatible.
The modes for config1 are as follows:

config1 = 0 or 2 : user access enabled and always 32-bit
config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
config1 = 3 : user access enabled and counter size matches underlying counter.

User access is enabled with config1 == 0 so that we match x86 behavior
and don't need Arm specific code (outside the counter read).

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Peter Z says (event->oncpu == smp_processor_id()) in the user page
update is always true, but my testing says otherwise[1].

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
 arch/arm64/include/asm/mmu.h   |   5 +
 arch/arm64/kernel/perf_event.c | 179 +++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |   6 ++
 3 files changed, 183 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 75beffe2ee8a..ee08447455da 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,11 @@
 
 typedef struct {
 	atomic64_t	id;
+	/*
+	 * non-zero if userspace have access to hardware
+	 * counters directly.
+	 */
+	atomic_t	pmu_direct_access;
 #ifdef CONFIG_COMPAT
 	void		*sigpage;
 #endif
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 40cf59455ce8..bfbb7f449aca 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -8,9 +8,11 @@
  * This code is based heavily on the ARMv7 perf event code.
  */
 
+#include <asm/cpu.h>
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
 #include <asm/sysreg.h>
+#include <asm/traps.h>
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -288,15 +290,22 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 
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
 
@@ -344,6 +353,15 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 	return (cpu_pmu->pmuver >= ID_AA64DFR0_PMUVER_8_5);
 }
 
+static inline bool armv8pmu_event_can_chain(struct perf_event *event)
+{
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+
+	return !armv8pmu_event_want_user_access(event) &&
+	       armv8pmu_event_is_64bit(event) &&
+	       !armv8pmu_has_long_event(cpu_pmu);
+}
+
 /*
  * We must chain two programmable counters for 64 bit events,
  * except when we have allocated the 64bit cycle counter (for CPU
@@ -353,11 +371,9 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
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
 
@@ -689,6 +705,17 @@ static inline u32 armv8pmu_getreset_flags(void)
 	return value;
 }
 
+static void armv8pmu_disable_user_access(void *mm)
+{
+	if (!mm || (mm == current->active_mm))
+		write_sysreg(0, pmuserenr_el0);
+}
+
+static void armv8pmu_enable_user_access(void)
+{
+	write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR, pmuserenr_el0);
+}
+
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	/*
@@ -849,13 +876,16 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -866,9 +896,12 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 {
 	int idx = event->hw.idx;
 
+	set_bit(idx, cpuc->dirty_mask);
 	clear_bit(idx, cpuc->used_mask);
-	if (armv8pmu_event_is_chained(event))
+	if (armv8pmu_event_is_chained(event)) {
+		set_bit(idx - 1, cpuc->dirty_mask);
 		clear_bit(idx - 1, cpuc->used_mask);
+	}
 }
 
 static int armv8pmu_access_event_idx(struct perf_event *event)
@@ -887,6 +920,86 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void armv8pmu_clear_dirty_counters(struct arm_pmu *armpmu)
+{
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
+	int i;
+
+	 /* Don't need to clear the assigned counter. */
+	for_each_set_bit(i, hw_events->used_mask, ARMPMU_MAX_HWEVENTS)
+		clear_bit(i, hw_events->dirty_mask);
+
+	if (bitmap_empty(hw_events->dirty_mask, ARMPMU_MAX_HWEVENTS))
+		return;
+
+	for_each_set_bit(i, hw_events->dirty_mask, ARMPMU_MAX_HWEVENTS) {
+		if (i == ARMV8_IDX_CYCLE_COUNTER)
+			write_sysreg(0, pmccntr_el0);
+		else
+			armv8pmu_write_evcntr(i, 0);
+	}
+
+	bitmap_zero(hw_events->dirty_mask, ARMPMU_MAX_HWEVENTS);
+}
+
+static void armv8pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	if (!sched_in)
+		return;
+	/*
+	 * If a new task has user access enabled, clear the dirty counters
+	 * to prevent the potential leak.
+	 */
+	if (ctx && current->mm && atomic_read(&current->mm->context.pmu_direct_access)) {
+		armv8pmu_enable_user_access();
+		armv8pmu_clear_dirty_counters(to_arm_pmu(ctx->pmu));
+	} else {
+		armv8pmu_disable_user_access(NULL);
+	}
+}
+
+static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	unsigned long flags;
+
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (atomic_inc_return(&mm->context.pmu_direct_access) != 1)
+		return;
+
+	/*
+	 * Enable sched_task() for the user access task,
+	 * and clear the existing dirty counters.
+	 */
+	local_irq_save(flags);
+
+	perf_sched_cb_inc(event->ctx->pmu);
+	if (event->hw.target)
+		armv8pmu_clear_dirty_counters(to_arm_pmu(event->pmu));
+	armv8pmu_enable_user_access();
+
+	local_irq_restore(flags);
+}
+
+static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	unsigned long flags;
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (!atomic_dec_and_test(&mm->context.pmu_direct_access))
+		return;
+
+	local_irq_save(flags);
+	perf_sched_cb_dec(event->ctx->pmu);
+	local_irq_restore(flags);
+
+	on_each_cpu_mask(&armpmu->supported_cpus, armv8pmu_disable_user_access, mm, 1);
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -980,7 +1093,19 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
-	if (armv8pmu_event_is_64bit(event))
+	if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event))
+		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
+
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
 
 	/* Only expose micro/arch events supported by this PMU */
@@ -1091,6 +1216,30 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+static int armv8pmu_undef_handler(struct pt_regs *regs, u32 insn)
+{
+	if (atomic_read(&current->mm->context.pmu_direct_access)) {
+		armv8pmu_enable_user_access();
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/* This hook will only be triggered by mrs instructions on PMU registers. */
+static struct undef_hook pmu_hook = {
+	.instr_mask = 0xffff8800,
+	.instr_val  = 0xd53b8800,
+	.fn = armv8pmu_undef_handler,
+};
+
+static int __init enable_pmu_undef_hook(void)
+{
+	register_undef_hook(&pmu_hook);
+	return 0;
+}
+core_initcall(enable_pmu_undef_hook);
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
@@ -1115,6 +1264,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
+	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
+	cpu_pmu->pmu.sched_task		= armv8pmu_sched_task;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
@@ -1290,6 +1442,19 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR) &&
+		(event->oncpu == smp_processor_id());
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
index d29aa981d989..63af052e3909 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -56,6 +56,12 @@ struct pmu_hw_events {
 	 */
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
 
+	/*
+	 * A 1 bit for an index indicates that the counter was used for an
+	 * event and has not been cleared. A 0 means that the counter is cleared.
+	 */
+	DECLARE_BITMAP(dirty_mask, ARMPMU_MAX_HWEVENTS);
+
 	/*
 	 * Hardware lock to serialize accesses to PMU registers. Needed for the
 	 * read/modify/write sequences.
-- 
2.27.0

