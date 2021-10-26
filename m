Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBA43B70F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhJZQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234557AbhJZQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93CB610CB;
        Tue, 26 Oct 2021 16:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEq-000qRC-Q5;
        Tue, 26 Oct 2021 12:23:48 -0400
Message-ID: <20211026162348.633531840@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: [for-next][PATCH 07/12] trace/timerlat: Add migrate-disabled field to the timerlat header
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Since "54357f0c9149 tracing: Add migrate-disabled counter to tracing
output," the migrate disabled field is also printed in the !PREEMPR_RT
kernel config. While this information was added to the vast majority of
tracers, osnoise and timerlat were not updated (because they are new
tracers).

Fix timerlat header by adding the information about migrate disabled.

Link: https://lkml.kernel.org/r/bc0c234ab49946cdd63effa6584e1d5e8662cb44.1634308385.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 54357f0c9149 ("tracing: Add migrate-disabled counter to tracing output.")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 34f26c632442..d11b41784fac 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -378,11 +378,12 @@ static void print_timerlat_headers(struct seq_file *s)
 	seq_puts(s, "#                               / _----=> need-resched\n");
 	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
 	seq_puts(s, "#                              || / _--=> preempt-depth\n");
-	seq_puts(s, "#                              || /\n");
-	seq_puts(s, "#                              ||||             ACTIVATION\n");
-	seq_puts(s, "#           TASK-PID      CPU# ||||   TIMESTAMP    ID     ");
-	seq_puts(s, "       CONTEXT                LATENCY\n");
-	seq_puts(s, "#              | |         |   ||||      |         |      ");
+	seq_puts(s, "#                              ||| / _-=> migrate-disable\n");
+	seq_puts(s, "#                              |||| /     delay\n");
+	seq_puts(s, "#                              |||||            ACTIVATION\n");
+	seq_puts(s, "#           TASK-PID      CPU# |||||   TIMESTAMP   ID      ");
+	seq_puts(s, "      CONTEXT                 LATENCY\n");
+	seq_puts(s, "#              | |         |   |||||      |         |      ");
 	seq_puts(s, "            |                       |\n");
 }
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.33.0
