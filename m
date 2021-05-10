Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D669B37922A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhEJPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:12:53 -0400
Received: from foss.arm.com ([217.140.110.172]:60728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235938AbhEJPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:12:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2886B1692;
        Mon, 10 May 2021 08:11:19 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2115F3F719;
        Mon, 10 May 2021 08:11:18 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bristot@redhat.com, yejune.deng@gmail.com
Subject: [PATCH 1/2] sched: Make the idle task quack like a per-CPU kthread
Date:   Mon, 10 May 2021 16:10:23 +0100
Message-Id: <20210510151024.2448573-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210510151024.2448573-1-valentin.schneider@arm.com>
References: <20210510151024.2448573-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all intents and purposes, the idle task is a per-CPU kthread. It isn't
created via the same route as other pcpu kthreads however, and as a result
it is missing a few bells and whistles: it fails kthread_is_per_cpu() and
it doesn't have PF_NO_SETAFFINITY set.

Fix the former by giving the idle task a kthread struct along with the
KTHREAD_IS_PER_CPU flag. This requires some extra iffery as init_idle()
call be called more than once on the same idle task.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/kthread.h |  2 ++
 kernel/kthread.c        | 30 ++++++++++++++++++------------
 kernel/sched/core.c     | 21 +++++++++++++++------
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2484ed97e72f..d9133d6db308 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -33,6 +33,8 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  unsigned int cpu,
 					  const char *namefmt);
 
+void set_kthread_struct(struct task_struct *p);
+
 void kthread_set_per_cpu(struct task_struct *k, int cpu);
 bool kthread_is_per_cpu(struct task_struct *k);
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 6d3c488a0f82..77dd0ea1d35d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -68,16 +68,6 @@ enum KTHREAD_BITS {
 	KTHREAD_SHOULD_PARK,
 };
 
-static inline void set_kthread_struct(void *kthread)
-{
-	/*
-	 * We abuse ->set_child_tid to avoid the new member and because it
-	 * can't be wrongly copied by copy_process(). We also rely on fact
-	 * that the caller can't exec, so PF_KTHREAD can't be cleared.
-	 */
-	current->set_child_tid = (__force void __user *)kthread;
-}
-
 static inline struct kthread *to_kthread(struct task_struct *k)
 {
 	WARN_ON(!(k->flags & PF_KTHREAD));
@@ -103,6 +93,22 @@ static inline struct kthread *__to_kthread(struct task_struct *p)
 	return kthread;
 }
 
+void set_kthread_struct(struct task_struct *p)
+{
+	struct kthread *kthread;
+
+	if (__to_kthread(p))
+		return;
+
+	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
+	/*
+	 * We abuse ->set_child_tid to avoid the new member and because it
+	 * can't be wrongly copied by copy_process(). We also rely on fact
+	 * that the caller can't exec, so PF_KTHREAD can't be cleared.
+	 */
+	p->set_child_tid = (__force void __user *)kthread;
+}
+
 void free_kthread_struct(struct task_struct *k)
 {
 	struct kthread *kthread;
@@ -272,8 +278,8 @@ static int kthread(void *_create)
 	struct kthread *self;
 	int ret;
 
-	self = kzalloc(sizeof(*self), GFP_KERNEL);
-	set_kthread_struct(self);
+	set_kthread_struct(current);
+	self = to_kthread(current);
 
 	/* If user was SIGKILLed, I release the structure. */
 	done = xchg(&create->done, NULL);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a0668acd876..5bb720829d93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7440,12 +7440,25 @@ void init_idle(struct task_struct *idle, int cpu)
 
 	__sched_fork(0, idle);
 
+	/*
+	 * The idle task doesn't need the kthread struct to function, but it
+	 * is dressed up as a per-CPU kthread and thus needs to play the part
+	 * if we want to avoid special-casing it in code that deals with per-CPU
+	 * kthreads.
+	 */
+	set_kthread_struct(idle);
+
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_lock(&rq->lock);
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
-	idle->flags |= PF_IDLE;
+	/*
+	 * PF_KTHREAD should already be set at this point; regardless, make it
+	 * look like a proper per-CPU kthread.
+	 */
+	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	kthread_set_per_cpu(idle, cpu);
 
 	scs_task_reset(idle);
 	kasan_unpoison_task_stack(idle);
@@ -7662,12 +7675,8 @@ static void balance_push(struct rq *rq)
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
-	 *
-	 * XXX: the idle task does not match kthread_is_per_cpu() due to
-	 * histerical raisins.
 	 */
-	if (rq->idle == push_task ||
-	    kthread_is_per_cpu(push_task) ||
+	if (kthread_is_per_cpu(push_task) ||
 	    is_migration_disabled(push_task)) {
 
 		/*
-- 
2.25.1

