Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A903626BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbhDPR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241793AbhDPR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136BE611C2;
        Fri, 16 Apr 2021 17:26:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF7-0069lR-4M; Fri, 16 Apr 2021 13:26:57 -0400
Message-ID: <20210416172657.005754827@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 5/7] tracing: Unify the logic for function tracing options
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

Currently the logic for dealing with the options for function tracing
has two different implementations. One is used when we set the flags
(in "static int func_set_flag()") and another used when we initialize
the tracer (in "static int function_trace_init()"). Those two
implementations are meant to do essentially the same thing and they
are both not very convenient for adding new options. In this patch
we add a helper function that provides a single implementation of
the logic for dealing with the options and we make it such that new
options can be easily added.

Link: https://lkml.kernel.org/r/20210415181854.147448-6-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 65 ++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f93723ca66bc..f37f73a9b1b8 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -31,9 +31,12 @@ static struct tracer_flags func_flags;
 
 /* Our option */
 enum {
+	TRACE_FUNC_NO_OPTS	= 0x0, /* No flags set. */
 	TRACE_FUNC_OPT_STACK	= 0x1,
 };
 
+#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_STACK)
+
 int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 {
 	struct ftrace_ops *ops;
@@ -86,6 +89,18 @@ void ftrace_destroy_function_files(struct trace_array *tr)
 	ftrace_free_ftrace_ops(tr);
 }
 
+static ftrace_func_t select_trace_function(u32 flags_val)
+{
+	switch (flags_val & TRACE_FUNC_OPT_MASK) {
+	case TRACE_FUNC_NO_OPTS:
+		return function_trace_call;
+	case TRACE_FUNC_OPT_STACK:
+		return function_stack_trace_call;
+	default:
+		return NULL;
+	}
+}
+
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
@@ -97,12 +112,9 @@ static int function_trace_init(struct trace_array *tr)
 	if (!tr->ops)
 		return -ENOMEM;
 
-	/* Currently only the global instance can do stack tracing */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL &&
-	    func_flags.val & TRACE_FUNC_OPT_STACK)
-		func = function_stack_trace_call;
-	else
-		func = function_trace_call;
+	func = select_trace_function(func_flags.val);
+	if (!func)
+		return -EINVAL;
 
 	ftrace_init_array_ops(tr, func);
 
@@ -213,7 +225,7 @@ static struct tracer_opt func_opts[] = {
 };
 
 static struct tracer_flags func_flags = {
-	.val = 0, /* By default: all flags disabled */
+	.val = TRACE_FUNC_NO_OPTS, /* By default: all flags disabled */
 	.opts = func_opts
 };
 
@@ -235,30 +247,29 @@ static struct tracer function_trace;
 static int
 func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-	switch (bit) {
-	case TRACE_FUNC_OPT_STACK:
-		/* do nothing if already set */
-		if (!!set == !!(func_flags.val & TRACE_FUNC_OPT_STACK))
-			break;
-
-		/* We can change this flag when not running. */
-		if (tr->current_trace != &function_trace)
-			break;
+	ftrace_func_t func;
+	u32 new_flags;
 
-		unregister_ftrace_function(tr->ops);
+	/* Do nothing if already set. */
+	if (!!set == !!(func_flags.val & bit))
+		return 0;
 
-		if (set) {
-			tr->ops->func = function_stack_trace_call;
-			register_ftrace_function(tr->ops);
-		} else {
-			tr->ops->func = function_trace_call;
-			register_ftrace_function(tr->ops);
-		}
+	/* We can change this flag only when not running. */
+	if (tr->current_trace != &function_trace)
+		return 0;
 
-		break;
-	default:
+	new_flags = (func_flags.val & ~bit) | (set ? bit : 0);
+	func = select_trace_function(new_flags);
+	if (!func)
 		return -EINVAL;
-	}
+
+	/* Check if there's anything to change. */
+	if (tr->ops->func == func)
+		return 0;
+
+	unregister_ftrace_function(tr->ops);
+	tr->ops->func = func;
+	register_ftrace_function(tr->ops);
 
 	return 0;
 }
-- 
2.30.1


