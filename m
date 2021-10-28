Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730A043DDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJ1JaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1JaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:30:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A934CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 02:27:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so4031567plc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0wUATtRztw4ODiCPUVecUWV+3lZ3yDYekIz3dB1LGU=;
        b=FKGfMlbM2myhaKuxIxycsZJrAhwoDMi6CLVfH5LgyVJb28ELWUr2oirENSfGs64eof
         5RFMTIiMe00K7pQgpsB6mb89RX3oScatumXOnirgwlLvzHYAiMgdAw+lmmNt1tPQcx7q
         gN5x7JRJ4Co4lq9/u6H8AzKlVVn1GVw4Ug6r4CNqItJnGotXls3liNVsHKisqscUWsBk
         qiBuiqPAfG6XgsUDaUC7FmPQ+UTEelyrqjaOhFFls1DaLJNteBOPDdxCSTU2fR/AP6nX
         gGa3KLJvubkaWKGoS0kowSQLE8ZQKODtGbsEbMictE7fH1q+l9nAF2ExfAz7yWMrLYTL
         QnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0wUATtRztw4ODiCPUVecUWV+3lZ3yDYekIz3dB1LGU=;
        b=rN/TwEU+k/oy3EBI80OwUSt/FeNRDSubuYBM0w5N12ScwE05weT7zsGD+nthcZ0vjG
         Gg3AKQ773sL0gg96SlEigYG3gU9aOhuPCWdLrzj0jIcu8swtlwRmxiQLRNoaetPI7m3d
         iWrj40zTh8IRWkddnZvrpcbC1pLB4f01mJ/BJSV/sqj3BI9Cc+o79aaleJjBex6AFHTX
         /7cFuyrYtFGtXUs2xU1dcu03sZF/SVq7vvA4XNdbofoCbIFPx5Pj30+MhlRxYOZeRx4P
         bx7Q6WQfsF9g31F/rU3b9+hgXjd1MlfgodWOje4Wwo6byxHxc5AvkhWElwerFdS+7RDD
         b4pQ==
X-Gm-Message-State: AOAM530HkbZFPI2BxdaF240RTOQLS4W8vkBf42xFmAa68+Hxj3AcSVxn
        v3dAE1Lm9JUaZxP6bPs2RIM=
X-Google-Smtp-Source: ABdhPJw8d7OwWNh+2Ggxj8zDt4BVn4G4LMey2yUUvflN+0qcnF3WgAUpMyeEW0Q/VrrBxxzi06Ohbw==
X-Received: by 2002:a17:902:8ecb:b0:140:1934:ea7d with SMTP id x11-20020a1709028ecb00b001401934ea7dmr2730279plo.46.1635413263175;
        Thu, 28 Oct 2021 02:27:43 -0700 (PDT)
Received: from localhost.localdomain (li1164-150.members.linode.com. [45.79.65.150])
        by smtp.gmail.com with ESMTPSA id m186sm2626763pfb.165.2021.10.28.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:27:42 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC] [PATCH v3] trace: Add trace any kernel object
Date:   Thu, 28 Oct 2021 17:27:02 +0800
Message-Id: <20211028092702.1099653-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a method based on function tracer and kprobe/uprobe/trace_event/
to trace any object in the linux kernel.

Usage:
When using kprobe/uprobe/trace_event/ we can use a new trigger(objtrace) 
to set object and trigger object trace.

For example:

For the function bio_add_page, we can trace the first argument:

int bio_add_page(struct bio *bio, struct page *page,
				unsigned int len, unsigned int offset)
				
[root@JeffXie ]# cd /sys/kernel/debug/tracing/
[root@JeffXie tracing]# echo 'p bio_add_page arg1=$arg1' > kprobe_events
[root@JeffXie tracing]# cd events/kprobes/p_bio_add_page_0/
[root@JeffXie p_bio_add_page_0]# echo 'objtrace:arg1:1 if comm == "cat"' > ./trigger
[root@JeffXie p_bio_add_page_0]# cat /test.txt
[root@JeffXie p_bio_add_page_0]# cd /sys/kernel/debug/tracing/
[root@JeffXie tracing]# cat ./trace
# tracer: nop
#
# entries-in-buffer/entries-written: 81/81   #P:4
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
             cat-122     [001] .....   111.193997: bio_add_page <-ext4_mpage_readpages object:0xffff888102a4b900
             cat-122     [001] .....   111.193998: __bio_try_merge_page <-bio_add_page object:0xffff888102a4b900
             cat-122     [001] .....   111.193998: __bio_add_page <-bio_add_page object:0xffff888102a4b900
             cat-122     [001] .....   111.193998: submit_bio <-ext4_mpage_readpages object:0xffff888102a4b900
             cat-122     [001] .....   111.193998: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888102a4b900
             cat-122     [001] .....   111.193999: __submit_bio <-submit_bio_noacct object:0xffff888102a4b900
             cat-122     [001] .....   111.193999: submit_bio_checks <-__submit_bio object:0xffff888102a4b900
             cat-122     [001] .....   111.193999: __cond_resched <-submit_bio_checks object:0xffff888102a4b900
             cat-122     [001] .....   111.193999: rcu_all_qs <-__cond_resched object:0xffff888102a4b900
             cat-122     [001] .....   111.194000: should_fail_bio <-submit_bio_checks object:0xffff888102a4b900
             cat-122     [001] .....   111.194001: blk_mq_submit_bio <-__submit_bio object:0xffff888102a4b900
             cat-122     [001] .....   111.194001: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888102a4b900
             cat-122     [001] .....   111.194001: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888102a4b900
             cat-122     [001] .....   111.194002: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888102a4b900
             cat-122     [001] .....   111.194002: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888102a4b900
             cat-122     [001] .....   111.194003: blk_account_io_start <-blk_mq_submit_bio object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194212: bio_advance <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194213: bio_endio <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194213: mpage_end_io <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194213: __read_end_io <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194218: bio_put <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194218: bio_free <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194218: bio_free <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194218: bvec_free <-bio_free object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194219: mempool_free <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194219: mempool_free <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194219: mempool_free_slab <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194219: mempool_free_slab <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194219: kmem_cache_free <-blk_update_request object:0xffff888102a4b900
          <idle>-0       [001] d....   111.194219: kmem_cache_free <-blk_update_request object:0xffff888102a4b900

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
Currently only showing all the code I have, But I think that there are main three tasks 
to be completed next:

1. Masami suggested:

<snip>
objfilter:add:arg1

and the exit event

objfilter:del:arg1

then user will only see the trace between the entrance and exit events.
</snip>

Actually, I don’t have a good idea to implement it now ;-)
Looking for related existing code logic.

2. Steven suggested:
<snip>
For example:

	obj = arg1 + 0x64
	if (copy_from_kernel_nofault(&val, arg1 + 0x64, sizeof(val)))
		// faulted
		return;

Now val has the content of __bi_cnt and we can print that!
</snip>

We need to implement a more complex parsing and also record the size of a arg 
or other related members.it may change the way I record the object.


3. Update trigger documentation

https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org/T/#t

I'm very happy to work with you all, and got a lot of knowledge from your help.

At present, I am the only person writing code using the free time, I usually need to do 
other work about linux and take care of a three-month-old boy. unlike a group, the progress 
of submitting patches may be slower.

 include/linux/ftrace.h              |  16 +
 include/linux/trace_events.h        |   1 +
 kernel/trace/Kconfig                |   7 +
 kernel/trace/Makefile               |   1 +
 kernel/trace/trace.h                |   8 +
 kernel/trace/trace_entries.h        |  17 +
 kernel/trace/trace_events_trigger.c |   1 +
 kernel/trace/trace_object.c         | 553 ++++++++++++++++++++++++++++
 kernel/trace/trace_output.c         |  40 ++
 9 files changed, 644 insertions(+)
 create mode 100644 kernel/trace/trace_object.c

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..37cbf154c2f8 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1078,4 +1078,20 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+struct trace_event_file;
+
+#ifdef CONFIG_TRACE_OBJECT
+int init_trace_object(void);
+int exit_trace_object(void);
+void set_trace_object(void *obj);
+void record_trace_object(struct trace_event_file *trace_file,
+		struct pt_regs *regs);
+#else
+static inline int init_trace_object(void) { return 0; }
+static inline int exit_trace_object(void) { return 0; }
+static inline void set_trace_object(void *obj) { }
+static inline void record_trace_object(struct trace_event_file *trace_file,
+		struct pt_regs *regs) { }
+#endif /* CONFIG_TRACE_OBJECT */
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3e475eeb5a99..84b5c12c7f44 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -684,6 +684,7 @@ enum event_trigger_type {
 	ETT_EVENT_HIST		= (1 << 4),
 	ETT_HIST_ENABLE		= (1 << 5),
 	ETT_EVENT_EPROBE	= (1 << 6),
+	ETT_TRACE_OBJECT	= (1 << 7),
 };
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 420ff4bc67fd..d302a0f085f9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -237,6 +237,13 @@ config FUNCTION_PROFILER
 
 	  If in doubt, say N.
 
+config TRACE_OBJECT
+	bool "Trace kernel object"
+	depends on FUNCTION_TRACER
+	default y
+	help
+	 This help kernel developer to trace any kernel object.
+
 config STACK_TRACER
 	bool "Trace max stack"
 	depends on HAVE_FUNCTION_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 6de5d4d63165..6d9e78a488aa 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
 obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
+obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
 ifeq ($(CONFIG_BLOCK),y)
 obj-$(CONFIG_EVENT_TRACING) += blktrace.o
 endif
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b7c0f8e160fb..d2508f977fe6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -49,6 +49,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_OBJECT,
 
 	__TRACE_LAST_TYPE,
 };
@@ -460,6 +461,7 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_RET);		\
 		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
 			  TRACE_FUNC_REPEATS);				\
+		IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
 		__ftrace_bad_type();					\
 	} while (0)
 
@@ -1510,6 +1512,12 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
 static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
 #endif
 
+#ifdef CONFIG_TRACE_OBJECT
+extern int register_trigger_object_cmd(void);
+#else
+static inline int register_trigger_object_cmd(void) { return 0; }
+#endif
+
 extern int register_trigger_cmds(void);
 extern void clear_event_triggers(struct trace_array *tr);
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index cd41e863b51c..bb120d9498a9 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
 		 __entry->context,
 		 __entry->timer_latency)
 );
+
+/*
+ * trace object entry:
+ */
+FTRACE_ENTRY(object, trace_object_entry,
+
+	TRACE_OBJECT,
+
+	F_STRUCT(
+		__field(	unsigned long,		ip		)
+		__field(	unsigned long,		parent_ip	)
+		__field(	unsigned long,		object		)
+	),
+
+	F_printk(" %ps <-- %ps object:%lx\n",
+		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
+);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3d5c07239a2a..da2d871fa809 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1687,6 +1687,7 @@ __init int register_trigger_cmds(void)
 	register_trigger_enable_disable_cmds();
 	register_trigger_hist_enable_disable_cmds();
 	register_trigger_hist_cmd();
+	register_trigger_object_cmd();
 
 	return 0;
 }
diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
new file mode 100644
index 000000000000..c10d8fb913db
--- /dev/null
+++ b/kernel/trace/trace_object.c
@@ -0,0 +1,553 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace any object
+ * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
+ */
+
+#define pr_fmt(fmt) "trace_object: " fmt
+
+#include <linux/workqueue.h>
+#include "trace_output.h"
+
+static struct work_struct obj_refill_work;
+static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
+static DEFINE_RAW_SPINLOCK(object_spin_lock);
+static struct trace_event_file event_trace_file;
+static LIST_HEAD(obj_head);
+static const int max_args_num = 6;
+static atomic_t trace_object_ref;
+
+struct obj_pool {
+	void **obj;
+	int min_nr;
+	int curr_nr;
+};
+
+static struct obj_pool obj_pool;
+static int init_obj_num = 1024;
+static int reserved_obj_num = 100;
+
+static int object_exist(void *obj)
+{
+	int i, used, ret = false;
+
+	if (!obj)
+		goto out;
+
+	used = obj_pool.min_nr - obj_pool.curr_nr;
+	if (!used)
+		goto out;
+
+	for (i = 0; i < used; i++) {
+		if (obj_pool.obj[obj_pool.curr_nr + i] == obj) {
+			ret = true;
+			goto out;
+		}
+	}
+out:
+	return ret;
+}
+
+static int object_empty(void)
+{
+	int ret;
+
+	ret = obj_pool.curr_nr == obj_pool.min_nr;
+
+	return ret;
+}
+
+static void **remove_object_element(void)
+{
+	void **obj = &obj_pool.obj[--obj_pool.curr_nr];
+	BUG_ON(obj_pool.curr_nr < 0);
+
+	return obj;
+}
+
+static void add_object_element(void *obj)
+{
+	BUG_ON(obj_pool.curr_nr >= obj_pool.min_nr);
+	obj_pool.obj[obj_pool.curr_nr++] = obj;
+}
+
+void set_trace_object(void *obj)
+{
+	unsigned long flags;
+	void **new_obj;
+
+	if (in_nmi())
+		return;
+
+	if (!obj)
+		return;
+
+	raw_spin_lock_irqsave(&object_spin_lock, flags);
+
+	if (object_exist(obj))
+		goto out;
+
+	if (obj_pool.curr_nr == 0) {
+		raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+		trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
+		return;
+	}
+
+	new_obj = remove_object_element();
+	*new_obj = obj;
+	if (obj_pool.curr_nr == reserved_obj_num) {
+		raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+		schedule_work(&obj_refill_work);
+		return;
+	}
+out:
+	raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+}
+
+static void object_pool_exit(void)
+{
+	obj_pool.min_nr = 0;
+	obj_pool.curr_nr = 0;
+	kfree(obj_pool.obj);
+	obj_pool.obj = NULL;
+}
+
+static void obj_refill_fn(struct work_struct *refill_work)
+{
+	void **new_obj_element;
+	unsigned long flags;
+	int new_min_nr, new_curr_nr;
+	int used_nr;
+
+	new_min_nr = obj_pool.min_nr * 2;
+	new_obj_element = kmalloc_array(new_min_nr, sizeof(void *), GFP_KERNEL);
+
+	if (!new_obj_element)
+		return;
+
+	raw_spin_lock_irqsave(&object_spin_lock, flags);
+
+	used_nr = obj_pool.min_nr - obj_pool.curr_nr;
+	new_curr_nr = new_min_nr - used_nr;
+	memcpy(new_obj_element + new_curr_nr, obj_pool.obj + obj_pool.curr_nr,
+			used_nr * sizeof(void *));
+
+	kfree(obj_pool.obj);
+	obj_pool.obj = new_obj_element;
+	obj_pool.curr_nr = new_curr_nr;
+	obj_pool.min_nr  = new_min_nr;
+
+	raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+}
+
+static int init_object_pool(void)
+{
+	int ret = 0;
+	int i;
+
+	obj_pool.obj = kmalloc_array(init_obj_num, sizeof(void *), GFP_KERNEL);
+	if (!obj_pool.obj) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	obj_pool.min_nr = init_obj_num;
+
+	for (i = 0; i < init_obj_num; i++)
+		add_object_element(obj_pool.obj[i]);
+
+out:
+	return ret;
+}
+
+static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
+				 unsigned long object)
+{
+
+	struct trace_buffer *buffer;
+	struct ring_buffer_event *event;
+	struct trace_object_entry *entry;
+	int pc;
+
+	pc = preempt_count();
+	event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
+			TRACE_OBJECT, sizeof(*entry), pc);
+	if (!event)
+		return;
+	entry   = ring_buffer_event_data(event);
+	entry->ip                       = ip;
+	entry->parent_ip                = parent_ip;
+	entry->object			= object;
+
+	event_trigger_unlock_commit(&event_trace_file, buffer, event,
+		entry, pc);
+}
+
+static void
+trace_object_events_call(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
+	unsigned long obj;
+	long disabled;
+	int cpu, n;
+
+	preempt_disable_notrace();
+
+	cpu = raw_smp_processor_id();
+	disabled = atomic_inc_return(&per_cpu(trace_object_event_disable, cpu));
+
+	if (disabled != 1)
+		goto out;
+
+	if (object_empty())
+		goto out;
+
+	for (n = 0; n < max_args_num; n++) {
+		obj = regs_get_kernel_argument(pt_regs, n);
+		if (object_exist((void *)obj))
+			submit_trace_object(ip, parent_ip, obj);
+	}
+
+out:
+	atomic_dec(&per_cpu(trace_object_event_disable, cpu));
+	preempt_enable_notrace();
+}
+
+static struct ftrace_ops trace_ops = {
+	.func  = trace_object_events_call,
+	.flags = FTRACE_OPS_FL_SAVE_REGS,
+};
+
+static void
+trace_object_trigger(struct event_trigger_data *data,
+		   struct trace_buffer *buffer,  void *rec,
+		   struct ring_buffer_event *event)
+{
+
+	struct ftrace_event_field *field = data->private_data;
+	void *obj = NULL;
+
+	memcpy(&obj, (char *)rec + field->offset, field->size);
+	set_trace_object(obj);
+}
+
+static void
+trace_object_trigger_free(struct event_trigger_ops *ops,
+		   struct event_trigger_data *data)
+{
+	if (WARN_ON_ONCE(data->ref <= 0))
+		return;
+
+	data->ref--;
+	if (!data->ref)
+		trigger_data_free(data);
+}
+
+static void
+trace_object_count_trigger(struct event_trigger_data *data,
+			 struct trace_buffer *buffer, void *rec,
+			 struct ring_buffer_event *event)
+{
+	if (!data->count)
+		return;
+
+	if (data->count != -1)
+		(data->count)--;
+
+	trace_object_trigger(data, buffer, rec, event);
+}
+
+static int event_object_trigger_init(struct event_trigger_ops *ops,
+		       struct event_trigger_data *data)
+{
+	data->ref++;
+	return 0;
+}
+
+static int
+event_trigger_print(const char *name, struct seq_file *m,
+		    void *data, char *filter_str)
+{
+	long count = (long)data;
+
+	seq_puts(m, name);
+
+	if (count == -1)
+		seq_puts(m, ":unlimited");
+	else
+		seq_printf(m, ":count=%ld", count);
+
+	if (filter_str)
+		seq_printf(m, " if %s\n", filter_str);
+	else
+		seq_putc(m, '\n');
+
+	return 0;
+}
+
+static int
+trace_object_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
+			 struct event_trigger_data *data)
+{
+	return event_trigger_print("objtrace", m, (void *)data->count,
+				   data->filter_str);
+}
+
+
+static struct event_trigger_ops objecttrace_trigger_ops = {
+	.func			= trace_object_trigger,
+	.print			= trace_object_trigger_print,
+	.init			= event_object_trigger_init,
+	.free			= trace_object_trigger_free,
+};
+
+static struct event_trigger_ops objecttrace_count_trigger_ops = {
+	.func			= trace_object_count_trigger,
+	.print			= trace_object_trigger_print,
+	.init			= event_object_trigger_init,
+	.free			= trace_object_trigger_free,
+};
+
+static struct event_trigger_ops *
+objecttrace_get_trigger_ops(char *cmd, char *param)
+{
+	return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
+}
+
+static int register_object_trigger(char *glob, struct event_trigger_ops *ops,
+			    struct event_trigger_data *data,
+			    struct trace_event_file *file)
+{
+	struct event_trigger_data *test;
+	int ret = 0;
+
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+
+	if (data->ops->init) {
+		ret = data->ops->init(data->ops, data);
+		if (ret < 0)
+			goto out;
+	}
+
+	list_add_rcu(&data->list, &file->triggers);
+	ret++;
+
+	update_cond_flag(file);
+	if (trace_event_trigger_enable_disable(file, 1) < 0) {
+		list_del_rcu(&data->list);
+		update_cond_flag(file);
+		ret--;
+	}
+	init_trace_object();
+out:
+	return ret;
+}
+
+void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
+			       struct event_trigger_data *test,
+			       struct trace_event_file *file)
+{
+	struct event_trigger_data *data;
+	bool unregistered = false;
+
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
+		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
+			unregistered = true;
+			list_del_rcu(&data->list);
+			trace_event_trigger_enable_disable(file, 0);
+			update_cond_flag(file);
+			break;
+		}
+	}
+
+	if (unregistered && data->ops->free) {
+		data->ops->free(data->ops, data);
+		exit_trace_object();
+	}
+}
+
+static int
+event_object_trigger_callback(struct event_command *cmd_ops,
+		       struct trace_event_file *file,
+		       char *glob, char *cmd, char *param)
+{
+	struct event_trigger_data *trigger_data;
+	struct event_trigger_ops *trigger_ops;
+	struct trace_event_call *call;
+	struct ftrace_event_field *field;
+	char *trigger = NULL;
+	char *arg;
+	char *number;
+	int ret;
+
+	ret = -EINVAL;
+	if (!param)
+		goto out;
+
+	/* separate the trigger from the filter (a:n [if filter]) */
+	trigger = strsep(&param, " \t");
+	if (!trigger)
+		goto out;
+	if (param) {
+		param = skip_spaces(param);
+		if (!*param)
+			param = NULL;
+	}
+
+	arg = strsep(&trigger, ":");
+	if (!arg)
+		goto out;
+	call = file->event_call;
+	field = trace_find_event_field(call, arg);
+	if (!field)
+		goto out;
+
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+
+	ret = -ENOMEM;
+	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	if (!trigger_data)
+		goto out;
+
+	trigger_data->count = -1;
+	trigger_data->ops = trigger_ops;
+	trigger_data->cmd_ops = cmd_ops;
+	trigger_data->private_data = field;
+	INIT_LIST_HEAD(&trigger_data->list);
+	INIT_LIST_HEAD(&trigger_data->named_list);
+
+	if (glob[0] == '!') {
+		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+		kfree(trigger_data);
+		ret = 0;
+		goto out;
+	}
+
+	if (trigger) {
+		number = strsep(&trigger, ":");
+
+		ret = -EINVAL;
+		if (!strlen(number))
+			goto out_free;
+
+		/*
+		 * We use the callback data field (which is a pointer)
+		 * as our counter.
+		 */
+		ret = kstrtoul(number, 0, &trigger_data->count);
+		if (ret)
+			goto out_free;
+	}
+
+	if (!param) /* if param is non-empty, it's supposed to be a filter */
+		goto out_reg;
+
+	if (!cmd_ops->set_filter)
+		goto out_reg;
+
+	ret = cmd_ops->set_filter(param, trigger_data, file);
+	if (ret < 0)
+		goto out_free;
+
+ out_reg:
+	/* Up the trigger_data count to make sure reg doesn't free it on failure */
+	event_object_trigger_init(trigger_ops, trigger_data);
+	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+	/*
+	 * The above returns on success the # of functions enabled,
+	 * but if it didn't find any functions it returns zero.
+	 * Consider no functions a failure too.
+	 */
+	if (!ret) {
+		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
+		ret = -ENOENT;
+	} else if (ret > 0)
+		ret = 0;
+
+	/* Down the counter of trigger_data or free it if not used anymore */
+	trace_object_trigger_free(trigger_ops, trigger_data);
+ out:
+	return ret;
+
+ out_free:
+	if (cmd_ops->set_filter)
+		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	kfree(trigger_data);
+	goto out;
+}
+
+static struct event_command trigger_object_cmd = {
+	.name			= "objtrace",
+	.trigger_type		= ETT_TRACE_OBJECT,
+	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.func			= event_object_trigger_callback,
+	.reg			= register_object_trigger,
+	.unreg			= unregister_object_trigger,
+	.get_trigger_ops	= objecttrace_get_trigger_ops,
+	.set_filter		= set_trigger_filter,
+};
+
+__init int register_trigger_object_cmd(void)
+{
+	int ret;
+
+	ret = register_event_command(&trigger_object_cmd);
+	WARN_ON(ret < 0);
+
+	return ret;
+}
+
+int init_trace_object(void)
+{
+	int ret;
+
+	if (atomic_inc_return(&trace_object_ref) != 1) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = init_object_pool();
+	if (ret)
+		goto out;
+
+	INIT_WORK(&obj_refill_work, obj_refill_fn);
+	event_trace_file.tr = top_trace_array();
+	if (WARN_ON(!event_trace_file.tr)) {
+		ret = -1;
+		goto out;
+	}
+	ret = register_ftrace_function(&trace_ops);
+out:
+	return ret;
+}
+
+int exit_trace_object(void)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(atomic_read(&trace_object_ref) <= 0))
+		goto out;
+
+	if (atomic_dec_return(&trace_object_ref) != 0) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = unregister_ftrace_function(&trace_ops);
+	if (ret) {
+		pr_err("can't unregister ftrace for trace object\n");
+		goto out;
+	}
+	object_pool_exit();
+out:
+	return ret;
+}
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index c2ca40e8595b..76ca560af693 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1552,6 +1552,45 @@ static struct trace_event trace_func_repeats_event = {
 	.funcs		= &trace_func_repeats_funcs,
 };
 
+/* TRACE_OBJECT */
+static enum print_line_t trace_object_print(struct trace_iterator *iter, int flags,
+					struct trace_event *event)
+{
+	struct trace_object_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	trace_seq_printf(s, " object:0x%lx", field->object);
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags,
+				      struct trace_event *event)
+{
+	struct trace_object_entry *field;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(&iter->seq, "%lx %lx\n",
+			 field->ip,
+			 field->parent_ip);
+
+	return trace_handle_return(&iter->seq);
+}
+
+static struct trace_event_functions trace_object_funcs = {
+	.trace		= trace_object_print,
+	.raw		= trace_object_raw,
+};
+
+static struct trace_event trace_object_event = {
+	.type		= TRACE_OBJECT,
+	.funcs		= &trace_object_funcs,
+};
+
 static struct trace_event *events[] __initdata = {
 	&trace_fn_event,
 	&trace_ctx_event,
@@ -1566,6 +1605,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_timerlat_event,
 	&trace_raw_data_event,
 	&trace_func_repeats_event,
+	&trace_object_event,
 	NULL
 };
 
-- 
2.25.1

