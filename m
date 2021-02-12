Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8831A6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhBLVZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhBLVY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:24:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D8A64E05;
        Fri, 12 Feb 2021 21:24:15 +0000 (UTC)
Date:   Fri, 12 Feb 2021 16:24:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing: Make hash-ptr option default
Message-ID: <20210212162414.76926502@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Since the original behavior of the trace events is to hash the %p pointers,
make that the default, and have developers have to enable the option in
order to have them unhashed.

[
  Based off of these patches:
    https://lore.kernel.org/lkml/160277369795.29307.6792451054602907237.stgit@devnote2/
]

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 16e252d39016..f5e8e39d6f57 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -408,7 +408,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 	 TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |			\
 	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
 	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
-	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS)
+	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
+	 TRACE_ITER_HASH_PTR)
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
-- 
2.25.4

