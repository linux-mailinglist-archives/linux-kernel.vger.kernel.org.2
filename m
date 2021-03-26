Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1472634A5BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCZKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhCZKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:42:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A35C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Fv0Hp6YOu3I6PIOVHt+bSMWXijjvmgCmnmdsY4Y28Ng=; b=rLjZAL+78Lc6ECxxqGVW0vFKXG
        4IrwXnyiDqQYp1Sn2uYMiN0LOT48222t349326eDKPhnv0aznqD949FwFXWLiusUbxfDDTrbSzdWx
        3OUqpEsrmk7apT6dW6Tk9XXTnxQIf9X1fsUURojAnrI7zhLoMVjl+YVQfAgCgPlIlpgG0szrlAFzn
        sykK/7sOJO5/2RX4w5yZ5Tq3e9MleKePjhdMctCOnI9XfH5W2GpPpgRC38j6PZ5+h7FC3+BozpU4l
        Yl7Ao2ej197XQ6dSc2jLo2xOUgTlcb6yNpO4+9HJunrj7zyz1q1Zfc3JQAI9WT6LawOpj0y2kQ6Uu
        YE2QPeLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvF-003L6N-MC; Fri, 26 Mar 2021 10:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9CE30753E;
        Fri, 26 Mar 2021 11:42:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B6D1C2BCA7ED8; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103935.103870746@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 5/9] sched,preempt: Move preempt_dynamic to debug.c
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the #ifdef SCHED_DEBUG bits to kernel/sched/debug.c in order to
collect all the debugfs bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   77 +--------------------------------------------------
 kernel/sched/debug.c |   67 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   11 +++++--
 3 files changed, 78 insertions(+), 77 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5371,9 +5371,9 @@ enum {
 	preempt_dynamic_full,
 };
 
-static int preempt_dynamic_mode = preempt_dynamic_full;
+int preempt_dynamic_mode = preempt_dynamic_full;
 
-static int sched_dynamic_mode(const char *str)
+int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
@@ -5387,7 +5387,7 @@ static int sched_dynamic_mode(const char
 	return -EINVAL;
 }
 
-static void sched_dynamic_update(int mode)
+void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
@@ -5444,79 +5444,8 @@ static int __init setup_preempt_mode(cha
 }
 __setup("preempt=", setup_preempt_mode);
 
-#ifdef CONFIG_SCHED_DEBUG
-
-static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
-{
-	char buf[16];
-	int mode;
-
-	if (cnt > 15)
-		cnt = 15;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-	mode = sched_dynamic_mode(strstrip(buf));
-	if (mode < 0)
-		return mode;
-
-	sched_dynamic_update(mode);
-
-	*ppos += cnt;
-
-	return cnt;
-}
-
-static int sched_dynamic_show(struct seq_file *m, void *v)
-{
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, "(");
-		seq_puts(m, preempt_modes[i]);
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, ")");
-
-		seq_puts(m, " ");
-	}
-
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static int sched_dynamic_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, sched_dynamic_show, NULL);
-}
-
-static const struct file_operations sched_dynamic_fops = {
-	.open		= sched_dynamic_open,
-	.write		= sched_dynamic_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-extern struct dentry *debugfs_sched;
-
-static __init int sched_init_debug_dynamic(void)
-{
-	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
-	return 0;
-}
-late_initcall(sched_init_debug_dynamic);
-
-#endif /* CONFIG_SCHED_DEBUG */
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
-
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -215,9 +215,71 @@ static const struct file_operations sche
 
 #endif /* SMP */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	int mode;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+	mode = sched_dynamic_mode(strstrip(buf));
+	if (mode < 0)
+		return mode;
+
+	sched_dynamic_update(mode);
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
+static int sched_dynamic_show(struct seq_file *m, void *v)
+{
+	static const char * preempt_modes[] = {
+		"none", "voluntary", "full"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, "(");
+		seq_puts(m, preempt_modes[i]);
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, ")");
+
+		seq_puts(m, " ");
+	}
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int sched_dynamic_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_dynamic_show, NULL);
+}
+
+static const struct file_operations sched_dynamic_fops = {
+	.open		= sched_dynamic_open,
+	.write		= sched_dynamic_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
 __read_mostly bool sched_debug_enabled;
 
-struct dentry *debugfs_sched;
+static struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
 {
@@ -227,6 +289,9 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
 	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
+#endif
 
 	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2733,5 +2733,12 @@ static inline bool is_per_cpu_kthread(st
 }
 #endif
 
-void swake_up_all_locked(struct swait_queue_head *q);
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void swake_up_all_locked(struct swait_queue_head *q);
+extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+extern int preempt_dynamic_mode;
+extern int sched_dynamic_mode(const char *str);
+extern void sched_dynamic_update(int mode);
+#endif
+


