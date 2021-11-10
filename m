Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDA44CB56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 22:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhKJVhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 16:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhKJVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:37:53 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD2DC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 13:35:05 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso5958996otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 13:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/J9rodLcmKIzHSYB7H5HF/ALKSqTpESqnFX+NtRJI4=;
        b=LWsJGzo8HSCdIVykb0qgXcKfwXeU4eluwVoKHocxJUU00mmJgneP6+L6hqWEDmtVhE
         g0sJo2hC9M59wZ1MNGPqtrlKPR4yhCH69w0KktBResP9u1MAj3rudpFLJgFixyXoYRb9
         XGBXBPAah0LIk8ERzdrefV0GFpRCacNHMoOT+AYjSfMWLQOIOnJnkazvDip1pi0U0wdT
         NIRRFsAE1qm4c7ZjRSIUXCvfx99mMuokaDiijt+NW9saT0W7YEyHQJ/edIafFV+efwmE
         NXh6AoXpPll5BC07OLGqhE3e5sQi7cjeXAGerhFRi/QSPzF2ern7VIdRsK8dobZWokCY
         o48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/J9rodLcmKIzHSYB7H5HF/ALKSqTpESqnFX+NtRJI4=;
        b=m8+TOZEYCqkGSmsj1203laYqX/fz/eoA9UHrt+osoNttp4TG2filLlhcVHfJPNEQIA
         KMrT4sd7Tr/y11ORykQsIFPr5hgYx2YKpmc70fswLS9OAVhrepZ9A2zl5Ee7ViOHWBVI
         b9qWeBnT87SYTJL3GHkuJtuUw3Gp8NjScX4HsvzG9jCvKBxPa3YdMMpesWsdZVKyXkXu
         sSSzEhO559PCIXCmfNEwiDXzSH4NgdS1y/a8b/TKfREp3kbcNVBdrAeYvZ8mB/NX+iHw
         MmwNnoRjLwGVh3QbkxwkU/mfCYgbWgKFQks+pWZCiwJszJFrWMoBUXoZatxhg6Qxeyin
         QjnQ==
X-Gm-Message-State: AOAM533VL8gSD5ARh4yoovcBNV7seyphRhfpmgweEcNVMJqteil16M2H
        FWCE5jUlRTaHEhqXR5/bTyE=
X-Google-Smtp-Source: ABdhPJwmc7ptE1LY+o2CgzibvHf6YWZgmvDLlI+s4cmqxAXqN4tFHk5cVzSMm7xf7aDrOiJEkFeRrQ==
X-Received: by 2002:a05:6830:236b:: with SMTP id r11mr1924505oth.145.1636580104395;
        Wed, 10 Nov 2021 13:35:04 -0800 (PST)
Received: from instance-20210906-1041.vcn06261419.oraclevcn.com ([193.122.149.193])
        by smtp.gmail.com with ESMTPSA id bi20sm338745oib.29.2021.11.10.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 13:35:03 -0800 (PST)
From:   Brian Chen <brianchen118@gmail.com>
To:     hannes@cmpxchg.org
Cc:     brianchen118@gmail.com, brianc118@fb.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] psi: fix PSI_MEM_FULL state when tasks are in memstall and doing reclaim
Date:   Wed, 10 Nov 2021 21:33:12 +0000
Message-Id: <20211110213312.310243-1-brianchen118@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've noticed cases where tasks in a cgroup are stalled on memory but
there is little memory FULL pressure since tasks stay on the runqueue
in reclaim.

A simple example involves a single threaded program that keeps leaking
and touching large amounts of memory. It runs in a cgroup with swap
enabled, memory.high set at 10M and cpu.max ratio set at 5%. Though
there is significant CPU pressure and memory SOME, there is barely any
memory FULL since the task enters reclaim and stays on the runqueue.
However, this memory-bound task is effectively stalled on memory and
we expect memory FULL to match memory SOME in this scenario.

The code is confused about memstall && running, thinking there is a
stalled task and a productive task when there's only one task: a
reclaimer that's counted as both. To fix this, we redefine the
condition for PSI_MEM_FULL to check that all running tasks are in an
active memstall instead of checking that there are no running tasks.

        case PSI_MEM_FULL:
-               return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
+               return unlikely(tasks[NR_MEMSTALL] &&
+                       tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);

This will capture reclaimers. It will also capture tasks that called
psi_memstall_enter() and are about to sleep, but this should be
negligible noise.

Signed-off-by: Brian Chen <brianchen118@gmail.com>
---
 include/linux/psi_types.h | 13 ++++++++++-
 kernel/sched/psi.c        | 45 ++++++++++++++++++++++++---------------
 kernel/sched/stats.h      |  5 ++++-
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300d49af..0819c82dba92 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -21,7 +21,17 @@ enum psi_task_count {
 	 * don't have to special case any state tracking for it.
 	 */
 	NR_ONCPU,
-	NR_PSI_TASK_COUNTS = 4,
+	/*
+	 * For IO and CPU stalls the presence of running/oncpu tasks
+	 * in the domain means a partial rather than a full stall.
+	 * For memory it's not so simple because of page reclaimers:
+	 * they are running/oncpu while representing a stall. To tell
+	 * whether a domain has productivity left or not, we need to
+	 * distinguish between regular running (i.e. productive)
+	 * threads and memstall ones.
+	 */
+	NR_MEMSTALL_RUNNING,
+	NR_PSI_TASK_COUNTS = 5,
 };
 
 /* Task state bitmasks */
@@ -29,6 +39,7 @@ enum psi_task_count {
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
 #define TSK_ONCPU	(1 << NR_ONCPU)
+#define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2bb54b7..69b19d3af690 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -34,13 +34,19 @@
  * delayed on that resource such that nobody is advancing and the CPU
  * goes idle. This leaves both workload and CPU unproductive.
  *
- * Naturally, the FULL state doesn't exist for the CPU resource at the
- * system level, but exist at the cgroup level, means all non-idle tasks
- * in a cgroup are delayed on the CPU resource which used by others outside
- * of the cgroup or throttled by the cgroup cpu.max configuration.
- *
  *	SOME = nr_delayed_tasks != 0
- *	FULL = nr_delayed_tasks != 0 && nr_running_tasks == 0
+ *	FULL = nr_delayed_tasks != 0 && nr_productive_tasks == 0
+ *
+ * What it means for a task to be productive is defined differently
+ * for each resource. For IO, productive means a running task. For
+ * memory, productive means a running task that isn't a reclaimer. For
+ * CPU, productive means an oncpu task.
+ *
+ * Naturally, the FULL state doesn't exist for the CPU resource at the
+ * system level, but exist at the cgroup level. At the cgroup level,
+ * FULL means all non-idle tasks in the cgroup are delayed on the CPU
+ * resource which is being used by others outside of the cgroup or
+ * throttled by the cgroup cpu.max configuration.
  *
  * The percentage of wallclock time spent in those compound stall
  * states gives pressure numbers between 0 and 100 for each resource,
@@ -81,13 +87,13 @@
  *
  *	threads = min(nr_nonidle_tasks, nr_cpus)
  *	   SOME = min(nr_delayed_tasks / threads, 1)
- *	   FULL = (threads - min(nr_running_tasks, threads)) / threads
+ *	   FULL = (threads - min(nr_productive_tasks, threads)) / threads
  *
  * For the 257 number crunchers on 256 CPUs, this yields:
  *
  *	threads = min(257, 256)
  *	   SOME = min(1 / 256, 1)             = 0.4%
- *	   FULL = (256 - min(257, 256)) / 256 = 0%
+ *	   FULL = (256 - min(256, 256)) / 256 = 0%
  *
  * For the 1 out of 4 memory-delayed tasks, this yields:
  *
@@ -112,7 +118,7 @@
  * For each runqueue, we track:
  *
  *	   tSOME[cpu] = time(nr_delayed_tasks[cpu] != 0)
- *	   tFULL[cpu] = time(nr_delayed_tasks[cpu] && !nr_running_tasks[cpu])
+ *	   tFULL[cpu] = time(nr_delayed_tasks[cpu] && !nr_productive_tasks[cpu])
  *	tNONIDLE[cpu] = time(nr_nonidle_tasks[cpu] != 0)
  *
  * and then periodically aggregate:
@@ -233,7 +239,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_SOME:
 		return unlikely(tasks[NR_MEMSTALL]);
 	case PSI_MEM_FULL:
-		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
+		return unlikely(tasks[NR_MEMSTALL] &&
+			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
 	case PSI_CPU_SOME:
 		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_CPU_FULL:
@@ -710,10 +717,11 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (groupc->tasks[t]) {
 			groupc->tasks[t]--;
 		} else if (!psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
-					groupc->tasks[3], clear, set);
+					groupc->tasks[3], groupc->tasks[4],
+					clear, set);
 			psi_bug = 1;
 		}
 	}
@@ -854,12 +862,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		int clear = TSK_ONCPU, set = 0;
 
 		/*
-		 * When we're going to sleep, psi_dequeue() lets us handle
-		 * TSK_RUNNING and TSK_IOWAIT here, where we can combine it
-		 * with TSK_ONCPU and save walking common ancestors twice.
+		 * When we're going to sleep, psi_dequeue() lets us
+		 * handle TSK_RUNNING, TSK_MEMSTALL_RUNNING and
+		 * TSK_IOWAIT here, where we can combine it with
+		 * TSK_ONCPU and save walking common ancestors twice.
 		 */
 		if (sleep) {
 			clear |= TSK_RUNNING;
+			if (prev->in_memstall)
+				clear |= TSK_MEMSTALL_RUNNING;
 			if (prev->in_iowait)
 				set |= TSK_IOWAIT;
 		}
@@ -908,7 +919,7 @@ void psi_memstall_enter(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->in_memstall = 1;
-	psi_task_change(current, 0, TSK_MEMSTALL);
+	psi_task_change(current, 0, TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
 
 	rq_unlock_irq(rq, &rf);
 }
@@ -937,7 +948,7 @@ void psi_memstall_leave(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->in_memstall = 0;
-	psi_task_change(current, TSK_MEMSTALL, 0);
+	psi_task_change(current, TSK_MEMSTALL | TSK_MEMSTALL_RUNNING, 0);
 
 	rq_unlock_irq(rq, &rf);
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index cfb0893a83d4..3a3c826dd83a 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -118,6 +118,9 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	if (p->in_memstall)
+		set |= TSK_MEMSTALL_RUNNING;
+
 	if (!wakeup || p->sched_psi_wake_requeue) {
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
@@ -148,7 +151,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		return;
 
 	if (p->in_memstall)
-		clear |= TSK_MEMSTALL;
+		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
 
 	psi_task_change(p, clear, 0);
 }
-- 
2.30.2

