Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95A2351C44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhDASP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhDAR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:57:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF2C08EC37
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PKU8tH4+tYYpH4/h1zmIIJEZAPehUqp+9c60qXsZpd4=; b=Z5yB+lkYTBwZG9QLB/rpDKbnct
        jN7CTJ/YUuOUBFPeLdQR88g4csKagBi3IUUp3ZiBcReQ74pvisX6M0mS0Oh5JqBvi4aFuvuw25vsN
        SYPGjnRNo9YBxfXOXM3LPOnlR/uJDhUd+11VVtk2EhrM39a8R2oMZ972lPw2zcTYlBNrNIm37+OKz
        bkk7KWVOrtPvOPETbpxTcwsaFIIWNRnkXzfe33YP6hXVnnf13dFO8In1kMF9xw6VSToMRbRNHznsC
        UkGdceRC5smO6lqhi/ZOfbG3bpt3MqrYxenxxk1t0KhdEFkvE3lu7lfVzkJQrXOQqfLCoha1J1MFZ
        Wsen/GYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxap-009iuI-Sa; Thu, 01 Apr 2021 13:44:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09FF6307001;
        Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D217D24C1A524; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.291069972@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 4/9] sched: Default core-sched policy
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement default core scheduling policy.

 - fork() / clone(): inherit cookie from parent
 - exec(): if cookie then new cookie

Did that exec() thing want to change cookie on suid instead, just like
perf_event_exit_task() ?

Note that sched_core_fork() is called from under tasklist_lock, and
not from sched_fork() earlier. This avoids a few races later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/exec.c                  |    4 +++-
 include/linux/sched.h      |    4 ++++
 include/linux/sched/task.h |    4 ++--
 kernel/fork.c              |    3 +++
 kernel/sched/core.c        |   11 +++++++++--
 kernel/sched/core_sched.c  |   21 +++++++++++++++++++++
 6 files changed, 42 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1807,7 +1807,9 @@ static int bprm_execve(struct linux_binp
 	if (IS_ERR(file))
 		goto out_unmark;
 
-	sched_exec();
+	retval = sched_exec();
+	if (retval)
+		goto out;
 
 	bprm->file = file;
 	/*
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2171,8 +2171,12 @@ const struct cpumask *sched_trace_rd_spa
 
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
+extern int sched_core_exec(void);
+extern void sched_core_fork(struct task_struct *p);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
+static inline int sched_core_exec(void) { return 0; }
+static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
 #endif
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -94,9 +94,9 @@ extern void free_task(struct task_struct
 
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
-extern void sched_exec(void);
+extern int sched_exec(void);
 #else
-#define sched_exec()   {}
+static inline int sched_exec(void) { return 0; }
 #endif
 
 static inline struct task_struct *get_task_struct(struct task_struct *t)
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2242,6 +2242,8 @@ static __latent_entropy struct task_stru
 
 	klp_copy_process(p);
 
+	sched_core_fork(p);
+
 	spin_lock(&current->sighand->siglock);
 
 	/*
@@ -2329,6 +2331,7 @@ static __latent_entropy struct task_stru
 	return p;
 
 bad_fork_cancel_cgroup:
+	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4762,11 +4762,17 @@ unsigned long nr_iowait(void)
  * sched_exec - execve() is a valuable balancing opportunity, because at
  * this point the task has the smallest effective memory and cache footprint.
  */
-void sched_exec(void)
+int sched_exec(void)
 {
 	struct task_struct *p = current;
 	unsigned long flags;
 	int dest_cpu;
+	int ret;
+
+	/* this may change what tasks current can share a core with */
+	ret = sched_core_exec();
+	if (ret)
+		return ret;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
@@ -4778,10 +4784,11 @@ void sched_exec(void)
 
 		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-		return;
+		return 0;
 	}
 unlock:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return 0;
 }
 
 #endif
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -100,7 +100,28 @@ static unsigned long sched_core_clone_co
 	return cookie;
 }
 
+void sched_core_fork(struct task_struct *p)
+{
+	RB_CLEAR_NODE(&p->core_node);
+	p->core_cookie = sched_core_clone_cookie(current);
+}
+
 void sched_core_free(struct task_struct *p)
 {
 	sched_core_put_cookie(p->core_cookie);
 }
+
+int sched_core_exec(void)
+{
+	/* absent a policy mech, if task had a cookie, give it a new one */
+	if (current->core_cookie) {
+		unsigned long cookie = sched_core_alloc_cookie();
+		if (!cookie)
+			return -ENOMEM;
+		cookie = sched_core_update_cookie(current, cookie);
+		sched_core_put_cookie(cookie);
+	}
+
+	return 0;
+}
+


