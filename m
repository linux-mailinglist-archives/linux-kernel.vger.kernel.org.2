Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D356D437F92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhJVUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234408AbhJVUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA2061378;
        Fri, 22 Oct 2021 20:48:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T0-000QPd-VK;
        Fri, 22 Oct 2021 16:48:42 -0400
Message-ID: <20211022204842.805398614@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [for-next][PATCH 25/40] tracing: Fix selftest config check for function graph start up test
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's a new test in trace_selftest_startup_function_graph() that
requires the use of ftrace args being supported as well does some tricks
with dynamic tracing. Although this code checks HAVE_DYNAMIC_FTRACE_WITH_ARGS
it fails to check DYNAMIC_FTRACE, and the kernel fails to build due to
that dependency.

Also only define the prototype of trace_direct_tramp() if it is used.

Link: https://lkml.kernel.org/r/20211021134357.7f48e173@gandalf.local.home

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 3404a245417e..afd937a46496 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -784,7 +784,11 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
+#if defined(CONFIG_DYNAMIC_FTRACE) && \
+    defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
+#define TEST_DIRECT_TRAMP
 noinline __noclone static void trace_direct_tramp(void) { }
+#endif
 
 /*
  * Pretty much the same than for the function tracer from which the selftest
@@ -845,7 +849,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+#ifdef TEST_DIRECT_TRAMP
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
 
-- 
2.33.0
