Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D3354FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbhDFJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhDFJRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB12C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eur+taF8MFY+0BRVLfuTJbm24yZlZbDubjR3JvWBbPY=; b=Ch06AJPu7d4+lhMOJzEHQscTTu
        neTadhv5mZwvBEMk7F91G6zE62OGf3l1Pi94ytz/f9KkVUwmJ258JWrkD0Z+8LANwwqFFtHKJcMem
        LgQbg5Mt0737FWsnB8gM38Tt/Jjbf2MiuDN6kE3BFIKcZ+NCbzuXdiPVdG3ydNXTi7afMBX64Py0m
        XO7Ml2wJUGNAIM0aTqL8OA6X2+0VMjoLYC+3N1YzLfDE8dOrF5R9yiHCicZ4yafKT6PaASg3oarCn
        lnf4kZG9AjzF0mVhmbl55AOU5u+vXFyoOrOYlnSy8ntGopW2ZEhZUXhmZy5qk1FMKR5JLrSbYvMsq
        s+wYiMXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTho2-00CZEX-W0; Tue, 06 Apr 2021 09:15:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFA9B304D58;
        Tue,  6 Apr 2021 11:15:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 976022BAE8C24; Tue,  6 Apr 2021 11:15:29 +0200 (CEST)
Date:   Tue, 6 Apr 2021 11:15:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
Message-ID: <YGwmsePipAYoAI2H@hirez.programming.kicks-ass.net>
References: <20210405234203.23526-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405234203.23526-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:42:03PM -0400, Waiman Long wrote:
> The handling of sysrq key can be activated by echoing the key to
> /proc/sysrq-trigger or via the magic key sequence typed into a terminal
> that is connected to the system in some way (serial, USB or other mean).
> In the former case, the handling is done in a user context. In the
> latter case, it is likely to be in an interrupt context.

> [ 7809.796281]  </NMI>
> [ 7809.796282]  _raw_spin_lock_irqsave+0x32/0x40
> [ 7809.796283]  print_cpu+0x261/0x7c0
> [ 7809.796283]  sysrq_sched_debug_show+0x34/0x50
> [ 7809.796284]  sysrq_handle_showstate+0xc/0x20
> [ 7809.796284]  __handle_sysrq.cold.11+0x48/0xfb
> [ 7809.796285]  write_sysrq_trigger+0x2b/0x30
> [ 7809.796285]  proc_reg_write+0x39/0x60
> [ 7809.796286]  vfs_write+0xa5/0x1a0
> [ 7809.796286]  ksys_write+0x4f/0xb0
> [ 7809.796287]  do_syscall_64+0x5b/0x1a0
> [ 7809.796287]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> [ 7809.796288] RIP: 0033:0x7fabe4ceb648
> 
> The purpose of sched_debug_lock is to serialize the use of the global
> cgroup_path[] buffer in print_cpu(). The rests of the printk calls don't
> need serialization from sched_debug_lock.

> The print_cpu() function has two callers - sched_debug_show() and
> sysrq_sched_debug_show(). 

So what idiot is doing sysrq and that proc file at the same time? Why is
it a problem now?

> @@ -470,16 +468,49 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
>  #endif
>  
>  #ifdef CONFIG_CGROUP_SCHED
> +static DEFINE_SPINLOCK(sched_debug_lock);
>  static char group_path[PATH_MAX];
> +static enum {
> +	TOKEN_NONE,
> +	TOKEN_ACQUIRED,
> +	TOKEN_NA	/* Not applicable */
> +} console_token = TOKEN_ACQUIRED;

> +/*
> + * All the print_cpu() callers from sched_debug_show() will be allowed
> + * to contend for sched_debug_lock and use group_path[] as their SEQ_printf()
> + * calls will be much faster. However only one print_cpu() caller from
> + * sysrq_sched_debug_show() which outputs to the console will be allowed
> + * to use group_path[]. Another parallel console writer will have to use
> + * a shorter stack buffer instead. Since the console output will be garbled
> + * anyway, truncation of some cgroup paths shouldn't be a big issue.
> + */
> +#define SEQ_printf_task_group_path(m, tg, fmt...)			\
> +{									\
> +	unsigned long flags;						\
> +	int token = m ? TOKEN_NA					\
> +		      : xchg_acquire(&console_token, TOKEN_NONE);	\
> +									\
> +	if (token == TOKEN_NONE) {					\
> +		char buf[128];						\
> +		task_group_path(tg, buf, sizeof(buf));			\
> +		SEQ_printf(m, fmt, buf);				\
> +	} else {							\
> +		spin_lock_irqsave(&sched_debug_lock, flags);		\
> +		task_group_path(tg, group_path, sizeof(group_path));	\
> +		SEQ_printf(m, fmt, group_path);				\
> +		spin_unlock_irqrestore(&sched_debug_lock, flags);	\
> +		if (token == TOKEN_ACQUIRED)				\
> +			smp_store_release(&console_token, token);	\
> +	}								\
>  }

This is disgusting... you have an open-coded test-and-set lock like
thing *AND* a spinlock, what gives?


What's wrong with something simple like this?

---
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4b49cc2af5c4..2ac2977f3b96 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,8 +8,6 @@
  */
 #include "sched.h"
 
-static DEFINE_SPINLOCK(sched_debug_lock);
-
 /*
  * This allows printing both to /proc/sched_debug and
  * to the console
@@ -470,6 +468,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
+static DEFINE_SPINLOCK(group_path_lock);
 static char group_path[PATH_MAX];
 
 static char *task_group_path(struct task_group *tg)
@@ -481,6 +480,22 @@ static char *task_group_path(struct task_group *tg)
 
 	return group_path;
 }
+
+#define SEQ_printf_task_group_path(m, tg)				\
+do {									\
+	if (spin_trylock(&group_path_lock)) {				\
+		task_group_path(tg, group_path, sizeof(group_path));	\
+		SEQ_printf(m, "%s", group_path);			\
+		spin_unlock(&group_path_lock);				\
+	} else {							\
+		SEQ_printf(m, "looser!");				\
+	}
+} while (0)
+
+#else
+
+#define SEQ_printf_task_group_path(m, tg) do { } while (0)
+
 #endif
 
 static void
@@ -505,9 +520,8 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
 #endif
-#ifdef CONFIG_CGROUP_SCHED
-	SEQ_printf(m, " %s", task_group_path(task_group(p)));
-#endif
+	SEQ_printf(m, " ");
+	SEQ_printf_task_group_path(m, task_group(p));
 
 	SEQ_printf(m, "\n");
 }
@@ -541,13 +555,10 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	struct sched_entity *last;
 	unsigned long flags;
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "cfs_rq[%d]:%s\n", cpu, task_group_path(cfs_rq->tg));
-#else
+	SEQ_printf(m, "cfs_rq[%d]:", cpu);
+	SEQ_printf_task_group_path(m, cfs_rq->tg);
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
-#endif
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
 			SPLIT_NS(cfs_rq->exec_clock));
 
@@ -612,13 +623,10 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 
 void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "rt_rq[%d]:%s\n", cpu, task_group_path(rt_rq->tg));
-#else
+	SEQ_printf(m, "rt_rq[%d]:", cpu);
+	SEQ_printf_task_group_path(m, rt_rq->tg);
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "rt_rq[%d]:\n", cpu);
-#endif
 
 #define P(x) \
 	SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rt_rq->x))
@@ -666,7 +674,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long flags;
 
 #ifdef CONFIG_X86
 	{
@@ -717,13 +724,11 @@ do {									\
 	}
 #undef P
 
-	spin_lock_irqsave(&sched_debug_lock, flags);
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
 
 	print_rq(m, rq, cpu);
-	spin_unlock_irqrestore(&sched_debug_lock, flags);
 	SEQ_printf(m, "\n");
 }
 
