Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE93E9BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhHLBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbhHLBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071D0610A7;
        Thu, 12 Aug 2021 01:13:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mDzIB-003pGO-0v; Wed, 11 Aug 2021 21:13:55 -0400
Message-ID: <20210812011354.866620020@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Aug 2021 21:12:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 3/7] trace/timerlat: Add a header with PREEMPT_RT additional fields
References: <20210812011250.954353252@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Some extra flags are printed to the trace header when using the
PREEMPT_RT config. The extra flags are: need-resched-lazy,
preempt-lazy-depth, and migrate-disable.

Without printing these fields, the timerlat specific fields are
shifted by three positions, for example:

 # tracer: timerlat
 #
 #                                _-----=> irqs-off
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              || /
 #                              ||||             ACTIVATION
 #           TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
 #              | |         |   ||||      |         |                  |                       |
           <idle>-0       [000] d..h...  3279.798871: #1     context    irq timer_latency       830 ns
            <...>-807     [000] .......  3279.798881: #1     context thread timer_latency     11301 ns

Add a new header for timerlat with the missing fields, to be used
when the PREEMPT_RT is enabled.

Link: https://lkml.kernel.org/r/babb83529a3211bd0805be0b8c21608230202c55.1626598844.git.bristot@kernel.org

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index cbdda2fe4926..f9652278bd10 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -354,6 +354,24 @@ static void trace_osnoise_sample(struct osnoise_sample *sample)
 /*
  * Print the timerlat header info.
  */
+#ifdef CONFIG_PREEMPT_RT
+static void print_timerlat_headers(struct seq_file *s)
+{
+	seq_puts(s, "#                                _-------=> irqs-off\n");
+	seq_puts(s, "#                               / _------=> need-resched\n");
+	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
+	seq_puts(s, "#                              || / _----=> hardirq/softirq\n");
+	seq_puts(s, "#                              ||| / _---=> preempt-depth\n");
+	seq_puts(s, "#                              |||| / _--=> preempt-lazy-depth\n");
+	seq_puts(s, "#                              ||||| / _-=> migrate-disable\n");
+	seq_puts(s, "#                              |||||| /\n");
+	seq_puts(s, "#                              |||||||             ACTIVATION\n");
+	seq_puts(s, "#           TASK-PID      CPU# |||||||   TIMESTAMP    ID     ");
+	seq_puts(s, "       CONTEXT                LATENCY\n");
+	seq_puts(s, "#              | |         |   |||||||      |         |      ");
+	seq_puts(s, "            |                       |\n");
+}
+#else /* CONFIG_PREEMPT_RT */
 static void print_timerlat_headers(struct seq_file *s)
 {
 	seq_puts(s, "#                                _-----=> irqs-off\n");
@@ -367,6 +385,7 @@ static void print_timerlat_headers(struct seq_file *s)
 	seq_puts(s, "#              | |         |   ||||      |         |      ");
 	seq_puts(s, "            |                       |\n");
 }
+#endif /* CONFIG_PREEMPT_RT */
 
 /*
  * Record an timerlat_sample into the tracer buffer.
-- 
2.30.2
