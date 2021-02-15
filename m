Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7027431C2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhBOT5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhBOT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:56:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB61664E16;
        Mon, 15 Feb 2021 19:55:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lBjyP-0009Sm-RM; Mon, 15 Feb 2021 14:55:57 -0500
Message-ID: <20210215195557.735466696@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Feb 2021 14:55:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 1/5] tracing: Show real address for trace event arguments
References: <20210215195533.101751000@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

To help debugging kernel, show real address for trace event arguments
in tracefs/trace{,pipe} instead of hashed pointer value.

Since ftrace human-readable format uses vsprintf(), all %p are
translated to hash values instead of pointer address.

However, when debugging the kernel, raw address value gives a
hint when comparing with the memory mapping in the kernel.
(Those are sometimes used with crash log, which is not hashed too)
So converting %p with %px when calling trace_seq_printf().

Moreover, this is not improving the security because the tracefs
can be used only by root user and the raw address values are readable
from tracefs/percpu/cpu*/trace_pipe_raw file.

Link: https://lkml.kernel.org/r/160277370703.29307.5134475491761971203.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  4 ++
 include/trace/trace_events.h |  2 +-
 kernel/trace/trace.c         | 71 +++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h         |  2 +
 kernel/trace/trace_output.c  | 12 +++++-
 5 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5d1eeac4bfbe..7077fec653bb 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -55,6 +55,8 @@ struct trace_event;
 
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *event);
+extern __printf(2, 3)
+void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 
 /*
  * The trace entry - the most basic unit of tracing. This is what
@@ -87,6 +89,8 @@ struct trace_iterator {
 	unsigned long		iter_flags;
 	void			*temp;	/* temp holder */
 	unsigned int		temp_size;
+	char			*fmt;	/* modified format holder */
+	unsigned int		fmt_size;
 
 	/* trace_seq for __print_flags() and __print_symbolic() etc. */
 	struct trace_seq	tmp_seq;
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7785961d82ba..e6a8b3febc49 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -364,7 +364,7 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 	if (ret != TRACE_TYPE_HANDLED)					\
 		return ret;						\
 									\
-	trace_seq_printf(s, print);					\
+	trace_event_printf(iter, print);				\
 									\
 	return trace_handle_return(s);					\
 }									\
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b79bcacdd6f9..39f8a537196e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3530,6 +3530,62 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
 	return next;
 }
 
+#define STATIC_FMT_BUF_SIZE	128
+static char static_fmt_buf[STATIC_FMT_BUF_SIZE];
+
+static char *trace_iter_expand_format(struct trace_iterator *iter)
+{
+	char *tmp;
+
+	if (iter->fmt == static_fmt_buf)
+		return NULL;
+
+	tmp = krealloc(iter->fmt, iter->fmt_size + STATIC_FMT_BUF_SIZE,
+		       GFP_KERNEL);
+	if (tmp) {
+		iter->fmt_size += STATIC_FMT_BUF_SIZE;
+		iter->fmt = tmp;
+	}
+
+	return tmp;
+}
+
+const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
+{
+	const char *p, *new_fmt;
+	char *q;
+
+	if (WARN_ON_ONCE(!fmt))
+		return fmt;
+
+	p = fmt;
+	new_fmt = q = iter->fmt;
+	while (*p) {
+		if (unlikely(q - new_fmt + 3 > iter->fmt_size)) {
+			if (!trace_iter_expand_format(iter))
+				return fmt;
+
+			q += iter->fmt - new_fmt;
+			new_fmt = iter->fmt;
+		}
+
+		*q++ = *p++;
+
+		/* Replace %p with %px */
+		if (p[-1] == '%') {
+			if (p[0] == '%') {
+				*q++ = *p++;
+			} else if (p[0] == 'p' && !isalnum(p[1])) {
+				*q++ = *p++;
+				*q++ = 'x';
+			}
+		}
+	}
+	*q = '\0';
+
+	return new_fmt;
+}
+
 #define STATIC_TEMP_BUF_SIZE	128
 static char static_temp_buf[STATIC_TEMP_BUF_SIZE] __aligned(4);
 
@@ -4322,6 +4378,16 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (iter->temp)
 		iter->temp_size = 128;
 
+	/*
+	 * trace_event_printf() may need to modify given format
+	 * string to replace %p with %px so that it shows real address
+	 * instead of hash value. However, that is only for the event
+	 * tracing, other tracer may not need. Defer the allocation
+	 * until it is needed.
+	 */
+	iter->fmt = NULL;
+	iter->fmt_size = 0;
+
 	/*
 	 * We make a copy of the current tracer to avoid concurrent
 	 * changes on it while we are reading.
@@ -4473,6 +4539,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 
 	mutex_destroy(&iter->mutex);
 	free_cpumask_var(iter->started);
+	kfree(iter->fmt);
 	kfree(iter->temp);
 	kfree(iter->trace);
 	kfree(iter->buffer_iter);
@@ -9331,9 +9398,11 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
-	/* Can not use kmalloc for iter.temp */
+	/* Can not use kmalloc for iter.temp and iter.fmt */
 	iter.temp = static_temp_buf;
 	iter.temp_size = STATIC_TEMP_BUF_SIZE;
+	iter.fmt = static_fmt_buf;
+	iter.fmt_size = STATIC_FMT_BUF_SIZE;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a9e13bd5a41b..6c3ea6f95e68 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -581,6 +581,8 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 void trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 					struct ring_buffer_event *event);
 
+const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
+
 int trace_empty(struct trace_iterator *iter);
 
 void *trace_find_next_entry_inc(struct trace_iterator *iter);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 92b1575ae0ca..61255bad7e01 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -312,13 +312,23 @@ int trace_raw_output_prep(struct trace_iterator *iter,
 }
 EXPORT_SYMBOL(trace_raw_output_prep);
 
+void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace_seq_vprintf(&iter->seq, trace_event_format(iter, fmt), ap);
+	va_end(ap);
+}
+EXPORT_SYMBOL(trace_event_printf);
+
 static int trace_output_raw(struct trace_iterator *iter, char *name,
 			    char *fmt, va_list ap)
 {
 	struct trace_seq *s = &iter->seq;
 
 	trace_seq_printf(s, "%s: ", name);
-	trace_seq_vprintf(s, fmt, ap);
+	trace_seq_vprintf(s, trace_event_format(iter, fmt), ap);
 
 	return trace_handle_return(s);
 }
-- 
2.30.0


