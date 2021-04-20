Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543F0365F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhDTSjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233363AbhDTSjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:39:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132D7613CD;
        Tue, 20 Apr 2021 18:38:45 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:38:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Fix checking event hash pointer logic when
 tp_printk is enabled
Message-ID: <20210420143843.1ba9e20c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing: Fix tp_printk command line and trace events

Masami added a wrapper to be able to unhash trace event pointers
as they are only read by root anyway, and they can also be extracted
by the raw trace data buffers. But this wrapper utilized the iterator
to have a temporary buffer to manipulate the text with.

tp_printk is a kernel command line option that will send the trace
output of a trace event to the console on boot up (useful when the
system crashes before finishing the boot). But the code used the same
wrapper that Masami added, and its iterator did not have a buffer,
and this caused the system to crash.

Have the wrapper just print the trace event normally if the iterator
has no temporary buffer.


Please pull the latest trace-v5.12-rc8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12-rc8

Tag SHA1: 39ed1af76146f9f995c224de1987f14babc9aa28
Head SHA1: 0e1e71d34901a633825cd5ae78efaf8abd9215c6


Steven Rostedt (VMware) (1):
      tracing: Fix checking event hash pointer logic when tp_printk is enabled

----
 kernel/trace/trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
---------------------------
commit 0e1e71d34901a633825cd5ae78efaf8abd9215c6
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Mon Apr 19 14:23:12 2021 -0400

    tracing: Fix checking event hash pointer logic when tp_printk is enabled
    
    Pointers in events that are printed are unhashed if the flags allow it,
    and the logic to do so is called before processing the event output from
    the raw ring buffer. In most cases, this is done when a user reads one of
    the trace files.
    
    But if tp_printk is added on the kernel command line, this logic is done
    for trace events when they are triggered, and their output goes out via
    printk. The unhash logic (and even the validation of the output) did not
    support the tp_printk output, and would crash.
    
    Link: https://lore.kernel.org/linux-tegra/9835d9f1-8d3a-3440-c53f-516c2606ad07@nvidia.com/
    
    Fixes: efbbdaa22bb7 ("tracing: Show real address for trace event arguments")
    Reported-by: Jon Hunter <jonathanh@nvidia.com>
    Tested-by: Jon Hunter <jonathanh@nvidia.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5c777627212f..c0c9aa5cd8e2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3545,7 +3545,11 @@ static char *trace_iter_expand_format(struct trace_iterator *iter)
 {
 	char *tmp;
 
-	if (iter->fmt == static_fmt_buf)
+	/*
+	 * iter->tr is NULL when used with tp_printk, which makes
+	 * this get called where it is not safe to call krealloc().
+	 */
+	if (!iter->tr || iter->fmt == static_fmt_buf)
 		return NULL;
 
 	tmp = krealloc(iter->fmt, iter->fmt_size + STATIC_FMT_BUF_SIZE,
@@ -3566,7 +3570,7 @@ const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
 	if (WARN_ON_ONCE(!fmt))
 		return fmt;
 
-	if (iter->tr->trace_flags & TRACE_ITER_HASH_PTR)
+	if (!iter->tr || iter->tr->trace_flags & TRACE_ITER_HASH_PTR)
 		return fmt;
 
 	p = fmt;
@@ -9692,7 +9696,7 @@ void __init early_trace_init(void)
 {
 	if (tracepoint_printk) {
 		tracepoint_print_iter =
-			kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
+			kzalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
 		if (MEM_FAIL(!tracepoint_print_iter,
 			     "Failed to allocate trace iterator\n"))
 			tracepoint_printk = 0;
