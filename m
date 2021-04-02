Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D6352B08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhDBNdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235459AbhDBNdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:33:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBC2610D2;
        Fri,  2 Apr 2021 13:33:17 +0000 (UTC)
Date:   Fri, 2 Apr 2021 09:33:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] tracing: Fix stack trace event size
Message-ID: <20210402093315.1b692cbf@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Fix stack trace entry size to stop showing garbage

The macro that creates both the structure and the format displayed
to user space for the stack trace event was changed a while ago
to fix the parsing by user space tooling. But this change also modified
the structure used to store the stack trace event. It changed the
caller array field from [0] to [8]. Even though the size in the ring
buffer is dynamic and can be something other than 8 (user space knows
how to handle this), the 8 extra words was not accounted for when
reserving the event on the ring buffer, and added 8 more entries, due
to the calculation of "sizeof(*entry) + nr_entries * sizeof(long)",
as the sizeof(*entry) now contains 8 entries. The size of the caller
field needs to be subtracted from the size of the entry to create
the correct allocation size.


Please pull the latest trace-v5.12-rc5-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12-rc5-2

Tag SHA1: cb39aeb904fb1dc0fff7e13799d9ad287fb4697f
Head SHA1: 9deb193af69d3fd6dd8e47f292b67c805a787010


Steven Rostedt (VMware) (1):
      tracing: Fix stack trace event size

----
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---------------------------
commit 9deb193af69d3fd6dd8e47f292b67c805a787010
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Apr 1 13:54:40 2021 -0400

    tracing: Fix stack trace event size
    
    Commit cbc3b92ce037 fixed an issue to modify the macros of the stack trace
    event so that user space could parse it properly. Originally the stack
    trace format to user space showed that the called stack was a dynamic
    array. But it is not actually a dynamic array, in the way that other
    dynamic event arrays worked, and this broke user space parsing for it. The
    update was to make the array look to have 8 entries in it. Helper
    functions were added to make it parse it correctly, as the stack was
    dynamic, but was determined by the size of the event stored.
    
    Although this fixed user space on how it read the event, it changed the
    internal structure used for the stack trace event. It changed the array
    size from [0] to [8] (added 8 entries). This increased the size of the
    stack trace event by 8 words. The size reserved on the ring buffer was the
    size of the stack trace event plus the number of stack entries found in
    the stack trace. That commit caused the amount to be 8 more than what was
    needed because it did not expect the caller field to have any size. This
    produced 8 entries of garbage (and reading random data) from the stack
    trace event:
    
              <idle>-0       [002] d... 1976396.837549: <stack trace>
     => trace_event_raw_event_sched_switch
     => __traceiter_sched_switch
     => __schedule
     => schedule_idle
     => do_idle
     => cpu_startup_entry
     => secondary_startup_64_no_verify
     => 0xc8c5e150ffff93de
     => 0xffff93de
     => 0
     => 0
     => 0xc8c5e17800000000
     => 0x1f30affff93de
     => 0x00000004
     => 0x200000000
    
    Instead, subtract the size of the caller field from the size of the event
    to make sure that only the amount needed to store the stack trace is
    reserved.
    
    Link: https://lore.kernel.org/lkml/your-ad-here.call-01617191565-ext-9692@work.hours/
    
    Cc: stable@vger.kernel.org
    Fixes: cbc3b92ce037 ("tracing: Set kernel_stack's caller size properly")
    Reported-by: Vasily Gorbik <gor@linux.ibm.com>
    Tested-by: Vasily Gorbik <gor@linux.ibm.com>
    Acked-by: Vasily Gorbik <gor@linux.ibm.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eccb4e1187cc..5c777627212f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2984,7 +2984,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 
 	size = nr_entries * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-					    sizeof(*entry) + size, trace_ctx);
+				    (sizeof(*entry) - sizeof(entry->caller)) + size,
+				    trace_ctx);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
