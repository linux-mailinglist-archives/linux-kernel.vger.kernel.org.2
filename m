Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317E236051A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhDOJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhDOI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:59:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38879C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RzyEi5B73kAsrxZ5avxC+MpqWeclsttq4wG14cBnHr0=; b=QPFFHrF8fEBaudxi550unoleUS
        G3JKPZAEzk+hFV0uAn2M5KnOEr4Zi7hbz9aUIqH3wqPWWPmCM5MJQKvfyytMfCPdVoVRnHJgVaaOj
        2okMXfCbZdBYAwJGh+VMdrnDlJxV8o5vjpMY3ML+LvSZ6z+HSNxgieurZL8EizrGJH2gY0blcda8N
        3ankXBXrG1CnXGUSJhu/v7RhKCFMBiA4SmeBxtDC6aRtKOYlKfE5WzGgIZCU9+wRUi8gxJd84oIpI
        b1Adrs3pP1MsDfl2t+R54NLSV+Ml+aDbkJkdgJ+UKSc9cBOKlfj0FAs/9AFHclCTvTkD9THXtr5uu
        AZ5kidCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWxqE-00FRDH-Ro; Thu, 15 Apr 2021 08:59:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10E95300033;
        Thu, 15 Apr 2021 10:59:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8AFC20224210; Thu, 15 Apr 2021 10:59:13 +0200 (CEST)
Date:   Thu, 15 Apr 2021 10:59:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 08:51:23AM +0200, Peter Zijlstra wrote:

> > I'm afraid I don't follow; we're replacing a read of rq->balance_push with
> > cpu_dying(), and those are still written on the same side of the
> > synchronize_rcu(). What am I missing?
> 
> Yeah, I'm not sure anymnore either; I tried to work out why I'd done
> that but upon closer examination everything fell flat.
> 
> Let me try again today :-)

Can't make sense of what I did.. I've removed that hunk. Patch now looks
like this.

---
Subject: sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan 21 16:09:32 CET 2021

Use the new cpu_dying() state to simplify and fix the balance_push()
vs CPU hotplug rollback state.

Specifically, we currently rely on notifiers sched_cpu_dying() /
sched_cpu_activate() to terminate balance_push, however if the
cpu_down() fails when we're past sched_cpu_deactivate(), it should
terminate balance_push at that point and not wait until we hit
sched_cpu_activate().

Similarly, when cpu_up() fails and we're going back down, balance_push
should be active, where it currently is not.

So instead, make sure balance_push is enabled between
sched_cpu_deactivate() and sched_cpu_activate() (eg. when
!cpu_active()), and gate it's utility with cpu_dying().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   26 +++++++++++++++-----------
 kernel/sched/sched.h |    1 -
 2 files changed, 15 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1811,7 +1811,7 @@ static inline bool is_cpu_allowed(struct
 		return cpu_online(cpu);
 
 	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_rq(cpu)->balance_push)
+	if (cpu_dying(cpu))
 		return false;
 
 	/* But are allowed during online. */
@@ -7639,6 +7639,9 @@ static DEFINE_PER_CPU(struct cpu_stop_wo
 
 /*
  * Ensure we only run per-cpu kthreads once the CPU goes !active.
+ *
+ * This is active/set between sched_cpu_deactivate() / sched_cpu_activate().
+ * But only effective when the hotplug motion is down.
  */
 static void balance_push(struct rq *rq)
 {
@@ -7646,12 +7649,19 @@ static void balance_push(struct rq *rq)
 
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
@@ -7704,7 +7714,6 @@ static void balance_push_set(int cpu, bo
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
-	rq->balance_push = on;
 	if (on) {
 		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
@@ -7829,8 +7838,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq_flags rf;
 
 	/*
-	 * Make sure that when the hotplug state machine does a roll-back
-	 * we clear balance_push. Ideally that would happen earlier...
+	 * Clear the balance_push callback and prepare to schedule
+	 * regular tasks.
 	 */
 	balance_push_set(cpu, false);
 
@@ -8015,12 +8024,6 @@ int sched_cpu_dying(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-	/*
-	 * Now that the CPU is offline, make sure we're welcome
-	 * to new tasks once we come back up.
-	 */
-	balance_push_set(cpu, false);
-
 	calc_load_migrate(rq);
 	update_max_interval();
 	hrtick_clear(rq);
@@ -8205,7 +8208,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
-		rq->balance_callback = NULL;
+		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
 		rq->push_cpu = 0;
@@ -8252,6 +8255,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
+	balance_push_set(smp_processor_id(), false);
 #endif
 	init_sched_fair_class();
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -983,7 +983,6 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
-	unsigned char		balance_push;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
