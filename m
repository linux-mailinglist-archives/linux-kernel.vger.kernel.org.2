Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE53424D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCSSid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7EAA6198D;
        Fri, 19 Mar 2021 18:38:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0W-0017jJ-PL; Fri, 19 Mar 2021 14:38:00 -0400
Message-ID: <20210319183800.667632557@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 04/13] ring-buffer: Allow ring_buffer_event_time_stamp() to return time
 stamp of all events
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, ring_buffer_event_time_stamp() only returns an accurate time
stamp of the event if it has an absolute extended time stamp attached to
it. To make it more robust, use the event_stamp() in case the event does
not have an absolute value attached to it.

This will allow ring_buffer_event_time_stamp() to be used in more cases
than just histograms, and it will also allow histograms to not require
including absolute values all the time.

Link: https://lkml.kernel.org/r/20210316164113.704830885@goodmis.org

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h      |  3 +-
 kernel/trace/ring_buffer.c       | 60 ++++++++++++++++++++++++--------
 kernel/trace/trace_events_hist.c |  2 +-
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 136ea0997e6d..057b7ed4fe24 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -61,7 +61,8 @@ enum ring_buffer_type {
 
 unsigned ring_buffer_event_length(struct ring_buffer_event *event);
 void *ring_buffer_event_data(struct ring_buffer_event *event);
-u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
+u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
+				 struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 470d97169081..8fa2a84f714f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -298,21 +298,6 @@ static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 	return ts;
 }
 
-/**
- * ring_buffer_event_time_stamp - return the event's extended timestamp
- * @event: the event to get the timestamp of
- *
- * Returns the extended timestamp associated with a data event.
- * An extended time_stamp is a 64-bit timestamp represented
- * internally in a special way that makes the best use of space
- * contained within a ring buffer event.  This function decodes
- * it and maps it to a straight u64 value.
- */
-u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
-{
-	return rb_event_time_stamp(event);
-}
-
 /* Flag when events were overwritten */
 #define RB_MISSED_EVENTS	(1 << 31)
 /* Missed count stored at end */
@@ -757,6 +742,51 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 }
 #endif
 
+static inline u64 rb_time_stamp(struct trace_buffer *buffer);
+
+/**
+ * ring_buffer_event_time_stamp - return the event's current time stamp
+ * @buffer: The buffer that the event is on
+ * @event: the event to get the time stamp of
+ *
+ * Note, this must be called after @event is reserved, and before it is
+ * committed to the ring buffer. And must be called from the same
+ * context where the event was reserved (normal, softirq, irq, etc).
+ *
+ * Returns the time stamp associated with the current event.
+ * If the event has an extended time stamp, then that is used as
+ * the time stamp to return.
+ * In the highly unlikely case that the event was nested more than
+ * the max nesting, then the write_stamp of the buffer is returned,
+ * otherwise  current time is returned, but that really neither of
+ * the last two cases should ever happen.
+ */
+u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
+				 struct ring_buffer_event *event)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[smp_processor_id()];
+	unsigned int nest;
+	u64 ts;
+
+	/* If the event includes an absolute time, then just use that */
+	if (event->type_len == RINGBUF_TYPE_TIME_STAMP)
+		return rb_event_time_stamp(event);
+
+	/* Read the current saved nesting level time stamp */
+	nest = local_read(&cpu_buffer->committing) - 1;
+	if (likely(nest < MAX_NEST))
+		return cpu_buffer->event_stamp[nest];
+
+	WARN_ON_ONCE(1);
+
+	/* Can only fail on 32 bit */
+	if (!rb_time_read(&cpu_buffer->write_stamp, &ts))
+		/* Screw it, just read the current time */
+		ts = rb_time_stamp(cpu_buffer->buffer);
+
+	return ts;
+}
+
 /**
  * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6978aa3ee4c5..45986cb4637e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -644,7 +644,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
 
-	u64 ts = ring_buffer_event_time_stamp(rbe);
+	u64 ts = ring_buffer_event_time_stamp(buffer, rbe);
 
 	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
 		ts = ns2usecs(ts);
-- 
2.30.1


