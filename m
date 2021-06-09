Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E103A1FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFIWHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhFIWHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:07:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28AC3613DF;
        Wed,  9 Jun 2021 22:05:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr6KQ-002aTR-2x; Wed, 09 Jun 2021 18:05:38 -0400
Message-ID: <20210609220537.927890401@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 18:04:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] tracing: Simplify the max length test when using the filtering temp
 buffer
References: <20210609220457.220164154@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When filtering trace events, a temp buffer is used because the extra copy
from the temp buffer into the ring buffer is still faster than the direct
write into the ring buffer followed by a discard if the filter does not
match.

But the data that can be stored in the temp buffer is a PAGE_SIZE minus the
ring buffer event header. The calculation of that header size is complex,
but using the helper macro "struct_size()" can simplify it.

Link: https://lore.kernel.org/stable/CAHk-=whKbJkuVmzb0hD3N6q7veprUrSpiBHRxVY=AffWZPtxmg@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f6c4d9cf0377..7f198d8959f2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2737,8 +2737,10 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
+		int max_len = PAGE_SIZE - struct_size(entry, array, 1);
+
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
-		if ((len < (PAGE_SIZE - sizeof(*entry) - sizeof(entry->array[0]))) && val == 1) {
+		if (val == 1 && unlikely(len < max_len)) {
 			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] = len;
 			return entry;
-- 
2.30.2
