Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAF3626C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbhDPR1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241805AbhDPR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652DB613C0;
        Fri, 16 Apr 2021 17:26:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF7-0069mQ-F3; Fri, 16 Apr 2021 13:26:57 -0400
Message-ID: <20210416172657.335441975@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 7/7] ftrace: Reuse the output of the function tracer for func_repeats
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The func_repeats event shows the output of the function tracer followed by
a count of the number of repeats the previous function had made, as well
as the timestamp of the last function that was repeated.

The printing of the function should be the same as is for the function it
is displaying. Reuse the code in trace_fn_trace() by making a helper
function print_fn_trace() and use it for trace_func_repeats_print().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3037f0c88f90..d0368a569bfa 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -845,6 +845,17 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 	return trace_handle_return(&iter->seq);
 }
 
+static void print_fn_trace(struct trace_seq *s, unsigned long ip,
+			   unsigned long parent_ip, int flags)
+{
+	seq_print_ip_sym(s, ip, flags);
+
+	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
+		trace_seq_puts(s, " <-");
+		seq_print_ip_sym(s, parent_ip, flags);
+	}
+}
+
 /* TRACE_FN */
 static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 					struct trace_event *event)
@@ -854,13 +865,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	seq_print_ip_sym(s, field->ip, flags);
-
-	if ((flags & TRACE_ITER_PRINT_PARENT) && field->parent_ip) {
-		trace_seq_puts(s, " <-");
-		seq_print_ip_sym(s, field->parent_ip, flags);
-	}
-
+	print_fn_trace(s, field->ip, field->parent_ip, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1408,9 +1413,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_puts(s, " <-");
-	seq_print_ip_sym(s, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.30.1


