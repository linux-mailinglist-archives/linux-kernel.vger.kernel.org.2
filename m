Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB24042F6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhJOPKb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Oct 2021 11:10:31 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:51003 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240814AbhJOPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:10:25 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-t5ElakxwMr6d0GBkSdSujQ-1; Fri, 15 Oct 2021 11:08:12 -0400
X-MC-Unique: t5ElakxwMr6d0GBkSdSujQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E712D801AA7;
        Fri, 15 Oct 2021 15:08:10 +0000 (UTC)
Received: from x1.com (unknown [10.22.9.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEC215F4E7;
        Fri, 15 Oct 2021 15:08:08 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] trace/osnoise: Add migrate-disabled field to the osnoise header
Date:   Fri, 15 Oct 2021 17:07:50 +0200
Message-Id: <9cb3d54e29e0588dbba12e81486bd8a09adcd8ca.1634308385.git.bristot@kernel.org>
In-Reply-To: <cover.1634308385.git.bristot@kernel.org>
References: <cover.1634308385.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "54357f0c9149 tracing: Add migrate-disabled counter to tracing
output," the migrate disabled field is also printed in the !PREEMPR_RT
kernel config. While this information was added to the vast majority of
tracers, osnoise and timerlat were not updated (because they are new
tracers).

Fix osnoise header by adding the information about migrate disabled.

Cc: Steven Rostedt <rostedt@goodmis.org>
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
---
 kernel/trace/trace_osnoise.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index ce053619f289..85852819aa0f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -294,19 +294,19 @@ static void print_osnoise_headers(struct seq_file *s)
 	seq_puts(s, "#                                _-----=> irqs-off\n");
 	seq_puts(s, "#                               / _----=> need-resched\n");
 	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
-	seq_puts(s, "#                              || / _--=> preempt-depth     ");
-	seq_puts(s, "                       MAX\n");
-
-	seq_puts(s, "#                              || /                         ");
+	seq_puts(s, "#                              || / _--=> preempt-depth\n");
+	seq_puts(s, "#                              ||| / _-=> migrate-disable     ");
+	seq_puts(s, "                    MAX\n");
+	seq_puts(s, "#                              |||| /     delay               ");
 	seq_puts(s, "                    SINGLE      Interference counters:\n");
 
-	seq_puts(s, "#                              ||||               RUNTIME   ");
+	seq_puts(s, "#                              |||||               RUNTIME   ");
 	seq_puts(s, "   NOISE  %% OF CPU  NOISE    +-----------------------------+\n");
 
-	seq_puts(s, "#           TASK-PID      CPU# ||||   TIMESTAMP    IN US    ");
+	seq_puts(s, "#           TASK-PID      CPU# |||||   TIMESTAMP    IN US    ");
 	seq_puts(s, "   IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD\n");
 
-	seq_puts(s, "#              | |         |   ||||      |           |      ");
+	seq_puts(s, "#              | |         |   |||||      |           |      ");
 	seq_puts(s, "       |    |            |      |      |      |      |      |\n");
 }
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.31.1

