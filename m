Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062053424DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCSSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhCSSiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5762D61980;
        Fri, 19 Mar 2021 18:38:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0W-0017hr-BB; Fri, 19 Mar 2021 14:38:00 -0400
Message-ID: <20210319183800.229786294@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 01/13] ring-buffer: Separate out internal use of
 ring_buffer_event_time_stamp()
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The exported use of ring_buffer_event_time_stamp() is going to become
different than how it is used internally. Move the internal logic out into a
static function called rb_event_time_stamp(), and have the internal callers
call that instead.

Link: https://lkml.kernel.org/r/20210316164113.257790481@goodmis.org

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 41 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 68744c51517e..941ac2021b97 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -287,6 +287,17 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define TS_MASK		((1ULL << TS_SHIFT) - 1)
 #define TS_DELTA_TEST	(~TS_MASK)
 
+static u64 rb_event_time_stamp(struct ring_buffer_event *event)
+{
+	u64 ts;
+
+	ts = event->array[0];
+	ts <<= TS_SHIFT;
+	ts += event->time_delta;
+
+	return ts;
+}
+
 /**
  * ring_buffer_event_time_stamp - return the event's extended timestamp
  * @event: the event to get the timestamp of
@@ -299,13 +310,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
  */
 u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
 {
-	u64 ts;
-
-	ts = event->array[0];
-	ts <<= TS_SHIFT;
-	ts += event->time_delta;
-
-	return ts;
+	return rb_event_time_stamp(event);
 }
 
 /* Flag when events were overwritten */
@@ -2766,7 +2771,7 @@ static u64 rb_time_delta(struct ring_buffer_event *event)
 		return 0;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		return ring_buffer_event_time_stamp(event);
+		return rb_event_time_stamp(event);
 
 	case RINGBUF_TYPE_TIME_STAMP:
 		return 0;
@@ -3212,13 +3217,13 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 		switch (event->type_len) {
 
 		case RINGBUF_TYPE_TIME_EXTEND:
-			delta = ring_buffer_event_time_stamp(event);
+			delta = rb_event_time_stamp(event);
 			ts += delta;
 			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
 			break;
 
 		case RINGBUF_TYPE_TIME_STAMP:
-			delta = ring_buffer_event_time_stamp(event);
+			delta = rb_event_time_stamp(event);
 			ts = delta;
 			pr_warn("  [%lld] absolute:%lld TIME STAMP\n", ts, delta);
 			break;
@@ -3289,12 +3294,12 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		switch (event->type_len) {
 
 		case RINGBUF_TYPE_TIME_EXTEND:
-			delta = ring_buffer_event_time_stamp(event);
+			delta = rb_event_time_stamp(event);
 			ts += delta;
 			break;
 
 		case RINGBUF_TYPE_TIME_STAMP:
-			delta = ring_buffer_event_time_stamp(event);
+			delta = rb_event_time_stamp(event);
 			ts = delta;
 			break;
 
@@ -4256,12 +4261,12 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = ring_buffer_event_time_stamp(event);
+		delta = rb_event_time_stamp(event);
 		cpu_buffer->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		delta = ring_buffer_event_time_stamp(event);
+		delta = rb_event_time_stamp(event);
 		cpu_buffer->read_stamp = delta;
 		return;
 
@@ -4286,12 +4291,12 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = ring_buffer_event_time_stamp(event);
+		delta = rb_event_time_stamp(event);
 		iter->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		delta = ring_buffer_event_time_stamp(event);
+		delta = rb_event_time_stamp(event);
 		iter->read_stamp = delta;
 		return;
 
@@ -4544,7 +4549,7 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 
 	case RINGBUF_TYPE_TIME_STAMP:
 		if (ts) {
-			*ts = ring_buffer_event_time_stamp(event);
+			*ts = rb_event_time_stamp(event);
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
 		}
@@ -4635,7 +4640,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 
 	case RINGBUF_TYPE_TIME_STAMP:
 		if (ts) {
-			*ts = ring_buffer_event_time_stamp(event);
+			*ts = rb_event_time_stamp(event);
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
 		}
-- 
2.30.1


