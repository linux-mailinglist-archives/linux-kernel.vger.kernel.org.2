Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401A8437F90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhJVUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234383AbhJVUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A250E6138B;
        Fri, 22 Oct 2021 20:48:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T0-000QP3-PQ;
        Fri, 22 Oct 2021 16:48:42 -0400
Message-ID: <20211022204842.631661677@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 24/40] tracing: Add trampoline/graph selftest
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Adding selftest for checking that direct trampoline can
co-exist together with graph tracer on same function.

This is supported for CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
config option, which is defined only for x86_64 for now.

Link: https://lkml.kernel.org/r/20211008091336.33616-5-jolsa@kernel.org

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 875b4f1a0476..3404a245417e 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -784,6 +784,8 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
+noinline __noclone static void trace_direct_tramp(void) { }
+
 /*
  * Pretty much the same than for the function tracer from which the selftest
  * has been borrowed.
@@ -794,6 +796,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 {
 	int ret;
 	unsigned long count;
+	char *func_name __maybe_unused;
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (ftrace_filter_param) {
@@ -842,8 +845,57 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-	/* Don't test dynamic tracing, the function tracer already did */
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	tracing_reset_online_cpus(&tr->array_buffer);
+	set_graph_array(tr);
+
+	/*
+	 * Some archs *cough*PowerPC*cough* add characters to the
+	 * start of the function names. We simply put a '*' to
+	 * accommodate them.
+	 */
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	ftrace_set_global_filter(func_name, strlen(func_name), 1);
+
+	/*
+	 * Register direct function together with graph tracer
+	 * and make sure we get graph trace.
+	 */
+	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+				     (unsigned long) trace_direct_tramp);
+	if (ret)
+		goto out;
+
+	ret = register_ftrace_graph(&fgraph_ops);
+	if (ret) {
+		warn_failed_init_tracer(trace, ret);
+		goto out;
+	}
+
+	DYN_FTRACE_TEST_NAME();
+
+	count = 0;
+
+	tracing_stop();
+	/* check the trace buffer */
+	ret = trace_test_buffer(&tr->array_buffer, &count);
+
+	unregister_ftrace_graph(&fgraph_ops);
+
+	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+				       (unsigned long) trace_direct_tramp);
+	if (ret)
+		goto out;
+
+	tracing_start();
 
+	if (!ret && !count) {
+		ret = -1;
+		goto out;
+	}
+#endif
+
+	/* Don't test dynamic tracing, the function tracer already did */
 out:
 	/* Stop it if we failed */
 	if (ret)
-- 
2.33.0
