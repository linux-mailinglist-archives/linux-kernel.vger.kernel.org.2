Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73D73CC84F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhGRJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 05:33:34 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.250]:24443 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhGRJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 05:33:33 -0400
X-Greylist: delayed 1344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 05:33:33 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 90607401195EB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 04:08:10 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 52mQmmKyFMGeE52mQmCT8I; Sun, 18 Jul 2021 04:08:10 -0500
X-Authority-Reason: nr=8
Received: from host-79-37-206-118.retail.telecomitalia.it ([79.37.206.118]:53030 helo=f34.bristot.me)
        by gator4132.hostgator.com with esmtpa (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1m52mM-001x7t-OK; Sun, 18 Jul 2021 04:08:07 -0500
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] trace/osnoise: Add a header with PREEMPT_RT additional fields
Date:   Sun, 18 Jul 2021 11:07:53 +0200
Message-Id: <1f03289d2a51fde5a58c2e7def063dc630820ad1.1626598844.git.bristot@kernel.org>
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
X-Exim-ID: 1m52mM-001x7t-OK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-37-206-118.retail.telecomitalia.it (f34.bristot.me) [79.37.206.118]:53030
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a7e3c24dee13..03ef720b491d 100644
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
2.31.1

