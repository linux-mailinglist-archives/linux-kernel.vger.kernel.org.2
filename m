Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100683424D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCSSi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCAE61992;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017kH-28; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183800.947844939@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 06/13] ring-buffer: Add verifier for using ring_buffer_event_time_stamp()
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ring_buffer_event_time_stamp() must be only called by an event that has
not been committed yet, and is on the buffer that is passed in. This was
used to help debug converting the histogram logic over to using the new
time stamp code, and was proven to be very useful.

Add a verifier that can check that this is the case, and extra WARN_ONs to
catch unexpected use cases.

Link: https://lkml.kernel.org/r/20210316164113.987294354@goodmis.org

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 56 +++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8fa2a84f714f..1c61a8cd7b99 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -742,6 +742,48 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 }
 #endif
 
+/*
+ * Enable this to make sure that the event passed to
+ * ring_buffer_event_time_stamp() is not committed and also
+ * is on the buffer that it passed in.
+ */
+//#define RB_VERIFY_EVENT
+#ifdef RB_VERIFY_EVENT
+static struct list_head *rb_list_head(struct list_head *list);
+static void verify_event(struct ring_buffer_per_cpu *cpu_buffer,
+			 void *event)
+{
+	struct buffer_page *page = cpu_buffer->commit_page;
+	struct buffer_page *tail_page = READ_ONCE(cpu_buffer->tail_page);
+	struct list_head *next;
+	long commit, write;
+	unsigned long addr = (unsigned long)event;
+	bool done = false;
+	int stop = 0;
+
+	/* Make sure the event exists and is not committed yet */
+	do {
+		if (page == tail_page || WARN_ON_ONCE(stop++ > 100))
+			done = true;
+		commit = local_read(&page->page->commit);
+		write = local_read(&page->write);
+		if (addr >= (unsigned long)&page->page->data[commit] &&
+		    addr < (unsigned long)&page->page->data[write])
+			return;
+
+		next = rb_list_head(page->list.next);
+		page = list_entry(next, struct buffer_page, list);
+	} while (!done);
+	WARN_ON_ONCE(1);
+}
+#else
+static inline void verify_event(struct ring_buffer_per_cpu *cpu_buffer,
+			 void *event)
+{
+}
+#endif
+
+
 static inline u64 rb_time_stamp(struct trace_buffer *buffer);
 
 /**
@@ -772,13 +814,19 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	if (event->type_len == RINGBUF_TYPE_TIME_STAMP)
 		return rb_event_time_stamp(event);
 
+	nest = local_read(&cpu_buffer->committing);
+	verify_event(cpu_buffer, event);
+	if (WARN_ON_ONCE(!nest))
+		goto fail;
+
 	/* Read the current saved nesting level time stamp */
-	nest = local_read(&cpu_buffer->committing) - 1;
-	if (likely(nest < MAX_NEST))
+	if (likely(--nest < MAX_NEST))
 		return cpu_buffer->event_stamp[nest];
 
-	WARN_ON_ONCE(1);
+	/* Shouldn't happen, warn if it does */
+	WARN_ONCE(1, "nest (%d) greater than max", nest);
 
+ fail:
 	/* Can only fail on 32 bit */
 	if (!rb_time_read(&cpu_buffer->write_stamp, &ts))
 		/* Screw it, just read the current time */
@@ -2750,7 +2798,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	u64 delta = info->delta;
 	unsigned int nest = local_read(&cpu_buffer->committing) - 1;
 
-	if (nest < MAX_NEST)
+	if (!WARN_ON_ONCE(nest >= MAX_NEST))
 		cpu_buffer->event_stamp[nest] = info->ts;
 
 	/*
-- 
2.30.1


