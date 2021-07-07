Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5EA3BEEA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhGGS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhGGS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:29:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960FE61C72;
        Wed,  7 Jul 2021 18:26:28 +0000 (UTC)
Date:   Wed, 7 Jul 2021 14:26:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v2] tracing: Add linear buckets to histogram logic
Message-ID: <20210707142621.25ac0bd3@oasis.local.home>
In-Reply-To: <20210706154315.3567166e@gandalf.local.home>
References: <20210706154315.3567166e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Due to a cut and paste error, I messed up the To: line, and LKML
  rejected the patch. Resending for archival ]

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

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 65 ++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0207aeed31e6..8facef163f2d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -120,6 +120,7 @@ struct hist_field {
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
+	unsigned long			grouping;
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
@@ -218,6 +219,27 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
+static u64 hist_field_bucket(struct hist_field *hist_field,
+			     struct tracing_map_elt *elt,
+			     struct trace_buffer *buffer,
+			     struct ring_buffer_event *rbe,
+			     void *event)
+{
+	struct hist_field *operand = hist_field->operands[0];
+	unsigned long grouping = hist_field->grouping;
+
+	u64 val = operand->fn(operand, elt, buffer, rbe, event);
+
+	if (WARN_ON_ONCE(!grouping))
+		return val;
+
+	if (val >= LONG_MAX)
+		val = div64_ul(val, grouping);
+	else
+		val = (u64)((unsigned long)val / grouping);
+	return val * grouping;
+}
+
 static u64 hist_field_plus(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
 			   struct trace_buffer *buffer,
@@ -317,6 +339,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_VAR_REF		= 1 << 14,
 	HIST_FIELD_FL_CPU		= 1 << 15,
 	HIST_FIELD_FL_ALIAS		= 1 << 16,
+	HIST_FIELD_FL_BUCKET		= 1 << 17,
 };
 
 struct var_defs {
@@ -1108,7 +1131,8 @@ static const char *hist_field_name(struct hist_field *field,
 	if (field->field)
 		field_name = field->field->name;
 	else if (field->flags & HIST_FIELD_FL_LOG2 ||
-		 field->flags & HIST_FIELD_FL_ALIAS)
+		 field->flags & HIST_FIELD_FL_ALIAS ||
+		 field->flags & HIST_FIELD_FL_BUCKET)
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "cpu";
@@ -1469,6 +1493,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "syscall";
 	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
 		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_BUCKET)
+		flags_str = "buckets";
 	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 		flags_str = "usecs";
 
@@ -1657,9 +1683,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
@@ -1950,7 +1977,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 
 static struct ftrace_event_field *
 parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
-	    char *field_str, unsigned long *flags)
+	    char *field_str, unsigned long *flags, unsigned long *grouping)
 {
 	struct ftrace_event_field *field = NULL;
 	char *field_name, *modifier, *str;
@@ -1977,7 +2004,22 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
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
+			ret = kstrtoul(modifier, 0, grouping);
+			if (ret || !(*grouping))
+				goto error;
+			*flags |= HIST_FIELD_FL_BUCKET;
+		} else {
+ error:
 			hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
 			field = ERR_PTR(-EINVAL);
 			goto out;
@@ -2036,6 +2078,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
 	struct ftrace_event_field *field = NULL;
 	struct hist_field *hist_field = NULL;
+	unsigned long grouping = 0;
 	int ret = 0;
 
 	s = strchr(str, '.');
@@ -2073,7 +2116,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	} else
 		str = s;
 
-	field = parse_field(hist_data, file, str, flags);
+	field = parse_field(hist_data, file, str, flags, &grouping);
 	if (IS_ERR(field)) {
 		ret = PTR_ERR(field);
 		goto out;
@@ -2084,6 +2127,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 		ret = -ENOMEM;
 		goto out;
 	}
+	hist_field->grouping = grouping;
 
 	return hist_field;
  out:
@@ -4664,6 +4708,11 @@ static void hist_trigger_print_key(struct seq_file *m,
 		} else if (key_field->flags & HIST_FIELD_FL_LOG2) {
 			seq_printf(m, "%s: ~ 2^%-2llu", field_name,
 				   *(u64 *)(key + key_field->offset));
+		} else if (key_field->flags & HIST_FIELD_FL_BUCKET) {
+			unsigned long grouping = key_field->grouping;
+			uval = *(u64 *)(key + key_field->offset);
+			seq_printf(m, "%s: ~ %llu-%llu", field_name,
+				   uval, uval + grouping -1);
 		} else if (key_field->flags & HIST_FIELD_FL_STRING) {
 			seq_printf(m, "%s: %-50s", field_name,
 				   (char *)(key + key_field->offset));
@@ -5103,6 +5152,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 				seq_printf(m, ".%s", flags);
 		}
 	}
+	if (hist_field->grouping)
+		seq_printf(m, "=%ld", hist_field->grouping);
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-- 
2.31.1

