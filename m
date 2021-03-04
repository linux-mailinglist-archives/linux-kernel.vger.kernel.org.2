Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F632C91E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356463AbhCDBEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451171AbhCDAal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:30:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0F064EA4;
        Thu,  4 Mar 2021 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817796;
        bh=ec9s9DKkUfgB2VcQUN8fIDRTVKD0E3Sm1++x8xAqrt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ty7QwfmpXq/F1Q6uBr++q5WgmG3ZfFMGe4TIZJt7kPb/CZViCAP2vY8NW9AkEhG69
         rUWYhojBWZbAGjmDyd7kDsbUGp2WRd/rRjEd4CLqWWe3mdALWXyfyef9lK/OpFgzqU
         Uyub3n5oe6ojTilnfjUMrFEYeNEfv6AQS43x8DsGvvtzq4TtSi2HXH9ne2O7JJUR+V
         97JRTFWm9fMjTWz3gkBNG1PI2In3clfQNs8u7/bVf2rblI0jTDyhbRIYufTOZ/u9S1
         DRIhHMxOOLz6jKO90KCyxukT9gRdoBaPhdpwbhnZTRoOpzqt3xEPBMpXQkaPK/o9+B
         kZumxcygU8kvA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH tip/core/rcu 1/5] rcu: Expedite deboost in case of deferred quiescent state
Date:   Wed,  3 Mar 2021 16:29:51 -0800
Message-Id: <20210304002955.24132-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002919.GA24003@paulmck-ThinkPad-P72>
References: <20210304002919.GA24003@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Historically, a task that has been subjected to RCU priority boosting is
deboosted at rcu_read_unlock() time.  However, with the advent of deferred
quiescent states, if the outermost rcu_read_unlock() was invoked with
either bottom halves, interrupts, or preemption disabled, the deboosting
will be delayed for some time.  During this time, a low-priority process
might be incorrectly running at a high real-time priority level.

Fortunately, rcu_read_unlock_special() already provides mechanisms for
forcing a minimal deferral of quiescent states, at least for kernels
built with CONFIG_IRQ_WORK=y.  These mechanisms are currently used
when expedited grace periods are pending that might be blocked by the
current task.  This commit therefore causes those mechanisms to also be
used in cases where the current task has been or might soon be subjected
to RCU priority boosting.  Note that this applies to all kernels built
with CONFIG_RCU_BOOST=y, regardless of whether or not they are also
built with CONFIG_PREEMPT_RT=y.

This approach assumes that kernels build for use with aggressive real-time
applications are built with CONFIG_IRQ_WORK=y.  It is likely to be far
simpler to enable CONFIG_IRQ_WORK=y than to implement a fast-deboosting
scheme that works correctly in its absence.

While in the area, alphabetize the rcu_preempt_deferred_qs_handler()
function's local variables.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..e17cb23 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -598,9 +598,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 static void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
+	bool irqs_were_disabled;
 	bool preempt_bh_were_disabled =
 			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
-	bool irqs_were_disabled;
 
 	/* NMI handlers cannot block and cannot safely manipulate state. */
 	if (in_nmi())
@@ -609,30 +609,32 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
-		bool exp;
+		bool expboost; // Expedited GP in flight or possible boosting.
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		exp = (t->rcu_blocked_node &&
-		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
-		      (rdp->grpmask & READ_ONCE(rnp->expmask));
+		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
+			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
+			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
+			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
+		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
-			// wakeup is free or there is an expedited GP.
+			// wakeup is free or there is either an expedited
+			// GP in flight or a potential need to deboost.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting, slow is OK.
-			// Plus nohz_full CPUs eventually get tick enabled.
+			// Also if no expediting and no possible deboosting,
+			// slow is OK.  Plus nohz_full CPUs eventually get
+			// tick enabled.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
+			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw,
-					      rcu_preempt_deferred_qs_handler);
+				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
-- 
2.9.5

