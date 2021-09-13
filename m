Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0114089F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhIMLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239476AbhIMLRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:17:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 054966044F;
        Mon, 13 Sep 2021 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531789;
        bh=jNV4+uB95M6z4uwbC5DehS84fHzc0jpeEIlv/rAD+3A=;
        h=From:To:Cc:Subject:Date:From;
        b=EytRrDtzVG/tiRfq14HgVFT5We5jHq9wa5WwkyB79u1/GRJCqr6dr4ykcNURkxGkr
         sEymK9lTDCG76bHAgzNHpy8FCVIQL1354AM74nm+aVEsAhg/xpPxvIj23CldJhzHx9
         Fh9r6rUN2FCjREUKxu16HhDFCDzEWSou8wvZIo/xEckN23UXOu75jWgB8x/z4MmpMn
         2/K4RBdgcFnegOsb/aY2el8zmmKOUOOp3sqJbHxQTOf/eEaOCdcWRX4UiVLUUiVTSR
         /quyBUqhAyrVkl8EFi0Mvkq9c3/jJSoR8EzASCOhtWjhjA0MDGL8p2LqMHCaId5/Dm
         MIGL+9lyEfPkA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] sched: Provide Kconfig support for default dynamic preempt mode
Date:   Mon, 13 Sep 2021 13:16:23 +0200
Message-Id: <20210913111623.230436-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the boot defined preempt behaviour (aka dynamic preempt)
selects full preemption by default when the "preempt=" boot parameter
is omitted. However distros may rather want to default to either
no preemption or voluntary preemption.

To provide with this flexibility, make dynamic preemption a visible
Kconfig option and adapt the preemption behaviour selected by the user
to either static or dynamic preemption.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/Kconfig.preempt | 31 ++++++++++++++++++++++---------
 kernel/sched/core.c    | 29 ++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 5876e30c5740..0ebf575c5287 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,10 +2,11 @@
 
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
+	default PREEMPT_NONE_BEHAVIOUR
 
-config PREEMPT_NONE
+config PREEMPT_NONE_BEHAVIOUR
 	bool "No Forced Preemption (Server)"
+	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -17,9 +18,10 @@ config PREEMPT_NONE
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY
+config PREEMPT_VOLUNTARY_BEHAVIOUR
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -35,12 +37,10 @@ config PREEMPT_VOLUNTARY
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT
+config PREEMPT_BEHAVIOUR
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +58,7 @@ config PREEMPT
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT
+	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -75,6 +75,17 @@ config PREEMPT_RT
 
 endchoice
 
+config PREEMPT_NONE
+	bool
+
+config PREEMPT_VOLUNTARY
+	bool
+
+config PREEMPT
+	bool
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 config PREEMPT_COUNT
        bool
 
@@ -83,7 +94,9 @@ config PREEMPTION
        select PREEMPT_COUNT
 
 config PREEMPT_DYNAMIC
-	bool
+	bool "Preemption behaviour defined on boot"
+	default y if HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..af2ca7ea7dda 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6586,12 +6586,13 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
  */
 
 enum {
-	preempt_dynamic_none = 0,
+	preempt_dynamic_undefined = -1,
+	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
 };
 
-int preempt_dynamic_mode = preempt_dynamic_full;
+int preempt_dynamic_mode = preempt_dynamic_undefined;
 
 int sched_dynamic_mode(const char *str)
 {
@@ -6664,7 +6665,27 @@ static int __init setup_preempt_mode(char *str)
 }
 __setup("preempt=", setup_preempt_mode);
 
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE_BEHAVIOUR)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_BEHAVIOUR));
+			preempt_dynamic_mode = preempt_dynamic_full;
+			pr_info("Dynamic Preempt: full\n");
+		}
+	}
+}
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
 
 /*
  * This is the entry point to schedule() from kernel preemption
@@ -9464,6 +9485,8 @@ void __init sched_init(void)
 
 	init_uclamp();
 
+	preempt_dynamic_init();
+
 	scheduler_running = 1;
 }
 
-- 
2.25.1

