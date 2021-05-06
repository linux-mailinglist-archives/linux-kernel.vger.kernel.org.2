Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7710337556A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhEFOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhEFOMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:12:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE9060FF2;
        Thu,  6 May 2021 14:11:21 +0000 (UTC)
Date:   Thu, 6 May 2021 10:11:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fix probes written to the set_ftrace_filter
 file
Message-ID: <20210506101120.77792a09@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Now that there's a library that accesses the tracefs file system,
(libtracefs), the way the files are interacted with is slightly
different than the command line. For instance, the write() system
call is used directly instead of an echo. This exposes some old bugs.

If a probe is written to "set_ftrace_filter" without any white space
after it, it will be ignored. This is because the write expects
that a string written to it that does not end with white spaces thinks
there is more to come. But if the file is closed, the release function
needs to finish it. The "set_ftrace_filter" release function handles
the filter part of the "set_ftrace_filter" file, but did not handle
the probe part.


Please pull the latest trace-v5.13-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.13-2

Tag SHA1: 82d2456e6fd7e77cb6bbc30c78302680e6115cb1
Head SHA1: 8c9af478c06bb1ab1422f90d8ecbc53defd44bc3


Steven Rostedt (VMware) (1):
      ftrace: Handle commands when closing set_ftrace_filter file

----
 kernel/trace/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
---------------------------
commit 8c9af478c06bb1ab1422f90d8ecbc53defd44bc3
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed May 5 10:38:24 2021 -0400

    ftrace: Handle commands when closing set_ftrace_filter file
    
     # echo switch_mm:traceoff > /sys/kernel/tracing/set_ftrace_filter
    
    will cause switch_mm to stop tracing by the traceoff command.
    
     # echo -n switch_mm:traceoff > /sys/kernel/tracing/set_ftrace_filter
    
    does nothing.
    
    The reason is that the parsing in the write function only processes
    commands if it finished parsing (there is white space written after the
    command). That's to handle:
    
     write(fd, "switch_mm:", 10);
     write(fd, "traceoff", 8);
    
    cases, where the command is broken over multiple writes.
    
    The problem is if the file descriptor is closed, then the write call is
    not processed, and the command needs to be processed in the release code.
    The release code can handle matching of functions, but does not handle
    commands.
    
    Cc: stable@vger.kernel.org
    Fixes: eda1e32855656 ("tracing: handle broken names in ftrace filter")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 057e962ca5ce..c57508445faa 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5591,7 +5591,10 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 	parser = &iter->parser;
 	if (trace_parser_loaded(parser)) {
-		ftrace_match_records(iter->hash, parser->buffer, parser->idx);
+		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
+
+		ftrace_process_regex(iter, parser->buffer,
+				     parser->idx, enable);
 	}
 
 	trace_parser_put(parser);
