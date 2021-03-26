Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38934A5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCZKoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhCZKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:43:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6447C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ypQLZTc9yNPawP9QY+lxfbn6H7EyyiLJvrKgLlvq+eI=; b=CUgaR4aMYsv6JoI81Th5sHzFx4
        uhsqkBQV9TxImYNjwLTTi0D4AwBma3vG0pvgA1LkghAe/sgONrMRW6OIGoaLeV7C6qREi4VDaTKBe
        W3iTM+saN4ouV7kiVfizLje+FwLRN9wi1c6bW2GSFCUCxDOggka1BXIDRK8R5TMJXCoU83kZ8w+wG
        1h7KXzs8N+XpgqiWXu9Fz7CSf13+cteo54AY2FhYrYuwLVc/T/Qn1Xg8fseMEiRiExZkZjGvg6ZXf
        my3VlxSZd+PFPqVarh1WdjiqlZL0q+d/9WG2WQr5yPAxVza220T+xduM8eQkEe9VmZvBDI3nn5FoJ
        vUSB1UEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvF-00EgYV-S2; Fri, 26 Mar 2021 10:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9C0306FFE;
        Fri, 26 Mar 2021 11:42:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0A7D2BCA7EDA; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103935.264012208@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 7/9] sched,debug: Convert sysctl sched_domains to debugfs
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop polluting sysctl, move to debugfs for SCHED_DEBUG stuff.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c    |  255 ++++++++++--------------------------------------
 kernel/sched/sched.h    |    2 
 kernel/sched/topology.c |    1 
 3 files changed, 59 insertions(+), 199 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -299,6 +299,10 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+
+	mutex_lock(&sched_domains_mutex);
+	register_sched_domain_sysctl();
+	mutex_unlock(&sched_domains_mutex);
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -316,229 +320,87 @@ late_initcall(sched_init_debug);
 
 #ifdef CONFIG_SMP
 
-#ifdef CONFIG_SYSCTL
-
-static struct ctl_table sd_ctl_dir[] = {
-	{
-		.procname	= "sched_domain",
-		.mode		= 0555,
-	},
-	{}
-};
-
-static struct ctl_table sd_ctl_root[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= sd_ctl_dir,
-	},
-	{}
-};
-
-static struct ctl_table *sd_alloc_ctl_entry(int n)
-{
-	struct ctl_table *entry =
-		kcalloc(n, sizeof(struct ctl_table), GFP_KERNEL);
-
-	return entry;
-}
-
-static void sd_free_ctl_entry(struct ctl_table **tablep)
-{
-	struct ctl_table *entry;
-
-	/*
-	 * In the intermediate directories, both the child directory and
-	 * procname are dynamically allocated and could fail but the mode
-	 * will always be set. In the lowest directory the names are
-	 * static strings and all have proc handlers.
-	 */
-	for (entry = *tablep; entry->mode; entry++) {
-		if (entry->child)
-			sd_free_ctl_entry(&entry->child);
-		if (entry->proc_handler == NULL)
-			kfree(entry->procname);
-	}
-
-	kfree(*tablep);
-	*tablep = NULL;
-}
-
-static void
-set_table_entry(struct ctl_table *entry,
-		const char *procname, void *data, int maxlen,
-		umode_t mode, proc_handler *proc_handler)
-{
-	entry->procname = procname;
-	entry->data = data;
-	entry->maxlen = maxlen;
-	entry->mode = mode;
-	entry->proc_handler = proc_handler;
-}
+static cpumask_var_t		sd_sysctl_cpus;
+static struct dentry		*sd_dentry;
 
-static int sd_ctl_doflags(struct ctl_table *table, int write,
-			  void *buffer, size_t *lenp, loff_t *ppos)
+static int sd_flags_show(struct seq_file *m, void *v)
 {
-	unsigned long flags = *(unsigned long *)table->data;
-	size_t data_size = 0;
-	size_t len = 0;
-	char *tmp, *buf;
+	unsigned long flags = *(unsigned int *)m->private;
 	int idx;
 
-	if (write)
-		return 0;
-
-	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
-		char *name = sd_flag_debug[idx].name;
-
-		/* Name plus whitespace */
-		data_size += strlen(name) + 1;
-	}
-
-	if (*ppos > data_size) {
-		*lenp = 0;
-		return 0;
-	}
-
-	buf = kcalloc(data_size + 1, sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
-		char *name = sd_flag_debug[idx].name;
-
-		len += snprintf(buf + len, strlen(name) + 2, "%s ", name);
+		seq_puts(m, sd_flag_debug[idx].name);
+		seq_puts(m, " ");
 	}
-
-	tmp = buf + *ppos;
-	len -= *ppos;
-
-	if (len > *lenp)
-		len = *lenp;
-	if (len)
-		memcpy(buffer, tmp, len);
-	if (len < *lenp) {
-		((char *)buffer)[len] = '\n';
-		len++;
-	}
-
-	*lenp = len;
-	*ppos += len;
-
-	kfree(buf);
+	seq_puts(m, "\n");
 
 	return 0;
 }
 
-static struct ctl_table *
-sd_alloc_ctl_domain_table(struct sched_domain *sd)
-{
-	struct ctl_table *table = sd_alloc_ctl_entry(9);
-
-	if (table == NULL)
-		return NULL;
-
-	set_table_entry(&table[0], "min_interval",	  &sd->min_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[1], "max_interval",	  &sd->max_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, sd_ctl_doflags);
-	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
-	/* &table[8] is terminator */
-
-	return table;
-}
-
-static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
+static int sd_flags_open(struct inode *inode, struct file *file)
 {
-	struct ctl_table *entry, *table;
-	struct sched_domain *sd;
-	int domain_num = 0, i;
-	char buf[32];
-
-	for_each_domain(cpu, sd)
-		domain_num++;
-	entry = table = sd_alloc_ctl_entry(domain_num + 1);
-	if (table == NULL)
-		return NULL;
-
-	i = 0;
-	for_each_domain(cpu, sd) {
-		snprintf(buf, 32, "domain%d", i);
-		entry->procname = kstrdup(buf, GFP_KERNEL);
-		entry->mode = 0555;
-		entry->child = sd_alloc_ctl_domain_table(sd);
-		entry++;
-		i++;
-	}
-	return table;
+	return single_open(file, sd_flags_show, inode->i_private);
 }
 
-static cpumask_var_t		sd_sysctl_cpus;
-static struct ctl_table_header	*sd_sysctl_header;
+static const struct file_operations sd_flags_fops = {
+	.open		= sd_flags_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
-void register_sched_domain_sysctl(void)
+static void register_sd(struct sched_domain *sd, struct dentry *parent)
 {
-	static struct ctl_table *cpu_entries;
-	static struct ctl_table **cpu_idx;
-	static bool init_done = false;
-	char buf[32];
-	int i;
-
-	if (!cpu_entries) {
-		cpu_entries = sd_alloc_ctl_entry(num_possible_cpus() + 1);
-		if (!cpu_entries)
-			return;
+#define SDM(type, mode, member)	\
+	debugfs_create_##type(#member, mode, parent, &sd->member)
 
-		WARN_ON(sd_ctl_dir[0].child);
-		sd_ctl_dir[0].child = cpu_entries;
-	}
+	SDM(ulong, 0644, min_interval);
+	SDM(ulong, 0644, max_interval);
+	SDM(u64,   0644, max_newidle_lb_cost);
+	SDM(u32,   0644, busy_factor);
+	SDM(u32,   0644, imbalance_pct);
+	SDM(u32,   0644, cache_nice_tries);
+//	SDM(x32,   0444, flags);
+	SDM(str,   0444, name);
 
-	if (!cpu_idx) {
-		struct ctl_table *e = cpu_entries;
+#undef SDM
 
-		cpu_idx = kcalloc(nr_cpu_ids, sizeof(struct ctl_table*), GFP_KERNEL);
-		if (!cpu_idx)
-			return;
+	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
+}
 
-		/* deal with sparse possible map */
-		for_each_possible_cpu(i) {
-			cpu_idx[i] = e;
-			e++;
-		}
-	}
+void register_sched_domain_sysctl(void)
+{
+	int cpu, i;
 
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
-	}
-
-	if (!init_done) {
-		init_done = true;
-		/* init to possible to not have holes in @cpu_entries */
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
 	}
 
-	for_each_cpu(i, sd_sysctl_cpus) {
-		struct ctl_table *e = cpu_idx[i];
+	if (!sd_dentry)
+		sd_dentry = debugfs_create_dir("domains", debugfs_sched);
 
-		if (e->child)
-			sd_free_ctl_entry(&e->child);
+	for_each_cpu(cpu, sd_sysctl_cpus) {
+		struct sched_domain *sd;
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%d", cpu);
+		debugfs_remove(debugfs_lookup(buf, sd_dentry));
+		d_cpu = debugfs_create_dir(buf, sd_dentry);
+
+		i = 0;
+		for_each_domain(cpu, sd) {
+			struct dentry *d_sd;
 
-		if (!e->procname) {
-			snprintf(buf, 32, "cpu%d", i);
-			e->procname = kstrdup(buf, GFP_KERNEL);
-		}
-		e->mode = 0555;
-		e->child = sd_alloc_ctl_cpu_table(i);
+			snprintf(buf, sizeof(buf), "domain%d", i);
+			d_sd = debugfs_create_dir(buf, d_cpu);
 
-		__cpumask_clear_cpu(i, sd_sysctl_cpus);
+			register_sd(sd, d_sd);
+			i++;
+		}
 	}
-
-	WARN_ON(sd_sysctl_header);
-	sd_sysctl_header = register_sysctl_table(sd_ctl_root);
 }
 
 void dirty_sched_domain_sysctl(int cpu)
@@ -547,13 +409,12 @@ void dirty_sched_domain_sysctl(int cpu)
 		__cpumask_set_cpu(cpu, sd_sysctl_cpus);
 }
 
-/* may be called multiple times per register */
 void unregister_sched_domain_sysctl(void)
 {
-	unregister_sysctl_table(sd_sysctl_header);
-	sd_sysctl_header = NULL;
+	debugfs_remove(sd_dentry);
+	sd_dentry = NULL;
 }
-#endif /* CONFIG_SYSCTL */
+
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1553,7 +1553,7 @@ static inline unsigned int group_first_c
 
 extern int group_balance_cpu(struct sched_group *sg);
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_SYSCTL)
+#ifdef CONFIG_SCHED_DEBUG
 void register_sched_domain_sysctl(void);
 void dirty_sched_domain_sysctl(int cpu);
 void unregister_sched_domain_sysctl(void);
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2223,7 +2223,6 @@ int sched_init_domains(const struct cpum
 		doms_cur = &fallback_doms;
 	cpumask_and(doms_cur[0], cpu_map, housekeeping_cpumask(HK_FLAG_DOMAIN));
 	err = build_sched_domains(doms_cur[0], NULL);
-	register_sched_domain_sysctl();
 
 	return err;
 }


