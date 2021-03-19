Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811EF3424D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCSSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4BD6198E;
        Fri, 19 Mar 2021 18:38:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0W-0017jn-Tn; Fri, 19 Mar 2021 14:38:00 -0400
Message-ID: <20210319183800.810665594@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 05/13] tracing: Use a no_filter_buffering_ref to stop using the filter
 buffer
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, the trace histograms relies on it using absolute time stamps to
trigger the tracing to not use the temp buffer if filters are set. That's
because the histograms need the full timestamp that is saved in the ring
buffer. That is no longer the case, as the ring_buffer_event_time_stamp()
can now return the time stamp for all events without all triggering a full
absolute time stamp.

Now that the absolute time stamp is an unrelated dependency to not using
the filters. There's nothing about having absolute timestamps to keep from
using the filter buffer. Instead, change the interface to explicitly state
to disable filter buffering that the histogram logic can use.

Link: https://lkml.kernel.org/r/20210316164113.847886563@goodmis.org

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c             | 28 ++++++++++++----------------
 kernel/trace/trace.h             |  4 ++--
 kernel/trace/trace_events_hist.c |  6 +++---
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f979220238a5..b15436ff85e8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2737,12 +2737,13 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 			  unsigned int trace_ctx)
 {
 	struct ring_buffer_event *entry;
+	struct trace_array *tr = trace_file->tr;
 	int val;
 
-	*current_rb = trace_file->tr->array_buffer.buffer;
+	*current_rb = tr->array_buffer.buffer;
 
-	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
-	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
+	if (!tr->no_filter_buffering_ref &&
+	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
@@ -6971,31 +6972,26 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
+/*
+ * Set or disable using the per CPU trace_buffer_event when possible.
+ */
+int tracing_set_filter_buffering(struct trace_array *tr, bool set)
 {
 	int ret = 0;
 
 	mutex_lock(&trace_types_lock);
 
-	if (abs && tr->time_stamp_abs_ref++)
+	if (set && tr->no_filter_buffering_ref++)
 		goto out;
 
-	if (!abs) {
-		if (WARN_ON_ONCE(!tr->time_stamp_abs_ref)) {
+	if (!set) {
+		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref)) {
 			ret = -EINVAL;
 			goto out;
 		}
 
-		if (--tr->time_stamp_abs_ref)
-			goto out;
+		--tr->no_filter_buffering_ref;
 	}
-
-	ring_buffer_set_time_stamp_abs(tr->array_buffer.buffer, abs);
-
-#ifdef CONFIG_TRACER_MAX_TRACE
-	if (tr->max_buffer.buffer)
-		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
-#endif
  out:
 	mutex_unlock(&trace_types_lock);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 798773178d7e..f2a7a72825c7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -352,7 +352,7 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
-	int			time_stamp_abs_ref;
+	int			no_filter_buffering_ref;
 	struct list_head	hist_vars;
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
@@ -372,7 +372,7 @@ extern int tracing_check_open_get_tr(struct trace_array *tr);
 extern struct trace_array *trace_array_find(const char *instance);
 extern struct trace_array *trace_array_find_get(const char *instance);
 
-extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+extern int tracing_set_filter_buffering(struct trace_array *tr, bool set);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 45986cb4637e..c1abd63f1d6c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5484,7 +5484,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			goto out;
 		}
 
-		tracing_set_time_stamp_abs(file->tr, true);
+		tracing_set_filter_buffering(file->tr, true);
 	}
 
 	if (named_data)
@@ -5592,7 +5592,7 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || unregistered)
-			tracing_set_time_stamp_abs(file->tr, false);
+			tracing_set_filter_buffering(file->tr, false);
 	}
 }
 
@@ -5639,7 +5639,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
-				tracing_set_time_stamp_abs(file->tr, false);
+				tracing_set_filter_buffering(file->tr, false);
 			if (test->ops->free)
 				test->ops->free(test->ops, test);
 		}
-- 
2.30.1


