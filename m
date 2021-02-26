Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF61326738
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBZTHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhBZTHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:07:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FF664F2D;
        Fri, 26 Feb 2021 19:07:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lFiS9-0017Xb-W4; Fri, 26 Feb 2021 14:07:06 -0500
Message-ID: <20210226190705.871102407@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Feb 2021 13:59:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>
Subject: [PATCH 2/2] tracing: Add a verifier to check string pointers for trace events
References: <20210226185909.100032746@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

It is a common mistake for someone writing a trace event to save a pointer
to a string in the TP_fast_assign() and then display that string pointer
in the TP_printk() with %s. The problem is that those two events may happen
a long time apart, where the source of the string may no longer exist.

The proper way to handle displaying any string that is not guaranteed to be
in the kernel core rodata section, is to copy it into the ring buffer via
the __string(), __assign_str() and __get_str() helper macros.

Add a check at run time while displaying the TP_printk() of events to make
sure that every %s referenced is safe to dereference, and if it is not,
trigger a warning and only show the address of the pointer, and the
dereferenced string if it can be safely retrieved with a
strncpy_from_kernel_nofault() call.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 148 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h        |   2 +
 kernel/trace/trace_output.c |   2 +-
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f5e8e39d6f57..ff08c04de6cb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3551,6 +3551,154 @@ static char *trace_iter_expand_format(struct trace_iterator *iter)
 	return tmp;
 }
 
+/* Returns true if the string is safe to dereference from an event */
+static bool trace_safe_str(struct trace_iterator *iter, const char *str)
+{
+	unsigned long addr = (unsigned long)str;
+	struct trace_event *trace_event;
+	struct trace_event_call *event;
+
+	/* OK if part of the event data */
+	if ((addr >= (unsigned long)iter->ent) &&
+	    (addr < (unsigned long)iter->ent + iter->ent_size))
+		return true;
+
+	/* OK if part of the temp seq buffer */
+	if ((addr >= (unsigned long)iter->tmp_seq.buffer) &&
+	    (addr < (unsigned long)iter->tmp_seq.buffer + PAGE_SIZE))
+		return true;
+
+	/* Core rodata can not be freed */
+	if (is_kernel_rodata(addr))
+		return true;
+
+	/*
+	 * Now this could be a module event, referencing core module
+	 * data, which is OK.
+	 */
+	if (!iter->ent)
+		return false;
+
+	trace_event = ftrace_find_event(iter->ent->type);
+	if (!trace_event)
+		return false;
+
+	event = container_of(trace_event, struct trace_event_call, event);
+	if (!event->mod)
+		return false;
+
+	/* Would rather have rodata, but this will suffice */
+	if (within_module_core(addr, event->mod))
+		return true;
+
+	return false;
+}
+
+/**
+ * trace_check_vprintf - Check dereferenced strings while writing to the seq buffer
+ * @iter: The iterator that holds the seq buffer and the event being printed
+ * @fmt: The format used to print the event
+ * @ap: The va_list holding the data to print from @fmt.
+ *
+ * This writes the data into the @iter->seq buffer using the data from
+ * @fmt and @ap. If the format has a %s, then the source of the string
+ * is examined to make sure it is safe to print, otherwise it will
+ * warn and print "[UNSAFE MEMORY]" in place of the dereferenced string
+ * pointer.
+ */
+void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
+			 va_list ap)
+{
+	const char *p = fmt;
+	const char *str;
+	int i, j;
+
+	if (WARN_ON_ONCE(!fmt))
+		return;
+
+	/* Don't bother checking when doing a ftrace_dump() */
+	if (iter->fmt == static_fmt_buf)
+		goto print;
+
+	while (*p) {
+		j = 0;
+
+		/* We only care about %s and variants */
+		for (i = 0; p[i]; i++) {
+			if (i + 1 >= iter->fmt_size) {
+				/*
+				 * If we can't expand the copy buffer,
+				 * just print it.
+				 */
+				if (!trace_iter_expand_format(iter))
+					goto print;
+			}
+
+			if (p[i] == '\\' && p[i+1]) {
+				i++;
+				continue;
+			}
+			if (p[i] == '%') {
+				/* Need to test cases like %08.*s */
+				for (j = 1; p[i+j]; j++) {
+					if (isdigit(p[i+j]) ||
+					    p[i+j] == '*' ||
+					    p[i+j] == '.')
+						continue;
+					break;
+				}
+				if (p[i+j] == 's')
+					break;
+			}
+			j = 0;
+		}
+		/* If no %s found then just print normally */
+		if (!p[i])
+			break;
+
+		/* Copy up to the %s, and print that */
+		strncpy(iter->fmt, p, i);
+		iter->fmt[i] = '\0';
+		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
+
+		/* The ap now points to the string data of the %s */
+		str = va_arg(ap, const char *);
+
+		/*
+		 * If you hit this warning, it is likely that the
+		 * trace event in question used %s on a string that
+		 * was saved at the time of the event, but may not be
+		 * around when the trace is read. Use __string(),
+		 * __assign_str() and __get_str() helpers in the TRACE_EVENT()
+		 * instead. See samples/trace_events/trace-events-sample.h
+		 * for reference.
+		 */
+		if (WARN_ON_ONCE(!trace_safe_str(iter, str))) {
+			int ret;
+
+			/* Try to safely read the string */
+			ret = strncpy_from_kernel_nofault(iter->fmt, str,
+							  iter->fmt_size);
+			if (ret < 0)
+				trace_seq_printf(&iter->seq, "(0x%px)", str);
+			else
+				trace_seq_printf(&iter->seq, "(0x%px:%s)",
+						 str, iter->fmt);
+			str = "[UNSAFE-MEMORY]";
+			strcpy(iter->fmt, "%s");
+		} else {
+			strncpy(iter->fmt, p + i, j + 1);
+			iter->fmt[j+1] = '\0';
+		}
+		trace_seq_printf(&iter->seq, iter->fmt, str);
+
+		p += i + j + 1;
+	}
+ print:
+	if (*p)
+		trace_seq_vprintf(&iter->seq, p, ap);
+}
+
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
 {
 	const char *p, *new_fmt;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index dec13ff66077..5e41b5fd5318 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -582,6 +582,8 @@ void trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 					struct ring_buffer_event *event);
 
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
+void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
+			 va_list ap);
 
 int trace_empty(struct trace_iterator *iter);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 61255bad7e01..a0146e1fffdf 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -317,7 +317,7 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
 	va_list ap;
 
 	va_start(ap, fmt);
-	trace_seq_vprintf(&iter->seq, trace_event_format(iter, fmt), ap);
+	trace_check_vprintf(iter, trace_event_format(iter, fmt), ap);
 	va_end(ap);
 }
 EXPORT_SYMBOL(trace_event_printf);
-- 
2.30.0


