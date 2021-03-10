Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1522334104
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhCJPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhCJPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:01:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9B2C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k3LAP6nuyVJ64Q+TnP9etBGvWVETHe7WmgwfLX7aamM=; b=h4txAob/jpziUFWjbItQPM+7vO
        VTC+XRVXL6FRExJwDnjWO/IJhraLUxrMnwd1L6Mj0H2EHx6WuXeLOF6EOVhZ3acjfjZRcq9vcr+aQ
        hK7QVXIvg7n9CW9ZAb2/xscqyJSonfCXj0qCyzX9U1ykzPTbK+onnK3o1PynHrZxjpzhdBBVfmyVv
        yhXfAqO5ZBnWmzPPcdPm1vllAWln2tm//boUeYufMX0GTR1GOlvfv8WeP7QgTMHurbjAgnBBl4ETq
        8n2++29Z3P8TqBdibTacdcX4Ocejzs+6ECalzQ4ebcuW9qFcScaFpmGeakeqyr5eqfzTyAlnz9ax+
        OdDW/Huw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK0LF-0074av-LG; Wed, 10 Mar 2021 15:01:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AFEE30257C;
        Wed, 10 Mar 2021 16:01:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0437729A44D2B; Wed, 10 Mar 2021 16:01:41 +0100 (CET)
Message-ID: <20210310150109.259726371@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Mar 2021 15:53:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
References: <20210310145258.899619710@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new cpu_dying() state to simplify and fix the balance_push()
vs CPU hotplug rollback state.

Specifically, we currently rely on notifiers sched_cpu_dying() /
sched_cpu_activate() to terminate balance_push, however if the
cpu_down() fails when we're past sched_cpu_deactivate(), it should
terminate balance_push at that point and not wait until we hit
sched_cpu_activate().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   33 ++++++++++++++++++++-------------
 kernel/sched/sched.h |    1 -
 2 files changed, 20 insertions(+), 14 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1811,7 +1811,7 @@ static inline bool is_cpu_allowed(struct
 		return cpu_online(cpu);
 
 	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_rq(cpu)->balance_push)
+	if (cpu_dying(cpu))
 		return false;
 
 	/* But are allowed during online. */
@@ -7647,12 +7647,19 @@ static void balance_push(struct rq *rq)
 
 	lockdep_assert_held(&rq->lock);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+
 	/*
 	 * Ensure the thing is persistent until balance_push_set(.on = false);
 	 */
 	rq->balance_callback = &balance_push_callback;
 
 	/*
+	 * Only active while going offline.
+	 */
+	if (!cpu_dying(rq->cpu))
+		return;
+
+	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 *
@@ -7705,7 +7712,6 @@ static void balance_push_set(int cpu, bo
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
-	rq->balance_push = on;
 	if (on) {
 		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
@@ -7830,8 +7836,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq_flags rf;
 
 	/*
-	 * Make sure that when the hotplug state machine does a roll-back
-	 * we clear balance_push. Ideally that would happen earlier...
+	 * Clear the balance_push callback and prepare to schedule
+	 * regular tasks.
 	 */
 	balance_push_set(cpu, false);
 
@@ -7883,14 +7889,6 @@ int sched_cpu_deactivate(unsigned int cp
 	set_cpu_active(cpu, false);
 
 	/*
-	 * From this point forward, this CPU will refuse to run any task that
-	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
-	 * push those tasks away until this gets cleared, see
-	 * sched_cpu_dying().
-	 */
-	balance_push_set(cpu, true);
-
-	/*
 	 * We've cleared cpu_active_mask / set balance_push, wait for all
 	 * preempt-disabled and RCU users of this state to go away such that
 	 * all new such users will observe it.
@@ -7910,6 +7908,14 @@ int sched_cpu_deactivate(unsigned int cp
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
+	/*
+	 * From this point forward, this CPU will refuse to run any task that
+	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
+	 * push those tasks away until this gets cleared, see
+	 * sched_cpu_dying().
+	 */
+	balance_push_set(cpu, true);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -8206,7 +8212,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
-		rq->balance_callback = NULL;
+		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
 		rq->push_cpu = 0;
@@ -8253,6 +8259,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
+	balance_push_set(smp_processor_id(), false);
 #endif
 	init_sched_fair_class();
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -982,7 +982,6 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
-	unsigned char		balance_push;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;


