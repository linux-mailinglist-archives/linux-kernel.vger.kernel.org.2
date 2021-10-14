Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFCE42D098
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJNCoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhJNCof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:44:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A5C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so3707815pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfBomfEf3eYtRauYwDoqJro8rx5+o5vZwKMhW5hW/LI=;
        b=B1GgJ23tRoogCUls2XsOsVnaqO0hV85gk3DznMiPMaiE5RokIYuo6p+yGREf87UW6V
         7zLwbK3S9s4CHlzB++m8WnwTrvTletQxUidRnx+DkcAgZldC22bK8JExFlrj4pBX+Rmu
         5h9z+soFM7fd2qQ5aWo0ubppg2LaOg+d8pM0H9BJgQVoPTbgzYHr//zs0qIFrGr/+kKW
         R0oFtUoryAksOZA6M5gH9ZuwdY7u6PaAJyHLxrIU78vBVD7lIl4vSKizPoydqd7f6Msd
         hSBToA8tdTT7DHaddAS8Wj9L52U5W8CLHIPDi7WWbp4gzREBiA64MKOfFIG93npOdi/2
         I8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfBomfEf3eYtRauYwDoqJro8rx5+o5vZwKMhW5hW/LI=;
        b=EhTblFhgQ9scjpMRE5X2Nnq6lC6cpY88vQpEd1HfaD0HAba0bjMbv9pLx/KTP3jurL
         BvYQDFNVVQ4uU6aMjBWBOt3Hcz+fD4UngjLLWfQua9dAynnyHlIwU0NMMSD7kn+i6zB1
         gdFVaMrbzVN1bR5h37EzXRGmaxbIoS4fxwjs371nVQwtbThNrDSrE8km7R2cBcNPTF6N
         /TDCsGBReIrIVsFsDVHC7tXO87PjsokrhGIizrTdUQ+vBzEjl7NypnyyZ2R8g9ryFP6H
         89oXf9UfJWIxQ0JkeIsuatLjmpk7iewoq8hyevxEwN/YFhqtkcJSMoPhg0yFOOeUrTI8
         WQPQ==
X-Gm-Message-State: AOAM533ZB1vAoTFCJDUKoc+mFNBVvMl4Rpm2Ma3bntUvA+XwQLrrYY7n
        Wc2Ddop6BzISXTLoIu/ZZg==
X-Google-Smtp-Source: ABdhPJwT/AxtD21P8lVjB6BvqXZxhfxING8z46Eksxb67tRO9Qie+FPtevqY25G+qCsx3aHWOVAlzA==
X-Received: by 2002:a17:902:dac4:b0:13e:fcb8:eaf1 with SMTP id q4-20020a170902dac400b0013efcb8eaf1mr2681627plx.50.1634179350794;
        Wed, 13 Oct 2021 19:42:30 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m28sm818403pgl.9.2021.10.13.19.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:42:30 -0700 (PDT)
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
Subject: [PATCHv3 4/4] arm64: Enable perf events based hard lockup detector
Date:   Thu, 14 Oct 2021 10:41:55 +0800
Message-Id: <20211014024155.15253-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014024155.15253-1-kernelfans@gmail.com>
References: <20211014024155.15253-1-kernelfans@gmail.com>
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
device_initcall(). To cope with that, overriding watchdog_nmi_probe() to
let the watchdog framework know PMU not ready, and inform the framework
to re-initialize lockup detection once PMU has been initialized.

[1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
(Pingfan: adapt it to watchdog_hld async model based on [1])
Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
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
index fee914c716aa..762500f27aec 100644
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
index b4044469527e..8e4c39f1db52 100644
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
+	detector_delay_init_state = DELAY_INIT_READY;
+	wake_up(&hld_detector_wait);
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..85536906a186
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
+	if (detector_delay_init_state != DELAY_INIT_READY)
+		return -EBUSY;
+	else if (!arm_pmu_irq_is_nmi())
+		return -ENODEV;
+
+	return hardlockup_detector_perf_init();
+}
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 295cc7952d0e..e77f4897fca2 100644
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
index 2512e2f9cd4e..9325d01adc3e 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -169,6 +169,8 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 #define kvm_host_pmu_init(x)	do { } while(0)
 #endif
 
+bool arm_pmu_irq_is_nmi(void);
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
-- 
2.31.1

