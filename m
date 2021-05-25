Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82F38FACD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEYGWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:22:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhEYGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:22:36 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq3lY0jPFzlYFJ;
        Tue, 25 May 2021 14:17:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:21:04 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:21:04 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] tracing: fix spelling mistakes
Date:   Tue, 25 May 2021 14:20:47 +0800
Message-ID: <20210525062047.8951-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210525062047.8951-1-thunder.leizhen@huawei.com>
References: <20210525062047.8951-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in comments:
wont ==> won't
overwite ==> overwrite
outputing ==> outputting
overlayed ==> overlaid
singe ==> single

The name of an unused function parameter:
ingore ==> ignore

And the name of the cpuhp step:
preapre ==> prepare

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/tracepoint.h           | 2 +-
 kernel/trace/Kconfig                 | 2 +-
 kernel/trace/ring_buffer.c           | 2 +-
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 kernel/trace/trace.c                 | 6 +++---
 kernel/trace/trace_branch.c          | 2 +-
 kernel/trace/trace_events.c          | 2 +-
 kernel/trace/trace_events_filter.c   | 2 +-
 kernel/trace/trace_seq.c             | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 13f65420f188..b0f19b799d77 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -507,7 +507,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	* This is how the tracepoint will appear under ftrace
  *	* plugins that make use of this tracepoint.
  *	*
- *	* (raw-binary tracing wont actually perform this step.)
+ *	* (raw-binary tracing won't actually perform this step.)
  *	*
  *
  *	TP_printk("task %s:%d [%d] ==> %s:%d [%d]",
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 7fa82778c3e6..110ff9a6175c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -795,7 +795,7 @@ config RING_BUFFER_RECORD_RECURSION
 	default y
 	help
 	  The ring buffer has its own internal recursion. Although when
-	  recursion happens it wont cause harm because of the protection,
+	  recursion happens it won't cause harm because of the protection,
 	  but it does cause an unwanted overhead. Enabling this option will
 	  place where recursion was detected into the ftrace "recursed_functions"
 	  file.
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2c0ee6484990..3cb9733719e5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5902,7 +5902,7 @@ static __init int test_ringbuffer(void)
 	/*
 	 * Show buffer is enabled before setting rb_test_started.
 	 * Yes there's a small race window where events could be
-	 * dropped and the thread wont catch it. But when a ring
+	 * dropped and the thread won't catch it. But when a ring
 	 * buffer gets enabled, there will always be some kind of
 	 * delay before other CPUs see it. Thus, we don't care about
 	 * those dropped events. We care about events dropped after
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
index a21ef9cd2aae..b869a53700a6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -122,7 +122,7 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * If there is an oops (or kernel panic) and the ftrace_dump_on_oops
  * is set, then ftrace_dump is called. This will output the contents
  * of the ftrace buffers to the console.  This is very useful for
- * capturing traces that lead to crashes and outputing it to a
+ * capturing traces that lead to crashes and outputting it to a
  * serial console.
  *
  * It is default off, but you can enable it with either specifying
@@ -9323,7 +9323,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
-static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
+static struct vfsmount *trace_automount(struct dentry *mntpt, void *ignore)
 {
 	struct vfsmount *mnt;
 	struct file_system_type *type;
@@ -9858,7 +9858,7 @@ __init static int tracer_alloc_buffers(void)
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
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 80e96989770e..3023c0878d32 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -594,7 +594,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 *
 		 * When soft_disable is not set but the SOFT_MODE flag is,
 		 * we do nothing. Do not disable the tracepoint, otherwise
-		 * "soft enable"s (clearing the SOFT_DISABLED bit) wont work.
+		 * "soft enable"s (clearing the SOFT_DISABLED bit) won't work.
 		 */
 		if (soft_disable) {
 			if (atomic_dec_return(&file->sm_ref) > 0)
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
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 9c90b3a7dce2..ec63d0ae6a22 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -18,7 +18,7 @@
  *
  * A write to the buffer will either succeed or fail. That is, unlike
  * sprintf() there will not be a partial write (well it may write into
- * the buffer but it wont update the pointers). This allows users to
+ * the buffer but it won't update the pointers). This allows users to
  * try to write something into the trace_seq buffer and if it fails
  * they can flush it and try again.
  *
-- 
2.25.1


