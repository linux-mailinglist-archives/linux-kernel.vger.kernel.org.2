Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93839F5FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhFHMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232054AbhFHMGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:06:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CBAC6135D;
        Tue,  8 Jun 2021 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623153891;
        bh=4qy1tuS9F33nYFqxuDssbOs1h0iTpI0TIiQpwxJ8aU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzJbszoDneJ3K1UTMqcu//IvyTNGtNr2y4mbx7Li1AaayXz9fjsU22APJfnx46m5c
         k9IJbUSw03t3vSO98dOkfZM9H8EQQ+d1yh/3+4FSTZH3ZVjf0JW14YWxcts2FO9++Y
         mLupABsfs8kYwdb7QyER9E66QB+oC5YGkGs93Wc9Z/vuVnIlgvrNiJxK5C2QjCt1xA
         kefIXJnVYrBkVh1dwgvcqrZ4JgFISpoFI9nFoPEUnoyT13MHEImLsgITsWOVO1U17w
         ir7lLUhgKQyDoOlvshmmNDwFA0iooe07N2iDR2wP6R/TaHJd+474saX6Oa0fxvviBD
         PlBOvs0x/GljQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Date:   Tue,  8 Jun 2021 14:04:41 +0200
Message-Id: <20210608120442.93587-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608120442.93587-1-frederic@kernel.org>
References: <20210608120442.93587-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the default behaviour for CONFIG_PREEMPT_DYNAMIC is
preempt=full. So distros always have to override that with the boot
option if it's not their default choice.

Make things more convenient for them with providing that choice at
Kconfig time.

This should also encourage automatic testing robots relying on randconfig
to run through all the various preempt dynamic flavours.

(Unfortunately this involved copy-pasting help text for static PREEMPT
Kconfig entries. Perhaps referring to them would be enough?)

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/Kconfig.preempt | 53 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c    | 23 +++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c4147b9a8..384110d1a215 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -100,6 +100,59 @@ config PREEMPT_DYNAMIC
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
 
+choice
+	prompt "Preemption dynamic default boot mode"
+	default PREEMPT_DYNAMIC_FULL
+	depends on PREEMPT_DYNAMIC
+
+config PREEMPT_DYNAMIC_NONE
+	bool "Default boot with no Forced Preemption (Server)"
+	help
+	  This is the traditional Linux preemption model, geared towards
+	  throughput. It will still provide good latencies most of the
+	  time, but there are no guarantees and occasional longer delays
+	  are possible.
+
+	  Select this option if you are building a kernel for a server or
+	  scientific/computation system, or if you want to maximize the
+	  raw processing power of the kernel, irrespective of scheduling
+	  latencies.
+
+config PREEMPT_DYNAMIC_VOLUNTARY
+	bool "Default boot with Voluntary Kernel Preemption (Desktop)"
+	help
+	  This option reduces the latency of the kernel by adding more
+	  "explicit preemption points" to the kernel code. These new
+	  preemption points have been selected to reduce the maximum
+	  latency of rescheduling, providing faster application reactions,
+	  at the cost of slightly lower throughput.
+
+	  This allows reaction to interactive events by allowing a
+	  low priority process to voluntarily preempt itself even if it
+	  is in kernel mode executing a system call. This allows
+	  applications to run more 'smoothly' even when the system is
+	  under load.
+
+	  Select this if you are building a kernel for a desktop system.
+
+config PREEMPT_DYNAMIC_FULL
+	bool "Default boot with Preemptible Kernel (Low-Latency Desktop)"
+	help
+	  This option reduces the latency of the kernel by making
+	  all kernel code (that is not executing in a critical section)
+	  preemptible.  This allows reaction to interactive events by
+	  permitting a low priority process to be preempted involuntarily
+	  even if it is in kernel mode executing a system call and would
+	  otherwise not be about to reach a natural preemption point.
+	  This allows applications to run more 'smoothly' even when the
+	  system is under load, at the cost of slightly lower throughput
+	  and a slight runtime overhead to kernel code.
+
+	  Select this if you are building a kernel for a desktop or
+	  embedded system with latency requirements in the milliseconds
+	  range.
+endchoice
+
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	default y
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e9a5be35cde..df47a8275c37 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6238,6 +6238,14 @@ enum {
 
 int preempt_dynamic_mode = preempt_dynamic_full;
 
+#if defined(CONFIG_PREEMPT_DYNAMIC_FULL)
+static __initdata int preempt_dynamic_mode_init = preempt_dynamic_full;
+#elif defined(CONFIG_PREEMPT_DYNAMIC_VOLUNTARY)
+static __initdata int preempt_dynamic_mode_init = preempt_dynamic_voluntary;
+#elif defined(CONFIG_PREEMPT_DYNAMIC_NONE)
+static __initdata int preempt_dynamic_mode_init = preempt_dynamic_none;
+#endif
+
 int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
@@ -6254,6 +6262,9 @@ int sched_dynamic_mode(const char *str)
 
 void sched_dynamic_update(int mode)
 {
+	if (preempt_dynamic_mode == mode)
+		return;
+
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
@@ -6304,13 +6315,22 @@ static int __init setup_preempt_mode(char *str)
 		return 1;
 	}
 
-	sched_dynamic_update(mode);
+	preempt_dynamic_mode_init = mode;
+
 	return 0;
 }
 __setup("preempt=", setup_preempt_mode);
 
+static void __init init_preempt(void)
+{
+	if (preempt_dynamic_mode_init != preempt_dynamic_full)
+		sched_dynamic_update(preempt_dynamic_mode_init);
+}
+#else
+static inline void init_preempt(void) { }
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
@@ -9079,6 +9099,7 @@ void __init sched_init(void)
 	psi_init();
 
 	init_uclamp();
+	init_preempt();
 
 	scheduler_running = 1;
 }
-- 
2.25.1

