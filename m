Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C140BE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhIODxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhIODxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:53:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F3C061768
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n30so1479953pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D7wwV9A8hOS3bHMonP493eHo3ii1Zb9/f1nywqD1lQ=;
        b=mIGQIFQKgI2AI0owZgvTAW5tYBU+xgbyw8L/jwH0VJPCb7t1BADYZRPI/2+iN082+j
         lUBOS+5Ib9t37pZ4LbxU76Nvy64CBD/xujxvdnbHO7yxEKMametVrCEqCd/Ov9fx5Ea0
         Xnxgx2nzJoqqrfAZaWalWNH/XkE4UPFf/KSJN5x6P/uDpmRvthjBSh8oxe+qYZiCXm+A
         9F/MZllk6ZUBrfzTYMbqRtQ1QwdsRUkw4TX2Bmpl0gtXGhuKYDfA+jc42Ezmmt3c333C
         09XDyYfj9h+jRWPb46CZEuxvzzpAenH2Nidk8KPi8xDffH9xCGs7E71Nz1Z9nD77+VKT
         VAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D7wwV9A8hOS3bHMonP493eHo3ii1Zb9/f1nywqD1lQ=;
        b=x2o4fA4TBnPLKL26g0qByGKOumzpd6n91NbSNMlLKP6Ivp3pkaNw/HOCIY7JutqGTe
         duJ0qRmwNHlIuC/jtBlABYiiJmohyRuR/1I57k71Mlb+KanZtS96fb8HaxYtn/NvBZzY
         CqpiaExndfcVEXrHnqW221CdP1d1dH+dq+sa+POmdcbbWTpXtYbk5PcASC5SixLeqKBt
         at6eI1q5o7DUopzErLKri4TDNciFaGrR5nWOAzxRDUiabX1NVpFo8nmRd6nmRRP4c+ol
         /PCyJ6Jq8202WBqLbRVZvS5rK4xUvB8xMxQpxcUdwf68gM6ktF8kbmMuKiVamyO0Qvil
         iYmw==
X-Gm-Message-State: AOAM531TLx+6oSd2Gy+2ljOBhkvnNXDws0Gtjv8p6YnRZYKmtJC7mUz/
        FtCUXUPT9U5tNqTGUX3xWA==
X-Google-Smtp-Source: ABdhPJy6c1uH9pGXaEDPt441Ud4f45h8uX+sf3aDZWFowAIFvH285EtKCCcrMoqBKYE9t15iR2XvEA==
X-Received: by 2002:aa7:9596:0:b0:43e:48:dbeb with SMTP id z22-20020aa79596000000b0043e0048dbebmr6617575pfj.77.1631677907032;
        Tue, 14 Sep 2021 20:51:47 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm8602357pfp.133.2021.09.14.20.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 20:51:46 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64/watchdog_hld: enable hard lockup on arm64 platform
Date:   Wed, 15 Sep 2021 11:51:03 +0800
Message-Id: <20210915035103.15586-6-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915035103.15586-1-kernelfans@gmail.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With watchdog_hld armed with the async model, arm64 can probe and enable
perf NMI after smp_init(). At the boot stage, all of cpus arm hard
lockup detector in the async model.

In this patch, the function hw_nmi_get_sample_period() is borrowed from
[1], credit goes to Sumit.

[1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Julien Thierry <jthierry@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/Kconfig                  |  3 ++
 arch/arm64/include/asm/perf_event.h |  5 ++
 arch/arm64/kernel/Makefile          |  1 +
 arch/arm64/kernel/perf_event.c      | 14 ++++-
 arch/arm64/kernel/watchdog_hld.c    | 83 +++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c              |  5 ++
 6 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 62c3c1d2190f..0f49e58a9dd8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -193,6 +193,9 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PERF_EVENTS_NMI
+	select HAVE_HARDLOCKUP_DETECTOR_PERF \
+		if PERF_EVENTS && HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUTEX_CMPXCHG if FUTEX
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 4ef6f19331f9..712a75f432f0 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -6,6 +6,7 @@
 #ifndef __ASM_PERF_EVENT_H
 #define __ASM_PERF_EVENT_H
 
+#include <linux/wait.h>
 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
 
@@ -259,4 +260,8 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
 
+extern bool arm_pmu_initialized;
+extern wait_queue_head_t arm_pmu_wait;
+extern bool check_pmu_nmi_ability(void);
+
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3f1490bfb938..789c2fe5bb90 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index d07788dad388..c4144cea0d55 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -24,6 +24,9 @@
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
 
+bool arm_pmu_initialized;
+DECLARE_WAIT_QUEUE_HEAD(arm_pmu_wait);
+
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
 
@@ -1284,10 +1287,17 @@ static struct platform_driver armv8_pmu_driver = {
 
 static int __init armv8_pmu_driver_init(void)
 {
+	int ret;
+
 	if (acpi_disabled)
-		return platform_driver_register(&armv8_pmu_driver);
+		ret = platform_driver_register(&armv8_pmu_driver);
 	else
-		return arm_pmu_acpi_probe(armv8_pmuv3_init);
+		ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
+
+	arm_pmu_initialized = true;
+	wake_up_all(&arm_pmu_wait);
+
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..18bfa62f1058
--- /dev/null
+++ b/arch/arm64/kernel/watchdog_hld.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/nmi.h>
+#include <linux/cpufreq.h>
+#include <asm/perf_event.h>
+
+/*
+ * Safe maximum CPU frequency in case a particular platform doesn't implement
+ * cpufreq driver. Although, architecture doesn't put any restrictions on
+ * maximum frequency but 5 GHz seems to be safe maximum given the available
+ * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
+ * hand, we can't make it much higher as it would lead to a large hard-lockup
+ * detection timeout on parts which are running slower (eg. 1GHz on
+ * Developerbox) and doesn't possess a cpufreq driver.
+ */
+#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long max_cpu_freq;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		max_cpu_freq = SAFE_MAX_CPU_FREQ;
+
+	return (u64)max_cpu_freq * watchdog_thresh;
+}
+
+static watchdog_nmi_status_reporter status_reporter;
+
+static int hld_enabled_thread_fun(void *unused)
+{
+	struct watchdog_nmi_status status;
+	watchdog_nmi_status_reporter local_reporter;
+	int ret;
+
+	wait_event(arm_pmu_wait, arm_pmu_initialized);
+	status.cpu = raw_smp_processor_id();
+
+	if (!check_pmu_nmi_ability()) {
+		status.status = -ENODEV;
+		goto report;
+	}
+
+	ret = hardlockup_detector_perf_enable();
+	status.status = ret;
+
+report:
+	local_reporter = (watchdog_nmi_status_reporter)atomic64_fetch_and(0,
+				(atomic64_t *)&status_reporter);
+	if (local_reporter)
+		(*local_reporter)(&status);
+
+	return 0;
+}
+
+/* As for watchdog_nmi_disable(), using the default implement */
+void watchdog_nmi_enable(unsigned int cpu)
+{
+	struct task_struct *t;
+
+	/* PMU is not ready */
+	if (!arm_pmu_initialized) {
+		t = kthread_create_on_cpu(hld_enabled_thread_fun, NULL, cpu,
+			       "arm64_hld.%u");
+		if (IS_ERR(t))
+			return;
+		wake_up_process(t);
+		return;
+	}
+
+	/* For hotplug in cpu */
+	hardlockup_detector_perf_enable();
+}
+
+int __init watchdog_nmi_probe(watchdog_nmi_status_reporter notifier)
+{
+	/* On arm64, arm pmu is not ready at this stage */
+	status_reporter = notifier;
+	return -EBUSY;
+}
+
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 3cbc3baf087f..e08961b37922 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -105,6 +105,11 @@ static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
 static bool has_nmi;
 
+bool check_pmu_nmi_ability(void)
+{
+	return has_nmi;
+}
+
 static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
 	if (event->hw.flags & ARMPMU_EVT_64BIT)
-- 
2.31.1

