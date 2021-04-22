Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49432368697
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhDVSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:34:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:51152 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVSeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:34:19 -0400
IronPort-SDR: dUjIIF8piXXN+48BbRBhrdRHvU1YvNibtjOhgIfnTS1qf1ERNv30BlUNZOx8Kk/qt2OHzyz7JD
 3RPqy7/uyFwA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281278052"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281278052"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 11:33:42 -0700
IronPort-SDR: Ei8APp5zxg9H74FwdbZ6MUtWO5QRA0TU521Dg/Pet49SYjPPSh3Mu5sUh/lxV16pcd6FZCINbs
 qV1rdjaxQOnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="535304656"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2021 11:33:41 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org,
        robh@kernel.org, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6] perf: Reset the dirty counter to prevent the leak for an RDPMC task
Date:   Thu, 22 Apr 2021 11:25:52 -0700
Message-Id: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
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

    $./rdpmc_read_all_counters
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

The security issue can only be found with an RDPMC task. It must update
the mm->context.perf_rdpmc_allowed, which can be used to detect an RDPMC
task.

Add a new check_leakage() method. When a RDPMC task is scheduled in,
the method is invoked to check and clear the dirty counters. Don't need
to invoke the method for the identical contexts, which have the same set
of events. Reset is not required.

The RDPMC is not an Intel-only feature. Add the changes in the X86
generic code. Only the un-assigned dirty counters are reset, bacause the
RDPMC assigned dirty counters will be updated soon.

After applying the patch,

        $ ./rdpmc_read_all_counters
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
Changes since V5:
- Don't update perf_sched_cb_{inc,dec} in mmap/munmap().
  Don't check and clear dirty counters in sched_task().
  Because perf_sched_cb_{inc,dec} modify per-CPU state. The mmap() and
  munmap() can be invoked in different CPU.
- Add a new method check_leakage() to check and clear dirty counters
  to prevent potential leakage.

Changes since V4:
- Fix the warning with CONFIG_DEBUG_PREEMPT=y
  Disable the interrupts and preemption around perf_sched_cb_inc/dec()
  to protect the sched_cb_list. I don't think we touch the area in NMI.
  Disabling the interrupts should be good enough to protect the cpuctx.
  We don't need perf_ctx_lock().

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
---
 arch/x86/events/core.c       | 35 +++++++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   |  5 +++++
 kernel/events/core.c         |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c7fcc8d..08cb779 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1624,6 +1624,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	__set_bit(event->hw.idx, cpuc->dirty);
+
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
@@ -2631,6 +2633,38 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
 	return 0;
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
+static void x86_pmu_check_leakage(void)
+{
+	if (READ_ONCE(x86_pmu.attr_rdpmc) && current->mm &&
+	    atomic_read(&current->mm->context.perf_rdpmc_allowed))
+		x86_pmu_clear_dirty_counters();
+}
+
 static int x86_pmu_aux_output_match(struct perf_event *event)
 {
 	if (!(pmu.capabilities & PERF_PMU_CAP_AUX_OUTPUT))
@@ -2675,6 +2709,7 @@ static struct pmu pmu = {
 	.sched_task		= x86_pmu_sched_task,
 	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
+	.check_leakage		= x86_pmu_check_leakage,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27fa85e..d6003e0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -229,6 +229,7 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a763928..bcf3964 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -514,6 +514,11 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Check and clear dirty counters to prevent potential leakage
+	 */
+	void (*check_leakage)		(void); /* optional */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 928b166..692b94e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3858,6 +3858,8 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 
 	if (cpuctx->sched_cb_usage && pmu->sched_task)
 		pmu->sched_task(cpuctx->task_ctx, true);
+	if (pmu->check_leakage)
+		pmu->check_leakage();
 
 	perf_pmu_enable(pmu);
 
-- 
2.7.4

