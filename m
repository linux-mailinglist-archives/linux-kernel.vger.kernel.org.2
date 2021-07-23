Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3E3D3DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhGWQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGWQPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:15:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B9260E97;
        Fri, 23 Jul 2021 16:55:33 +0000 (UTC)
Date:   Fri, 23 Jul 2021 12:55:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Haoran Luo <www@aegistudio.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [GIT PULL] tracing: Fixes for 5.14-rc2
Message-ID: <20210723125527.767d1c18@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 5.14-rc2:

- Fix deadloop in ring buffer because of using stale "read" variable

- Fix synthetic event use of field_pos as boolean and not an index

- Fixed histogram special var "cpu" overriding event fields called "cpu"

- Cleaned up error prone logic in alloc_synth_event()

- Removed call to synchronize_rcu_tasks_rude() when not needed

- Removed redundant initialization of a local variable "ret"

- Fixed kernel crash when updating tracepoint callbacks of different
  priorities.


Please pull the latest trace-v5.14-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14-rc2

Tag SHA1: f2309a60f1d5381f1d3abaf936e567947efe8351
Head SHA1: 352384d5c84ebe40fa77098cc234fe173247d8ef


Colin Ian King (1):
      ftrace: Remove redundant initialization of variable ret

Haoran Luo (1):
      tracing: Fix bug in rb_per_cpu_empty() that might cause deadloop.

Nicolas Saenz Julienne (1):
      ftrace: Avoid synchronize_rcu_tasks_rude() call when not necessary

Steven Rostedt (VMware) (4):
      tracing: Synthetic event field_pos is an index not a boolean
      tracing/histogram: Rename "cpu" to "common_cpu"
      tracing: Clean up alloc_synth_event()
      tracepoints: Update static_call before tp_funcs when adding a tracepoint

----
 Documentation/trace/histogram.rst |  2 +-
 kernel/trace/ftrace.c             |  5 +++--
 kernel/trace/ring_buffer.c        | 28 ++++++++++++++++++++++++----
 kernel/trace/trace.c              |  4 ++++
 kernel/trace/trace_events_hist.c  | 22 ++++++++++++++++------
 kernel/trace/trace_events_synth.c |  8 +++-----
 kernel/trace/trace_synth.h        |  2 +-
 kernel/tracepoint.c               |  2 +-
 8 files changed, 53 insertions(+), 20 deletions(-)
---------------------------
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index b71e09f745c3..f99be8062bc8 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -191,7 +191,7 @@ Documentation written by Tom Zanussi
                                 with the event, in nanoseconds.  May be
 			        modified by .usecs to have timestamps
 			        interpreted as microseconds.
-    cpu                    int  the cpu on which the event occurred.
+    common_cpu             int  the cpu on which the event occurred.
     ====================== ==== =======================================
 
 Extended error information
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6fb3e6e1ffc..7b180f61e6d3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5985,7 +5985,8 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		synchronize_rcu_tasks_rude();
+		if (old_hash != EMPTY_HASH)
+			synchronize_rcu_tasks_rude();
 
 		free_ftrace_hash(old_hash);
 	}
@@ -7544,7 +7545,7 @@ int ftrace_is_dead(void)
  */
 int register_ftrace_function(struct ftrace_ops *ops)
 {
-	int ret = -1;
+	int ret;
 
 	ftrace_ops_init(ops);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d1463eac11a3..e592d1df6f88 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3880,10 +3880,30 @@ static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
 	if (unlikely(!head))
 		return true;
 
-	return reader->read == rb_page_commit(reader) &&
-		(commit == reader ||
-		 (commit == head &&
-		  head->read == rb_page_commit(commit)));
+	/* Reader should exhaust content in reader page */
+	if (reader->read != rb_page_commit(reader))
+		return false;
+
+	/*
+	 * If writers are committing on the reader page, knowing all
+	 * committed content has been read, the ring buffer is empty.
+	 */
+	if (commit == reader)
+		return true;
+
+	/*
+	 * If writers are committing on a page other than reader page
+	 * and head page, there should always be content to read.
+	 */
+	if (commit != head)
+		return false;
+
+	/*
+	 * Writers are committing on the head page, we just need
+	 * to care about there're committed data, and the reader will
+	 * swap reader page with head page when it is to read data.
+	 */
+	return rb_page_commit(commit) == 0;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f8b80b5bab71..c59dd35a6da5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5609,6 +5609,10 @@ static const char readme_msg[] =
 	"\t            [:name=histname1]\n"
 	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
+	"\t    Note, special fields can be used as well:\n"
+	"\t            common_timestamp - to record current timestamp\n"
+	"\t            common_cpu - to record the CPU the event happened on\n"
+	"\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
 	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 16a9dfc9fffc..34325f41ebc0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1111,7 +1111,7 @@ static const char *hist_field_name(struct hist_field *field,
 		 field->flags & HIST_FIELD_FL_ALIAS)
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_CPU)
-		field_name = "cpu";
+		field_name = "common_cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
@@ -1991,14 +1991,24 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		hist_data->enable_timestamps = true;
 		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 			hist_data->attrs->ts_in_usecs = true;
-	} else if (strcmp(field_name, "cpu") == 0)
+	} else if (strcmp(field_name, "common_cpu") == 0)
 		*flags |= HIST_FIELD_FL_CPU;
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
-			hist_err(tr, HIST_ERR_FIELD_NOT_FOUND, errpos(field_name));
-			field = ERR_PTR(-EINVAL);
-			goto out;
+			/*
+			 * For backward compatibility, if field_name
+			 * was "cpu", then we treat this the same as
+			 * common_cpu.
+			 */
+			if (strcmp(field_name, "cpu") == 0) {
+				*flags |= HIST_FIELD_FL_CPU;
+			} else {
+				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
+					 errpos(field_name));
+				field = ERR_PTR(-EINVAL);
+				goto out;
+			}
 		}
 	}
  out:
@@ -5085,7 +5095,7 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 		seq_printf(m, "%s=", hist_field->var.name);
 
 	if (hist_field->flags & HIST_FIELD_FL_CPU)
-		seq_puts(m, "cpu");
+		seq_puts(m, "common_cpu");
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2ac75eb6aa86..9315fc03e303 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -893,15 +893,13 @@ static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 	dyn_event_init(&event->devent, &synth_event_ops);
 
 	for (i = 0, j = 0; i < n_fields; i++) {
+		fields[i]->field_pos = i;
 		event->fields[i] = fields[i];
 
-		if (fields[i]->is_dynamic) {
-			event->dynamic_fields[j] = fields[i];
-			event->dynamic_fields[j]->field_pos = i;
+		if (fields[i]->is_dynamic)
 			event->dynamic_fields[j++] = fields[i];
-			event->n_dynamic_fields++;
-		}
 	}
+	event->n_dynamic_fields = j;
 	event->n_fields = n_fields;
  out:
 	return event;
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 6e146b959dcd..4007fe95cf42 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -14,10 +14,10 @@ struct synth_field {
 	char *name;
 	size_t size;
 	unsigned int offset;
+	unsigned int field_pos;
 	bool is_signed;
 	bool is_string;
 	bool is_dynamic;
-	bool field_pos;
 };
 
 struct synth_event {
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 976bf8ce8039..fc32821f8240 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -299,8 +299,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * a pointer to it.  This array is referenced by __DO_TRACE from
 	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
-	rcu_assign_pointer(tp->funcs, tp_funcs);
 	tracepoint_update_call(tp, tp_funcs, false);
+	rcu_assign_pointer(tp->funcs, tp_funcs);
 	static_key_enable(&tp->key);
 
 	release_probes(old);
