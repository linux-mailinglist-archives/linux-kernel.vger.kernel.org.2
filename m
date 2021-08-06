Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945E33E2E8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhHFQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbhHFQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA29C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 09:49:09 -0700 (PDT)
Date:   Fri, 6 Aug 2021 18:49:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628268548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=U988bZqtXmwL4HUKwddW6bn8KCgnf2TSTJu5tvZmMc8=;
        b=pmWXJL+JBPImjdc5w6WFrf5ANLoGX7/+hJfhFS7k6QhlwGNG16+AxNvRyBc4YR+ZVX2bqa
        whyzwJDDcuALKzeKKNswAHn9Z7hvk8Mb1l4g5ErQfBd9rkln6dCVQu5wgINwFgJptwb4UI
        ADqqjIoyf6lbzf3ZOW7fdGQx1YPeIWllc9cfsES1x81TThHuUy+0P8ODhTyLXEIntQHpyZ
        Kref+k38KEBkmmHWgEkDiUTMwonWdJtdchH0evZPOGV2pH3zD9wFD5k/DLy4uBlEDALUvk
        J3nNB9NDBRe1l7o4/ksYv+KjterH5HzvQIGYMwV90A/473z8tY+mL1UnWLE55g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628268548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=U988bZqtXmwL4HUKwddW6bn8KCgnf2TSTJu5tvZmMc8=;
        b=9FinEYdUDWlb+5whW8N0HTELwPWsv2a29l5dNyTWbryOPXOavMMR/RDmKsh9PF4f7vBaTv
        ZgO6t5DwYOp+iFBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

migrate_disable() forbids task migration to another CPU. It is available
since v5.11 and has already users such as highmem or BPF. It is useful
to observe this task state in tracing which already has other states
like the preemption counter.

Add the migrate-disable counter to the trace entry so it shows up in the
trace. Due to the users mentioned above, it is already possible to
observe it:

|  bash-1108    [000] ...21    73.950578: rss_stat: mm_id=2213312838 curr=0 type=MM_ANONPAGES size=8192B
|  bash-1108    [000] d..31    73.951222: irq_disable: caller=flush_tlb_mm_range+0x115/0x130 parent=ptep_clear_flush+0x42/0x50
|  bash-1108    [000] d..31    73.951222: tlb_flush: pages:1 reason:local mm shootdown (3)

The last value is the migrate-disable counter.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: patch description.]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h |  2 ++
 kernel/trace/trace.c         | 26 +++++++++++++++++++-------
 kernel/trace/trace_events.c  |  1 +
 kernel/trace/trace_output.c  |  5 +++++
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ad413b382a3ca..7c4280b4c6be7 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -69,6 +69,7 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
+	unsigned char		migrate_disable;
 };
 
 #define TRACE_EVENT_TYPE_MAX						\
@@ -157,6 +158,7 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 						unsigned int trace_ctx)
 {
 	entry->preempt_count		= trace_ctx & 0xff;
+	entry->migrate_disable		= (trace_ctx >> 8) & 0xff;
 	entry->pid			= current->pid;
 	entry->type			= type;
 	entry->flags =			trace_ctx >> 16;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c59dd35a6da5c..936b683c81c7a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2603,6 +2603,15 @@ enum print_line_t trace_handle_return(struct trace_seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
 
+static unsigned short migration_disable_value(void)
+{
+#if defined(CONFIG_SMP)
+	return current->migration_disabled;
+#else
+	return 0;
+#endif
+}
+
 unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 {
 	unsigned int trace_flags = irqs_status;
@@ -2621,7 +2630,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
-	return (trace_flags << 16) | (pc & 0xff);
+	return (trace_flags << 16) | (pc & 0xff) |
+		(migration_disable_value() & 0xff) << 8;
 }
 
 struct ring_buffer_event *
@@ -4177,9 +4187,10 @@ static void print_lat_help_header(struct seq_file *m)
 		    "#                  | / _----=> need-resched    \n"
 		    "#                  || / _---=> hardirq/softirq \n"
 		    "#                  ||| / _--=> preempt-depth   \n"
-		    "#                  |||| /     delay            \n"
-		    "#  cmd     pid     ||||| time  |   caller      \n"
-		    "#     \\   /        |||||  \\    |   /         \n");
+		    "#                  |||| / _-=> migrate-disable \n"
+		    "#                  ||||| /     delay           \n"
+		    "#  cmd     pid     |||||| time  |   caller     \n"
+		    "#     \\   /        ||||||  \\    |    /       \n");
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -4217,9 +4228,10 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
 	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
 	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
-	seq_printf(m, "#                            %.*s||| /     delay\n", prec, space);
-	seq_printf(m, "#           TASK-PID  %.*s CPU#  ||||   TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
-	seq_printf(m, "#              | |    %.*s   |   ||||      |         |\n", prec, "       |    ");
+	seq_printf(m, "#                            %.*s||| / _-=> migrate-disable\n", prec, space);
+	seq_printf(m, "#                            %.*s|||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  |||||  TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   |||||     |         |\n", prec, "       |    ");
 }
 
 void
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 80e96989770ed..80b09956d5a0f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -183,6 +183,7 @@ static int trace_define_common_fields(void)
 	__common_field(unsigned char, flags);
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
+	__common_field(unsigned char, migrate_disable);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a0bf446bb0348..5b642b502b00f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -497,6 +497,11 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 	else
 		trace_seq_putc(s, '.');
 
+	if (entry->migrate_disable)
+		trace_seq_printf(s, "%x", entry->migrate_disable);
+	else
+		trace_seq_putc(s, '.');
+
 	return !trace_seq_has_overflowed(s);
 }
 
-- 
2.32.0

