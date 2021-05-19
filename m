Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36773388D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhESLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238729AbhESLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dHWHuRSH+7iwbu0N3JZSeg8TiEuaJcTzc0Ua1Omi0I=;
        b=T3eMZzVVkembbPaVj1Id6XDVZoVXQxzUk7esIPUS/qeyvW8sVp/XK55vowGxFB/eN9DGuP
        N1eaNhKdZePIGNQx80/AEvGY4mh+Z8E90Sn4qY3u0V+BSM733pvhSAJkx1N5HDIE3gveLx
        mZgwYmcGghrCSh+EikxCooHPdAA8ZBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-W3mE0uUYN4qrnSuGj4mqLQ-1; Wed, 19 May 2021 07:38:55 -0400
X-MC-Unique: W3mE0uUYN4qrnSuGj4mqLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A230801817;
        Wed, 19 May 2021 11:38:53 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A97966090F;
        Wed, 19 May 2021 11:38:29 +0000 (UTC)
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
Subject: [RFC PATCH 11/16] rv/monitors: wwnr instrumentation and Makefile/Kconfig entries
Date:   Wed, 19 May 2021 13:36:32 +0200
Message-Id: <879c2e3f03baefcda72e5923d9a16f340edeccca.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the instrumentation to the previously created wwnr monitor, as an
example of the developer work. It also adds a Makefile and Kconfig
entries.

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
 kernel/trace/rv/Kconfig              |  7 ++++++
 kernel/trace/rv/Makefile             |  1 +
 kernel/trace/rv/monitors/wwnr/wwnr.c | 35 ++++++++++++----------------
 kernel/trace/rv/monitors/wwnr/wwnr.h |  2 +-
 4 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 4a1088c5ba68..612b36b97663 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -21,6 +21,13 @@ config RV_MON_WIP
 	  Enable WIP sample monitor, this is a sample monitor that
 	  illustrates the usage of per-cpu monitors.
 
+config RV_MON_WWNR
+	tristate "WWNR monitor"
+	help
+	  Enable WWNR sample monitor, this is a sample monitor that
+	  illustrates the usage of per-task monitor. The model is
+	  broken on purpose: it serves to test reactors.
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y if RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index b41109d2750a..af0ff9a46418 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
+obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 91cb3b70a6a7..cb364a02639b 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -33,39 +33,34 @@ DECLARE_DA_MON_PER_TASK(wwnr, char);
  *
  */
 
-void handle_switch_in(void *data, /* XXX: fill header */)
+static void handle_switch(void *data, bool preempt, struct task_struct *p, struct task_struct *n)
 {
-	pid_t pid = /* XXX how do I get the pid? */;
-	da_handle_event_wwnr(pid, switch_in);
-}
+	int ppid = p->pid;
+	int npid = n->pid;
 
-void handle_switch_out(void *data, /* XXX: fill header */)
-{
-	pid_t pid = /* XXX how do I get the pid? */;
-	da_handle_event_wwnr(pid, switch_out);
+	if (ppid && ppid < MAX_PID)
+		da_handle_init_event_wwnr(ppid, switch_out);
+
+	if (npid && npid < MAX_PID)
+		da_handle_event_wwnr(npid, switch_in);
 }
 
-void handle_wakeup(void *data, /* XXX: fill header */)
+static void handle_wakeup(void *data, struct task_struct *p)
 {
-	pid_t pid = /* XXX how do I get the pid? */;
-	da_handle_event_wwnr(pid, wakeup);
+	if (p->pid && p->pid < MAX_PID)
+		da_handle_event_wwnr(p->pid, wakeup);
 }
 
-#define NR_TP   3
+#define NR_TP	2
 static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
 	{
-		.probe = handle_switch_in,
-		.name = /* XXX: tracepoint name here */,
-		.registered = 0
-	},
-	{
-		.probe = handle_switch_out,
-		.name = /* XXX: tracepoint name here */,
+		.probe = handle_switch,
+		.name = "sched_switch",
 		.registered = 0
 	},
 	{
 		.probe = handle_wakeup,
-		.name = /* XXX: tracepoint name here */,
+		.name = "sched_wakeup",
 		.registered = 0
 	},
 };
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index 4af1827d2f16..ed817952821e 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -65,6 +65,6 @@ TRACE_EVENT(error_wwnr,
 
 /* This part ust be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../kernel/trace/rv/monitors/wwnr/
 #define TRACE_INCLUDE_FILE wwnr
 #include <trace/define_trace.h>
-- 
2.26.2

