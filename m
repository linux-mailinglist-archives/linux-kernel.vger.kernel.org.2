Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B33626BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbhDPR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241765AbhDPR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8052613B4;
        Fri, 16 Apr 2021 17:26:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF6-0069kN-PN; Fri, 16 Apr 2021 13:26:56 -0400
Message-ID: <20210416172656.610535799@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 3/7] tracing: Add "last_func_repeats" to struct trace_array
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

The field is used to keep track of the consecutive (on the same CPU) calls
of a single function. This information is needed in order to consolidate
the function tracing record in the cases when a single function is called
number of times.

Link: https://lkml.kernel.org/r/20210415181854.147448-4-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c |  1 +
 kernel/trace/trace.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 507a30bf26e4..82833be07c1e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9104,6 +9104,7 @@ static int __remove_instance(struct trace_array *tr)
 	ftrace_clear_pids(tr);
 	ftrace_destroy_function_files(tr);
 	tracefs_remove(tr->dir);
+	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
 
 	for (i = 0; i < tr->nr_topts; i++) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6a5b4c2a0fa7..a4f1b66049fd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -262,6 +262,17 @@ struct cond_snapshot {
 	cond_update_fn_t		update;
 };
 
+/*
+ * struct trace_func_repeats - used to keep track of the consecutive
+ * (on the same CPU) calls of a single function.
+ */
+struct trace_func_repeats {
+	unsigned long	ip;
+	unsigned long	parent_ip;
+	unsigned long	count;
+	u64		ts_last_call;
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -358,6 +369,7 @@ struct trace_array {
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
 #endif
+	struct trace_func_repeats	__percpu *last_func_repeats;
 };
 
 enum {
-- 
2.30.1


