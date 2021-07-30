Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D443DB364
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhG3GPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:15:25 -0400
Received: from mx20.baidu.com ([111.202.115.85]:38758 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237004AbhG3GPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:15:22 -0400
Received: from BJHW-Mail-Ex03.internal.baidu.com (unknown [10.127.64.13])
        by Forcepoint Email with ESMTPS id 945B73908C7E8E837FA7;
        Fri, 30 Jul 2021 14:15:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 30 Jul 2021 14:15:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 30 Jul 2021 14:15:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] tracing: Fix typo in comments, print info and function
Date:   Fri, 30 Jul 2021 14:15:04 +0800
Message-ID: <20210730061504.2687-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex27.internal.baidu.com (172.31.51.21) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo:
*singe  ==> single
*outputing  ==> outputting
*ingore  ==> ignore
*preapre  ==> prepare
*overlayed  ==> overlaid
*alloced  ==> allocated
*varaibles  ==> variables
*timestemp  ==> timestamp
*reseted  ==> reset
*overwite  ==> overwrite

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/trace/ring_buffer.c           | 4 ++--
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 kernel/trace/trace.c                 | 8 ++++----
 kernel/trace/trace_branch.c          | 2 +-
 kernel/trace/trace_events_filter.c   | 2 +-
 kernel/trace/trace_osnoise.c         | 6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e592d1df6f88..f915ac0fa691 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5979,7 +5979,7 @@ static __init int test_ringbuffer(void)
 		pr_info("CPU %d:\n", cpu);
 		pr_info("              events:    %ld\n", total_events);
 		pr_info("       dropped bytes:    %ld\n", total_dropped);
-		pr_info("       alloced bytes:    %ld\n", total_alloc);
+		pr_info("     allocated bytes:    %ld\n", total_alloc);
 		pr_info("       written bytes:    %ld\n", total_written);
 		pr_info("       biggest event:    %d\n", big_event_size);
 		pr_info("      smallest event:    %d\n", small_event_size);
@@ -6016,7 +6016,7 @@ static __init int test_ringbuffer(void)
 		pr_info(" recorded size bytes:   %ld\n", total_size);
 		if (total_lost)
 			pr_info(" With dropped events, record len and size may not match\n"
-				" alloced and written from above\n");
+				" allocated and written from above\n");
 		if (!total_lost) {
 			if (RB_WARN_ON(buffer, total_len != total_alloc ||
 				       total_size != total_written))
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 78e576575b79..62a3d26e591e 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -431,7 +431,7 @@ static int __init ring_buffer_benchmark_init(void)
 {
 	int ret;
 
-	/* make a one meg buffer in overwite mode */
+	/* make a one meg buffer in overwrite mode */
 	buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
 	if (!buffer)
 		return -ENOMEM;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 28b6429e140e..ad0eb7fb37ed 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -124,7 +124,7 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * If there is an oops (or kernel panic) and the ftrace_dump_on_oops
  * is set, then ftrace_dump is called. This will output the contents
  * of the ftrace buffers to the console.  This is very useful for
- * capturing traces that lead to crashes and outputing it to a
+ * capturing traces that lead to crashes and outputting it to a
  * serial console.
  *
  * It is default off, but you can enable it with either specifying
@@ -4847,7 +4847,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 		iter->trace->close(iter);
 
 	if (!iter->snapshot && tr->stop_count)
-		/* reenable tracing if it was previously enabled */
+		/* re-enable tracing if it was previously enabled */
 		tracing_start_tr(tr);
 
 	__trace_array_put(tr);
@@ -9464,7 +9464,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
-static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
+static struct vfsmount *trace_automount(struct dentry *mntpt, void *ignore)
 {
 	struct vfsmount *mnt;
 	struct file_system_type *type;
@@ -9999,7 +9999,7 @@ __init static int tracer_alloc_buffers(void)
 	 * buffer. The memory will be removed once the "instance" is removed.
 	 */
 	ret = cpuhp_setup_state_multi(CPUHP_TRACE_RB_PREPARE,
-				      "trace/RB:preapre", trace_rb_cpu_prepare,
+				      "trace/RB:prepare", trace_rb_cpu_prepare,
 				      NULL);
 	if (ret < 0)
 		goto out_free_cpumask;
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index e47fdb4c92fb..c69a192ca728 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -274,7 +274,7 @@ static void branch_stat_show(struct seq_file *m,
 	long percent;
 
 	/*
-	 * The miss is overlayed on correct, and hit on incorrect.
+	 * The miss is overlaid on correct, and hit on incorrect.
 	 */
 	percent = get_incorrect_percent(p);
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c9124038b140..aeb4e9892a72 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -91,7 +91,7 @@ static bool is_not(const char *str)
 }
 
 /**
- * prog_entry - a singe entry in the filter program
+ * prog_entry - a single entry in the filter program
  * @target:	     Index to jump to on a branch (actually one minus the index)
  * @when_to_branch:  The value of the result of the predicate to do a branch
  * @pred:	     The predicate to execute.
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a7e3c24dee13..5f6347b1166d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -500,7 +500,7 @@ cond_move_thread_delta_start(struct osnoise_variables *osn_var, u64 duration)
 /*
  * get_int_safe_duration - Get the duration of a window
  *
- * The irq, softirq and thread varaibles need to have its duration without
+ * The irq, softirq and thread variables need to have its duration without
  * the interference from higher priority interrupts. Instead of keeping a
  * variable to discount the interrupt interference from these variables, the
  * starting time of these variables are pushed forward with the interrupt's
@@ -1083,7 +1083,7 @@ static int run_osnoise(void)
 	stop_in = osnoise_data.stop_tracing * NSEC_PER_USEC;
 
 	/*
-	 * Start timestemp
+	 * Start timestamp
 	 */
 	start = time_get();
 
@@ -1888,7 +1888,7 @@ static int __osnoise_tracer_start(struct trace_array *tr)
 	if (retval)
 		return retval;
 	/*
-	 * Make sure NMIs see reseted values.
+	 * Make sure NMIs see reset values.
 	 */
 	barrier();
 	trace_osnoise_callback_enabled = true;
-- 
2.25.1

