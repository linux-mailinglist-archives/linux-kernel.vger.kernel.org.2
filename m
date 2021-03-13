Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9B339A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhCMAwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhCMAw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:52:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C4264F45;
        Sat, 13 Mar 2021 00:52:28 +0000 (UTC)
Date:   Fri, 12 Mar 2021 19:52:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zanussi, Tom" <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Yordan Karadzhov" <y.karadz@gmail.com>
Subject: [PATCH 7/7 v2.5] tracing: Add tracing_event_time_stamp() API
Message-ID: <20210312195227.4cd669b4@gandalf.local.home>
In-Reply-To: <20210312211505.818683162@goodmis.org>
References: <20210312211353.422067021@goodmis.org>
        <20210312211505.818683162@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a tracing_event_time_stamp() API that checks if the event passed in is
not on the ring buffer but a pointer to the per CPU trace_buffered_event
which does not have its time stamp set yet.

If it is a pointer to the trace_buffered_event, then just return the
current time stamp that the ring buffer would produce.

Otherwise, return the time stamp from the event.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

I updated this patch but never committed the changes, before sending to the
list. There's no reason to pass in the trace array, when the trace buffer
would suffice.


 kernel/trace/trace.c | 8 ++++++++
 kernel/trace/trace.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8cf7397f3f56..00797a58971d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7120,6 +7120,14 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
+{
+	if (rbe == this_cpu_read(trace_buffered_event))
+		return ring_buffer_time_stamp(buffer, smp_processor_id());
+
+	return ring_buffer_event_time_stamp(buffer, rbe);
+}
+
 /*
  * Set or disable using the per CPU trace_buffer_event when possible.
  */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index de717706e863..50f944e0b5a1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -372,6 +372,7 @@ extern int tracing_check_open_get_tr(struct trace_array *tr);
 extern struct trace_array *trace_array_find(const char *instance);
 extern struct trace_array *trace_array_find_get(const char *instance);
 
+extern u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe);
 extern int tracing_set_filter_buffering(struct trace_array *tr, bool set);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
-- 
2.29.2

