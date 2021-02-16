Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00431C8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBPKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:37:12 -0500
Received: from foss.arm.com ([217.140.110.172]:60216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBPKgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:36:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 710661042;
        Tue, 16 Feb 2021 02:35:25 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.6.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41A903F73B;
        Tue, 16 Feb 2021 02:35:24 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 3/3] cpu/hotplug: Add cpuhp_invoke_callback_range()
Date:   Tue, 16 Feb 2021 10:35:06 +0000
Message-Id: <20210216103506.416286-4-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210216103506.416286-1-vincent.donnefort@arm.com>
References: <20210216103506.416286-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Factorizing and unifying cpuhp callback range invocations, especially for
the hotunplug path, where two different ways of decrementing were used. The
first one, decrements before the callback is called:

 cpuhp_thread_fun()
     state = st->state;
     st->state--;
     cpuhp_invoke_callback(state);

The second one, after:

 take_down_cpu()|cpuhp_down_callbacks()
     cpuhp_invoke_callback(st->state);
     st->state--;

This is problematic for rolling back the steps in case of error, as
depending on the decrement, the rollback will start from N or N-1. It also
makes tracing inconsistent, between steps run in the cpuhp thread and
the others.

Additionally, avoid useless cpuhp_thread_fun() loops by skipping empty
steps.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d44877095b8c..382ef48e1271 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -135,6 +135,11 @@ static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 	return cpuhp_hp_states + state;
 }
 
+static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
+{
+	return bringup ? !step->startup.single : !step->teardown.single;
+}
+
 /**
  * cpuhp_invoke_callback _ Invoke the callbacks for a given state
  * @cpu:	The cpu for which the callback should be invoked
@@ -157,26 +162,24 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
-
-		if (!(bringup ? step->startup.single : step->teardown.single))
-			return 0;
-
 		return -EAGAIN;
 	}
 
+	if (cpuhp_step_empty(bringup, step)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
 	if (!step->multi_instance) {
 		WARN_ON_ONCE(lastp && *lastp);
 		cb = bringup ? step->startup.single : step->teardown.single;
-		if (!cb)
-			return 0;
+
 		trace_cpuhp_enter(cpu, st->target, state, cb);
 		ret = cb(cpu);
 		trace_cpuhp_exit(cpu, st->state, state, ret);
 		return ret;
 	}
 	cbm = bringup ? step->startup.multi : step->teardown.multi;
-	if (!cbm)
-		return 0;
 
 	/* Single invocation for instance add/remove */
 	if (node) {
@@ -468,6 +471,15 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 static inline void
 cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 {
+	st->target = prev_state;
+
+	/*
+	 * Already rolling back. No need invert the bringup value or to change
+	 * the current state.
+	 */
+	if (st->rollback)
+		return;
+
 	st->rollback = true;
 
 	/*
@@ -481,7 +493,6 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 			st->state++;
 	}
 
-	st->target = prev_state;
 	st->bringup = !st->bringup;
 }
 
@@ -584,10 +595,53 @@ static int finish_cpu(unsigned int cpu)
  * Hotplug state machine related functions
  */
 
-static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
+/*
+ * Get the next state to run. Empty ones will be skipped. Returns true if a
+ * state must be run.
+ *
+ * st->state will be modified ahead of time, to match state_to_run, as if it
+ * has already ran.
+ */
+static bool cpuhp_next_state(bool bringup,
+			     enum cpuhp_state *state_to_run,
+			     struct cpuhp_cpu_state *st,
+			     enum cpuhp_state target)
 {
-	for (st->state--; st->state > st->target; st->state--)
-		cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
+	do {
+		if (bringup) {
+			if (st->state >= target)
+				return false;
+
+			*state_to_run = ++st->state;
+		} else {
+			if (st->state <= target)
+				return false;
+
+			*state_to_run = st->state--;
+		}
+
+		if (!cpuhp_step_empty(bringup, cpuhp_get_step(*state_to_run)))
+			break;
+	} while (true);
+
+	return true;
+}
+
+static int cpuhp_invoke_callback_range(bool bringup,
+				       unsigned int cpu,
+				       struct cpuhp_cpu_state *st,
+				       enum cpuhp_state target)
+{
+	enum cpuhp_state state;
+	int err = 0;
+
+	while (cpuhp_next_state(bringup, &state, st, target)) {
+		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
+		if (err)
+			break;
+	}
+
+	return err;
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -610,16 +664,12 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 	enum cpuhp_state prev_state = st->state;
 	int ret = 0;
 
-	while (st->state < target) {
-		st->state++;
-		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-		if (ret) {
-			if (can_rollback_cpu(st)) {
-				st->target = prev_state;
-				undo_cpu_up(cpu, st);
-			}
-			break;
-		}
+	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
+	if (ret) {
+		cpuhp_reset_state(st, prev_state);
+		if (can_rollback_cpu(st))
+			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
+							    prev_state));
 	}
 	return ret;
 }
@@ -683,17 +733,9 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		state = st->cb_state;
 		st->should_run = false;
 	} else {
-		if (bringup) {
-			st->state++;
-			state = st->state;
-			st->should_run = (st->state < st->target);
-			WARN_ON_ONCE(st->state > st->target);
-		} else {
-			state = st->state;
-			st->state--;
-			st->should_run = (st->state > st->target);
-			WARN_ON_ONCE(st->state < st->target);
-		}
+		st->should_run = cpuhp_next_state(bringup, &state, st, st->target);
+		if (!st->should_run)
+			goto end;
 	}
 
 	WARN_ON_ONCE(!cpuhp_is_ap_state(state));
@@ -721,6 +763,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		st->should_run = false;
 	}
 
+end:
 	cpuhp_lock_release(bringup);
 	lockdep_release_cpus_lock();
 
@@ -874,19 +917,18 @@ static int take_cpu_down(void *_param)
 		return err;
 
 	/*
-	 * We get here while we are in CPUHP_TEARDOWN_CPU state and we must not
-	 * do this step again.
+	 * Must be called from CPUHP_TEARDOWN_CPU, which means, as we are going
+	 * down, that the current state is CPUHP_TEARDOWN_CPU - 1.
 	 */
-	WARN_ON(st->state != CPUHP_TEARDOWN_CPU);
-	st->state--;
+	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
+
 	/* Invoke the former CPU_DYING callbacks */
-	for (; st->state > target; st->state--) {
-		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
-		/*
-		 * DYING must not fail!
-		 */
-		WARN_ON_ONCE(ret);
-	}
+	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
+
+	/*
+	 * DYING must not fail!
+	 */
+	WARN_ON_ONCE(ret);
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -968,27 +1010,22 @@ void cpuhp_report_idle_dead(void)
 				 cpuhp_complete_idle_dead, st, 0);
 }
 
-static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st)
-{
-	for (st->state++; st->state < st->target; st->state++)
-		cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-}
-
 static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 				enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
 	int ret = 0;
 
-	for (; st->state > target; st->state--) {
-		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
-		if (ret) {
-			st->target = prev_state;
-			if (st->state < prev_state)
-				undo_cpu_down(cpu, st);
-			break;
-		}
+	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
+	if (ret) {
+
+		cpuhp_reset_state(st, prev_state);
+
+		if (st->state < prev_state)
+			WARN_ON(cpuhp_invoke_callback_range(true, cpu, st,
+							    prev_state));
 	}
+
 	return ret;
 }
 
@@ -1161,14 +1198,12 @@ void notify_cpu_starting(unsigned int cpu)
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	while (st->state < target) {
-		st->state++;
-		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-		/*
-		 * STARTING must not fail!
-		 */
-		WARN_ON_ONCE(ret);
-	}
+	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
+
+	/*
+	 * STARTING must not fail!
+	 */
+	WARN_ON_ONCE(ret);
 }
 
 /*
@@ -1774,8 +1809,7 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
 	 * If there's nothing to do, we done.
 	 * Relies on the union for multi_instance.
 	 */
-	if ((bringup && !sp->startup.single) ||
-	    (!bringup && !sp->teardown.single))
+	if (cpuhp_step_empty(bringup, sp))
 		return 0;
 	/*
 	 * The non AP bound callbacks can fail on bringup. On teardown
-- 
2.25.1

