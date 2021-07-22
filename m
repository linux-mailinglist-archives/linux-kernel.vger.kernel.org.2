Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1493B3D1B82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhGVBGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhGVBG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:06:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C676120A;
        Thu, 22 Jul 2021 01:47:04 +0000 (UTC)
Date:   Wed, 21 Jul 2021 21:47:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] tracing: Allow execnames to be passed as args for
 synthetic events
Message-ID: <20210721214702.4eeb1cd9@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow common_pid.execname to be saved in a variable in one histogram to be
passed to another histogram that can pass it as a parameter to a synthetic
event.

 ># echo 'hist:keys=pid:__arg__1=common_timestamp.usecs:arg2=common_pid.execname' \
       > events/sched/sched_waking/trigger
 ># echo 'wakeup_lat s32 pid; u64 delta; char wake_comm[]' > synthetic_events
 ># echo 'hist:keys=next_pid:pid=next_pid,delta=common_timestamp.usecs-$__arg__1,exec=$arg2'\
':onmatch(sched.sched_waking).trace(wakeup_lat,$pid,$delta,$exec)' \
 > events/sched/sched_switch/trigger

The above is a wake up latency synthetic event setup that passes the execname
of the common_pid that woke the task to the scheduling of that task, which
triggers a synthetic event that passes the original execname as a
parameter to display it.

 ># echo 1 > events/synthetic/enable
 ># cat trace
    <idle>-0       [006] d..4   186.863801: wakeup_lat: pid=1306 delta=65 wake_comm=kworker/u16:3
    <idle>-0       [000] d..4   186.863858: wakeup_lat: pid=163 delta=27 wake_comm=<idle>
    <idle>-0       [001] d..4   186.863903: wakeup_lat: pid=1307 delta=36 wake_comm=kworker/u16:4
    <idle>-0       [000] d..4   186.863927: wakeup_lat: pid=163 delta=5 wake_comm=<idle>
    <idle>-0       [006] d..4   186.863957: wakeup_lat: pid=1306 delta=24 wake_comm=kworker/u16:3
      sshd-1306    [006] d..4   186.864051: wakeup_lat: pid=61 delta=62 wake_comm=<idle>
    <idle>-0       [000] d..4   186.965030: wakeup_lat: pid=609 delta=18 wake_comm=<idle>
    <idle>-0       [006] d..4   186.987582: wakeup_lat: pid=1306 delta=65 wake_comm=kworker/u16:3
    <idle>-0       [000] d..4   186.987639: wakeup_lat: pid=163 delta=27 wake_comm=<idle>

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:
  - Hit a bug on freeing the histogram, found that I used "char[]" for the
    type, and it expects to be freed. Freed the old "type" and still use
    "char[]" but have the normal freeing use kfree_const() on type.

 kernel/trace/trace_events_hist.c | 49 ++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 34325f41ebc0..bb1956efd5ef 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1395,17 +1395,17 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 	struct hist_trigger_data *hist_data = elt->map->private_data;
 	unsigned int size = TASK_COMM_LEN;
 	struct hist_elt_data *elt_data;
-	struct hist_field *key_field;
+	struct hist_field *hist_field;
 	unsigned int i, n_str;
 
 	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
 	if (!elt_data)
 		return -ENOMEM;
 
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
 
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
+		if (hist_field->flags & HIST_FIELD_FL_EXECNAME) {
 			elt_data->comm = kzalloc(size, GFP_KERNEL);
 			if (!elt_data->comm) {
 				kfree(elt_data);
@@ -1589,7 +1589,9 @@ static void __destroy_hist_field(struct hist_field *hist_field)
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
-	kfree(hist_field->type);
+
+	/* execname vars use a constant type */
+	kfree_const(hist_field->type);
 
 	kfree(hist_field->system);
 	kfree(hist_field->event_name);
@@ -3707,6 +3709,40 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
 }
 
+static const char *no_comm = "(no comm)";
+
+static u64 hist_field_execname(struct hist_field *hist_field,
+			       struct tracing_map_elt *elt,
+			       struct trace_buffer *buffer,
+			       struct ring_buffer_event *rbe,
+			       void *event)
+{
+	struct hist_elt_data *elt_data;
+
+	if (WARN_ON_ONCE(!elt))
+		return (u64)(unsigned long)no_comm;
+
+	elt_data = elt->private_data;
+
+	if (WARN_ON_ONCE(!elt_data->comm))
+		return (u64)(unsigned long)no_comm;
+
+	return (u64)(unsigned long)(elt_data->comm);
+}
+
+/* Convert a var that points to common_pid.execname to a string */
+static void update_var_execname(struct hist_field *hist_field)
+{
+	hist_field->flags = HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR |
+		HIST_FIELD_FL_EXECNAME;
+	hist_field->size = MAX_FILTER_STR_VAL;
+	hist_field->is_signed = 0;
+	kfree(hist_field->type);
+	/* This uses kfree_const() to free */
+	hist_field->type = "char[]";
+	hist_field->fn = hist_field_execname;
+}
+
 static int create_var_field(struct hist_trigger_data *hist_data,
 			    unsigned int val_idx,
 			    struct trace_event_file *file,
@@ -3731,6 +3767,9 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 
 	ret = __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
 
+	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
+		update_var_execname(hist_data->fields[val_idx]);
+
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
-- 
2.31.1

