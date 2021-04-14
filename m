Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5877835F666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351838AbhDNOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:44:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:53050 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbhDNOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:44:49 -0400
IronPort-SDR: AUUoMhTQInf/w6xtmeh94IGqwi6SUUk2XnkF+see0S6OXHi+liQqHhM3B4Ho+sDSaTqCBEVIvi
 rr1AUpzLF2nQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181775105"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181775105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 07:44:23 -0700
IronPort-SDR: 3viz7qrRAYUYnhI/s8U7s0tCIu2N2zVuDWJISCNQqLOvgFjfoTbeji/lh49TKIfADw5H4veA/C
 oWWOMwFi9PEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="452478799"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2021 07:44:23 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, ak@linux.intel.com, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/2] perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task
Date:   Wed, 14 Apr 2021 07:36:30 -0700
Message-Id: <1618410990-21383-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618410990-21383-1-git-send-email-kan.liang@linux.intel.com>
References: <1618410990-21383-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The counter value of a perf task may leak to another RDPMC task.
For example, a perf stat task as below is running on CPU 0.

    perf stat -e 'branches,cycles' -- taskset -c 0 ./workload

In the meantime, an RDPMC task, which is also running on CPU 0, may read
the GP counters periodically. (The RDPMC task creates a fixed event,
but read four GP counters.)

    $ taskset -c 0 ./rdpmc_read_all_counters
    index 0x0 value 0x8001e5970f99
    index 0x1 value 0x8005d750edb6
    index 0x2 value 0x0
    index 0x3 value 0x0

    index 0x0 value 0x8002358e48a5
    index 0x1 value 0x8006bd1e3bc9
    index 0x2 value 0x0
    index 0x3 value 0x0

It is a potential security issue. Once the attacker knows what the other
thread is counting. The PerfMon counter can be used as a side-channel to
attack cryptosystems.

The counter value of the perf stat task leaks to the RDPMC task because
perf never clears the counter when it's stopped.

Two methods were considered to address the issue.
- Unconditionally reset the counter in x86_pmu_del(). It can bring extra
  overhead even when there is no RDPMC task running.
- Only reset the un-assigned dirty counters when the RDPMC task is
  scheduled in. The method is implemented here.

The dirty counter is a counter, on which the assigned event has been
deleted, but the counter is not reset. To track the dirty counters,
add a 'dirty' variable in the struct cpu_hw_events.

The current code doesn't reset the counter when the assigned event is
deleted. Set the corresponding bit in the 'dirty' variable in
x86_pmu_del(), if the RDPMC feature is available on the system.

The security issue can only be found with an RDPMC task. The event for
an RDPMC task requires the mmap buffer. This can be used to detect an
RDPMC task. Once the event is detected in the event_mapped(), enable
sched_task(), which is invoked in each context switch. Add a check in
the sched_task() to clear the dirty counters, when the RDPMC task is
scheduled in. Only the current un-assigned dirty counters are reset,
bacuase the RDPMC assigned dirty counters will be updated soon.

The RDPMC instruction is also supported on the older platforms. Add
sched_task() for the core_pmu. The core_pmu doesn't support large PEBS
and LBR callstack, the intel_pmu_pebs/lbr_sched_task() will be ignored.

The RDPMC is not Intel-only feature. Add the dirty counters clear code
in the X86 generic code.

After applying the patch,

        $ taskset -c 0 ./rdpmc_read_all_counters
        index 0x0 value 0x0
        index 0x1 value 0x0
        index 0x2 value 0x0
        index 0x3 value 0x0

        index 0x0 value 0x0
        index 0x1 value 0x0
        index 0x2 value 0x0
        index 0x3 value 0x0

Performance

The performance of a context switch only be impacted when there are two
or more perf users and one of the users must be an RDPMC user. In other
cases, there is no performance impact.

The worst-case occurs when there are two users: the RDPMC user only
applies one counter; while the other user applies all available
counters. When the RDPMC task is scheduled in, all the counters, other
than the RDPMC assigned one, have to be reset.

Here is the test result for the worst-case.

The test is implemented on an Ice Lake platform, which has 8 GP
counters and 3 fixed counters (Not include SLOTS counter).

The lat_ctx is used to measure the context switching time.

    lat_ctx -s 128K -N 1000 processes 2

I instrument the lat_ctx to open all 8 GP counters and 3 fixed
counters for one task. The other task opens a fixed counter and enable
RDPMC.

Without the patch:
The context switch time is 4.97 us

With the patch:
The context switch time is 5.16 us

There is ~4% performance drop for the context switching time in the
worst-case.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
Changes since V3:
- Fix warnings reported by kernel test robot <lkp@intel.com>
- Move bitmap_empty() check after clearing assigned counters.
  It should be very likely that the cpuc->dirty is non-empty.
  Move it after the clearing can skip the for_each_set_bit() and
  bitmap_zero(). 

The V2 can be found here.
https://lore.kernel.org/lkml/20200821195754.20159-3-kan.liang@linux.intel.com/

Changes since V2:
- Unconditionally set cpuc->dirty. The worst case for an RDPMC task is
  that we may have to clear all counters for the first time in
  x86_pmu_event_mapped. After that, the sched_task() will clear/update
  the 'dirty'. Only the real 'dirty' counters are clear. For a non-RDPMC
  task, it's harmless to unconditionally set the cpuc->dirty.
- Remove the !is_sampling_event() check
- Move the code into X86 generic file, because RDPMC is not a Intel-only
  feature.

Changes since V1:
- Drop the old method, which unconditionally reset the counter in
  x86_pmu_del().
  Only reset the dirty counters when a RDPMC task is sheduled in.

 arch/x86/events/core.c       | 47 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dd9f3c2..e34eb72 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1585,6 +1585,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	__set_bit(event->hw.idx, cpuc->dirty);
+
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
@@ -2304,12 +2306,46 @@ static int x86_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+static void x86_pmu_clear_dirty_counters(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	 /* Don't need to clear the assigned counter. */
+	for (i = 0; i < cpuc->n_events; i++)
+		__clear_bit(cpuc->assign[i], cpuc->dirty);
+
+	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
+		return;
+
+	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
+		/* Metrics and fake events don't have corresponding HW counters. */
+		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
+			continue;
+		else if (i >= INTEL_PMC_IDX_FIXED)
+			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+		else
+			wrmsrl(x86_pmu_event_addr(i), 0);
+	}
+
+	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
+}
+
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
 	/*
+	 * Enable sched_task() for the RDPMC task,
+	 * and clear the existing dirty counters.
+	 */
+	if (x86_pmu.sched_task && event->hw.target) {
+		perf_sched_cb_inc(event->ctx->pmu);
+		x86_pmu_clear_dirty_counters();
+	}
+
+	/*
 	 * This function relies on not being called concurrently in two
 	 * tasks in the same mm.  Otherwise one task could observe
 	 * perf_rdpmc_allowed > 1 and return all the way back to
@@ -2331,6 +2367,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
+	if (x86_pmu.sched_task && event->hw.target)
+		perf_sched_cb_dec(event->ctx->pmu);
+
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
 		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
@@ -2436,6 +2475,14 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+
+	/*
+	 * If a new task has the RDPMC enabled, clear the dirty counters
+	 * to prevent the potential leak.
+	 */
+	if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
+	    current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
+		x86_pmu_clear_dirty_counters();
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 54a340e..e855f20 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -228,6 +228,7 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
-- 
2.7.4

