Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38263E9BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHLBO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhHLBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F54C610CF;
        Thu, 12 Aug 2021 01:13:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mDzIB-003pGw-6k; Wed, 11 Aug 2021 21:13:55 -0400
Message-ID: <20210812011355.049731952@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Aug 2021 21:12:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 4/7] trace/osnoise: Print a stop tracing message
References: <20210812011250.954353252@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

When using osnoise/timerlat with stop tracing, sometimes it is
not clear in which CPU the stop condition was hit, mainly
when using some extra events.

Print a message informing in which CPU the trace stopped, like
in the example below:

          <idle>-0       [006] d.h.  2932.676616: #1672599 context    irq timer_latency     34689 ns
          <idle>-0       [006] dNh.  2932.676618: irq_noise: local_timer:236 start 2932.676615639 duration 2391 ns
          <idle>-0       [006] dNh.  2932.676620: irq_noise: virtio0-output.0:47 start 2932.676620180 duration 86 ns
          <idle>-0       [003] d.h.  2932.676621: #1673374 context    irq timer_latency      1200 ns
          <idle>-0       [006] d...  2932.676623: thread_noise: swapper/6:0 start 2932.676615964 duration 4339 ns
          <idle>-0       [003] dNh.  2932.676623: irq_noise: local_timer:236 start 2932.676620597 duration 1881 ns
          <idle>-0       [006] d...  2932.676623: sched_switch: prev_comm=swapper/6 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=timerlat/6 next_pid=852 next_prio=4
      timerlat/6-852     [006] ....  2932.676623: #1672599 context thread timer_latency     41931 ns
          <idle>-0       [003] d...  2932.676623: thread_noise: swapper/3:0 start 2932.676620854 duration 880 ns
          <idle>-0       [003] d...  2932.676624: sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=timerlat/3 next_pid=849 next_prio=4
      timerlat/6-852     [006] ....  2932.676624: timerlat_main: stop tracing hit on cpu 6
      timerlat/3-849     [003] ....  2932.676624: #1673374 context thread timer_latency      4310 ns

Link: https://lkml.kernel.org/r/b30a0d7542adba019185f44ee648e60e14923b11.1626598844.git.bristot@kernel.org

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f9652278bd10..b576e96d9741 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1075,9 +1075,13 @@ diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *
 /*
  * osnoise_stop_tracing - Stop tracing and the tracer.
  */
-static void osnoise_stop_tracing(void)
+static __always_inline void osnoise_stop_tracing(void)
 {
 	struct trace_array *tr = osnoise_trace;
+
+	trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
+			"stop tracing hit on cpu %d\n", smp_processor_id());
+
 	tracer_tracing_off(tr);
 }
 
-- 
2.30.2
