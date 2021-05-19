Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3644D388D06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351743AbhESLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351744AbhESLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBoptFB/eA2EaHWPLwx+enXV2mYtLtnsaM2sIdiC25k=;
        b=Pu+LjOGUTMNkrqS5JF8WKMVG/xfK6lv9FMa4vGPE2DM/WK22ji1MXCCBsllKboAwVwMgTg
        0iMANQRLIsEZQuoK32YcNrq/Ls6fg64I8BWxZzy97oh8QgK9+e02yp7rEiZKYPxPmzT7jc
        02yqPLKP5f9gL1iM389JWVb1g+UNngw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-XRkfgHzfPQG_5h-GnMgIMg-1; Wed, 19 May 2021 07:38:24 -0400
X-MC-Unique: XRkfgHzfPQG_5h-GnMgIMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 979308015F5;
        Wed, 19 May 2021 11:38:22 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8F51687D3;
        Wed, 19 May 2021 11:38:11 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 09/16] rv/monitors: wip instrumentation and Makefile/Kconfig entries
Date:   Wed, 19 May 2021 13:36:30 +0200
Message-Id: <8ffcb3a4c8b55ef63cc02b487aa1c8ad5bf3f800.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the instrumentation to the previously created wip monitor, as an
example of the developer work. It also adds a Makefile and Kconfig
entries.

This is a good example of the manual work that is left for the
developer to do.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/rv/Kconfig            |  7 +++++++
 kernel/trace/rv/Makefile           |  1 +
 kernel/trace/rv/monitors/wip/wip.c | 16 ++++++++--------
 kernel/trace/rv/monitors/wip/wip.h |  2 +-
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 74eb2f216255..4a1088c5ba68 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -14,6 +14,13 @@ menuconfig RV
 
 if RV
 
+config RV_MON_WIP
+	depends on PREEMPTIRQ_TRACEPOINTS
+	tristate "WIP monitor"
+	help
+	  Enable WIP sample monitor, this is a sample monitor that
+	  illustrates the usage of per-cpu monitors.
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y if RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 8944274d9b41..b41109d2750a 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
+obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 1aec75e683d2..dd35a042e727 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -33,36 +33,36 @@ DECLARE_DA_MON_PER_CPU(wip, char);
  *
  */
 
-void handle_preempt_disable(void *data, /* XXX: fill header */)
+void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
 	da_handle_event_wip(preempt_disable);
 }
 
-void handle_preempt_enable(void *data, /* XXX: fill header */)
+void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_wip(preempt_enable);
+	da_handle_init_event_wip(preempt_enable);
 }
 
-void handle_sched_waking(void *data, /* XXX: fill header */)
+void handle_sched_waking(void *data, struct task_struct *task)
 {
 	da_handle_event_wip(sched_waking);
 }
 
-#define NR_TP   3
+#define NR_TP	3
 static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
 	{
 		.probe = handle_preempt_disable,
-		.name = /* XXX: tracepoint name here */,
+		.name = "preempt_disable",
 		.registered = 0
 	},
 	{
 		.probe = handle_preempt_enable,
-		.name = /* XXX: tracepoint name here */,
+		.name = "preempt_enable",
 		.registered = 0
 	},
 	{
 		.probe = handle_sched_waking,
-		.name = /* XXX: tracepoint name here */,
+		.name = "sched_wakeup",
 		.registered = 0
 	},
 };
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index 7a751a8896e9..f980b5e85940 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -59,6 +59,6 @@ TRACE_EVENT(error_wip,
 
 /* This part ust be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../kernel/trace/rv/monitors/wip/
 #define TRACE_INCLUDE_FILE wip
 #include <trace/define_trace.h>
-- 
2.26.2

