Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF543398F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhCLVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235175AbhCLVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:15:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6508C64F6D;
        Fri, 12 Mar 2021 21:15:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lKp7h-000Lpo-7B; Fri, 12 Mar 2021 16:15:05 -0500
Message-ID: <20210312211505.101877704@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 16:13:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zanussi, Tom" <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Yordan Karadzhov" <y.karadz@gmail.com>
Subject: [PATCH 2/7] ring-buffer: Add a event_stamp to cpu_buffer for each level of
 nesting
References: <20210312211353.422067021@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a place to save the current event time stamp for each level of nesting.
This will be used to retrieve the time stamp of the current event before it
is committed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 941ac2021b97..470d97169081 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -492,6 +492,8 @@ struct rb_time_struct {
 #endif
 typedef struct rb_time_struct rb_time_t;
 
+#define MAX_NEST	5
+
 /*
  * head_page == tail_page && head == tail then buffer is empty.
  */
@@ -529,6 +531,7 @@ struct ring_buffer_per_cpu {
 	unsigned long			read_bytes;
 	rb_time_t			write_stamp;
 	rb_time_t			before_stamp;
+	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
@@ -2715,6 +2718,10 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	unsigned length = info->length;
 	u64 delta = info->delta;
+	unsigned int nest = local_read(&cpu_buffer->committing) - 1;
+
+	if (nest < MAX_NEST)
+		cpu_buffer->event_stamp[nest] = info->ts;
 
 	/*
 	 * If we need to add a timestamp, then we
@@ -3456,7 +3463,6 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 				    info->after, ts)) {
 			/* Nothing came after this event between C and E */
 			info->delta = ts - info->after;
-			info->ts = ts;
 		} else {
 			/*
 			 * Interrupted between C and E:
@@ -3468,6 +3474,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			 */
 			info->delta = 0;
 		}
+		info->ts = ts;
 		info->add_timestamp &= ~RB_ADD_STAMP_FORCE;
 	}
 
@@ -5026,6 +5033,8 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_time_set(&cpu_buffer->write_stamp, 0);
 	rb_time_set(&cpu_buffer->before_stamp, 0);
 
+	memset(cpu_buffer->event_stamp, 0, sizeof(cpu_buffer->event_stamp));
+
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
-- 
2.30.1


