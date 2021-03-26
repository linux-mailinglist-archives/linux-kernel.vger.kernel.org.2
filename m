Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6A34A5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCZKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCZKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:42:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7DC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=O6GfCn7xXbfxQaFAjX7wDV2xqZiEaepit3JMtUsu/04=; b=rAReX+fG9crr9mF2AVQJGCeXXL
        JDeVS1LXKLfXzV6eeOrp27KgbSS7v8P+8+7Jwejx+f8d7TmehuIc3m8otNwIjoxlY2XPdyOnPkwjf
        b19tsaNO+35O60fJuLYMpf4HyJmj4hzzzSeA6qK4q3XJbMTnLoJ9duxPD4HBWYVCkkbPbx/thdzw5
        FTIRfo1kdfj2vH+dfunU/M/wFubFpUmeZIRjGbFWg6e9YvzJLdHSRlaPyh84XF626pDa5PpNQ+UfG
        El7eQyMiuTaFJKVhV0uhtvLa/wBtaV5iSyurizg2MxMCBPRIvrxSwR3EYD3eWDIFaYg3BoyYYzlV7
        BiWQIUaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvE-003L6E-U6; Fri, 26 Mar 2021 10:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4C6E306BCA;
        Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B23062BCA7ED7; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103935.025550243@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 4/9] sched: Move SCHED_DEBUG to debugfs
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop polluting sysctl with undocumented knobs that really are debug
only, move them all to /debug/sched/ along with the existing
/debug/sched_* files that already exist.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


