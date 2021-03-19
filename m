Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B213424D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhCSSig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DED6198C;
        Fri, 19 Mar 2021 18:38:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0W-0017ip-KJ; Fri, 19 Mar 2021 14:38:00 -0400
Message-ID: <20210319183800.514230739@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 03/13] tracing: Pass buffer of event to trigger operations
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ring_buffer_event_time_stamp() is going to be updated to extract the
time stamp for the event without needing it to be set to have absolute
values for all events. But to do so, it needs the buffer that the event is
on as the buffer saves information for the event before it is committed to
the buffer.

If the trace buffer is disabled, a temporary buffer is used, and there's
no access to this buffer from the current histogram triggers, even though
it is passed to the trace event code.

Pass the buffer that the event is on all the way down to the histogram
triggers.

Link: https://lkml.kernel.org/r/20210316164113.542448131@goodmis.org

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h        |  5 +-
 kernel/trace/trace.c                |  2 +-
 kernel/trace/trace.h                |  4 +-
 kernel/trace/trace_events_hist.c    | 92 +++++++++++++++++++----------
 kernel/trace/trace_events_trigger.c | 45 ++++++++------
 5 files changed, 95 insertions(+), 53 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 28e7af1406f2..8cba64ce23a4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -640,7 +640,8 @@ enum event_trigger_type {
 extern int filter_match_preds(struct event_filter *filter, void *rec);
 
 extern enum event_trigger_type
-event_triggers_call(struct trace_event_file *file, void *rec,
+event_triggers_call(struct trace_event_file *file,
+		    struct trace_buffer *buffer, void *rec,
 		    struct ring_buffer_event *event);
 extern void
 event_triggers_post_call(struct trace_event_file *file,
@@ -664,7 +665,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
 		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL, NULL);
+			event_triggers_call(file, NULL, NULL, NULL);
 		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
 			return true;
 		if (eflags & EVENT_FILE_FL_PID_FILTER)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eccb4e1187cc..f979220238a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6763,7 +6763,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
 		entry->buf[cnt] = '\0';
-		tt = event_triggers_call(tr->trace_marker_file, entry, event);
+		tt = event_triggers_call(tr->trace_marker_file, buffer, entry, event);
 	}
 
 	if (entry->buf[cnt - 1] != '\n') {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a6446c03cfbc..798773178d7e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1329,7 +1329,7 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	unsigned long eflags = file->flags;
 
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
-		*tt = event_triggers_call(file, entry, event);
+		*tt = event_triggers_call(file, buffer, entry, event);
 
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
 	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
@@ -1626,7 +1626,7 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  */
 struct event_trigger_ops {
 	void			(*func)(struct event_trigger_data *data,
-					void *rec,
+					struct trace_buffer *buffer, void *rec,
 					struct ring_buffer_event *rbe);
 	int			(*init)(struct event_trigger_ops *ops,
 					struct event_trigger_data *data);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 39ebe1826fc3..6978aa3ee4c5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -81,6 +81,7 @@ struct hist_field;
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 				struct tracing_map_elt *elt,
+				struct trace_buffer *buffer,
 				struct ring_buffer_event *rbe,
 				void *event);
 
@@ -153,6 +154,7 @@ struct hist_field {
 
 static u64 hist_field_none(struct hist_field *field,
 			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
 			   struct ring_buffer_event *rbe,
 			   void *event)
 {
@@ -161,6 +163,7 @@ static u64 hist_field_none(struct hist_field *field,
 
 static u64 hist_field_counter(struct hist_field *field,
 			      struct tracing_map_elt *elt,
+			      struct trace_buffer *buffer,
 			      struct ring_buffer_event *rbe,
 			      void *event)
 {
@@ -169,6 +172,7 @@ static u64 hist_field_counter(struct hist_field *field,
 
 static u64 hist_field_string(struct hist_field *hist_field,
 			     struct tracing_map_elt *elt,
+			     struct trace_buffer *buffer,
 			     struct ring_buffer_event *rbe,
 			     void *event)
 {
@@ -179,6 +183,7 @@ static u64 hist_field_string(struct hist_field *hist_field,
 
 static u64 hist_field_dynstring(struct hist_field *hist_field,
 				struct tracing_map_elt *elt,
+				struct trace_buffer *buffer,
 				struct ring_buffer_event *rbe,
 				void *event)
 {
@@ -191,6 +196,7 @@ static u64 hist_field_dynstring(struct hist_field *hist_field,
 
 static u64 hist_field_pstring(struct hist_field *hist_field,
 			      struct tracing_map_elt *elt,
+			      struct trace_buffer *buffer,
 			      struct ring_buffer_event *rbe,
 			      void *event)
 {
@@ -201,52 +207,56 @@ static u64 hist_field_pstring(struct hist_field *hist_field,
 
 static u64 hist_field_log2(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
 			   struct ring_buffer_event *rbe,
 			   void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, elt, rbe, event);
+	u64 val = operand->fn(operand, elt, buffer, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
 static u64 hist_field_plus(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
 			   struct ring_buffer_event *rbe,
 			   void *event)
 {
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, rbe, event);
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
 
 	return val1 + val2;
 }
 
 static u64 hist_field_minus(struct hist_field *hist_field,
 			    struct tracing_map_elt *elt,
+			    struct trace_buffer *buffer,
 			    struct ring_buffer_event *rbe,
 			    void *event)
 {
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, rbe, event);
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
 
 	return val1 - val2;
 }
 
 static u64 hist_field_unary_minus(struct hist_field *hist_field,
 				  struct tracing_map_elt *elt,
+				  struct trace_buffer *buffer,
 				  struct ring_buffer_event *rbe,
 				  void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	s64 sval = (s64)operand->fn(operand, elt, rbe, event);
+	s64 sval = (s64)operand->fn(operand, elt, buffer, rbe, event);
 	u64 val = (u64)-sval;
 
 	return val;
@@ -255,6 +265,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 #define DEFINE_HIST_FIELD_FN(type)					\
 	static u64 hist_field_##type(struct hist_field *hist_field,	\
 				     struct tracing_map_elt *elt,	\
+				     struct trace_buffer *buffer,	\
 				     struct ring_buffer_event *rbe,	\
 				     void *event)			\
 {									\
@@ -380,7 +391,8 @@ struct hist_trigger_data {
 struct action_data;
 
 typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
-			     struct tracing_map_elt *elt, void *rec,
+			     struct tracing_map_elt *elt,
+			     struct trace_buffer *buffer, void *rec,
 			     struct ring_buffer_event *rbe, void *key,
 			     struct action_data *data, u64 *var_ref_vals);
 
@@ -608,7 +620,8 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 }
 
 static void action_trace(struct hist_trigger_data *hist_data,
-			 struct tracing_map_elt *elt, void *rec,
+			 struct tracing_map_elt *elt,
+			 struct trace_buffer *buffer, void *rec,
 			 struct ring_buffer_event *rbe, void *key,
 			 struct action_data *data, u64 *var_ref_vals)
 {
@@ -624,6 +637,7 @@ struct hist_var_data {
 
 static u64 hist_field_timestamp(struct hist_field *hist_field,
 				struct tracing_map_elt *elt,
+				struct trace_buffer *buffer,
 				struct ring_buffer_event *rbe,
 				void *event)
 {
@@ -640,6 +654,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 
 static u64 hist_field_cpu(struct hist_field *hist_field,
 			  struct tracing_map_elt *elt,
+			  struct trace_buffer *buffer,
 			  struct ring_buffer_event *rbe,
 			  void *event)
 {
@@ -1020,6 +1035,7 @@ static struct hist_field *find_event_var(struct hist_trigger_data *hist_data,
 
 static u64 hist_field_var_ref(struct hist_field *hist_field,
 			      struct tracing_map_elt *elt,
+			      struct trace_buffer *buffer,
 			      struct ring_buffer_event *rbe,
 			      void *event)
 {
@@ -2561,6 +2577,7 @@ find_target_event_var(struct hist_trigger_data *hist_data,
 }
 
 static inline void __update_field_vars(struct tracing_map_elt *elt,
+				       struct trace_buffer *buffer,
 				       struct ring_buffer_event *rbe,
 				       void *rec,
 				       struct field_var **field_vars,
@@ -2576,7 +2593,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 		struct hist_field *var = field_var->var;
 		struct hist_field *val = field_var->val;
 
-		var_val = val->fn(val, elt, rbe, rec);
+		var_val = val->fn(val, elt, buffer, rbe, rec);
 		var_idx = var->var.idx;
 
 		if (val->flags & HIST_FIELD_FL_STRING) {
@@ -2592,19 +2609,21 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 
 static void update_field_vars(struct hist_trigger_data *hist_data,
 			      struct tracing_map_elt *elt,
+			      struct trace_buffer *buffer,
 			      struct ring_buffer_event *rbe,
 			      void *rec)
 {
-	__update_field_vars(elt, rbe, rec, hist_data->field_vars,
+	__update_field_vars(elt, buffer, rbe, rec, hist_data->field_vars,
 			    hist_data->n_field_vars, 0);
 }
 
 static void save_track_data_vars(struct hist_trigger_data *hist_data,
-				 struct tracing_map_elt *elt, void *rec,
+				 struct tracing_map_elt *elt,
+				 struct trace_buffer *buffer,  void *rec,
 				 struct ring_buffer_event *rbe, void *key,
 				 struct action_data *data, u64 *var_ref_vals)
 {
-	__update_field_vars(elt, rbe, rec, hist_data->save_vars,
+	__update_field_vars(elt, buffer, rbe, rec, hist_data->save_vars,
 			    hist_data->n_save_vars, hist_data->n_field_var_str);
 }
 
@@ -2780,12 +2799,14 @@ static void save_track_val(struct hist_trigger_data *hist_data,
 }
 
 static void save_track_data(struct hist_trigger_data *hist_data,
-			    struct tracing_map_elt *elt, void *rec,
+			    struct tracing_map_elt *elt,
+			    struct trace_buffer *buffer, void *rec,
 			    struct ring_buffer_event *rbe, void *key,
 			    struct action_data *data, u64 *var_ref_vals)
 {
 	if (data->track_data.save_data)
-		data->track_data.save_data(hist_data, elt, rec, rbe, key, data, var_ref_vals);
+		data->track_data.save_data(hist_data, elt, buffer, rec, rbe,
+					   key, data, var_ref_vals);
 }
 
 static bool check_track_val(struct tracing_map_elt *elt,
@@ -2836,7 +2857,8 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 }
 
 static void save_track_data_snapshot(struct hist_trigger_data *hist_data,
-				     struct tracing_map_elt *elt, void *rec,
+				     struct tracing_map_elt *elt,
+				     struct trace_buffer *buffer, void *rec,
 				     struct ring_buffer_event *rbe, void *key,
 				     struct action_data *data,
 				     u64 *var_ref_vals)
@@ -2905,7 +2927,8 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	return false;
 }
 static void save_track_data_snapshot(struct hist_trigger_data *hist_data,
-				     struct tracing_map_elt *elt, void *rec,
+				     struct tracing_map_elt *elt,
+				     struct trace_buffer *buffer, void *rec,
 				     struct ring_buffer_event *rbe, void *key,
 				     struct action_data *data,
 				     u64 *var_ref_vals) {}
@@ -2947,7 +2970,8 @@ static void track_data_print(struct seq_file *m,
 }
 
 static void ontrack_action(struct hist_trigger_data *hist_data,
-			   struct tracing_map_elt *elt, void *rec,
+			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer, void *rec,
 			   struct ring_buffer_event *rbe, void *key,
 			   struct action_data *data, u64 *var_ref_vals)
 {
@@ -2955,7 +2979,8 @@ static void ontrack_action(struct hist_trigger_data *hist_data,
 
 	if (check_track_val(elt, data, var_val)) {
 		save_track_val(hist_data, elt, data, var_val);
-		save_track_data(hist_data, elt, rec, rbe, key, data, var_ref_vals);
+		save_track_data(hist_data, elt, buffer, rec, rbe,
+				key, data, var_ref_vals);
 	}
 }
 
@@ -4400,7 +4425,8 @@ create_hist_data(unsigned int map_bits,
 }
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
-				    struct tracing_map_elt *elt, void *rec,
+				    struct tracing_map_elt *elt,
+				    struct trace_buffer *buffer, void *rec,
 				    struct ring_buffer_event *rbe,
 				    u64 *var_ref_vals)
 {
@@ -4414,7 +4440,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+		hist_val = hist_field->fn(hist_field, elt, buffer, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
@@ -4442,13 +4468,13 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 	for_each_hist_key_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
-			hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+			hist_val = hist_field->fn(hist_field, elt, buffer, rbe, rec);
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
 		}
 	}
 
-	update_field_vars(hist_data, elt, rbe, rec);
+	update_field_vars(hist_data, elt, buffer, rbe, rec);
 }
 
 static inline void add_to_key(char *compound_key, void *key,
@@ -4478,7 +4504,8 @@ static inline void add_to_key(char *compound_key, void *key,
 
 static void
 hist_trigger_actions(struct hist_trigger_data *hist_data,
-		     struct tracing_map_elt *elt, void *rec,
+		     struct tracing_map_elt *elt,
+		     struct trace_buffer *buffer, void *rec,
 		     struct ring_buffer_event *rbe, void *key,
 		     u64 *var_ref_vals)
 {
@@ -4487,11 +4514,12 @@ hist_trigger_actions(struct hist_trigger_data *hist_data,
 
 	for (i = 0; i < hist_data->n_actions; i++) {
 		data = hist_data->actions[i];
-		data->fn(hist_data, elt, rec, rbe, key, data, var_ref_vals);
+		data->fn(hist_data, elt, buffer, rec, rbe, key, data, var_ref_vals);
 	}
 }
 
-static void event_hist_trigger(struct event_trigger_data *data, void *rec,
+static void event_hist_trigger(struct event_trigger_data *data,
+			       struct trace_buffer *buffer, void *rec,
 			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -4516,7 +4544,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 					 HIST_STACKTRACE_SKIP);
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, elt, rbe, rec);
+			field_contents = key_field->fn(key_field, elt, buffer, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -4539,10 +4567,10 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	if (!elt)
 		return;
 
-	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
+	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, var_ref_vals);
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, rec, rbe, key, var_ref_vals);
+		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5812,7 +5840,8 @@ __init int register_trigger_hist_cmd(void)
 }
 
 static void
-hist_enable_trigger(struct event_trigger_data *data, void *rec,
+hist_enable_trigger(struct event_trigger_data *data,
+		    struct trace_buffer *buffer,  void *rec,
 		    struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -5830,7 +5859,8 @@ hist_enable_trigger(struct event_trigger_data *data, void *rec,
 }
 
 static void
-hist_enable_count_trigger(struct event_trigger_data *data, void *rec,
+hist_enable_count_trigger(struct event_trigger_data *data,
+			  struct trace_buffer *buffer,  void *rec,
 			  struct ring_buffer_event *event)
 {
 	if (!data->count)
@@ -5839,7 +5869,7 @@ hist_enable_count_trigger(struct event_trigger_data *data, void *rec,
 	if (data->count != -1)
 		(data->count)--;
 
-	hist_enable_trigger(data, rec, event);
+	hist_enable_trigger(data, buffer, rec, event);
 }
 
 static struct event_trigger_ops hist_enable_trigger_ops = {
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index f725802160c0..b8bfa8505b7b 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -53,7 +53,8 @@ void trigger_data_free(struct event_trigger_data *data)
  * any trigger that should be deferred, ETT_NONE if nothing to defer.
  */
 enum event_trigger_type
-event_triggers_call(struct trace_event_file *file, void *rec,
+event_triggers_call(struct trace_event_file *file,
+		    struct trace_buffer *buffer, void *rec,
 		    struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
@@ -67,7 +68,7 @@ event_triggers_call(struct trace_event_file *file, void *rec,
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->func(data, rec, event);
+			data->ops->func(data, buffer, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -77,7 +78,7 @@ event_triggers_call(struct trace_event_file *file, void *rec,
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->func(data, rec, event);
+		data->ops->func(data, buffer, rec, event);
 	}
 	return tt;
 }
@@ -105,7 +106,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, NULL, NULL);
+			data->ops->func(data, NULL, NULL, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -937,7 +938,8 @@ get_named_trigger_data(struct event_trigger_data *data)
 }
 
 static void
-traceon_trigger(struct event_trigger_data *data, void *rec,
+traceon_trigger(struct event_trigger_data *data,
+		struct trace_buffer *buffer, void *rec,
 		struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
@@ -947,7 +949,8 @@ traceon_trigger(struct event_trigger_data *data, void *rec,
 }
 
 static void
-traceon_count_trigger(struct event_trigger_data *data, void *rec,
+traceon_count_trigger(struct event_trigger_data *data,
+		      struct trace_buffer *buffer, void *rec,
 		      struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
@@ -963,7 +966,8 @@ traceon_count_trigger(struct event_trigger_data *data, void *rec,
 }
 
 static void
-traceoff_trigger(struct event_trigger_data *data, void *rec,
+traceoff_trigger(struct event_trigger_data *data,
+		 struct trace_buffer *buffer, void *rec,
 		 struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
@@ -973,7 +977,8 @@ traceoff_trigger(struct event_trigger_data *data, void *rec,
 }
 
 static void
-traceoff_count_trigger(struct event_trigger_data *data, void *rec,
+traceoff_count_trigger(struct event_trigger_data *data,
+		       struct trace_buffer *buffer, void *rec,
 		       struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
@@ -1071,7 +1076,8 @@ static struct event_command trigger_traceoff_cmd = {
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 static void
-snapshot_trigger(struct event_trigger_data *data, void *rec,
+snapshot_trigger(struct event_trigger_data *data,
+		 struct trace_buffer *buffer, void *rec,
 		 struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
@@ -1083,7 +1089,8 @@ snapshot_trigger(struct event_trigger_data *data, void *rec,
 }
 
 static void
-snapshot_count_trigger(struct event_trigger_data *data, void *rec,
+snapshot_count_trigger(struct event_trigger_data *data,
+		       struct trace_buffer *buffer, void *rec,
 		       struct ring_buffer_event *event)
 {
 	if (!data->count)
@@ -1092,7 +1099,7 @@ snapshot_count_trigger(struct event_trigger_data *data, void *rec,
 	if (data->count != -1)
 		(data->count)--;
 
-	snapshot_trigger(data, rec, event);
+	snapshot_trigger(data, buffer, rec, event);
 }
 
 static int
@@ -1176,14 +1183,16 @@ static __init int register_trigger_snapshot_cmd(void) { return 0; }
 #endif
 
 static void
-stacktrace_trigger(struct event_trigger_data *data, void *rec,
+stacktrace_trigger(struct event_trigger_data *data,
+		   struct trace_buffer *buffer,  void *rec,
 		   struct ring_buffer_event *event)
 {
 	trace_dump_stack(STACK_SKIP);
 }
 
 static void
-stacktrace_count_trigger(struct event_trigger_data *data, void *rec,
+stacktrace_count_trigger(struct event_trigger_data *data,
+			 struct trace_buffer *buffer, void *rec,
 			 struct ring_buffer_event *event)
 {
 	if (!data->count)
@@ -1192,7 +1201,7 @@ stacktrace_count_trigger(struct event_trigger_data *data, void *rec,
 	if (data->count != -1)
 		(data->count)--;
 
-	stacktrace_trigger(data, rec, event);
+	stacktrace_trigger(data, buffer, rec, event);
 }
 
 static int
@@ -1254,7 +1263,8 @@ static __init void unregister_trigger_traceon_traceoff_cmds(void)
 }
 
 static void
-event_enable_trigger(struct event_trigger_data *data, void *rec,
+event_enable_trigger(struct event_trigger_data *data,
+		     struct trace_buffer *buffer,  void *rec,
 		     struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1266,7 +1276,8 @@ event_enable_trigger(struct event_trigger_data *data, void *rec,
 }
 
 static void
-event_enable_count_trigger(struct event_trigger_data *data, void *rec,
+event_enable_count_trigger(struct event_trigger_data *data,
+			   struct trace_buffer *buffer,  void *rec,
 			   struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1281,7 +1292,7 @@ event_enable_count_trigger(struct event_trigger_data *data, void *rec,
 	if (data->count != -1)
 		(data->count)--;
 
-	event_enable_trigger(data, rec, event);
+	event_enable_trigger(data, buffer, rec, event);
 }
 
 int event_enable_trigger_print(struct seq_file *m,
-- 
2.30.1


