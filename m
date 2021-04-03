Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECF353455
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhDCOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236557AbhDCOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:34:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C4C6124C;
        Sat,  3 Apr 2021 14:34:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lShM7-0040FO-QA; Sat, 03 Apr 2021 10:34:31 -0400
Message-ID: <20210403143431.638878518@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 03 Apr 2021 10:33:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 2/4] tracing: Remove unused argument from "ring_buffer_time_stamp()
References: <20210403143347.409590683@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

The "cpu" parameter is not being used by the function.

Link: https://lkml.kernel.org/r/20210329130331.199402-1-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 2 +-
 kernel/trace/trace.c        | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 057b7ed4fe24..dac53fd3afea 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -181,7 +181,7 @@ unsigned long ring_buffer_commit_overrun_cpu(struct trace_buffer *buffer, int cp
 unsigned long ring_buffer_dropped_events_cpu(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_read_events_cpu(struct trace_buffer *buffer, int cpu);
 
-u64 ring_buffer_time_stamp(struct trace_buffer *buffer, int cpu);
+u64 ring_buffer_time_stamp(struct trace_buffer *buffer);
 void ring_buffer_normalize_time_stamp(struct trace_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct trace_buffer *buffer,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f4216df58e31..2c0ee6484990 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1080,7 +1080,7 @@ static inline u64 rb_time_stamp(struct trace_buffer *buffer)
 	return ts << DEBUG_SHIFT;
 }
 
-u64 ring_buffer_time_stamp(struct trace_buffer *buffer, int cpu)
+u64 ring_buffer_time_stamp(struct trace_buffer *buffer)
 {
 	u64 time;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3834de91fb97..507a30bf26e4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -771,7 +771,7 @@ static u64 buffer_ftrace_now(struct array_buffer *buf, int cpu)
 	if (!buf->buffer)
 		return trace_clock_local();
 
-	ts = ring_buffer_time_stamp(buf->buffer, cpu);
+	ts = ring_buffer_time_stamp(buf->buffer);
 	ring_buffer_normalize_time_stamp(buf->buffer, cpu, &ts);
 
 	return ts;
@@ -7174,7 +7174,7 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
 {
 	if (rbe == this_cpu_read(trace_buffered_event))
-		return ring_buffer_time_stamp(buffer, smp_processor_id());
+		return ring_buffer_time_stamp(buffer);
 
 	return ring_buffer_event_time_stamp(buffer, rbe);
 }
@@ -8088,7 +8088,7 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 		trace_seq_printf(s, "oldest event ts: %5llu.%06lu\n",
 								t, usec_rem);
 
-		t = ns2usecs(ring_buffer_time_stamp(trace_buf->buffer, cpu));
+		t = ns2usecs(ring_buffer_time_stamp(trace_buf->buffer));
 		usec_rem = do_div(t, USEC_PER_SEC);
 		trace_seq_printf(s, "now ts: %5llu.%06lu\n", t, usec_rem);
 	} else {
@@ -8097,7 +8097,7 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 				ring_buffer_oldest_event_ts(trace_buf->buffer, cpu));
 
 		trace_seq_printf(s, "now ts: %llu\n",
-				ring_buffer_time_stamp(trace_buf->buffer, cpu));
+				ring_buffer_time_stamp(trace_buf->buffer));
 	}
 
 	cnt = ring_buffer_dropped_events_cpu(trace_buf->buffer, cpu);
-- 
2.30.1


