Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E065339DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCMLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhCMLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:17:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 03:17:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615634270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWR9w35LU6JQL3tnc1gYid+ESDhBaWrk3Ixdx+usV9A=;
        b=MUl5U+cR70WcPaxlhfT9YfnL2fdrPqKtxbxOcv4TJTC8x/PuksbtP0ms8U0ihuJntgR4Ey
        Nxkodmymf//a85Z2cEsitHXz60oZTSAZNAjFKd51covNDCqJXv+Jy+xGZ1UE5Q0poDVxJj
        f3n+zjZYm0geJ6BkrSm2ZtyJemnOgoRQopEmCFEyz9+HVniIcDB9k4DOYZiIJn/IfUF2ZU
        +8cFGKXwCzQfLIJGr3nZF4sCNipZyc67LSoj6oYp1YFewYD67ZisLXSDV/5oVeEunvGH+b
        S+bUbq2pgpF9nSxNtcJWWtl3WYoyDGdvnHGJCdH6SGWdOLTOa684/RPav8L5WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615634270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWR9w35LU6JQL3tnc1gYid+ESDhBaWrk3Ixdx+usV9A=;
        b=rhCyQfZxidKxAQRWDrqWrC8n3ydJ/gRqO9mgU303iPIhiVOhVx5j4NH4LXV3AFXY+NzBHD
        x4MU7ZAmSuaZc9Bw==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
Subject: [patch V3 3/3] signal: Allow tasks to cache one sigqueue struct
In-Reply-To: <871rck2hze.fsf@nanos.tec.linutronix.de>
References: <20210311132036.228542540@linutronix.de> <20210311141704.424120350@linutronix.de> <20210312161148.GA25946@redhat.com> <87blbo2my0.fsf@nanos.tec.linutronix.de> <871rck2hze.fsf@nanos.tec.linutronix.de>
Date:   Sat, 13 Mar 2021 12:17:49 +0100
Message-ID: <87pn031ew2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Thomas Gleixner <tglx@linutronix.de>
Subject: signal: Allow tasks to cache one sigqueue struct
Date: Wed, 03 Mar 2021 15:20:25 +0100

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

V3: Use READ/WRITE_ONCE() for the cache operations and add commentry
    for it.
---
 include/linux/sched.h |    1 +
 kernel/fork.c         |    1 +
 kernel/signal.c       |   41 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 40 insertions(+), 3 deletions(-)

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
@@ -1995,6 +1995,7 @@ static __latent_entropy struct task_stru
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
+	p->sigqueue_cache = NULL;
 
 	p->utime = p->stime = p->gtime = 0;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -433,7 +433,16 @@ static struct sigqueue *
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		/*
+		 * Preallocation does not hold sighand::siglock so it can't
+		 * use the cache. The lockless caching requires that only
+		 * one consumer and only one producer run at a time.
+		 */
+		q = READ_ONCE(t->sigqueue_cache);
+		if (!q || sigqueue_flags)
+			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		else
+			WRITE_ONCE(t->sigqueue_cache, NULL);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -450,13 +459,29 @@ static struct sigqueue *
 	return q;
 }
 
+static void sigqueue_cache_or_free(struct sigqueue *q)
+{
+	/*
+	 * Cache one sigqueue per task. This pairs with the consumer side
+	 * in __sigqueue_alloc() and needs READ/WRITE_ONCE() to prevent the
+	 * compiler from store tearing and to tell KCSAN that the data race
+	 * is intentional when run without holding current->sighand->siglock,
+	 * which is fine as current obviously cannot run __sigqueue_free()
+	 * concurrently.
+	 */
+	if (!READ_ONCE(current->sigqueue_cache))
+		WRITE_ONCE(current->sigqueue_cache, q);
+	else
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
 static void __sigqueue_free(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
 	if (atomic_dec_and_test(&q->user->sigpending))
 		free_uid(q->user);
-	kmem_cache_free(sigqueue_cachep, q);
+	sigqueue_cache_or_free(q);
 }
 
 void flush_sigqueue(struct sigpending *queue)
@@ -472,12 +497,22 @@ void flush_sigqueue(struct sigpending *q
 }
 
 /*
- * Called from __exit_signal. Flush tsk->pending and clear tsk->sighand.
+ * Called from __exit_signal(). Flush tsk->pending, clear tsk->sighand and
+ * free tsk->sigqueue_cache.
  */
 void exit_task_sighand(struct task_struct *tsk)
 {
+	struct sigqueue *q;
+
 	flush_sigqueue(&tsk->pending);
 	tsk->sighand = NULL;
+
+	/* Race free because @tsk is mopped up */
+	q = tsk->sigqueue_cache;
+	if (q) {
+		tsk->sigqueue_cache = NULL;
+		sigqueue_cache_or_free(q);
+	}
 }
 
 /*
