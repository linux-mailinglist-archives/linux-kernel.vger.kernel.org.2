Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310B3626BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbhDPR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241761AbhDPR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8594A6124B;
        Fri, 16 Apr 2021 17:26:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF6-0069jr-IT; Fri, 16 Apr 2021 13:26:56 -0400
Message-ID: <20210416172656.445828277@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 2/7] tracing: Define new ftrace event "func_repeats"
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

The event aims to consolidate the function tracing record in the cases
when a single function is called number of times consecutively.

	while (cond)
		do_func();

This may happen in various scenarios (busy waiting for example).
The new ftrace event can be used to show repeated function events with
a single event and save space on the ring buffer

Link: https://lkml.kernel.org/r/20210415181854.147448-3-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h         |  3 +++
 kernel/trace/trace_entries.h | 22 +++++++++++++++++
 kernel/trace/trace_output.c  | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5506424eae2a..6a5b4c2a0fa7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -45,6 +45,7 @@ enum trace_type {
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_RAW_DATA,
+	TRACE_FUNC_REPEATS,
 
 	__TRACE_LAST_TYPE,
 };
@@ -442,6 +443,8 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_ENT);		\
 		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
 			  TRACE_GRAPH_RET);		\
+		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
+			  TRACE_FUNC_REPEATS);				\
 		__ftrace_bad_type();					\
 	} while (0)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 4547ac59da61..251c819cf0c5 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -338,3 +338,25 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
+
+#define FUNC_REPEATS_GET_DELTA_TS(entry)				\
+	(((u64)(entry)->top_delta_ts << 32) | (entry)->bottom_delta_ts)	\
+
+FTRACE_ENTRY(func_repeats, func_repeats_entry,
+
+	TRACE_FUNC_REPEATS,
+
+	F_STRUCT(
+		__field(	unsigned long,	ip		)
+		__field(	unsigned long,	parent_ip	)
+		__field(	u16	,	count		)
+		__field(	u16	,	top_delta_ts	)
+		__field(	u32	,	bottom_delta_ts	)
+	),
+
+	F_printk(" %ps <-%ps\t(repeats:%u  delta: -%llu)",
+		 (void *)__entry->ip,
+		 (void *)__entry->parent_ip,
+		 __entry->count,
+		 FUNC_REPEATS_GET_DELTA_TS(__entry))
+);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 333233d45596..3037f0c88f90 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1381,6 +1381,53 @@ static struct trace_event trace_raw_data_event = {
 	.funcs		= &trace_raw_data_funcs,
 };
 
+static enum print_line_t
+trace_func_repeats_raw(struct trace_iterator *iter, int flags,
+			 struct trace_event *event)
+{
+	struct func_repeats_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(s, "%lu %lu %u %llu\n",
+			 field->ip,
+			 field->parent_ip,
+			 field->count,
+			 FUNC_REPEATS_GET_DELTA_TS(field));
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t
+trace_func_repeats_print(struct trace_iterator *iter, int flags,
+			 struct trace_event *event)
+{
+	struct func_repeats_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	seq_print_ip_sym(s, field->ip, flags);
+	trace_seq_puts(s, " <-");
+	seq_print_ip_sym(s, field->parent_ip, flags);
+	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
+	trace_print_time(s, iter,
+			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
+	trace_seq_puts(s, ")\n");
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_func_repeats_funcs = {
+	.trace		= trace_func_repeats_print,
+	.raw		= trace_func_repeats_raw,
+};
+
+static struct trace_event trace_func_repeats_event = {
+	.type	 	= TRACE_FUNC_REPEATS,
+	.funcs		= &trace_func_repeats_funcs,
+};
 
 static struct trace_event *events[] __initdata = {
 	&trace_fn_event,
@@ -1393,6 +1440,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_print_event,
 	&trace_hwlat_event,
 	&trace_raw_data_event,
+	&trace_func_repeats_event,
 	NULL
 };
 
-- 
2.30.1


