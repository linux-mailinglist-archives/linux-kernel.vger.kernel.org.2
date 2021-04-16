Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C13626BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbhDPR1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241778AbhDPR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E238361222;
        Fri, 16 Apr 2021 17:26:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF6-0069kx-Uu; Fri, 16 Apr 2021 13:26:56 -0400
Message-ID: <20210416172656.823902929@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 4/7] tracing: Add method for recording "func_repeats" events
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

This patch only provides the implementation of the method.
Later we will used it in a combination with a new option for
function tracing.

Link: https://lkml.kernel.org/r/20210415181854.147448-5-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 82833be07c1e..66a4ad93b5e9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3117,6 +3117,40 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 
 #endif /* CONFIG_STACKTRACE */
 
+static inline void
+func_repeats_set_delta_ts(struct func_repeats_entry *entry,
+			  unsigned long long delta)
+{
+	entry->bottom_delta_ts = delta & U32_MAX;
+	entry->top_delta_ts = (delta >> 32);
+}
+
+void trace_last_func_repeats(struct trace_array *tr,
+			     struct trace_func_repeats *last_info,
+			     unsigned int trace_ctx)
+{
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct func_repeats_entry *entry;
+	struct ring_buffer_event *event;
+	u64 delta;
+
+	event = __trace_buffer_lock_reserve(buffer, TRACE_FUNC_REPEATS,
+					    sizeof(*entry), trace_ctx);
+	if (!event)
+		return;
+
+	delta = ring_buffer_event_time_stamp(buffer, event) -
+		last_info->ts_last_call;
+
+	entry = ring_buffer_event_data(event);
+	entry->ip = last_info->ip;
+	entry->parent_ip = last_info->parent_ip;
+	entry->count = last_info->count;
+	func_repeats_set_delta_ts(entry, delta);
+
+	__buffer_unlock_commit(buffer, event);
+}
+
 /* created for use with alloc_percpu */
 struct trace_buffer_struct {
 	int nesting;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a4f1b66049fd..cd80d046c7a5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -695,6 +695,10 @@ static inline void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 }
 #endif /* CONFIG_STACKTRACE */
 
+void trace_last_func_repeats(struct trace_array *tr,
+			     struct trace_func_repeats *last_info,
+			     unsigned int trace_ctx);
+
 extern u64 ftrace_now(int cpu);
 
 extern void trace_find_cmdline(int pid, char comm[]);
-- 
2.30.1


