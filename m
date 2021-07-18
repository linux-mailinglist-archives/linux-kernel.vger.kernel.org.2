Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8B3CC850
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGRJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 05:33:35 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.250]:35835 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbhGRJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 05:33:33 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 62C7940119615
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 04:08:19 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 52mZmmL3RMGeE52mZmCTDS; Sun, 18 Jul 2021 04:08:19 -0500
X-Authority-Reason: nr=8
Received: from host-79-37-206-118.retail.telecomitalia.it ([79.37.206.118]:53030 helo=f34.bristot.me)
        by gator4132.hostgator.com with esmtpa (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1m52mV-001x7t-Ik; Sun, 18 Jul 2021 04:08:15 -0500
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] trace/osnoise: Print a stop tracing message
Date:   Sun, 18 Jul 2021 11:07:55 +0200
Message-Id: <b30a0d7542adba019185f44ee648e60e14923b11.1626598844.git.bristot@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626598844.git.bristot@kernel.org>
References: <cover.1626598844.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.37.206.118
X-Source-L: No
X-Exim-ID: 1m52mV-001x7t-Ik
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-37-206-118.retail.telecomitalia.it (f34.bristot.me) [79.37.206.118]:53030
X-Source-Auth: kernel@bristot.me
X-Email-Count: 17
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 518a5c190b2b..b61eefe5ccf5 100644
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
2.31.1

