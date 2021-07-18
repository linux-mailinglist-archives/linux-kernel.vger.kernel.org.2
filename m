Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504703CC861
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhGRKBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:01:06 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.119]:20579 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhGRKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:01:05 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 06:01:05 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 7491D400D6F9C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 04:08:15 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 52mVmiNpYL9qA52mVmCHe1; Sun, 18 Jul 2021 04:08:15 -0500
X-Authority-Reason: nr=8
Received: from host-79-37-206-118.retail.telecomitalia.it ([79.37.206.118]:53030 helo=f34.bristot.me)
        by gator4132.hostgator.com with esmtpa (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1m52mR-001x7t-Kq; Sun, 18 Jul 2021 04:08:11 -0500
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] trace/timerlat: Add a header with PREEMPT_RT additional fields
Date:   Sun, 18 Jul 2021 11:07:54 +0200
Message-Id: <babb83529a3211bd0805be0b8c21608230202c55.1626598844.git.bristot@kernel.org>
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
X-Exim-ID: 1m52mR-001x7t-Kq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-37-206-118.retail.telecomitalia.it (f34.bristot.me) [79.37.206.118]:53030
X-Source-Auth: kernel@bristot.me
X-Email-Count: 10
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 03ef720b491d..518a5c190b2b 100644
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
2.31.1

