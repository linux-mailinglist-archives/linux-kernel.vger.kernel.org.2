Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E396B3E3A01
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhHHLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:34:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72DC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 04:34:22 -0700 (PDT)
Date:   Sun, 08 Aug 2021 11:33:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628422459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WPEo9YoZjQwzZ6q45PHQzpuFxKkcH598k06XBlS/u3k=;
        b=dw+HN7Nx7KcvuA9fZfd06B5T4nPYF8M97ACBTQmZ3RZdUEReIIS6/ka7f0/MbSaF5ftpei
        MhVC8MbosT6GGwy8lU3gSD/Zd5k3T6g8B7yUQ1uQthzBsDSxeg6RF6jvzKXNX1dfVSzVI5
        6I9a7AVI86IrlmJMlvYyxFlvhS5bg87ZR/7VmKsZoTn4id1JV0tRyDBkOoA8BBX+hyrfrD
        +VNTqT/Vc/Kvl+Fd1m9NPNXDA1XR42zWAA5BG+ruHBJ2iwC8MelTrwEdfeR39kGM0YmaSj
        ZPnqWCMs7184Ev2gbvBs7sqafhqkSK/rRPpIsEObYqrLXT+Jk/8NBfBkuMgL/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628422459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WPEo9YoZjQwzZ6q45PHQzpuFxKkcH598k06XBlS/u3k=;
        b=Ze0YCq4y/8J4WqcgtQ9qtuEK3zHCQQS5+EaGsD1akGml/9m0DU6eMT7U3Q186zX4IXR4uU
        YLI9k6t6N8hH5ZCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.14-rc5
Message-ID: <162842243492.9524.2294192686333344509.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-08-08

up to:  acade6379930: perf/x86/intel: Apply mid ACK for small core


A set of perf fixes:

 - Correct the permission checks for perf event which send SIGTRAP to a
   different process and clean up that code to be more readable.

 - Prevent an out of bound MSR access in the x86 perf code which happened
   due to an incomplete limiting to the actually available hardware
   counters.

 - Prevent access to the AMD64_EVENTSEL_HOSTONLY bit when running inside a
   guest.

 - Handle small core counter re-enabling correctly by issuing an ACK right
   before reenabling it to prevent a stale PEBS record being kept around.

Thanks,

	tglx

------------------>
Kan Liang (1):
      perf/x86/intel: Apply mid ACK for small core

Like Xu (1):
      perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest

Marco Elver (2):
      perf: Fix required permissions if sigtrap is requested
      perf: Refactor permissions check into perf_check_permission()

Peter Zijlstra (1):
      perf/x86: Fix out of bound MSR access


 arch/x86/events/core.c       | 12 +++++++-----
 arch/x86/events/intel/core.c | 23 +++++++++++++++--------
 arch/x86/events/perf_event.h | 18 +++++++++++++++++-
 kernel/events/core.c         | 35 ++++++++++++++++++++++++++++++++---
 4 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1eb45139fcc6..3092fbf9dbe4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2489,13 +2489,15 @@ void perf_clear_dirty_counters(void)
 		return;
 
 	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
-		/* Metrics and fake events don't have corresponding HW counters. */
-		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
-			continue;
-		else if (i >= INTEL_PMC_IDX_FIXED)
+		if (i >= INTEL_PMC_IDX_FIXED) {
+			/* Metrics and fake events don't have corresponding HW counters. */
+			if ((i - INTEL_PMC_IDX_FIXED) >= hybrid(cpuc->pmu, num_counters_fixed))
+				continue;
+
 			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
-		else
+		} else {
 			wrmsrl(x86_pmu_event_addr(i), 0);
+		}
 	}
 
 	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fca7a6e2242f..ac6fd2dabf6a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2904,24 +2904,28 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
  */
 static int intel_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct cpu_hw_events *cpuc;
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	bool late_ack = hybrid_bit(cpuc->pmu, late_ack);
+	bool mid_ack = hybrid_bit(cpuc->pmu, mid_ack);
 	int loops;
 	u64 status;
 	int handled;
 	int pmu_enabled;
 
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-
 	/*
 	 * Save the PMU state.
 	 * It needs to be restored when leaving the handler.
 	 */
 	pmu_enabled = cpuc->enabled;
 	/*
-	 * No known reason to not always do late ACK,
-	 * but just in case do it opt-in.
+	 * In general, the early ACK is only applied for old platforms.
+	 * For the big core starts from Haswell, the late ACK should be
+	 * applied.
+	 * For the small core after Tremont, we have to do the ACK right
+	 * before re-enabling counters, which is in the middle of the
+	 * NMI handler.
 	 */
-	if (!x86_pmu.late_ack)
+	if (!late_ack && !mid_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
@@ -2958,6 +2962,8 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 		goto again;
 
 done:
+	if (mid_ack)
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
@@ -2969,7 +2975,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * have been reset. This avoids spurious NMIs on
 	 * Haswell CPUs.
 	 */
-	if (x86_pmu.late_ack)
+	if (late_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	return handled;
 }
@@ -6129,7 +6135,6 @@ __init int intel_pmu_init(void)
 		static_branch_enable(&perf_is_hybrid);
 		x86_pmu.num_hybrid_pmus = X86_HYBRID_NUM_PMUS;
 
-		x86_pmu.late_ack = true;
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
@@ -6167,6 +6172,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
 		pmu->cpu_type = hybrid_big;
+		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
 			pmu->num_counters = x86_pmu.num_counters + 2;
 			pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
@@ -6192,6 +6198,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		pmu->name = "cpu_atom";
 		pmu->cpu_type = hybrid_small;
+		pmu->mid_ack = true;
 		pmu->num_counters = x86_pmu.num_counters;
 		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
 		pmu->max_pebs_events = x86_pmu.max_pebs_events;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2bf1c7ea2758..e3ac05c97b5e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -656,6 +656,10 @@ struct x86_hybrid_pmu {
 	struct event_constraint		*event_constraints;
 	struct event_constraint		*pebs_constraints;
 	struct extra_reg		*extra_regs;
+
+	unsigned int			late_ack	:1,
+					mid_ack		:1,
+					enabled_ack	:1;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -686,6 +690,16 @@ extern struct static_key_false perf_is_hybrid;
 	__Fp;						\
 }))
 
+#define hybrid_bit(_pmu, _field)			\
+({							\
+	bool __Fp = x86_pmu._field;			\
+							\
+	if (is_hybrid() && (_pmu))			\
+		__Fp = hybrid_pmu(_pmu)->_field;	\
+							\
+	__Fp;						\
+})
+
 enum hybrid_pmu_type {
 	hybrid_big		= 0x40,
 	hybrid_small		= 0x20,
@@ -755,6 +769,7 @@ struct x86_pmu {
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
+			mid_ack			:1,
 			enabled_ack		:1;
 	/*
 	 * sysfs attrs
@@ -1115,9 +1130,10 @@ void x86_pmu_stop(struct perf_event *event, int flags);
 
 static inline void x86_pmu_disable_event(struct perf_event *event)
 {
+	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
 
 	if (is_counter_pair(hwc))
 		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 464917096e73..1cb1f9b8392e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11917,6 +11917,37 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
 	return gctx;
 }
 
+static bool
+perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
+{
+	unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
+	bool is_capable = perfmon_capable();
+
+	if (attr->sigtrap) {
+		/*
+		 * perf_event_attr::sigtrap sends signals to the other task.
+		 * Require the current task to also have CAP_KILL.
+		 */
+		rcu_read_lock();
+		is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
+		rcu_read_unlock();
+
+		/*
+		 * If the required capabilities aren't available, checks for
+		 * ptrace permissions: upgrade to ATTACH, since sending signals
+		 * can effectively change the target task.
+		 */
+		ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
+	}
+
+	/*
+	 * Preserve ptrace permission check for backwards compatibility. The
+	 * ptrace check also includes checks that the current task and other
+	 * task have matching uids, and is therefore not done here explicitly.
+	 */
+	return is_capable || ptrace_may_access(task, ptrace_mode);
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
@@ -12163,15 +12194,13 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_file;
 
 		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
 		 * We must hold exec_update_lock across this and any potential
 		 * perf_install_in_context() call for this new event to
 		 * serialize against exec() altering our credentials (and the
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!perf_check_permission(&attr, task))
 			goto err_cred;
 	}
 

