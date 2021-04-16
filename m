Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B23626B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbhDPR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241756AbhDPR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E60E611AF;
        Fri, 16 Apr 2021 17:26:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF6-0069jJ-Dg; Fri, 16 Apr 2021 13:26:56 -0400
Message-ID: <20210416172656.297285043@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 1/7] tracing: Define static void trace_print_time()
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

The part of the code that prints the time of the trace record in
"int trace_print_context()" gets extracted in a static function. This
is done as a preparation for a following patch, in which we will define
a new ftrace event called "func_repeats". The new static method,
defined here, will be used by this new event to print the time of the
last repeat of a function that is consecutively called number of times.

Link: https://lkml.kernel.org/r/20210415181854.147448-2-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a0146e1fffdf..333233d45596 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -587,13 +587,26 @@ lat_print_timestamp(struct trace_iterator *iter, u64 next_ts)
 	return !trace_seq_has_overflowed(s);
 }
 
+static void trace_print_time(struct trace_seq *s, struct trace_iterator *iter,
+			     unsigned long long ts)
+{
+	unsigned long secs, usec_rem;
+	unsigned long long t;
+
+	if (iter->iter_flags & TRACE_FILE_TIME_IN_NS) {
+		t = ns2usecs(ts);
+		usec_rem = do_div(t, USEC_PER_SEC);
+		secs = (unsigned long)t;
+		trace_seq_printf(s, " %5lu.%06lu", secs, usec_rem);
+	} else
+		trace_seq_printf(s, " %12llu", ts);
+}
+
 int trace_print_context(struct trace_iterator *iter)
 {
 	struct trace_array *tr = iter->tr;
 	struct trace_seq *s = &iter->seq;
 	struct trace_entry *entry = iter->ent;
-	unsigned long long t;
-	unsigned long secs, usec_rem;
 	char comm[TASK_COMM_LEN];
 
 	trace_find_cmdline(entry->pid, comm);
@@ -614,13 +627,8 @@ int trace_print_context(struct trace_iterator *iter)
 	if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
 		trace_print_lat_fmt(s, entry);
 
-	if (iter->iter_flags & TRACE_FILE_TIME_IN_NS) {
-		t = ns2usecs(iter->ts);
-		usec_rem = do_div(t, USEC_PER_SEC);
-		secs = (unsigned long)t;
-		trace_seq_printf(s, " %5lu.%06lu: ", secs, usec_rem);
-	} else
-		trace_seq_printf(s, " %12llu: ", iter->ts);
+	trace_print_time(s, iter, iter->ts);
+	trace_seq_puts(s, ": ");
 
 	return !trace_seq_has_overflowed(s);
 }
-- 
2.30.1


