Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785093DEB35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhHCKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235058AbhHCKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627987521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jKgg9/d8334eBYt/1ABSUHMbzu4iE6tM1orTJdxi55A=;
        b=fbYKD/lBNBLpkh9GjxhXehuLtekEFvSrM5wM+R0fVB1CuEaxo2baRbHk1oxvPeYfj8iukW
        InAS0IRoWcEsUvx0hNPSxaS+BVas0RlC3z/ht56mM+RvnZg3ZX0QARBZt2ajYIcFnbzq3n
        Xx9z50YvtjAk+yE/CcHPwuCCrLu4zWE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-zk2wBvp9NZ6T2NLfnAq_UQ-1; Tue, 03 Aug 2021 06:45:20 -0400
X-MC-Unique: zk2wBvp9NZ6T2NLfnAq_UQ-1
Received: by mail-ej1-f70.google.com with SMTP id nb40-20020a1709071ca8b02905992266c319so2401367ejc.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKgg9/d8334eBYt/1ABSUHMbzu4iE6tM1orTJdxi55A=;
        b=nwBifuidc9cdn/VcjzClLeRg81obYBWuS4nZ6QPt/O56OxTVKE2BTmD+M04iELHVUB
         mJohZFswQmrbqt5thhZ2VMzOxukNHUJEAl5oARxhKQgaxsuph8BFwLcWbMjlFg94M95e
         EEHV7E2c6ofeECWAGgTjv4ei1VpXpkQyq73wfCOWiiF1PC9ZXZtLnTS0nILRYFDAxjd6
         XJiesDcMwd9x5/zrErR7V5F5FJK4VN7x9gUAXXYnkNzfOuUaESsKBrP2ScP0jj7Ljhfo
         76uieZ9bHYoFqLfJ8J6/XHzMvIuHbiGH7+E2RSepsh8EBDmvDPxCR5PrEjXhCiQtGtkP
         pIGA==
X-Gm-Message-State: AOAM5308jGWaH/CJh195cJg2pBnxIt/nQ1UUfzmqeB9P15sUqV7lGv6d
        Paypfq3A4UQUWOt5z7B6pb4F225YZw8uN9+cNQLBoChxqJ9Eo76ERC0u3zl6mlB3swSfAYAyHAx
        tKZb04fNqgLcFb2ymatFk0ZvT
X-Received: by 2002:aa7:c042:: with SMTP id k2mr25156561edo.104.1627987518814;
        Tue, 03 Aug 2021 03:45:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPBJbv0PItHSEze5gql55lCJ9qClCLtQRaeXCgZ0XkChOhizSm0GIteumE7y859q/p48giEA==
X-Received: by 2002:aa7:c042:: with SMTP id k2mr25156544edo.104.1627987518512;
        Tue, 03 Aug 2021 03:45:18 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.73.156])
        by smtp.gmail.com with ESMTPSA id x4sm5859663ejb.106.2021.08.03.03.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:45:17 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bristot@redhat.com,
        bsegall@google.com, mgorman@suse.de,
        Mark Simmons <msimmons@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2] sched/rt: Fix double enqueue caused by rt_effective_prio
Date:   Tue,  3 Aug 2021 12:45:01 +0200
Message-Id: <20210803104501.38333-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Double enqueues in rt runqueues (list) have been reported while running
a simple test that spawns a number of threads doing a short sleep/run
pattern while being concurrently setscheduled between rt and fair class.

WARNING: CPU: 3 PID: 2825 at kernel/sched/rt.c:1294 enqueue_task_rt+0x355/0x360
CPU: 3 PID: 2825 Comm: setsched__13
RIP: 0010:enqueue_task_rt+0x355/0x360
Call Trace:
 __sched_setscheduler+0x581/0x9d0
 _sched_setscheduler+0x63/0xa0
 do_sched_setscheduler+0xa0/0x150
 __x64_sys_sched_setscheduler+0x1a/0x30
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

list_add double add: new=ffff9867cb629b40, prev=ffff9867cb629b40,
                     next=ffff98679fc67ca0.
kernel BUG at lib/list_debug.c:31!
invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
CPU: 3 PID: 2825 Comm: setsched__13
RIP: 0010:__list_add_valid+0x41/0x50
Call Trace:
 enqueue_task_rt+0x291/0x360
 __sched_setscheduler+0x581/0x9d0
 _sched_setscheduler+0x63/0xa0
 do_sched_setscheduler+0xa0/0x150
 __x64_sys_sched_setscheduler+0x1a/0x30
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

__sched_setscheduler() uses rt_effective_prio() to handle proper queuing
of priority boosted tasks that are setscheduled while being boosted.
rt_effective_prio() is however called twice per each
__sched_setscheduler() call: first directly by __sched_setscheduler()
before dequeuing the task and then by __setscheduler() to actually do
the priority change. If the priority of the pi_top_task is concurrently
being changed however, it might happen that the two calls return
different results. If, for example, the first call returned the same rt
priority the task was running at and the second one a fair priority, the
task won't be removed by the rt list (on_list still set) and then
enqueued in the fair runqueue. When eventually setscheduled back to rt
it will be seen as enqueued already and the WARNING/BUG be issued.

Fix this by calling rt_effective_prio() only once and then reusing the
return value. While at it refactor code as well for clarity. Concurrent
priority inheritance handling is still safe and will eventually converge
to a new state by following the inheritance chain(s).

Fixes: 0782e63bc6fe ("sched: Handle priority boosted tasks proper in setscheduler()")
Reported-by: Mark Simmons <msimmons@redhat.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
[squashed Peterz changes; added changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Changes since v1:
  - correct fixes tag
  - big refactor
---
 kernel/sched/core.c | 90 ++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd026440..5006b62878f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1978,12 +1978,18 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
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
@@ -1995,15 +2001,7 @@ static inline int __normal_prio(struct task_struct *p)
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
@@ -4096,7 +4094,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		} else if (PRIO_TO_NICE(p->static_prio) < 0)
 			p->static_prio = NICE_TO_PRIO(0);
 
-		p->prio = p->normal_prio = __normal_prio(p);
+		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
 		/*
@@ -6338,6 +6336,18 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
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
@@ -6453,22 +6463,19 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
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
@@ -6821,35 +6828,6 @@ static void __setscheduler_params(struct task_struct *p,
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
@@ -6870,10 +6848,8 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -7071,6 +7047,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
+	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
 	if (pi) {
 		/*
 		 * Take priority boosted tasks into account. If the new
@@ -7079,8 +7056,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		 * the runqueue. This will be done when the task deboost
 		 * itself.
 		 */
-		new_effective_prio = rt_effective_prio(p, newprio);
-		if (new_effective_prio == oldprio)
+		newprio = rt_effective_prio(p, newprio);
+		if (newprio == oldprio)
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
@@ -7093,7 +7070,10 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
-	__setscheduler(rq, p, attr, pi);
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+		__setscheduler_params(p, attr);
+		__setscheduler_prio(p, newprio);
+	}
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
-- 
2.31.1

