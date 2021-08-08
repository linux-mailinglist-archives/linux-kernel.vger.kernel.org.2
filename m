Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1B3E3A02
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhHHLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHHLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:34:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4818C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 04:34:22 -0700 (PDT)
Date:   Sun, 08 Aug 2021 11:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628422461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=i+0M6fqokdwqeBrRLAa1fng0E7L3a9JKaydUndni/Ak=;
        b=dCDoKo+0K6D9ec4MoZPhcq/tgHA5+FhMA0MNImtSfVM1NR+JbTcv3abCy0mHSMgCcJwyqb
        MM2xzEbD+/NBwZQc53vMNNkcJXXrYaY/HgyZ1IYH05u7AQs1NdhvUQC1TwH+JJwQ2Lcj5a
        6+d4D1dbPoFIYSIclqbODvVUOlpy+y0nwb0Arj9jXfyi+O4Dfk5rggJkfYVpxUUftYAFvb
        MoQA2QlaPn8DH+kCeDunRcKM+IF2GuB+6HVawjXuQzPNEOYYn8728C1m0KPgu6HeHeyyVv
        6kMKFMo4s40sh+JeNV/0EOBR1Hmp0XgCPsHi9szxRtwx3uZ60jQ8W8cZWHtFgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628422461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=i+0M6fqokdwqeBrRLAa1fng0E7L3a9JKaydUndni/Ak=;
        b=5M4A2idxEavTmKpqbBGCFIRvvyneEQUjxZnJjnvfO6Ka6GNymjP6fcwoEJKEnldfcddMSX
        ZLBCePletmUAYVDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.14-rc5
References: <162842243492.9524.2294192686333344509.tglx@xen13>
Message-ID: <162842243640.9524.17249767231918700773.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-08-08

up to:  f558c2b834ec: sched/rt: Fix double enqueue caused by rt_effective_prio


A single scheduler fix:

 - Prevent a double enqueue caused by rt_effective_prio() being invoked
   twice in __sched_setscheduler().


Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      sched/rt: Fix double enqueue caused by rt_effective_prio


 kernel/sched/core.c | 90 +++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..20ffcc044134 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1981,12 +1981,18 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-/*
- * __normal_prio - return the priority that is based on the static prio
- */
-static inline int __normal_prio(struct task_struct *p)
+static inline int __normal_prio(int policy, int rt_prio, int nice)
 {
-	return p->static_prio;
+	int prio;
+
+	if (dl_policy(policy))
+		prio = MAX_DL_PRIO - 1;
+	else if (rt_policy(policy))
+		prio = MAX_RT_PRIO - 1 - rt_prio;
+	else
+		prio = NICE_TO_PRIO(nice);
+
+	return prio;
 }
 
 /*
@@ -1998,15 +2004,7 @@ static inline int __normal_prio(struct task_struct *p)
  */
 static inline int normal_prio(struct task_struct *p)
 {
-	int prio;
-
-	if (task_has_dl_policy(p))
-		prio = MAX_DL_PRIO-1;
-	else if (task_has_rt_policy(p))
-		prio = MAX_RT_PRIO-1 - p->rt_priority;
-	else
-		prio = __normal_prio(p);
-	return prio;
+	return __normal_prio(p->policy, p->rt_priority, PRIO_TO_NICE(p->static_prio));
 }
 
 /*
@@ -4099,7 +4097,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		} else if (PRIO_TO_NICE(p->static_prio) < 0)
 			p->static_prio = NICE_TO_PRIO(0);
 
-		p->prio = p->normal_prio = __normal_prio(p);
+		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
 		/*
@@ -6341,6 +6339,18 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
+static void __setscheduler_prio(struct task_struct *p, int prio)
+{
+	if (dl_prio(prio))
+		p->sched_class = &dl_sched_class;
+	else if (rt_prio(prio))
+		p->sched_class = &rt_sched_class;
+	else
+		p->sched_class = &fair_sched_class;
+
+	p->prio = prio;
+}
+
 #ifdef CONFIG_RT_MUTEXES
 
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
@@ -6456,22 +6466,19 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		} else {
 			p->dl.pi_se = &p->dl;
 		}
-		p->sched_class = &dl_sched_class;
 	} else if (rt_prio(prio)) {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
 		if (oldprio < prio)
 			queue_flag |= ENQUEUE_HEAD;
-		p->sched_class = &rt_sched_class;
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
 		if (rt_prio(oldprio))
 			p->rt.timeout = 0;
-		p->sched_class = &fair_sched_class;
 	}
 
-	p->prio = prio;
+	__setscheduler_prio(p, prio);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -6824,35 +6831,6 @@ static void __setscheduler_params(struct task_struct *p,
 	set_load_weight(p, true);
 }
 
-/* Actually do priority change: must hold pi & rq lock. */
-static void __setscheduler(struct rq *rq, struct task_struct *p,
-			   const struct sched_attr *attr, bool keep_boost)
-{
-	/*
-	 * If params can't change scheduling class changes aren't allowed
-	 * either.
-	 */
-	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		return;
-
-	__setscheduler_params(p, attr);
-
-	/*
-	 * Keep a potential priority boosting if called from
-	 * sched_setscheduler().
-	 */
-	p->prio = normal_prio(p);
-	if (keep_boost)
-		p->prio = rt_effective_prio(p, p->prio);
-
-	if (dl_prio(p->prio))
-		p->sched_class = &dl_sched_class;
-	else if (rt_prio(p->prio))
-		p->sched_class = &rt_sched_class;
-	else
-		p->sched_class = &fair_sched_class;
-}
-
 /*
  * Check the target process has a UID that matches the current process's:
  */
@@ -6873,10 +6851,8 @@ static int __sched_setscheduler(struct task_struct *p,
 				const struct sched_attr *attr,
 				bool user, bool pi)
 {
-	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
-		      MAX_RT_PRIO - 1 - attr->sched_priority;
-	int retval, oldprio, oldpolicy = -1, queued, running;
-	int new_effective_prio, policy = attr->sched_policy;
+	int oldpolicy = -1, policy = attr->sched_policy;
+	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
 	struct callback_head *head;
 	struct rq_flags rf;
@@ -7074,6 +7050,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
+	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
 	if (pi) {
 		/*
 		 * Take priority boosted tasks into account. If the new
@@ -7082,8 +7059,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		 * the runqueue. This will be done when the task deboost
 		 * itself.
 		 */
-		new_effective_prio = rt_effective_prio(p, newprio);
-		if (new_effective_prio == oldprio)
+		newprio = rt_effective_prio(p, newprio);
+		if (newprio == oldprio)
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
@@ -7096,7 +7073,10 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
-	__setscheduler(rq, p, attr, pi);
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+		__setscheduler_params(p, attr);
+		__setscheduler_prio(p, newprio);
+	}
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {

