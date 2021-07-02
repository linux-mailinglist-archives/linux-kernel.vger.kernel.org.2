Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035A33BA553
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGBV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhGBV7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:59:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD54613FC;
        Fri,  2 Jul 2021 21:56:49 +0000 (UTC)
Date:   Fri, 2 Jul 2021 17:56:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] tracing: Add "grouping" to histogram logic
Message-ID: <20210702175648.1172476c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Introduce a "grouping" command to each field where it will record in a
rounded number. For example:

 ># echo 'hist:keys=bytes_req-100:sort=bytes_req' > events/kmem/kmalloc/trigger
 ># cat events/kmem/kmalloc/hist
 # event histogram
 #
 # trigger info:
 hist:keys=bytes_req-100:vals=hitcount:sort=bytes_req-100:size=2048
 [active]
 #

 { bytes_req:          0-99 } hitcount:       7207
 { bytes_req:        100-199 } hitcount:       1030
 { bytes_req:        200-299 } hitcount:        602
 { bytes_req:        300-399 } hitcount:        414
 { bytes_req:        400-499 } hitcount:        584
 { bytes_req:        500-599 } hitcount:         35
 { bytes_req:        600-699 } hitcount:        361
 { bytes_req:        700-799 } hitcount:         37
 { bytes_req:        800-899 } hitcount:         26
 { bytes_req:        900-999 } hitcount:         15
 { bytes_req:       1100-1199 } hitcount:          4
 { bytes_req:       1200-1299 } hitcount:        102
 { bytes_req:       1300-1399 } hitcount:          2
 { bytes_req:       1400-1499 } hitcount:         15
 { bytes_req:       1500-1599 } hitcount:        100
 { bytes_req:       1600-1699 } hitcount:          1
 { bytes_req:       1700-1799 } hitcount:          3
 { bytes_req:       1800-1899 } hitcount:         10
 { bytes_req:       2000-2099 } hitcount:         19
 { bytes_req:       2100-2199 } hitcount:          3
 { bytes_req:       2500-2599 } hitcount:         72
 { bytes_req:       2900-2999 } hitcount:          1
 { bytes_req:       3300-3399 } hitcount:          4
 { bytes_req:       3900-3999 } hitcount:          2
 { bytes_req:       4000-4099 } hitcount:       1761
 { bytes_req:       4600-4699 } hitcount:         65
 { bytes_req:       5000-5099 } hitcount:          3
 { bytes_req:       6500-6599 } hitcount:          1
 { bytes_req:       8100-8199 } hitcount:          1
 { bytes_req:       9800-9899 } hitcount:          1

 Totals:
     Hits: 12481
     Entries: 30
     Dropped: 0

This finally makes the histograms actual histograms!

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 34 ++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ba03b7d84fc2..d6e644df9506 100644
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
@@ -3761,6 +3762,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 {
 	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_field *hist_field = NULL;
+	char *field;
 	unsigned long flags = 0;
 	unsigned int key_size;
 	int ret = 0;
@@ -3768,14 +3770,16 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
 		return -EINVAL;
 
+	field = strsep(&field_str, "-");
+
 	flags |= HIST_FIELD_FL_KEY;
 
-	if (strcmp(field_str, "stacktrace") == 0) {
+	if (strcmp(field, "stacktrace") == 0) {
 		flags |= HIST_FIELD_FL_STACKTRACE;
 		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
 		hist_field = create_hist_field(hist_data, NULL, flags, NULL);
 	} else {
-		hist_field = parse_expr(hist_data, file, field_str, flags,
+		hist_field = parse_expr(hist_data, file, field, flags,
 					NULL, 0);
 		if (IS_ERR(hist_field)) {
 			ret = PTR_ERR(hist_field);
@@ -3783,7 +3787,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 
 		if (field_has_hist_vars(hist_field, 0))	{
-			hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field_str));
+			hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field));
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
@@ -3792,6 +3796,14 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		key_size = hist_field->size;
 	}
 
+	if (field_str) {
+		unsigned long grouping;
+
+		ret = kstrtoul(field_str, 0, &grouping);
+		if (!ret)
+			hist_field->grouping = grouping;
+	}
+
 	hist_data->fields[key_idx] = hist_field;
 
 	key_size = ALIGN(key_size, sizeof(u64));
@@ -4548,8 +4560,18 @@ static void event_hist_trigger(struct event_trigger_data *data,
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
-			} else
+			} else {
+				if (key_field->grouping) {
+					unsigned long grouping = key_field->grouping;
+
+					if (field_contents >= LONG_MAX)
+						field_contents = div64_ul(field_contents, grouping);
+					else
+						field_contents = (u64)((unsigned long)field_contents / grouping);
+					field_contents *= grouping;
+				}
 				key = (void *)&field_contents;
+			}
 		}
 
 		if (use_compound_key)
@@ -4663,6 +4685,8 @@ static void hist_trigger_print_key(struct seq_file *m,
 		} else {
 			uval = *(u64 *)(key + key_field->offset);
 			seq_printf(m, "%s: %10llu", field_name, uval);
+			if (key_field->grouping)
+				seq_printf(m, "-%llu", uval + key_field->grouping - 1);
 		}
 	}
 
@@ -5096,6 +5120,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 				seq_printf(m, ".%s", flags);
 		}
 	}
+	if (hist_field->grouping)
+		seq_printf(m, "-%ld", hist_field->grouping);
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-- 
2.31.1

