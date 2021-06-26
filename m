Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF693B4E9B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFZNIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhFZNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A1A61C42;
        Sat, 26 Jun 2021 13:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx807-000Ehb-U3; Sat, 26 Jun 2021 09:05:35 -0400
Message-ID: <20210626130535.766916537@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 07/24] tracing: Add better comments for the filtering temp buffer use case
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When filtering is enabled, the event is copied into a temp buffer instead
of being written into the ring buffer directly, because the discarding of
events from the ring buffer is very expensive, and doing the extra copy is
much faster than having to discard most of the time.

As that logic is subtle, add comments to explain in more detail to what is
going on and how it works.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a0a84ff46ecd..a0d66a056e59 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2734,10 +2734,44 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	if (!tr->no_filter_buffering_ref &&
 	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
-		/* Try to use the per cpu buffer first */
+		/*
+		 * Filtering is on, so try to use the per cpu buffer first.
+		 * This buffer will simulate a ring_buffer_event,
+		 * where the type_len is zero and the array[0] will
+		 * hold the full length.
+		 * (see include/linux/ring-buffer.h for details on
+		 *  how the ring_buffer_event is structured).
+		 *
+		 * Using a temp buffer during filtering and copying it
+		 * on a matched filter is quicker than writing directly
+		 * into the ring buffer and then discarding it when
+		 * it doesn't match. That is because the discard
+		 * requires several atomic operations to get right.
+		 * Copying on match and doing nothing on a failed match
+		 * is still quicker than no copy on match, but having
+		 * to discard out of the ring buffer on a failed match.
+		 */
 		int max_len = PAGE_SIZE - struct_size(entry, array, 1);
 
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
+
+		/*
+		 * Preemption is disabled, but interrupts and NMIs
+		 * can still come in now. If that happens after
+		 * the above increment, then it will have to go
+		 * back to the old method of allocating the event
+		 * on the ring buffer, and if the filter fails, it
+		 * will have to call ring_buffer_discard_commit()
+		 * to remove it.
+		 *
+		 * Need to also check the unlikely case that the
+		 * length is bigger than the temp buffer size.
+		 * If that happens, then the reserve is pretty much
+		 * guaranteed to fail, as the ring buffer currently
+		 * only allows events less than a page. But that may
+		 * change in the future, so let the ring buffer reserve
+		 * handle the failure in that case.
+		 */
 		if (val == 1 && likely(len <= max_len)) {
 			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] = len;
-- 
2.30.2
