Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7C3EF2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhHQTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232631AbhHQTnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1358761056;
        Tue, 17 Aug 2021 19:43:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zH-004TMC-2h; Tue, 17 Aug 2021 15:43:03 -0400
Message-ID: <20210817194302.918591420@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 02/19] tracing: Add linear buckets to histogram logic
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's been several times I wished the histogram logic had a "grouping"
feature for the buckets. Currently, each bucket has a size of one. That
is, if you trace the amount of requested allocations, each allocation is
its own bucket, even if you are interested in what allocates 100 bytes or
less, 100 to 200, 200 to 300, etc.

Also, without grouping, it fills up the allocated histogram buckets
quickly. If you are tracking latency, and don't care if something is 200
microseconds off, or 201 microseconds off, but want to track them by say
10 microseconds each. This can not currently be done.

There is a log2 but that grouping get's too big too fast for a lot of
cases.

Introduce a "buckets=SIZE" command to each field where it will record in a
rounded number. For example:

 ># echo 'hist:keys=bytes_req.buckets=100:sort=bytes_req' > events/kmem/kmalloc/trigger
 ># cat events/kmem/kmalloc/hist
 # event histogram
 #
 # trigger info:
 hist:keys=bytes_req.buckets=100:vals=hitcount:sort=bytes_req.buckets=100:size=2048
 [active]
 #

 { bytes_req: ~ 0-99 } hitcount:       3149
 { bytes_req: ~ 100-199 } hitcount:       1468
 { bytes_req: ~ 200-299 } hitcount:         39
 { bytes_req: ~ 300-399 } hitcount:        306
 { bytes_req: ~ 400-499 } hitcount:        364
 { bytes_req: ~ 500-599 } hitcount:         32
 { bytes_req: ~ 600-699 } hitcount:         69
 { bytes_req: ~ 700-799 } hitcount:         37
 { bytes_req: ~ 1200-1299 } hitcount:         16
 { bytes_req: ~ 1400-1499 } hitcount:         30
 { bytes_req: ~ 2000-2099 } hitcount:          6
 { bytes_req: ~ 4000-4099 } hitcount:       2168
 { bytes_req: ~ 5000-5099 } hitcount:          6

 Totals:
     Hits: 7690
     Entries: 13
     Dropped: 0

Link: https://lkml.kernel.org/r/20210707213921.980359719@goodmis.org

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 65 ++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a48aa2a2875b..8e87c4a429fd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -121,6 +121,7 @@ struct hist_field {
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
+	unsigned long			buckets;
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
@@ -219,6 +220,27 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
+static u64 hist_field_bucket(struct hist_field *hist_field,
+			     struct tracing_map_elt *elt,
+			     struct trace_buffer *buffer,
+			     struct ring_buffer_event *rbe,
+			     void *event)
+{
+	struct hist_field *operand = hist_field->operands[0];
+	unsigned long buckets = hist_field->buckets;
+
+	u64 val = operand->fn(operand, elt, buffer, rbe, event);
+
+	if (WARN_ON_ONCE(!buckets))
+		return val;
+
+	if (val >= LONG_MAX)
+		val = div64_ul(val, buckets);
+	else
+		val = (u64)((unsigned long)val / buckets);
+	return val * buckets;
+}
+
 static u64 hist_field_plus(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
 			   struct trace_buffer *buffer,
@@ -318,6 +340,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_VAR_REF		= 1 << 14,
 	HIST_FIELD_FL_CPU		= 1 << 15,
 	HIST_FIELD_FL_ALIAS		= 1 << 16,
+	HIST_FIELD_FL_BUCKET		= 1 << 17,
 };
 
 struct var_defs {
@@ -1109,7 +1132,8 @@ static const char *hist_field_name(struct hist_field *field,
 	if (field->field)
 		field_name = field->field->name;
 	else if (field->flags & HIST_FIELD_FL_LOG2 ||
-		 field->flags & HIST_FIELD_FL_ALIAS)
+		 field->flags & HIST_FIELD_FL_ALIAS ||
+		 field->flags & HIST_FIELD_FL_BUCKET)
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "common_cpu";
@@ -1470,6 +1494,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "syscall";
 	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
 		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_BUCKET)
+		flags_str = "buckets";
 	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 		flags_str = "usecs";
 
@@ -1658,9 +1684,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	if (flags & HIST_FIELD_FL_LOG2) {
-		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
-		hist_field->fn = hist_field_log2;
+	if (flags & (HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET)) {
+		unsigned long fl = flags & ~(HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET);
+		hist_field->fn = flags & HIST_FIELD_FL_LOG2 ? hist_field_log2 :
+			hist_field_bucket;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
 		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
@@ -1953,7 +1980,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 
 static struct ftrace_event_field *
 parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
-	    char *field_str, unsigned long *flags)
+	    char *field_str, unsigned long *flags, unsigned long *buckets)
 {
 	struct ftrace_event_field *field = NULL;
 	char *field_name, *modifier, *str;
@@ -1980,7 +2007,22 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			*flags |= HIST_FIELD_FL_LOG2;
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
-		else {
+		else if (strncmp(modifier, "bucket", 6) == 0) {
+			int ret;
+
+			modifier += 6;
+
+			if (*modifier == 's')
+				modifier++;
+			if (*modifier != '=')
+				goto error;
+			modifier++;
+			ret = kstrtoul(modifier, 0, buckets);
+			if (ret || !(*buckets))
+				goto error;
+			*flags |= HIST_FIELD_FL_BUCKET;
+		} else {
+ error:
 			hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
 			field = ERR_PTR(-EINVAL);
 			goto out;
@@ -2049,6 +2091,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
 	struct ftrace_event_field *field = NULL;
 	struct hist_field *hist_field = NULL;
+	unsigned long buckets = 0;
 	int ret = 0;
 
 	s = strchr(str, '.');
@@ -2086,7 +2129,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	} else
 		str = s;
 
-	field = parse_field(hist_data, file, str, flags);
+	field = parse_field(hist_data, file, str, flags, &buckets);
 	if (IS_ERR(field)) {
 		ret = PTR_ERR(field);
 		goto out;
@@ -2097,6 +2140,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 		ret = -ENOMEM;
 		goto out;
 	}
+	hist_field->buckets = buckets;
 
 	return hist_field;
  out:
@@ -4698,6 +4742,11 @@ static void hist_trigger_print_key(struct seq_file *m,
 		} else if (key_field->flags & HIST_FIELD_FL_LOG2) {
 			seq_printf(m, "%s: ~ 2^%-2llu", field_name,
 				   *(u64 *)(key + key_field->offset));
+		} else if (key_field->flags & HIST_FIELD_FL_BUCKET) {
+			unsigned long buckets = key_field->buckets;
+			uval = *(u64 *)(key + key_field->offset);
+			seq_printf(m, "%s: ~ %llu-%llu", field_name,
+				   uval, uval + buckets -1);
 		} else if (key_field->flags & HIST_FIELD_FL_STRING) {
 			seq_printf(m, "%s: %-50s", field_name,
 				   (char *)(key + key_field->offset));
@@ -5137,6 +5186,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 				seq_printf(m, ".%s", flags);
 		}
 	}
+	if (hist_field->buckets)
+		seq_printf(m, "=%ld", hist_field->buckets);
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-- 
2.30.2
