Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E9340960
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhCRP4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhCRPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:55:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151F564F18;
        Thu, 18 Mar 2021 15:55:40 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:55:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] workqueue/tracing: Copy workqueue name to buffer in trace
 event
Message-ID: <20210318115538.33bfc00b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The trace event "workqueue_queue_work" references an unsafe string in
dereferencing the name of the workqueue. As the name is allocated, it
could later be freed, and the pointer to that string could stay on the
tracing buffer. If the trace buffer is read after the string is freed, it
will reference an unsafe pointer.

I added a new verifier to make sure that all strings referenced in the
output of the trace buffer is safe to read and this triggered on the
workqueue_queue_work trace event:

workqueue_queue_work: work struct=00000000b2b235c7 function=gc_worker workqueue=(0xffff888100051160:events_power_efficient)[UNSAFE-MEMORY] req_cpu=256 cpu=1
workqueue_queue_work: work struct=00000000c344caec function=flush_to_ldisc workqueue=(0xffff888100054d60:events_unbound)[UNSAFE-MEMORY] req_cpu=256 cpu=4294967295
workqueue_queue_work: work struct=00000000b2b235c7 function=gc_worker workqueue=(0xffff888100051160:events_power_efficient)[UNSAFE-MEMORY] req_cpu=256 cpu=1
workqueue_queue_work: work struct=000000000b238b3f function=vmstat_update workqueue=(0xffff8881000c3760:mm_percpu_wq)[UNSAFE-MEMORY] req_cpu=1 cpu=1

Also, if this event is read via a user space application like perf or
trace-cmd, the name would only be an address and useless information:

workqueue_queue_work: work struct=0xffff953f80b4b918 function=disk_events_workfn workqueue=ffff953f8005d378 req_cpu=8192 cpu=5

Cc: stable@vger.kernel.org
Fixes: 7bf9c4a88e3e3 ("workqueue: tracing the name of the workqueue instead of it's address")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

[
  This is another reason I need to get my verifier into the kernel,
  because it would have triggered a WARN_ON() and stopped the broken
  patch from getting in, in the first place.
]

 include/trace/events/workqueue.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 970cc2ea2850..6154a2e72bce 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -30,7 +30,7 @@ TRACE_EVENT(workqueue_queue_work,
 	TP_STRUCT__entry(
 		__field( void *,	work	)
 		__field( void *,	function)
-		__field( const char *,	workqueue)
+		__string( workqueue,	pwq->wq->name)
 		__field( unsigned int,	req_cpu	)
 		__field( unsigned int,	cpu	)
 	),
@@ -38,13 +38,13 @@ TRACE_EVENT(workqueue_queue_work,
 	TP_fast_assign(
 		__entry->work		= work;
 		__entry->function	= work->func;
-		__entry->workqueue	= pwq->wq->name;
+		__assign_str(workqueue, pwq->wq->name);
 		__entry->req_cpu	= req_cpu;
 		__entry->cpu		= pwq->pool->cpu;
 	),
 
 	TP_printk("work struct=%p function=%ps workqueue=%s req_cpu=%u cpu=%u",
-		  __entry->work, __entry->function, __entry->workqueue,
+		  __entry->work, __entry->function, __get_str(workqueue),
 		  __entry->req_cpu, __entry->cpu)
 );
 
-- 
2.29.2

