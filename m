Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762FC31C2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhBOT46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhBOT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:56:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA0564E20;
        Mon, 15 Feb 2021 19:55:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lBjyP-0009TH-Vy; Mon, 15 Feb 2021 14:55:57 -0500
Message-ID: <20210215195557.874410674@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Feb 2021 14:55:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 2/5] tracing: Update the stage 3 of trace event macro comment
References: <20210215195533.101751000@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Update the comment of the 3rd stage of trace event macro
expansion code. Now there are 2 macros makes different
trace_raw_output_<call>() functions.

Link: https://lkml.kernel.org/r/160277371605.29307.8586817119278606720.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index e6a8b3febc49..8268bf747d6f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -231,9 +231,11 @@ TRACE_MAKE_SYSTEM_STR();
  * {
  *	struct trace_seq *s = &iter->seq;
  *	struct trace_event_raw_<call> *field; <-- defined in stage 1
- *	struct trace_entry *entry;
  *	struct trace_seq *p = &iter->tmp_seq;
- *	int ret;
+ *
+ * -------(for event)-------
+ *
+ *	struct trace_entry *entry;
  *
  *	entry = iter->ent;
  *
@@ -245,14 +247,23 @@ TRACE_MAKE_SYSTEM_STR();
  *	field = (typeof(field))entry;
  *
  *	trace_seq_init(p);
- *	ret = trace_seq_printf(s, "%s: ", <call>);
- *	if (ret)
- *		ret = trace_seq_printf(s, <TP_printk> "\n");
- *	if (!ret)
- *		return TRACE_TYPE_PARTIAL_LINE;
+ *	return trace_output_call(iter, <call>, <TP_printk> "\n");
  *
- *	return TRACE_TYPE_HANDLED;
- * }
+ * ------(or, for event class)------
+ *
+ *	int ret;
+ *
+ *	field = (typeof(field))iter->ent;
+ *
+ *	ret = trace_raw_output_prep(iter, trace_event);
+ *	if (ret != TRACE_TYPE_HANDLED)
+ *		return ret;
+ *
+ *	trace_event_printf(iter, <TP_printk> "\n");
+ *
+ *	return trace_handle_return(s);
+ * -------
+ *  }
  *
  * This is the method used to print the raw event to the trace
  * output format. Note, this is not needed if the data is read
-- 
2.30.0


