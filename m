Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B293B718E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhF2Lvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233536AbhF2LvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E3861D2B;
        Tue, 29 Jun 2021 11:48:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEV-000SXk-4X; Tue, 29 Jun 2021 07:48:51 -0400
Message-ID: <20210629114850.975139884@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 1/6] tracing: Have osnoise_main() add a quiescent state for task rcu
References: <20210629114811.473560262@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

ftracetest triggered:

 INFO: rcu_tasks detected stalls on tasks:
 00000000b92b832d: .. nvcsw: 1/1 holdout: 1 idle_cpu: -1/7
 task:osnoise/7       state:R  running task     stack:    0 pid: 2133 ppid:     2 flags:0x00004000
 Call Trace:
  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
  ? trace_hardirqs_on+0x2b/0xe0
  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
  ? trace_clock_local+0xc/0x20
  ? osnoise_main+0x10e/0x450
  ? trace_softirq_entry_callback+0x50/0x50
  ? kthread+0x153/0x170
  ? __kthread_bind_mask+0x60/0x60
  ? ret_from_fork+0x22/0x30

While running osnoise tracer with other tracers that rely on
synchronize_rcu_tasks(), where that just hung.

The reason is that osnoise_main() never schedules out if the interval
is less than 1, and this will cause synchronize_rcu_tasks() to never
return.

Link: https://lkml.kernel.org/r/20210628114953.6dc06a91@oasis.local.home

Fixes: bce29ac9ce0bb ("trace: Add osnoise tracer")
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 38aa5e208ffd..556d530af805 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1216,8 +1216,11 @@ static int osnoise_main(void *data)
 		 * differently from hwlat_detector, the osnoise tracer can run
 		 * without a pause because preemption is on.
 		 */
-		if (interval < 1)
+		if (interval < 1) {
+			/* Let synchronize_rcu_tasks() make progress */
+			cond_resched_tasks_rcu_qs();
 			continue;
+		}
 
 		if (msleep_interruptible(interval))
 			break;
-- 
2.30.2
