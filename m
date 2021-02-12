Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE731A0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBLOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhBLOqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:46:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA3364E6B;
        Fri, 12 Feb 2021 14:45:18 +0000 (UTC)
Date:   Fri, 12 Feb 2021 09:45:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: [GIT PULL] tracing: Check length before giving out the filter
 buffer
Message-ID: <20210212094517.7930a8b1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt (VMware) <rostedt@goodmis.org>

Linus,

tracing: Fix buffer overflow in trace event filter

It was reported that if a trace event was larger than a page
and was filtered, that it caused memory corruption. The reason
is that filtered events first go into a buffer to test the filter
before being written into the ring buffer. Unfortunately,
this write did not check the size.


Please pull the latest trace-v5.11-rc7-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.11-rc7-2

Tag SHA1: f34ead40f801eff27d17410da944f4072b6a0bd4
Head SHA1: b220c049d5196dd94d992dd2dc8cba1a5e6123bf


Steven Rostedt (VMware) (1):
      tracing: Check length before giving out the filter buffer

----
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit b220c049d5196dd94d992dd2dc8cba1a5e6123bf
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Feb 10 11:53:22 2021 -0500

    tracing: Check length before giving out the filter buffer
    
    When filters are used by trace events, a page is allocated on each CPU and
    used to copy the trace event fields to this page before writing to the ring
    buffer. The reason to use the filter and not write directly into the ring
    buffer is because a filter may discard the event and there's more overhead
    on discarding from the ring buffer than the extra copy.
    
    The problem here is that there is no check against the size being allocated
    when using this page. If an event asks for more than a page size while being
    filtered, it will get only a page, leading to the caller writing more that
    what was allocated.
    
    Check the length of the request, and if it is more than PAGE_SIZE minus the
    header default back to allocating from the ring buffer directly. The ring
    buffer may reject the event if its too big anyway, but it wont overflow.
    
    Link: https://lore.kernel.org/ath10k/1612839593-2308-1-git-send-email-wgong@codeaurora.org/
    
    Cc: stable@vger.kernel.org
    Fixes: 0fc1b09ff1ff4 ("tracing: Use temp buffer when filtering events")
    Reported-by: Wen Gong <wgong@codeaurora.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8a2d786b503..b5815a022ecc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2745,7 +2745,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
-		if (val == 1) {
+		if ((len < (PAGE_SIZE - sizeof(*entry))) && val == 1) {
 			trace_event_setup(entry, type, flags, pc);
 			entry->array[0] = len;
 			return entry;
