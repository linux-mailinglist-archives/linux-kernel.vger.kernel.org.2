Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83A43424D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCSSi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF8E61993;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017kl-6i; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183801.088720898@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 07/13] tracing: Add tracing_event_time_stamp() API
References: <20210319183426.840228082@goodmis.org>
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

Link: https://lkml.kernel.org/r/20210316164114.131996180@goodmis.org

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 8 ++++++++
 kernel/trace/trace.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b15436ff85e8..90ae3140756e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6972,6 +6972,14 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
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
index f2a7a72825c7..0d8f54f49a3a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -372,6 +372,7 @@ extern int tracing_check_open_get_tr(struct trace_array *tr);
 extern struct trace_array *trace_array_find(const char *instance);
 extern struct trace_array *trace_array_find_get(const char *instance);
 
+extern u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe);
 extern int tracing_set_filter_buffering(struct trace_array *tr, bool set);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
-- 
2.30.1


