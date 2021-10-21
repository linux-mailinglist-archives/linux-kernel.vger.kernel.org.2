Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA4436809
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhJUQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbhJUQjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:39:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F03866138D;
        Thu, 21 Oct 2021 16:37:30 +0000 (UTC)
Date:   Thu, 21 Oct 2021 12:37:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] tracing: Fix selftest config check for function graph start
 up test
Message-ID: <20211021123729.23be20c4@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's a new test in trace_selftest_startup_function_graph() that
requires the use of ftrace args being supported as well does some tricks
with dynamic tracing. Although this code checks HAVE_DYNAMIC_FTRACE_WITH_ARGS
it fails to check DYNAMIC_FTRACE, and the kernel fails to build due to
that dependency.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Fixes this patch:
   https://lore.kernel.org/all/20211008091336.33616-5-jolsa@kernel.org/

 kernel/trace/trace_selftest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 3404a245417e..3db8b80fbdca 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -845,7 +845,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+#if defined(CONFIG_DYNAMIC_FTRACE) && \
+    defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
 
-- 
2.31.1

