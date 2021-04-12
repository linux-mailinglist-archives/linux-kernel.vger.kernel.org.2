Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B635C3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhDLKWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbhDLKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88284C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CBYFi211bbUVsumXjXzpiCfDA3LorifZJoWbdsyAFOA=; b=q9+lw5xChyL+rptbOnyYQRd7ho
        +sD6EtFA5R9iLo/ND68M/JqxqP9p5A2SSx1QLGIne/IFu9AYi5IbPkWZ0jbbDn9JC57J5ySbNtMO0
        q1px81m3lP3IIc+8fJSemjLhVFciLWMH9bN6JgHrAvcZEJpAZdQJO16dnHgJ4wKsDcvCHpJ/ROEZl
        10Wm5EbAEbKuv7hbbZgijQnA4OkixnQkw6Yd7N2LRf2866jRnB6ZM9Otp/UPLUW09tNO/IgEREWZq
        ivAbEEM6JDOOhcgTSwWJ2en1I+vijcwI8lgar7LD+0lUFkvDGD5Pcbr5ikfgcLrNAUvEdC7tsYOV3
        nyIvXiAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgi-004BDQ-PZ; Mon, 12 Apr 2021 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 091583001FF;
        Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C230B29D8B768; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412102001.287610138@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/9] sched: Move SCHED_DEBUG sysctl to debugfs
References: <20210412101421.609526370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop polluting sysctl with undocumented knobs that really are debug
only, move them all to /debug/sched/ along with the existing
/debug/sched_* files that already exist.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sched/sysctl.h |    8 +--
 kernel/sched/core.c          |    4 +
 kernel/sched/debug.c         |   74 +++++++++++++++++++++++++++++++--
 kernel/sched/fair.c          |    9 ----
 kernel/sched/sched.h         |    2 
 kernel/sysctl.c              |   96 -------------------------------------------
 6 files changed, 80 insertions(+), 113 deletions(-)

--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -26,10 +26,11 @@ int proc_dohung_task_timeout_secs(struct
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
+extern unsigned int sysctl_sched_child_runs_first;
+
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
-extern unsigned int sysctl_sched_child_runs_first;
 
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
@@ -37,7 +38,7 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_LINEAR,
 	SCHED_TUNABLESCALING_END,
 };
-extern enum sched_tunable_scaling sysctl_sched_tunable_scaling;
+extern unsigned int sysctl_sched_tunable_scaling;
 
 extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
@@ -47,9 +48,6 @@ extern unsigned int sysctl_numa_balancin
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-
-int sched_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5504,9 +5504,11 @@ static const struct file_operations sche
 	.release	= single_release,
 };
 
+extern struct dentry *debugfs_sched;
+
 static __init int sched_init_debug_dynamic(void)
 {
-	debugfs_create_file("sched_preempt", 0644, NULL, NULL, &sched_dynamic_fops);
+	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 	return 0;
 }
 late_initcall(sched_init_debug_dynamic);
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -169,15 +169,81 @@ static const struct file_operations sche
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SMP
+
+static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	if (kstrtouint(buf, 10, &sysctl_sched_tunable_scaling))
+		return -EINVAL;
+
+	if (sched_update_scaling())
+		return -EINVAL;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_scaling_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", sysctl_sched_tunable_scaling);
+	return 0;
+}
+
+static int sched_scaling_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_scaling_show, NULL);
+}
+
+static const struct file_operations sched_scaling_fops = {
+	.open		= sched_scaling_open,
+	.write		= sched_scaling_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* SMP */
+
 __read_mostly bool sched_debug_enabled;
 
+struct dentry *debugfs_sched;
+
 static __init int sched_init_debug(void)
 {
-	debugfs_create_file("sched_features", 0644, NULL, NULL,
-			&sched_feat_fops);
+	struct dentry __maybe_unused *numa;
+
+	debugfs_sched = debugfs_create_dir("sched", NULL);
+
+	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
+	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
+
+	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
+	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
+
+#ifdef CONFIG_SMP
+	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
+	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
+	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+#endif
+
+#ifdef CONFIG_NUMA_BALANCING
+	numa = debugfs_create_dir("numa_balancing", debugfs_sched);
 
-	debugfs_create_bool("sched_debug", 0644, NULL,
-			&sched_debug_enabled);
+	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
+	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
+	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
+	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+#endif
 
 	return 0;
 }
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -49,7 +49,7 @@ static unsigned int normalized_sysctl_sc
  *
  * (default SCHED_TUNABLESCALING_LOG = *(1+ilog(ncpus))
  */
-enum sched_tunable_scaling sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
+unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 
 /*
  * Minimal preemption granularity for CPU-bound tasks:
@@ -627,15 +627,10 @@ struct sched_entity *__pick_last_entity(
  * Scheduling class statistics methods:
  */
 
-int sched_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+int sched_update_scaling(void)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	unsigned int factor = get_update_sysctl_factor();
 
-	if (ret || !write)
-		return ret;
-
 	sched_nr_latency = DIV_ROUND_UP(sysctl_sched_latency,
 					sysctl_sched_min_granularity);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1569,6 +1569,8 @@ static inline void unregister_sched_doma
 }
 #endif
 
+extern int sched_update_scaling(void);
+
 extern void flush_smp_call_function_from_idle(void);
 
 #else /* !CONFIG_SMP: */
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -184,17 +184,6 @@ static enum sysctl_writes_mode sysctl_wr
 int sysctl_legacy_va_layout;
 #endif
 
-#ifdef CONFIG_SCHED_DEBUG
-static int min_sched_granularity_ns = 100000;		/* 100 usecs */
-static int max_sched_granularity_ns = NSEC_PER_SEC;	/* 1 second */
-static int min_wakeup_granularity_ns;			/* 0 usecs */
-static int max_wakeup_granularity_ns = NSEC_PER_SEC;	/* 1 second */
-#ifdef CONFIG_SMP
-static int min_sched_tunable_scaling = SCHED_TUNABLESCALING_NONE;
-static int max_sched_tunable_scaling = SCHED_TUNABLESCALING_END-1;
-#endif /* CONFIG_SMP */
-#endif /* CONFIG_SCHED_DEBUG */
-
 #ifdef CONFIG_COMPACTION
 static int min_extfrag_threshold;
 static int max_extfrag_threshold = 1000;
@@ -1659,91 +1648,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_SCHED_DEBUG
-	{
-		.procname	= "sched_min_granularity_ns",
-		.data		= &sysctl_sched_min_granularity,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_granularity_ns,
-		.extra2		= &max_sched_granularity_ns,
-	},
-	{
-		.procname	= "sched_latency_ns",
-		.data		= &sysctl_sched_latency,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_granularity_ns,
-		.extra2		= &max_sched_granularity_ns,
-	},
-	{
-		.procname	= "sched_wakeup_granularity_ns",
-		.data		= &sysctl_sched_wakeup_granularity,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_wakeup_granularity_ns,
-		.extra2		= &max_wakeup_granularity_ns,
-	},
-#ifdef CONFIG_SMP
-	{
-		.procname	= "sched_tunable_scaling",
-		.data		= &sysctl_sched_tunable_scaling,
-		.maxlen		= sizeof(enum sched_tunable_scaling),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_tunable_scaling,
-		.extra2		= &max_sched_tunable_scaling,
-	},
-	{
-		.procname	= "sched_migration_cost_ns",
-		.data		= &sysctl_sched_migration_cost,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sched_nr_migrate",
-		.data		= &sysctl_sched_nr_migrate,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif /* CONFIG_SMP */
-#ifdef CONFIG_NUMA_BALANCING
-	{
-		.procname	= "numa_balancing_scan_delay_ms",
-		.data		= &sysctl_numa_balancing_scan_delay,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_period_min_ms",
-		.data		= &sysctl_numa_balancing_scan_period_min,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_period_max_ms",
-		.data		= &sysctl_numa_balancing_scan_period_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_size_mb",
-		.data		= &sysctl_numa_balancing_scan_size,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",


