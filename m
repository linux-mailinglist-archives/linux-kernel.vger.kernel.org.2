Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06F441D27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhKAPLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhKAPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:11:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D11C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:08:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m21so17390726pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8wMJzdNOsi/VqCHNi+JHvuZgJNpJMCn+67JndRkGWI=;
        b=FIIGGdAfn2u4BrFskePqWljEpztJ5O2/NdrGAj277H4JtNJjh+JxSL+5EI6Vfuxlir
         mmIMV+6ISO8tpv1/LoDNhsHXCa4P2/fey1AJksQSTiCfvCEYd8OYHsbqMRpCAuO+/+3S
         5GNyyexMXdzMZGI8/IiA/eh06sRaC66RYq3wUiRO4B5VuGfkWUZrRvkkTqTJbdAKBt+d
         PAjc5iXQ+IKkqo/WF5LeXqPB3Fy3Y3lDXR79EKCVGP5g1WvHG4BFQPMsvUeuVRyHKg0F
         2W9eJEaM/YZvRtgPqyac4hGZXACVn8Fff9HcsQ54ILVFLtPRkzVYR/2OcnjrR4O5nCUB
         kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8wMJzdNOsi/VqCHNi+JHvuZgJNpJMCn+67JndRkGWI=;
        b=U+4dSaCp3RB/oQ/liSGCJopQh8Yixm1eFSjwdrrqnkBFYnEjQax+wMoINJ7f9cULB/
         zFVYsMcvwWACLPwidW0LC97gAmU8tuhFDi3v7h29fcdLScyvFZZmwp9Zl3ezBGnyIelc
         ZBH4vEg8E58vj1gX+POlvcdrYz8K+Yl0U/Fblx8iNLytp2jvMdB9ff7gIyTVXUrBA/Oa
         +tX+a4/gpKbNP5hqL0SPbp380KbNG3td/gj7KMbPEHaIurMMRYCUGrJD/yrOE25JOzMj
         Gl9lyH1avuJ2DnzakW4WWSeaoVyUsE18/BbM6Sz8XIslm00mpFFniqBC3meZGbLS+Ygr
         odvw==
X-Gm-Message-State: AOAM530SCqp/ZPs/4NFrSf53KaBD37s8IHUByoNEFqjJSgw1SrQ2gnUK
        aAiudi7joEvKIgIUFPhQnWI=
X-Google-Smtp-Source: ABdhPJzuHBQuCMSO9tco7/G5h4IYqm7m/r0JgPkm9Ia5d6tzQn1y4XGeXiiDngbBq0/hpNlU/Kxzlw==
X-Received: by 2002:a05:6a00:2181:b0:44c:f4bc:2f74 with SMTP id h1-20020a056a00218100b0044cf4bc2f74mr29024107pfi.68.1635779323542;
        Mon, 01 Nov 2021 08:08:43 -0700 (PDT)
Received: from localhost.localdomain (li1164-150.members.linode.com. [45.79.65.150])
        by smtp.gmail.com with ESMTPSA id e14sm16682550pfv.192.2021.11.01.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:08:43 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v4 1/2] trace: Add trace any kernel object
Date:   Mon,  1 Nov 2021 23:07:59 +0800
Message-Id: <20211101150759.617943-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a method based on function tracer to trace any object and get
the value of the object dynamically. the object can from the dynamic event
(kprobe_event/uprobe_event) or the static event(tracepoint).

Usage:
When using the kprobe event, only need to set the objtrace(a new trigger),
we can get the value of the object. The object is from the setting of the 
kprobe event.

For example:
For the function bio_add_page():

int bio_add_page(struct bio *bio, struct page *page,
	unsigned int len, unsigned int offset)

Firstly, we can set the base of the object, thus the first string "arg1"
stands for the value of the first parameter of this function bio_add_gage(),

echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events

Secondly, we can get the value dynamically base the above object. 

find the offset of the bi_size in struct bio:
$ gdb vmlinux
(gdb) p &(((struct bio *)0)->bi_iter.bi_size)
$1 = (unsigned int *) 0x28

echo 'objtrace:0x28(arg1):u32:1 if comm == "cat"' > ./events/kprobes/ \
	p_bio_add_page_0/trigger

The best way to use this is that we can set the entrance event and exit
event, for example, the following example is to set the read_papes as
the entrance event, and set the blk_account_io_start as the exit event.

dd if=/dev/zero of=/test.txt bs=4k count=3
cd /sys/kernel/debug/tracing/
echo 0 > ./tracing_on
echo 'p read_pages' >> ./kprobe_events
echo 'p blk_account_io_start' >> ./kprobe_events
echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
echo 'traceoff if comm == "cat"' > ./events/kprobes/p_blk_account_io_start_0/trigger
echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
echo 'objtrace:0x28(arg1):u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
cat  /test.txt > /dev/null
cat ./trace

# tracer: nop
#
# entries-in-buffer/entries-written: 50/50   #P:1
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
             cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
             cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
             cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
             cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
             cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
             cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
             cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000


Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 include/linux/trace_events.h        |   1 +
 kernel/trace/Kconfig                |   9 +
 kernel/trace/Makefile               |   1 +
 kernel/trace/trace.h                |   8 +
 kernel/trace/trace_entries.h        |  18 +
 kernel/trace/trace_events_trigger.c |   1 +
 kernel/trace/trace_object.c         | 705 ++++++++++++++++++++++++++++
 kernel/trace/trace_output.c         |  40 ++
 8 files changed, 783 insertions(+)
 create mode 100644 kernel/trace/trace_object.c

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
index 420ff4bc67fd..419ec048686a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -237,6 +237,15 @@ config FUNCTION_PROFILER
 
 	  If in doubt, say N.
 
+config TRACE_OBJECT
+	bool "Trace kernel object"
+	depends on FUNCTION_TRACER
+	default y
+	help
+	 This help kernel developer to trace any kernel object, and get the value
+	 of the object dynamically. the object can from the dynamic event(kprobe_event/
+	 uprobe_event) or the static event(tracepoint).
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
index cd41e863b51c..b98c8d048bc3 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -401,3 +401,21 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
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
+		__field(	unsigned long,		value		)
+	),
+
+	F_printk(" %ps <-- %ps object:%lx value=%lx\n", (void *)__entry->ip,
+		(void *)__entry->parent_ip, __entry->object, __entry->value)
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
index 000000000000..4454613d2e49
--- /dev/null
+++ b/kernel/trace/trace_object.c
@@ -0,0 +1,705 @@
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
+static DEFINE_RAW_SPINLOCK(object_spin_lock);
+static struct trace_event_file event_trace_file;
+static LIST_HEAD(obj_head);
+static atomic_t trace_object_ref;
+static atomic_t trace_object_spin_disable;
+
+static int init_trace_object(void);
+static int exit_trace_object(void);
+
+struct objtrace_trigger_data {
+	struct ftrace_event_field *field;
+	long offset;
+	int type_size;
+};
+
+struct objtrace_fetch_type {
+	char *name;
+	int type_size;
+};
+
+struct objtrace_record {
+	void *obj;
+	int type_size;
+};
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
+	struct objtrace_record *obj_record;
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
+		obj_record = obj_pool.obj[obj_pool.curr_nr + i];
+		if (obj_record->obj == obj) {
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
+static void *remove_object_element(void)
+{
+	struct objtrace_record *obj_record = obj_pool.obj[--obj_pool.curr_nr];
+
+	BUG_ON(obj_pool.curr_nr < 0);
+
+	return obj_record;
+}
+
+static void add_object_element(void *obj)
+{
+	BUG_ON(obj_pool.curr_nr >= obj_pool.min_nr);
+	obj_pool.obj[obj_pool.curr_nr++] = obj;
+}
+
+static void set_trace_object(void *obj, int type_size)
+{
+	struct objtrace_record *new_obj_record;
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+
+	if (!obj)
+		return;
+
+	atomic_inc(&trace_object_spin_disable);
+	raw_spin_lock_irqsave(&object_spin_lock, flags);
+
+	if (object_exist(obj))
+		goto out;
+
+	if (obj_pool.curr_nr == 0) {
+		raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+		atomic_dec(&trace_object_spin_disable);
+		trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
+		return;
+	}
+
+	new_obj_record = remove_object_element();
+	new_obj_record->obj = obj;
+	new_obj_record->type_size = type_size;
+	if (obj_pool.curr_nr == reserved_obj_num) {
+		raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+		atomic_dec(&trace_object_spin_disable);
+		schedule_work(&obj_refill_work);
+		return;
+	}
+out:
+	raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+	atomic_dec(&trace_object_spin_disable);
+}
+
+static void object_pool_exit(void)
+{
+	struct objtrace_record *obj_record;
+
+	if (!obj_pool.obj)
+		return;
+
+	while (obj_pool.curr_nr) {
+		obj_record = remove_object_element();
+		kfree(obj_record);
+	}
+
+}
+
+static void object_pool_destory(void)
+{
+	if (!obj_pool.obj)
+		return;
+
+	object_pool_exit();
+	obj_pool.min_nr = 0;
+	kfree(obj_pool.obj);
+	obj_pool.obj = NULL;
+}
+
+static void obj_refill_fn(struct work_struct *refill_work)
+{
+	struct objtrace_record *obj_record;
+	void **new_obj_element, **prev_obj;
+	unsigned long flags;
+	int used_nr, prev_curr_nr, i;
+	int new_min_nr;
+
+	/*
+	 * using the two times of the previous min_nr when refill the object record.
+	 */
+	new_min_nr = obj_pool.min_nr * 2;
+	new_obj_element = kmalloc_array(new_min_nr, sizeof(void *), GFP_KERNEL);
+
+	if (!new_obj_element)
+		return;
+
+	atomic_inc(&trace_object_spin_disable);
+	raw_spin_lock_irqsave(&object_spin_lock, flags);
+
+	used_nr = obj_pool.min_nr - obj_pool.curr_nr;
+	prev_curr_nr = obj_pool.curr_nr;
+	prev_obj = obj_pool.obj;
+	/* exit the previous object record pool */
+	object_pool_exit();
+	obj_pool.obj = new_obj_element;
+	obj_pool.min_nr  = new_min_nr;
+
+	for (i = 0; i < new_min_nr - used_nr; i++) {
+		raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+		atomic_dec(&trace_object_spin_disable);
+
+		obj_record = kzalloc(sizeof(*obj_record), GFP_KERNEL);
+
+		atomic_inc(&trace_object_spin_disable);
+		raw_spin_lock_irqsave(&object_spin_lock, flags);
+		if (!obj_record) {
+			object_pool_exit();
+			return;
+		}
+		add_object_element(obj_record);
+	}
+	memcpy(obj_pool.obj + obj_pool.curr_nr, prev_obj + prev_curr_nr,
+			used_nr * sizeof(void *));
+	kfree(prev_obj);
+	raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+	atomic_dec(&trace_object_spin_disable);
+}
+
+static int init_object_pool(void)
+{
+	struct objtrace_record *obj_record;
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
+	for (i = 0; i < init_obj_num; i++) {
+		obj_record = kzalloc(sizeof(*obj_record), GFP_KERNEL);
+		if (!obj_record) {
+			object_pool_destory();
+			ret = -ENOMEM;
+			goto out;
+		}
+		add_object_element(obj_record);
+	}
+
+out:
+	return ret;
+}
+
+static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
+				 unsigned long object, unsigned long value)
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
+	entry->value			= value;
+
+	event_trigger_unlock_commit(&event_trace_file, buffer, event,
+		entry, pc);
+}
+
+static void
+trace_object_events_call(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct objtrace_record *obj_record;
+	unsigned long val = 0, flags;
+	int i, used;
+
+	if (in_nmi())
+		return;
+
+	/* prevent recursion when invoking raw_spin_lock_irqsave/raw_spin_unlock_irqrestore */
+	if (atomic_read(&trace_object_spin_disable) != 0)
+		return;
+	atomic_inc(&trace_object_spin_disable);
+	raw_spin_lock_irqsave(&object_spin_lock, flags);
+
+	if (object_empty())
+		goto out;
+
+	used = obj_pool.min_nr - obj_pool.curr_nr;
+	if (!used)
+		goto out;
+
+	for (i = 0; i < used; i++) {
+		obj_record = obj_pool.obj[obj_pool.curr_nr + i];
+
+		if (copy_from_kernel_nofault(&val, obj_record->obj, obj_record->type_size))
+			goto out;
+
+		raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+		atomic_dec(&trace_object_spin_disable);
+
+		submit_trace_object(ip, parent_ip, (unsigned long)obj_record->obj, val);
+
+		atomic_inc(&trace_object_spin_disable);
+		raw_spin_lock_irqsave(&object_spin_lock, flags);
+
+	}
+
+out:
+	raw_spin_unlock_irqrestore(&object_spin_lock, flags);
+	atomic_dec(&trace_object_spin_disable);
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
+	struct objtrace_trigger_data *obj_data = data->private_data;
+	struct ftrace_event_field *field;
+	void *obj, *val = NULL;
+
+	field = obj_data->field;
+	memcpy(&val, (char *)rec + field->offset, field->size);
+	obj = val + obj_data->offset;
+	set_trace_object(obj, obj_data->type_size);
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
+	if (!data->ref) {
+		kfree(data->private_data);
+		trigger_data_free(data);
+	}
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
+static const struct objtrace_fetch_type objtrace_fetch_types[] = {
+	{"u8", 1},
+	{"s8", 1},
+	{"x8", 1},
+	{"u16", 2},
+	{"s16", 2},
+	{"x16", 2},
+	{"u32", 4},
+	{"s32", 4},
+	{"x32", 4},
+	{"u64", 8},
+	{"s64", 8},
+	{"x64", 8},
+	{}
+};
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
+	struct objtrace_trigger_data *obj_data;
+	long offset = 0;
+	char *trigger = NULL;
+	char *arg, *type, *tr, *tr_end;
+	char *number;
+	int ret, i, type_size = 0;
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
+
+	tr = strchr(arg, '(');
+	/* now force to get the value of the val. */
+	if (!tr)
+		goto out;
+	tr_end = strchr(tr, ')');
+	if (!tr_end)
+		goto out;
+	*tr++ = '\0';
+	*tr_end = '\0';
+	ret = kstrtol(arg, 0, &offset);
+	if (ret)
+		goto out;
+	arg = tr;
+	ret = -EINVAL;
+	if (!trigger)
+		goto out;
+
+	type = strsep(&trigger, ":");
+	if (!type)
+		goto out;
+	for (i = 0; objtrace_fetch_types[i].name; i++) {
+		if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
+			type_size = objtrace_fetch_types[i].type_size;
+			break;
+		}
+	}
+
+	if (type_size == 0)
+		goto out;
+
+	call = file->event_call;
+	field = trace_find_event_field(call, arg);
+	if (!field)
+		goto out;
+
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+
+	ret = -ENOMEM;
+	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
+	if (!obj_data)
+		goto out;
+
+	obj_data->field = field;
+	obj_data->offset = offset;
+	obj_data->type_size = type_size;
+
+	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	if (!trigger_data) {
+		kfree(obj_data);
+		goto out;
+	}
+
+	trigger_data->count = -1;
+	trigger_data->ops = trigger_ops;
+	trigger_data->cmd_ops = cmd_ops;
+	trigger_data->private_data = obj_data;
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
+	kfree(obj_data);
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
+static int init_trace_object(void)
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
+static int exit_trace_object(void)
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
+	object_pool_destory();
+out:
+	return ret;
+}
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index c2ca40e8595b..99bc09f31e0c 100644
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
+	trace_seq_printf(s, " value:0x%lx", field->value);
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
+	trace_seq_printf(&iter->seq, "%lx %lx %lx\n",
+			 field->ip, field->parent_ip, field->value);
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

