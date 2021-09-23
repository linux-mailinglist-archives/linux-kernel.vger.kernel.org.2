Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD44160CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbhIWOMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbhIWOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:12:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE53C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v19so4548136pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZysB6B1fylvRcmjz+YxzcufocnP0eHTmJAB2LpWg6Q=;
        b=Vi+vH7BW/f9VkQhaVR+mOMIWqOBrDWTonxYSwBG/fXNPufRSitagCVDzDz26pYzYtD
         b2IvZv6z0SFcV/PGMFaurJpxqlYyHFqyzqQNSQhMFw6j7XYSV8umsByWG0CJ7/zVtyOJ
         Tco/fohEUcE0FRCNeCKgMAyZoJUCyal0JCuMhc3wlXFaJpoTK2RCGlRVsSO7QWgJz/1i
         /pH1+nC3euSXAbTQjIRA2baOFApcIsGzZAoW2A7lT4eUW+vAoh4Pw7Gk+z/URz3RPYsB
         VRQhRPNe1TdCHH9KwHqLUAk6fZ0mmhAad9SLOx4YZ0hVbJIm3KRWq6wZjcI1onMkZxf6
         I3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZysB6B1fylvRcmjz+YxzcufocnP0eHTmJAB2LpWg6Q=;
        b=x2K3K3yWKrURCiJ3ZqD5aOL8gR3vmIR3msyNK7xuRLJD+IOEzNmMqroUcqBNb+FWdJ
         dlEwZ98nzdawvVBFF5c3pHvmq18IHbiJn39XgzegTNLwKZXHmpA476Ye2c6kE7/CepZS
         YwqjM/EyPCNPoqP503yT9scZ5gwYdfuGsit//4YzZfdSKAeExIAYIvmtJcrM2ewqrrVy
         HeJyicK9N/0RqiCDwAsuMlTybzE0Jhn0Fo6MzDm/OMEkn6JcD6iJ3w0OK3wlb7NlLv21
         cPpnVGdljLdLFc8yNrt/qdnYOthaCuBtjIlTTB2eNycswt82YQjlJ0TRVA8+Kv6HUcWf
         tFfw==
X-Gm-Message-State: AOAM5315w1D9Imc91Hvh5dObGdQNlkwljnhAS/ymXNOWda8eMdHs0DQV
        ulN/4ZyJu6tRcEqSisCgLg==
X-Google-Smtp-Source: ABdhPJzjrZs3XaHoleg1SXJxNrF68ViHeoZETQNt13Q41Kiwy9o56HgaZSsQ66w+fanThAzaApD9qA==
X-Received: by 2002:a17:90a:f2cd:: with SMTP id gt13mr5597806pjb.153.1632406243141;
        Thu, 23 Sep 2021 07:10:43 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm5800766pfn.107.2021.09.23.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:10:42 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 4/4] arm64: Enable perf events based hard lockup detector
Date:   Thu, 23 Sep 2021 22:09:51 +0800
Message-Id: <20210923140951.35902-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923140951.35902-1-kernelfans@gmail.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

With the recent feature added to enable perf events to use pseudo NMIs
as interrupts on platforms which support GICv3 or later, its now been
possible to enable hard lockup detector (or NMI watchdog) on arm64
platforms. So enable corresponding support.

One thing to note here is that normally lockup detector is initialized
just after the early initcalls but PMU on arm64 comes up much later as
device_initcall(). So we need to re-initialize lockup detection once
PMU has been initialized.

[1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
(Pingfan: adapt it to watchdog_hld async model based on [1])
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/perf_event.c   | 11 ++++++++--
 arch/arm64/kernel/watchdog_hld.c | 36 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c           |  5 +++++
 include/linux/perf/arm_pmu.h     |  2 ++
 6 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..8287e9e1d28d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -189,6 +189,8 @@ config ARM64
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
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
index b4044469527e..a34343d0f418 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
+#include <linux/nmi.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
@@ -1284,10 +1285,16 @@ static struct platform_driver armv8_pmu_driver = {
 
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
+	hld_detector_delay_initialized = true;
+	wake_up(&hld_detector_wait);
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..379743e0d001
--- /dev/null
+++ b/arch/arm64/kernel/watchdog_hld.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/nmi.h>
+#include <linux/cpufreq.h>
+#include <linux/perf/arm_pmu.h>
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
+int __init watchdog_nmi_probe(void)
+{
+	if (!hld_detector_delay_initialized)
+		return -EBUSY;
+	else if (!arm_pmu_irq_is_nmi())
+		return -ENODEV;
+
+	return hardlockup_detector_perf_init();
+}
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 3cbc3baf087f..2aecb0c34290 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -697,6 +697,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 	return per_cpu(hw_events->irq, cpu);
 }
 
+bool arm_pmu_irq_is_nmi(void)
+{
+	return has_nmi;
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 505480217cf1..bf7966776c55 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -163,6 +163,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
 static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
+bool arm_pmu_irq_is_nmi(void);
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
-- 
2.31.1

