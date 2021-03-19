Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2363424DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCSSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhCSSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EBE61981;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017mh-PD; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183801.664219864@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [for-next][PATCH 11/13] tracing: Add check of trace event print fmts for dereferencing
 pointers
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Trace events record data into the ring buffer at the time of the event. The
trace event has a printf logic to display the recorded data at a much later
time when the user reads the trace file. This makes using dereferencing
pointers unsafe if the dereferenced pointer points to the original source.
The safe way to handle this is to create an array within the trace event and
copy the source into the array. Then the dereference pointer may point to
that array.

As this is a easy mistake to make, a check is added to examine all trace
event print fmts to make sure that they are safe to use. This only checks
the various %p* dereferenced pointers like %pB, %pR, etc. It does not handle
dereferencing of strings, as there are some use cases that are OK to
dereference the source. That will be dealt with differently.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 210 ++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a3563afd412d..f58106eaf8cb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -217,6 +217,214 @@ int trace_event_get_offsets(struct trace_event_call *call)
 	return tail->offset + tail->size;
 }
 
+/*
+ * Check if the referenced field is an array and return true,
+ * as arrays are OK to dereference.
+ */
+static bool test_field(const char *fmt, struct trace_event_call *call)
+{
+	struct trace_event_fields *field = call->class->fields_array;
+	const char *array_descriptor;
+	const char *p = fmt;
+	int len;
+
+	if (!(len = str_has_prefix(fmt, "REC->")))
+		return false;
+	fmt += len;
+	for (p = fmt; *p; p++) {
+		if (!isalnum(*p) && *p != '_')
+			break;
+	}
+	len = p - fmt;
+
+	for (; field->type; field++) {
+		if (strncmp(field->name, fmt, len) ||
+		    field->name[len])
+			continue;
+		array_descriptor = strchr(field->type, '[');
+		/* This is an array and is OK to dereference. */
+		return array_descriptor != NULL;
+	}
+	return false;
+}
+
+/*
+ * Examine the print fmt of the event looking for unsafe dereference
+ * pointers using %p* that could be recorded in the trace event and
+ * much later referenced after the pointer was freed. Dereferencing
+ * pointers are OK, if it is dereferenced into the event itself.
+ */
+static void test_event_printk(struct trace_event_call *call)
+{
+	u64 dereference_flags = 0;
+	bool first = true;
+	const char *fmt, *c, *r, *a;
+	int parens = 0;
+	char in_quote = 0;
+	int start_arg = 0;
+	int arg = 0;
+	int i;
+
+	fmt = call->print_fmt;
+
+	if (!fmt)
+		return;
+
+	for (i = 0; fmt[i]; i++) {
+		switch (fmt[i]) {
+		case '\\':
+			i++;
+			if (!fmt[i])
+				return;
+			continue;
+		case '"':
+		case '\'':
+			/*
+			 * The print fmt starts with a string that
+			 * is processed first to find %p* usage,
+			 * then after the first string, the print fmt
+			 * contains arguments that are used to check
+			 * if the dereferenced %p* usage is safe.
+			 */
+			if (first) {
+				if (fmt[i] == '\'')
+					continue;
+				if (in_quote) {
+					arg = 0;
+					first = false;
+					/*
+					 * If there was no %p* uses
+					 * the fmt is OK.
+					 */
+					if (!dereference_flags)
+						return;
+				}
+			}
+			if (in_quote) {
+				if (in_quote == fmt[i])
+					in_quote = 0;
+			} else {
+				in_quote = fmt[i];
+			}
+			continue;
+		case '%':
+			if (!first || !in_quote)
+				continue;
+			i++;
+			if (!fmt[i])
+				return;
+			switch (fmt[i]) {
+			case '%':
+				continue;
+			case 'p':
+				/* Find dereferencing fields */
+				switch (fmt[i + 1]) {
+				case 'B': case 'R': case 'r':
+				case 'b': case 'M': case 'm':
+				case 'I': case 'i': case 'E':
+				case 'U': case 'V': case 'N':
+				case 'a': case 'd': case 'D':
+				case 'g': case 't': case 'C':
+				case 'O': case 'f':
+					if (WARN_ONCE(arg == 63,
+						      "Too many args for event: %s",
+						      trace_event_name(call)))
+						return;
+					dereference_flags |= 1ULL << arg;
+				}
+				break;
+			default:
+			{
+				bool star = false;
+				int j;
+
+				/* Increment arg if %*s exists. */
+				for (j = 0; fmt[i + j]; j++) {
+					if (isdigit(fmt[i + j]) ||
+					    fmt[i + j] == '.')
+						continue;
+					if (fmt[i + j] == '*') {
+						star = true;
+						continue;
+					}
+					if ((fmt[i + j] == 's') && star)
+						arg++;
+					break;
+				}
+				break;
+			} /* default */
+
+			} /* switch */
+			arg++;
+			continue;
+		case '(':
+			if (in_quote)
+				continue;
+			parens++;
+			continue;
+		case ')':
+			if (in_quote)
+				continue;
+			parens--;
+			if (WARN_ONCE(parens < 0,
+				      "Paren mismatch for event: %s\narg='%s'\n%*s",
+				      trace_event_name(call),
+				      fmt + start_arg,
+				      (i - start_arg) + 5, "^"))
+				return;
+			continue;
+		case ',':
+			if (in_quote || parens)
+				continue;
+			i++;
+			while (isspace(fmt[i]))
+				i++;
+			start_arg = i;
+			if (!(dereference_flags & (1ULL << arg)))
+				goto next_arg;
+
+			/* Find the REC-> in the argument */
+			c = strchr(fmt + i, ',');
+			r = strstr(fmt + i, "REC->");
+			if (r && (!c || r < c)) {
+				/*
+				 * Addresses of events on the buffer,
+				 * or an array on the buffer is
+				 * OK to dereference.
+				 * There's ways to fool this, but
+				 * this is to catch common mistakes,
+				 * not malicious code.
+				 */
+				a = strchr(fmt + i, '&');
+				if ((a && (a < r)) || test_field(r, call))
+					dereference_flags &= ~(1ULL << arg);
+			}
+		next_arg:
+			i--;
+			arg++;
+		}
+	}
+
+	/*
+	 * If you triggered the below warning, the trace event reported
+	 * uses an unsafe dereference pointer %p*. As the data stored
+	 * at the trace event time may no longer exist when the trace
+	 * event is printed, dereferencing to the original source is
+	 * unsafe. The source of the dereference must be copied into the
+	 * event itself, and the dereference must access the copy instead.
+	 */
+	if (WARN_ON_ONCE(dereference_flags)) {
+		arg = 1;
+		while (!(dereference_flags & 1)) {
+			dereference_flags >>= 1;
+			arg++;
+		}
+		pr_warn("event %s has unsafe dereference of argument %d\n",
+			trace_event_name(call), arg);
+		pr_warn("print_fmt: %s\n", fmt);
+	}
+}
+
 int trace_event_raw_init(struct trace_event_call *call)
 {
 	int id;
@@ -225,6 +433,8 @@ int trace_event_raw_init(struct trace_event_call *call)
 	if (!id)
 		return -ENODEV;
 
+	test_event_printk(call);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(trace_event_raw_init);
-- 
2.30.1


