Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF06632BECB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575847AbhCCRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:36:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443809AbhCCOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:21:10 -0500
Date:   Wed, 3 Mar 2021 15:20:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614781226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Uygo4+pN9ZU+8SJPswqacGqnDLCgMpJOpodWvXLFwxo=;
        b=IHN2RlA7MqSG+MK8+7hHOuyUr0Gec8kXqm/Pu1TJb3O7tQ6w5JRM/si7zgZzdB771l2dt7
        l9NluabgSEOTjFLDXKn0JoIN5RdzhqhUfrfSv3u0osyfbRryp6W3NLYmlowwjiPrhKvniA
        aKj8+pr5PbaalW4WEguvnNT+wT7Uub6686shCWeWvxUVjmt3wF8iuP5xvILrRz+8Ck7JUy
        QPpHaC8uIRtvG+TEAjbYc22TPYvCb+gZCgdDlV4oen7pUdMdvP5ysCGwZRfJH18LIVv/VT
        3GhBb3OhZEF2W4sp+fwwghsjd8YEUa1dOoRg77rigWHsZl35/1ctURvm8sdKnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614781226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Uygo4+pN9ZU+8SJPswqacGqnDLCgMpJOpodWvXLFwxo=;
        b=DjdEZKqvRRMWo4z4Lawa4+aVY/rfFn8XJosEqfnftJZNDI6+pkWIVfNPR00g+tCNM9Z74/
        K/BE8mNB5UA9mODg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
Message-ID: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allow realtime tasks to cache one sigqueue in task struct. This avoids an
allocation which can increase the latency or fail.
Ideally the sigqueue is cached after first successful delivery and will be
available for next signal delivery. This works under the assumption that the RT
task has never an unprocessed signal while a one is about to be queued.

The caching is not used for SIGQUEUE_PREALLOC because this kind of sigqueue is
handled differently (and not used for regular signal delivery).

[bigeasy: With a fix from Matt Fleming <matt@codeblueprint.co.uk>]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h  |  1 +
 include/linux/signal.h |  1 +
 kernel/exit.c          |  2 +-
 kernel/fork.c          |  1 +
 kernel/signal.c        | 65 +++++++++++++++++++++++++++++++++++++++---
 5 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb22164cd..7009b25f48160 100644
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
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c4003aa..d47a86790edc8 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -265,6 +265,7 @@ static inline void init_sigpending(struct sigpending *sig)
 }
 
 extern void flush_sigqueue(struct sigpending *queue);
+extern void flush_task_sigqueue(struct task_struct *tsk);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e35e69af..346f7b76cecaa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -152,7 +152,7 @@ static void __exit_signal(struct task_struct *tsk)
 	 * Do this under ->siglock, we can race with another thread
 	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
 	 */
-	flush_sigqueue(&tsk->pending);
+	flush_task_sigqueue(tsk);
 	tsk->sighand = NULL;
 	spin_unlock(&sighand->siglock);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211b..a767e4e49a692 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1993,6 +1993,7 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
+	p->sigqueue_cache = NULL;
 
 	p->utime = p->stime = p->gtime = 0;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef39a9ea..d99273b798085 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/rt.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
@@ -404,13 +405,30 @@ void task_join_group_stop(struct task_struct *task)
 	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
+static struct sigqueue *sigqueue_from_cache(struct task_struct *t)
+{
+	struct sigqueue *q = t->sigqueue_cache;
+
+	if (q && cmpxchg(&t->sigqueue_cache, q, NULL) == q)
+		return q;
+	return NULL;
+}
+
+static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
+{
+	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
+		return true;
+	return false;
+}
+
 /*
  * allocate a new signal queue record
  * - this may be called without locks if and only if t == current, otherwise an
  *   appropriate lock must be held to stop the target task from exiting
  */
 static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimit)
+__sigqueue_do_alloc(int sig, struct task_struct *t, gfp_t flags,
+		    int override_rlimit, bool fromslab)
 {
 	struct sigqueue *q = NULL;
 	struct user_struct *user;
@@ -432,7 +450,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, flags);
+		if (!fromslab)
+			q = sigqueue_from_cache(t);
+		if (!q)
+			q = kmem_cache_alloc(sigqueue_cachep, flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -449,6 +470,13 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
 	return q;
 }
 
+static struct sigqueue *
+__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags,
+		 int override_rlimit)
+{
+	return __sigqueue_do_alloc(sig, t, flags, override_rlimit, false);
+}
+
 static void __sigqueue_free(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
@@ -458,6 +486,20 @@ static void __sigqueue_free(struct sigqueue *q)
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
+static void __sigqueue_cache_or_free(struct sigqueue *q)
+{
+	struct user_struct *up;
+
+	if (q->flags & SIGQUEUE_PREALLOC)
+		return;
+
+	up = q->user;
+	if (atomic_dec_and_test(&up->sigpending))
+		free_uid(up);
+	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
 void flush_sigqueue(struct sigpending *queue)
 {
 	struct sigqueue *q;
@@ -470,6 +512,21 @@ void flush_sigqueue(struct sigpending *queue)
 	}
 }
 
+/*
+ * Called from __exit_signal. Flush tsk->pending and
+ * tsk->sigqueue_cache
+ */
+void flush_task_sigqueue(struct task_struct *tsk)
+{
+	struct sigqueue *q;
+
+	flush_sigqueue(&tsk->pending);
+
+	q = sigqueue_from_cache(tsk);
+	if (q)
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
 /*
  * Flush all pending signals for this kthread.
  */
@@ -594,7 +651,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 			(info->si_code == SI_TIMER) &&
 			(info->si_sys_private);
 
-		__sigqueue_free(first);
+		__sigqueue_cache_or_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -1807,7 +1864,7 @@ EXPORT_SYMBOL(kill_pid);
  */
 struct sigqueue *sigqueue_alloc(void)
 {
-	struct sigqueue *q = __sigqueue_alloc(-1, current, GFP_KERNEL, 0);
+	struct sigqueue *q = __sigqueue_do_alloc(-1, current, GFP_KERNEL, 0, true);
 
 	if (q)
 		q->flags |= SIGQUEUE_PREALLOC;
-- 
2.30.1

