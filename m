Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8C3F17BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhHSLKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbhHSLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:10:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+YpZp2E5Lu7WGawwqWr3YCkfHQOZO81lNz7EQ6EH8ws=; b=C7f7ONiAvwo/CpVfvLzsK48KZM
        IvzHtuGkUW3Otr7je1HsNlIos7FuKzwWZx9lTNYtqkXFiJeeffuEDAWTskkEBOcAmWZh1HNwAvuPK
        09BqejT0geHj6TeCOOOhDtNf9WNXNeMglWTiRXt8+D+Ru8fqupDIlWayGiU1WVXXUuRVyfh8wjOcA
        tORXJEB94wUv/Z1SJP8b2NVTQOgAPTvZKeO6Y5E+9fuI6BjAqJuooHcRm435SI+fPRRC1haTRKYyg
        fW3/MyIvapHGtHfiNNzgrvMSOu+siIdNdBQn50thU9S/ujii9tZdPVZFqKMK3CRyNETd7qmoWGRC6
        gv3b+i2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGfvE-00B5UI-7t; Thu, 19 Aug 2021 11:09:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9FC03004B2;
        Thu, 19 Aug 2021 13:09:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C86E320C98239; Thu, 19 Aug 2021 13:09:17 +0200 (CEST)
Date:   Thu, 19 Aug 2021 13:09:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Subject: [PATCH] sched: Fix Core-wide rq->lock for uninitialized CPUs
Message-ID: <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
 <20210817151542.GA1665@asgard.redhat.com>
 <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
 <20210817231734.GA4449@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817231734.GA4449@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:17:34AM +0200, Eugene Syromiatnikov wrote:
> On Tue, Aug 17, 2021 at 05:52:43PM +0200, Peter Zijlstra wrote:
> > Urgh... lemme guess, your HP BIOS is funny and reports more possible
> > CPUs than you actually have resulting in cpu_possible_mask !=
> > cpu_online_mask. Alternatively, you booted with nr_cpus= or something
> > daft like that.
> 
> Yep, it seems to be the case:
> 
>     # cat /sys/devices/system/cpu/possible
>     0-7
>     # cat /sys/devices/system/cpu/online
>     0-3
> 

I think the below should work... can you please verify?

---
Subject: sched: Fix Core-wide rq->lock for uninitialized CPUs

Eugene tripped over the case where rq_lock(), as called in a
for_each_possible_cpu() loop came apart because rq->core hadn't been
setup yet.

This is a somewhat unusual, but valid case.

Rework things such that rq->core is initialized to point at itself. IOW
initialize each CPU as a single threaded Core. CPU online will then join
the new CPU (thread) to an existing Core where needed.

For completeness sake, have CPU offline fully undo the state so as to
not presume the topology will match the next time it comes online.

Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  | 143 +++++++++++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h |   2 +-
 2 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f14e09a4f99..21d633971fcf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -237,9 +237,30 @@ static DEFINE_MUTEX(sched_core_mutex);
 static atomic_t sched_core_count;
 static struct cpumask sched_core_mask;
 
+static void sched_core_lock(int cpu, unsigned long *flags)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	int t, i = 0;
+
+	local_irq_save(*flags);
+	for_each_cpu(t, smt_mask)
+		raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
+}
+
+static void sched_core_unlock(int cpu, unsigned long *flags)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	int t;
+
+	for_each_cpu(t, smt_mask)
+		raw_spin_unlock(&cpu_rq(t)->__lock);
+	local_irq_restore(*flags);
+}
+
 static void __sched_core_flip(bool enabled)
 {
-	int cpu, t, i;
+	unsigned long flags;
+	int cpu, t;
 
 	cpus_read_lock();
 
@@ -250,19 +271,12 @@ static void __sched_core_flip(bool enabled)
 	for_each_cpu(cpu, &sched_core_mask) {
 		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 
-		i = 0;
-		local_irq_disable();
-		for_each_cpu(t, smt_mask) {
-			/* supports up to SMT8 */
-			raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
-		}
+		sched_core_lock(cpu, &flags);
 
 		for_each_cpu(t, smt_mask)
 			cpu_rq(t)->core_enabled = enabled;
 
-		for_each_cpu(t, smt_mask)
-			raw_spin_unlock(&cpu_rq(t)->__lock);
-		local_irq_enable();
+		sched_core_unlock(cpu, &flags);
 
 		cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);
 	}
@@ -5979,35 +5993,109 @@ void queue_core_balance(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
 }
 
-static inline void sched_core_cpu_starting(unsigned int cpu)
+static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-	struct rq *rq, *core_rq = NULL;
-	int i;
+	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	unsigned long flags;
+	int t;
 
-	core_rq = cpu_rq(cpu)->core;
+	sched_core_lock(cpu, &flags);
 
-	if (!core_rq) {
-		for_each_cpu(i, smt_mask) {
-			rq = cpu_rq(i);
-			if (rq->core && rq->core == rq)
-				core_rq = rq;
+	WARN_ON_ONCE(rq->core != rq);
+
+	/* if we're the first, we'll be our own leader */
+	if (cpumask_weight(smt_mask) == 1)
+		goto unlock;
+
+	/* find the leader */
+	for_each_cpu(t, smt_mask) {
+		if (t == cpu)
+			continue;
+		rq = cpu_rq(t);
+		if (rq->core == rq) {
+			core_rq = rq;
+			break;
 		}
+	}
 
-		if (!core_rq)
-			core_rq = cpu_rq(cpu);
+	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
+		goto unlock;
 
-		for_each_cpu(i, smt_mask) {
-			rq = cpu_rq(i);
+	/* install and validate core_rq */
+	for_each_cpu(t, smt_mask) {
+		rq = cpu_rq(t);
 
-			WARN_ON_ONCE(rq->core && rq->core != core_rq);
+		if (t == cpu)
 			rq->core = core_rq;
-		}
+
+		WARN_ON_ONCE(rq->core != core_rq);
 	}
+
+unlock:
+	sched_core_unlock(cpu, &flags);
 }
+
+static void sched_core_cpu_deactivate(unsigned int cpu)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	unsigned long flags;
+	int t;
+
+	sched_core_lock(cpu, &flags);
+
+	/* if we're the last man standing, nothing to do */
+	if (cpumask_weight(smt_mask) == 1) {
+		WARN_ON_ONCE(rq->core != rq);
+		goto unlock;
+	}
+
+	/* if we're not the leader, nothing to do */
+	if (rq->core != rq)
+		goto unlock;
+
+	/* find a new leader */
+	for_each_cpu(t, smt_mask) {
+		if (t == cpu)
+			continue;
+		core_rq = cpu_rq(t);
+		break;
+	}
+
+	if (WARN_ON_ONCE(!core_rq)) /* impossible */
+		goto unlock;
+
+	/* copy the shared state to the new leader */
+	core_rq->core_task_seq      = rq->core_task_seq;
+	core_rq->core_pick_seq      = rq->core_pick_seq;
+	core_rq->core_cookie        = rq->core_cookie;
+	core_rq->core_forceidle     = rq->core_forceidle;
+	core_rq->core_forceidle_seq = rq->core_forceidle_seq;
+
+	/* install new leader */
+	for_each_cpu(t, smt_mask) {
+		rq = cpu_rq(t);
+		rq->core = core_rq;
+	}
+
+unlock:
+	sched_core_unlock(cpu, &flags);
+}
+
+static inline void sched_core_cpu_dying(unsigned int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (rq->core != rq)
+		rq->core = rq;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_cpu_starting(unsigned int cpu) {}
+static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
+static inline void sched_core_cpu_dying(unsigned int cpu) {}
 
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
@@ -9009,6 +9097,8 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
 		static_branch_dec_cpuslocked(&sched_smt_present);
+
+	sched_core_cpu_deactivate(cpu);
 #endif
 
 	if (!sched_smp_initialized)
@@ -9113,6 +9203,7 @@ int sched_cpu_dying(unsigned int cpu)
 	calc_load_migrate(rq);
 	update_max_interval();
 	hrtick_clear(rq);
+	sched_core_cpu_dying(cpu);
 	return 0;
 }
 #endif
@@ -9324,7 +9415,7 @@ void __init sched_init(void)
 		atomic_set(&rq->nr_iowait, 0);
 
 #ifdef CONFIG_SCHED_CORE
-		rq->core = NULL;
+		rq->core = rq;
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a9a660c6e08a..e6347c88c467 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1103,7 +1103,7 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 
-	/* shared state */
+	/* shared state -- careful with sched_core_cpu_deactivate() */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
