Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08C343CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCVJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCVJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:28:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2948C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:28:41 -0700 (PDT)
Message-Id: <20210322092259.067712342@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616405320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7K2EPBKHgSmyUIUjynimZ1M/NZifCtxQWE95Wst7mRc=;
        b=SLlVUBt+lC/5UrZ9Mu8/PIaeZNHmkFHmvBrOeS91Dw0rd2o/MG/PnjCcZrf2frThdSZgCP
        aBiVOqPzQVq6RA+BZ/ofk4e0jdEZ1Tl2yJlpLVDhuOdC4UeWEKa4e9g0VmHpBYVpnoUEsu
        pbZ+95dMhOy8v40zTarQMLu2AiKN2lFzjl1XJjvfgaPeOCoWZPfoshNrjJwu5zcOVUP8+L
        YyNME9zMv9WtI/7WP+2lKVihq7acfYmXc1CoiTl5HOJjLjPjAqCsii3IbWnZLVGYfZhmUX
        H/nfL2MGVZcgDu3mg6c1lmqK9TkGeYtXw9UPVNRBMRHGQWMWMekCZXll+/R2tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616405320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7K2EPBKHgSmyUIUjynimZ1M/NZifCtxQWE95Wst7mRc=;
        b=VZHh+XfKL+Gn+cHlaTlkOd/JioMpVWIucSUXkRlsCogE81cybNptxOntJiONGJXXwaKHFX
        5u/4I9ExZK8VgkCw==
Date:   Mon, 22 Mar 2021 10:19:43 +0100
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
Subject: [patch V4 2/2] signal: Allow tasks to cache one sigqueue struct
References: <20210322091941.909544288@linutronix.de>
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
V4: Handle the self reaping case correctly (Oleg)

V3: Use READ/WRITE_ONCE() for the cache operations and add commentry
    for it.

V2: Remove the realtime task restriction and get rid of the cmpxchg()
    (Eric, Oleg)
    Add more information to the changelog.
---
 include/linux/sched.h  |    1 +
 include/linux/signal.h |    1 +
 kernel/exit.c          |    1 +
 kernel/fork.c          |    1 +
 kernel/signal.c        |   41 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 43 insertions(+), 2 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -984,6 +984,7 @@ struct task_struct {
 	/* Signal handlers: */
 	struct signal_struct		*signal;
 	struct sighand_struct __rcu		*sighand;
+	struct sigqueue			*sigqueue_cache;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -265,6 +265,7 @@ static inline void init_sigpending(struc
 }
 
 extern void flush_sigqueue(struct sigpending *queue);
+extern void exit_task_sigqueue_cache(struct task_struct *tsk);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -162,6 +162,7 @@ static void __exit_signal(struct task_st
 		flush_sigqueue(&sig->shared_pending);
 		tty_kref_put(tty);
 	}
+	exit_task_sigqueue_cache(tsk);
 }
 
 static void delayed_put_task_struct(struct rcu_head *rhp)
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2003,6 +2003,7 @@ static __latent_entropy struct task_stru
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
@@ -450,13 +459,41 @@ static struct sigqueue *
 	return q;
 }
 
+static void sigqueue_cache_or_free(struct sigqueue *q, bool cache)
+{
+	/*
+	 * Cache one sigqueue per task. This pairs with the consumer side
+	 * in __sigqueue_alloc() and needs READ/WRITE_ONCE() to prevent the
+	 * compiler from store tearing and to tell KCSAN that the data race
+	 * is intentional when run without holding current->sighand->siglock,
+	 * which is fine as current obviously cannot run __sigqueue_free()
+	 * concurrently.
+	 */
+	if (cache && !READ_ONCE(current->sigqueue_cache))
+		WRITE_ONCE(current->sigqueue_cache, q);
+	else
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
+void exit_task_sigqueue_cache(struct task_struct *tsk)
+{
+	/* Race free because @tsk is mopped up */
+	struct sigqueue *q = tsk->sigqueue_cache;
+
+	if (q) {
+		tsk->sigqueue_cache = NULL;
+		/* If task is self reaping, don't cache it back */
+		sigqueue_cache_or_free(q, tsk != current);
+	}
+}
+
 static void __sigqueue_free(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
 	if (atomic_dec_and_test(&q->user->sigpending))
 		free_uid(q->user);
-	kmem_cache_free(sigqueue_cachep, q);
+	sigqueue_cache_or_free(q, true);
 }
 
 void flush_sigqueue(struct sigpending *queue)

