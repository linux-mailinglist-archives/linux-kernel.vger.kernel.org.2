Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F023E9BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhHLBOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhHLBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0226610A3;
        Thu, 12 Aug 2021 01:13:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mDzIA-003pFq-RA; Wed, 11 Aug 2021 21:13:54 -0400
Message-ID: <20210812011354.680710117@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Aug 2021 21:12:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 2/7] trace/osnoise: Add a header with PREEMPT_RT additional fields
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

Without printing these fields, the osnoise specific fields are
shifted by three positions, for example:

 # tracer: osnoise
 #
 #                                _-----=> irqs-off
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth                            MAX
 #                              || /                                             SINGLE      Interference counters:
 #                              ||||               RUNTIME      NOISE  %% OF CPU  NOISE    +-----------------------------+
 #           TASK-PID      CPU# ||||   TIMESTAMP    IN US       IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD
 #              | |         |   ||||      |           |             |    |            |      |      |      |      |      |
            <...>-741     [000] .......  1105.690909: 1000000        234  99.97660      36     21      0   1001     22      3
            <...>-742     [001] .......  1105.691923: 1000000        281  99.97190     197      7      0   1012     35     14
            <...>-743     [002] .......  1105.691958: 1000000       1324  99.86760     118     11      0   1016    155    143
            <...>-744     [003] .......  1105.691998: 1000000        109  99.98910      21      4      0   1004     33      7
            <...>-745     [004] .......  1105.692015: 1000000       2023  99.79770      97     37      0   1023     52     18

Add a new header for osnoise with the missing fields, to be used
when the PREEMPT_RT is enabled.

Link: https://lkml.kernel.org/r/1f03289d2a51fde5a58c2e7def063dc630820ad1.1626598844.git.bristot@kernel.org

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 912036d6a668..cbdda2fe4926 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -253,10 +253,40 @@ static struct osnoise_data {
  */
 static bool osnoise_busy;
 
+#ifdef CONFIG_PREEMPT_RT
 /*
  * Print the osnoise header info.
  */
 static void print_osnoise_headers(struct seq_file *s)
+{
+	if (osnoise_data.tainted)
+		seq_puts(s, "# osnoise is tainted!\n");
+
+	seq_puts(s, "#                                _-------=> irqs-off\n");
+	seq_puts(s, "#                               / _------=> need-resched\n");
+	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
+	seq_puts(s, "#                              || / _----=> hardirq/softirq\n");
+	seq_puts(s, "#                              ||| / _---=> preempt-depth\n");
+	seq_puts(s, "#                              |||| / _--=> preempt-lazy-depth\n");
+	seq_puts(s, "#                              ||||| / _-=> migrate-disable\n");
+
+	seq_puts(s, "#                              |||||| /          ");
+	seq_puts(s, "                                     MAX\n");
+
+	seq_puts(s, "#                              ||||| /                         ");
+	seq_puts(s, "                    SINGLE      Interference counters:\n");
+
+	seq_puts(s, "#                              |||||||               RUNTIME   ");
+	seq_puts(s, "   NOISE  %% OF CPU  NOISE    +-----------------------------+\n");
+
+	seq_puts(s, "#           TASK-PID      CPU# |||||||   TIMESTAMP    IN US    ");
+	seq_puts(s, "   IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD\n");
+
+	seq_puts(s, "#              | |         |   |||||||      |           |      ");
+	seq_puts(s, "       |    |            |      |      |      |      |      |\n");
+}
+#else /* CONFIG_PREEMPT_RT */
+static void print_osnoise_headers(struct seq_file *s)
 {
 	if (osnoise_data.tainted)
 		seq_puts(s, "# osnoise is tainted!\n");
@@ -279,6 +309,7 @@ static void print_osnoise_headers(struct seq_file *s)
 	seq_puts(s, "#              | |         |   ||||      |           |      ");
 	seq_puts(s, "       |    |            |      |      |      |      |      |\n");
 }
+#endif /* CONFIG_PREEMPT_RT */
 
 /*
  * osnoise_taint - report an osnoise error.
-- 
2.30.2
