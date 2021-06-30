Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2F3B8ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhF3XVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235717AbhF3XUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:20:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 892DD61477;
        Wed, 30 Jun 2021 23:18:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyjTK-000ZDq-I9; Wed, 30 Jun 2021 19:18:22 -0400
Message-ID: <20210630231822.405224806@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 19:18:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 3/5] trace/timerlat: Fix indentation on timerlat_main()
References: <20210630231758.861158022@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

Dan Carpenter reported that:

 The patch a955d7eac177: "trace: Add timerlat tracer" from Jun 22,
 2021, leads to the following static checker warning:

	kernel/trace/trace_osnoise.c:1400 timerlat_main()
	warn: inconsistent indenting

here:
  1389          while (!kthread_should_stop()) {
  1390                  now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
  1391                  diff = now - tlat->abs_period;
  1392
  1393                  s.seqnum = tlat->count;
  1394                  s.timer_latency = diff;
  1395                  s.context = THREAD_CONTEXT;
  1396
  1397                  trace_timerlat_sample(&s);
  1398
  1399  #ifdef CONFIG_STACKTRACE
  1400          if (osnoise_data.print_stack)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    This should be indented another tab?

  1401                  if (osnoise_data.print_stack <= time_to_us(diff))
  1402                          timerlat_dump_stack();
  1403  #endif /* CONFIG_STACKTRACE */
  1404
  1405                  tlat->tracing_thread = false;
  1406                  if (osnoise_data.stop_tracing_total)
  1407                          if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
  1408                                  osnoise_stop_tracing();
  1409
  1410                  wait_next_period(tlat);
  1411          }

And the static checker is right. Fix the indentation.

Link: https://lkml.kernel.org/r/3d5d8c9258fbdcfa9d3c7362941b3d13a2a28d9d.1624986368.git.bristot@redhat.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org
Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index cc1faca1a620..a7e3c24dee13 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1403,9 +1403,9 @@ static int timerlat_main(void *data)
 		trace_timerlat_sample(&s);
 
 #ifdef CONFIG_STACKTRACE
-	if (osnoise_data.print_stack)
-		if (osnoise_data.print_stack <= time_to_us(diff))
-			timerlat_dump_stack();
+		if (osnoise_data.print_stack)
+			if (osnoise_data.print_stack <= time_to_us(diff))
+				timerlat_dump_stack();
 #endif /* CONFIG_STACKTRACE */
 
 		tlat->tracing_thread = false;
-- 
2.30.2
