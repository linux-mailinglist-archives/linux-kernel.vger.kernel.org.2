Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1C337550
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhCKOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:18:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhCKOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:18:20 -0500
Message-Id: <20210311141704.424120350@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615472299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JzFKYyhyF74uZtUNXalJnyEY5Rmr0Hpk5/P+m+FtnIE=;
        b=V2OVDsiDGgeZSf+FuPjl0TLc8ZlBabWN0LM4jqZFCVz5c4NOjj+IBCJS7XtxVGaHCtPUB7
        AOUEnTKGRK1WZ8SuNMC+J1mx+dMaoTucByGSeHEQeIcN2qfIvw4QYyJPXtgDxXS+CNKd8Y
        pWsJuftZdwgW69ESH9AW5QpkC8jM61ViP0W+pZ7YlpY3t8RdtoOKnMfRbko2RiytUMNVE2
        M7Fvm+r2P1aoR931eQ2EQbDW1+JBHD7GPQEQJA8B9eN4JkiPXnh5B+x+dtQT4m4ECOzNst
        pOnKe3Wl5+j4BqFnNlKeGM897gufApo3Z8qb5TYuHe0UYPl0Mxc/441FGv/blA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615472299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JzFKYyhyF74uZtUNXalJnyEY5Rmr0Hpk5/P+m+FtnIE=;
        b=c90Z7hpV/bwVWMAqKqmzKQBgj1/poY9XXaKUUrbl2glwlt3/+LJZ56glsNHGmGLZRU6c1d
        ENDph+ODr4jBVkDg==
Date:   Thu, 11 Mar 2021 14:20:39 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [patch V2 3/3] signal: Allow tasks to cache one sigqueue struct
References: <20210311132036.228542540@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The idea for this originates from the real time tree to make signal
delivery for realtime applications more efficient. In quite some of these
application scenarios a control tasks signals workers to start their
computations. There is usually only one signal per worker on flight.  This
works nicely as long as the kmem cache allocations do not hit the slow path
and cause latencies.

To cure this an optimistic caching was introduced (limited to RT tasks)
which allows a task to cache a single sigqueue in a pointer in task_struct
instead of handing it back to the kmem cache after consuming a signal. When
the next signal is sent to the task then the cached sigqueue is used
instead of allocating a new one. This solved the problem for this set of
application scenarios nicely.

The task cache is not preallocated so the first signal sent to a task goes
always to the cache allocator. The cached sigqueue stays around until the
task exits and is freed when task::sighand is dropped.

After posting this solution for mainline the discussion came up whether
this would be useful in general and should not be limited to realtime
tasks: https://lore.kernel.org/r/m11rcu7nbr.fsf@fess.ebiederm.org

One concern leading to the original limitation was to avoid a large amount
of pointlessly cached sigqueues in alive tasks. The other concern was
vs. RLIMIT_SIGPENDING as these cached sigqueues are not accounted for.

The accounting problem is real, but on the other hand slightly academic.
After gathering some statistics it turned out that after boot of a regular
distro install there are less than 10 sigqueues cached in ~1500 tasks.

In case of a 'mass fork and fire signal to child' scenario the extra 80
bytes of memory per task are well in the noise of the overall memory
consumption of the fork bomb.

If this should be limited then this would need an extra counter in struct
user, more atomic instructions and a seperate rlimit. Yet another tunable
which is mostly unused.

The caching is actually used. After boot and a full kernel compile on a
64CPU machine with make -j128 the number of 'allocations' looks like this:

  From slab: 	   23996
  From task cache: 52223

I.e. it reduces the number of slab cache operations by ~68%.

A typical pattern there is:

<...>-58490 __sigqueue_alloc:  for 58488 from slab ffff8881132df460
<...>-58488 __sigqueue_free:   cache ffff8881132df460
<...>-58488 __sigqueue_alloc:  for 1149 from cache ffff8881103dc550
  bash-1149 exit_task_sighand: free ffff8881132df460
  bash-1149 __sigqueue_free:   cache ffff8881103dc550

The interesting sequence is that the exiting task 58488 grabs the sigqueue
from bash's task cache to signal exit and bash sticks it back into it's own
cache. Lather, rinse and repeat.

The caching is probably not noticable for the general use case, but the
benefit for latency sensitive applications is clear. While kmem caches are
usually just serving from the fast path the slab merging (default) can
depending on the usage pattern of the merged slabs cause occasional slow
path allocations.

The time spared per cached entry is a few micro seconds per signal which is
not relevant for e.g. a kernel build, but for signal heavy workloads it's
measurable.

As there is no real downside of this caching mechanism making it
unconditionally available is preferred over more conditional code or new
magic tunables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove the realtime task restriction and get rid of the cmpxchg()
    (Eric, Oleg)
    Add more information to the changelog.
---
 include/linux/sched.h |    1 +
 kernel/fork.c         |    1 +
 kernel/signal.c       |   22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -985,6 +985,7 @@ struct task_struct {
 	/* Signal handlers: */
 	struct signal_struct		*signal;
 	struct sighand_struct __rcu		*sighand;
+	struct sigqueue			*sigqueue_cache;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1993,6 +1993,7 @@ static __latent_entropy struct task_stru
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
+	p->sigqueue_cache = NULL;
 
 	p->utime = p->stime = p->gtime = 0;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -433,7 +433,11 @@ static struct sigqueue *
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		/* Preallocation does not hold sighand::siglock */
+		if (sigqueue_flags || !t->sigqueue_cache)
+			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		else
+			q = xchg(&t->sigqueue_cache, NULL);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -456,7 +460,12 @@ static void __sigqueue_free(struct sigqu
 		return;
 	if (atomic_dec_and_test(&q->user->sigpending))
 		free_uid(q->user);
-	kmem_cache_free(sigqueue_cachep, q);
+
+	/* Cache one sigqueue per task */
+	if (!current->sigqueue_cache)
+		current->sigqueue_cache = q;
+	else
+		kmem_cache_free(sigqueue_cachep, q);
 }
 
 void flush_sigqueue(struct sigpending *queue)
@@ -472,12 +481,19 @@ void flush_sigqueue(struct sigpending *q
 }
 
 /*
- * Called from __exit_signal. Flush tsk->pending and clear tsk->sighand.
+ * Called from __exit_signal. Flush tsk->pending, clear tsk->sighand and
+ * free tsk->sigqueue_cache.
  */
 void exit_task_sighand(struct task_struct *tsk)
 {
+	struct sigqueue *q;
+
 	flush_sigqueue(&tsk->pending);
 	tsk->sighand = NULL;
+
+	q = xchg(&tsk->sigqueue_cache, NULL);
+	if (q)
+		kmem_cache_free(sigqueue_cachep, q);
 }
 
 /*

