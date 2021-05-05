Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4129373DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhEEOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhEEOtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:49:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B335613BA;
        Wed,  5 May 2021 14:48:20 +0000 (UTC)
Date:   Wed, 5 May 2021 10:48:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] ftrace: Handle commands when closing set_ftrace_filter file
Message-ID: <20210505104818.24358ef7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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
---
 kernel/trace/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.29.2

