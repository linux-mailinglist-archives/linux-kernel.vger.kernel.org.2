Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B33EF294
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhHQTQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhHQTQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:16:33 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D5660C40;
        Tue, 17 Aug 2021 19:15:59 +0000 (UTC)
Date:   Tue, 17 Aug 2021 15:15:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>
Subject: [for-linus][PATCH] tracing: Apply trace filters on all output
 channels
Message-ID: <20210817151552.01bb6efd@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



The "tp_printk" option redirects the trace event output to printk at boot
up. This is useful when a machine crashes before boot where the trace events
can not be retrieved by the in kernel ring buffer. But it can be "dangerous"
because trace events can be located in high frequency locations such as
interrupts and the scheduler, where a printk can slow it down that it live
locks the machine (because by the time the printk finishes, the next event
is triggered). Thus tp_printk must be used with care.

It was discovered that the filter logic to trace events does not apply to
the tp_printk events. This can cause a surprise and live lock when the user
expects it to be filtered to limit the amount of events printed to the
console when in fact it still prints everything.

Pingfan Liu (1):
      tracing: Apply trace filters on all output channels

----
 kernel/trace/trace.c | 18 +++++++++++++++---
 kernel/trace/trace.h | 32 --------------------------------
 2 files changed, 15 insertions(+), 35 deletions(-)
---------------------------
commit 6c34df6f350df9579ce99d887a2b5fa14cc13b32
Author: Pingfan Liu <kernelfans@gmail.com>
Date:   Sat Aug 14 11:45:38 2021 +0800

    tracing: Apply trace filters on all output channels
    
    The event filters are not applied on all of the output, which results in
    the flood of printk when using tp_printk. Unfolding
    event_trigger_unlock_commit_regs() into trace_event_buffer_commit(), so
    the filters can be applied on every output.
    
    Link: https://lkml.kernel.org/r/20210814034538.8428-1-kernelfans@gmail.com
    
    Cc: stable@vger.kernel.org
    Fixes: 0daa2302968c1 ("tracing: Add tp_printk cmdline to have tracepoints go to printk()")
    Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 33899a71fdc1..a1adb29ef5c1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2897,14 +2897,26 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 {
+	enum event_trigger_type tt = ETT_NONE;
+	struct trace_event_file *file = fbuffer->trace_file;
+
+	if (__event_trigger_test_discard(file, fbuffer->buffer, fbuffer->event,
+			fbuffer->entry, &tt))
+		goto discard;
+
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
 	if (static_branch_unlikely(&trace_event_exports_enabled))
 		ftrace_exports(fbuffer->event, TRACE_EXPORT_EVENT);
-	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
-				    fbuffer->event, fbuffer->entry,
-				    fbuffer->trace_ctx, fbuffer->regs);
+
+	trace_buffer_unlock_commit_regs(file->tr, fbuffer->buffer,
+			fbuffer->event, fbuffer->trace_ctx, fbuffer->regs);
+
+discard:
+	if (tt)
+		event_triggers_post_call(file, tt);
+
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a180abf76d4e..4a0e693000c6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1389,38 +1389,6 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		event_triggers_post_call(file, tt);
 }
 
-/**
- * event_trigger_unlock_commit_regs - handle triggers and finish event commit
- * @file: The file pointer associated with the event
- * @buffer: The ring buffer that the event is being written to
- * @event: The event meta data in the ring buffer
- * @entry: The event itself
- * @trace_ctx: The tracing context flags.
- *
- * This is a helper function to handle triggers that require data
- * from the event itself. It also tests the event against filters and
- * if the event is soft disabled and should be discarded.
- *
- * Same as event_trigger_unlock_commit() but calls
- * trace_buffer_unlock_commit_regs() instead of trace_buffer_unlock_commit().
- */
-static inline void
-event_trigger_unlock_commit_regs(struct trace_event_file *file,
-				 struct trace_buffer *buffer,
-				 struct ring_buffer_event *event,
-				 void *entry, unsigned int trace_ctx,
-				 struct pt_regs *regs)
-{
-	enum event_trigger_type tt = ETT_NONE;
-
-	if (!__event_trigger_test_discard(file, buffer, event, entry, &tt))
-		trace_buffer_unlock_commit_regs(file->tr, buffer, event,
-						trace_ctx, regs);
-
-	if (tt)
-		event_triggers_post_call(file, tt);
-}
-
 #define FILTER_PRED_INVALID	((unsigned short)-1)
 #define FILTER_PRED_IS_RIGHT	(1 << 15)
 #define FILTER_PRED_FOLD	(1 << 15)
