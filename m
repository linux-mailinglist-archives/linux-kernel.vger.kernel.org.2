Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF53398EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhCLVPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhCLVPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:15:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA40F64FC3;
        Fri, 12 Mar 2021 21:15:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lKp7h-000LsG-UU; Fri, 12 Mar 2021 16:15:05 -0500
Message-ID: <20210312211505.818683162@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 16:14:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zanussi, Tom" <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Yordan Karadzhov" <y.karadz@gmail.com>
Subject: [PATCH 7/7] tracing: Add tracing_event_time_stamp() API
References: <20210312211353.422067021@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 kernel/trace/trace.c | 10 ++++++++++
 kernel/trace/trace.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8cf7397f3f56..a8d5356ed327 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7120,6 +7120,16 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+u64 tracing_event_time_stamp(struct trace_array *tr, struct ring_buffer_event *rbe)
+{
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+
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
index de717706e863..23d85e78bef4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -372,6 +372,7 @@ extern int tracing_check_open_get_tr(struct trace_array *tr);
 extern struct trace_array *trace_array_find(const char *instance);
 extern struct trace_array *trace_array_find_get(const char *instance);
 
+extern u64 tracing_event_time_stamp(struct trace_array *tr, struct ring_buffer_event *rbe);
 extern int tracing_set_filter_buffering(struct trace_array *tr, bool set);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
-- 
2.30.1


