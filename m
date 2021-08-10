Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830453E3270
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhHGA65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:58:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhHGA6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:58:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A2CB11FB;
        Fri,  6 Aug 2021 17:58:39 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 490E43F66F;
        Fri,  6 Aug 2021 17:58:36 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 3/4] rcu/nocb: Protect NOCB state via local_lock() under PREEMPT_RT
Date:   Sat,  7 Aug 2021 01:58:06 +0100
Message-Id: <20210807005807.1083943-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807005807.1083943-1-valentin.schneider@arm.com>
References: <20210807005807.1083943-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning
=======

Running v5.13-rt1 on my arm64 Juno board triggers:

[    0.156302] =============================
[    0.160416] WARNING: suspicious RCU usage
[    0.164529] 5.13.0-rt1 #20 Not tainted
[    0.168300] -----------------------------
[    0.172409] kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
[    0.179920]
[    0.179920] other info that might help us debug this:
[    0.179920]
[    0.188037]
[    0.188037] rcu_scheduler_active = 1, debug_locks = 1
[    0.194677] 3 locks held by rcuc/0/11:
[    0.198448] #0: ffff00097ef10cf8 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:662 kernel/softirq.c:171)
[    0.208709] #1: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:43 (discriminator 4))
[    0.217134] #2: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:169)
[    0.226428]
[    0.226428] stack backtrace:
[    0.230889] CPU: 0 PID: 11 Comm: rcuc/0 Not tainted 5.13.0-rt1 #20
[    0.237100] Hardware name: ARM Juno development board (r0) (DT)
[    0.243041] Call trace:
[    0.245497] dump_backtrace (arch/arm64/kernel/stacktrace.c:163)
[    0.249185] show_stack (arch/arm64/kernel/stacktrace.c:219)
[    0.252522] dump_stack (lib/dump_stack.c:122)
[    0.255947] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6439)
[    0.260328] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
[    0.264537] rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
[    0.267786] rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
[    0.271644] smpboot_thread_fn (kernel/smpboot.c:165 (discriminator 3))
[    0.275767] kthread (kernel/kthread.c:321)
[    0.279013] ret_from_fork (arch/arm64/kernel/entry.S:1005)

In this case, this is the RCU core kthread accessing the local CPU's
rdp. Before that, rcu_cpu_kthread() invokes local_bh_disable().

Under !CONFIG_PREEMPT_RT (and rcutree.use_softirq=0), this ends up
incrementing the preempt_count, which satisfies the "local non-preemptible
read" of rcu_rdp_is_offloaded().

Under CONFIG_PREEMPT_RT however, this becomes

  local_lock(&softirq_ctrl.lock)

which, under the same config, is migrate_disable() + rt_spin_lock(). As
pointed out by Frederic, this is not sufficient to safely access an rdp's
offload state, as the RCU core kthread can be preempted by a kworker
executing rcu_nocb_rdp_offload() [1].

Introduce a local_lock to serialize an rdp's offload state while the rdp's
associated core kthread is executing rcu_core().

rcu_core() preemptability considerations
========================================

As pointed out by Paul [2], keeping rcu_check_quiescent_state() preemptible
(which is the case under CONFIG_PREEMPT_RT) requires some consideration.

note_gp_changes() itself runs with irqs off, and enters
__note_gp_changes() with rnp->lock held (raw_spinlock), thus is safe vs
preemption.

rdp->core_needs_qs *could* change after being read by the RCU core
kthread if it then gets preempted. Consider, with
CONFIG_RCU_STRICT_GRACE_PERIOD:

  rcuc/x                                   task_foo

    rcu_check_quiescent_state()
    `\
      rdp->core_needs_qs == true
			     <PREEMPT>
					   rcu_read_unlock()
					   `\
					     rcu_preempt_deferred_qs_irqrestore()
					     `\
					       rcu_report_qs_rdp()
					       `\
						 rdp->core_needs_qs := false;

This would let rcuc/x's rcu_check_quiescent_state() proceed further down to
rcu_report_qs_rdp(), but if task_foo's earlier rcu_report_qs_rdp()
invocation would have cleared the rdp grpmask from the rnp mask, so
rcuc/x's invocation would simply bail.

Since rcu_report_qs_rdp() can be safely invoked, even if rdp->core_needs_qs
changed, it appears safe to keep rcu_check_quiescent_state() preemptible.

[1]: http://lore.kernel.org/r/20210727230814.GC283787@lothringen
[2]: http://lore.kernel.org/r/20210729010445.GO4397@paulmck-ThinkPad-P17-Gen-1
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/rcu/tree.c        |  4 ++
 kernel/rcu/tree.h        |  4 ++
 kernel/rcu/tree_plugin.h | 82 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51f24ecd94b2..caadfec994f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -87,6 +87,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
+	.nocb_local_lock =  INIT_LOCAL_LOCK(nocb_local_lock),
 #endif
 };
 static struct rcu_state rcu_state = {
@@ -2853,10 +2854,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 {
 	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int spincnt;
 
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
+		rcu_nocb_local_lock(rdp);
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
@@ -2866,6 +2869,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		if (work)
 			rcu_core();
 		local_bh_enable();
+		rcu_nocb_local_unlock(rdp);
 		if (*workp == 0) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb408..aa6831255fec 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -210,6 +210,8 @@ struct rcu_data {
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
 
+	local_lock_t nocb_local_lock;
+
 	/* The following fields are used by call_rcu, hence own cacheline. */
 	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
 	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
@@ -445,6 +447,8 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
+static void rcu_nocb_local_lock(struct rcu_data *rdp);
+static void rcu_nocb_local_unlock(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #define rcu_nocb_lock_irqsave(rdp, flags)				\
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0ff5e4fb933e..b1487cac9250 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -21,6 +21,17 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 	return lockdep_is_held(&rdp->nocb_lock);
 }
 
+static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
+{
+	return lockdep_is_held(
+#ifdef CONFIG_PREEMPT_RT
+		&rdp->nocb_local_lock.lock
+#else
+		&rdp->nocb_local_lock
+#endif
+	);
+}
+
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
 	/* Race on early boot between thread creation and assignment */
@@ -38,7 +49,10 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 {
 	return 0;
 }
-
+static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
+{
+	return 0;
+}
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
 	return false;
@@ -46,23 +60,44 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
+/*
+ * Is a local read of the rdp's offloaded state safe and stable?
+ * See rcu_nocb_local_lock() & family.
+ */
+static inline bool rcu_local_offload_access_safe(struct rcu_data *rdp)
+{
+	if (!preemptible())
+		return true;
+
+	if (is_pcpu_safe()) {
+		if (!IS_ENABLED(CONFIG_RCU_NOCB))
+			return true;
+
+		return rcu_lockdep_is_held_nocb_local(rdp);
+	}
+
+	return false;
+}
+
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
 	/*
-	 * In order to read the offloaded state of an rdp is a safe
-	 * and stable way and prevent from its value to be changed
-	 * under us, we must either hold the barrier mutex, the cpu
-	 * hotplug lock (read or write) or the nocb lock. Local
-	 * non-preemptible reads are also safe. NOCB kthreads and
-	 * timers have their own means of synchronization against the
-	 * offloaded state updaters.
+	 * In order to read the offloaded state of an rdp is a safe and stable
+	 * way and prevent from its value to be changed under us, we must either...
 	 */
 	RCU_LOCKDEP_WARN(
+		// ...hold the barrier mutex...
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
+		  // ... the cpu hotplug lock (read or write)...
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
+		  // ... or the NOCB lock.
 		  rcu_lockdep_is_held_nocb(rdp) ||
+		  // Local reads still require the local state to remain stable
+		  // (preemption disabled / local lock held)
 		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		   rcu_local_offload_access_safe(rdp)) ||
+		  // NOCB kthreads and timers have their own means of synchronization
+		  // against the offloaded state updaters.
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
@@ -1629,6 +1664,22 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	}
 }
 
+/*
+ * The invocation of rcu_core() within the RCU core kthreads remains preemptible
+ * under PREEMPT_RT, thus the offload state of a CPU could change while
+ * said kthreads are preempted. Prevent this from happening by protecting the
+ * offload state with a local_lock().
+ */
+static void rcu_nocb_local_lock(struct rcu_data *rdp)
+{
+	local_lock(&rcu_data.nocb_local_lock);
+}
+
+static void rcu_nocb_local_unlock(struct rcu_data *rdp)
+{
+	local_unlock(&rcu_data.nocb_local_lock);
+}
+
 /* Lockdep check that ->cblist may be safely accessed. */
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
@@ -2396,6 +2447,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	if (rdp->nocb_cb_sleep)
 		rdp->nocb_cb_sleep = false;
 	rcu_nocb_unlock_irqrestore(rdp, flags);
+	rcu_nocb_local_unlock(rdp);
 
 	/*
 	 * Ignore former value of nocb_cb_sleep and force wake up as it could
@@ -2427,6 +2479,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
+	rcu_nocb_local_lock(rdp);
 	rcu_nocb_lock_irqsave(rdp, flags);
 	/*
 	 * Flush once and for all now. This suffices because we are
@@ -2509,6 +2562,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 * Can't use rcu_nocb_lock_irqsave() while we are in
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
+	rcu_nocb_local_lock(rdp);
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 
 	/*
@@ -2868,6 +2922,16 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	local_irq_restore(flags);
 }
 
+/* No ->nocb_local_lock to acquire. */
+static void rcu_nocb_local_lock(struct rcu_data *rdp)
+{
+}
+
+/* No ->nocb_local_lock to release. */
+static void rcu_nocb_local_unlock(struct rcu_data *rdp)
+{
+}
+
 /* Lockdep check that ->cblist may be safely accessed. */
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
-- 
2.25.1

