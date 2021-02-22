Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54F3214F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhBVLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBVLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:19:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1890C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:19:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so6375853pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCAo7IpqHyroEPQXtSm8kSnOvzhLaLHtFXJKdGhVkIM=;
        b=o7SIYX9zQMoOYB+YvdmVUcY9rTrAaPOEtJ1TrWDw6v3+pJXwIwGCvn3HrT9CxIQSFw
         Y1Qb6QzKxwIs+MYjCdo+mDpfS6iz8E0f1g6dTO2EIpLny2MRL3ZdwtdhMJG8NTC7xUKP
         fOr3wYuS/7+Vv8y/E+IluwSq49R7jvEmWR5/Yes3mdqJvIoRvKwyodjJ+Ar9ixxkBxMX
         U9/jxCPoqVHLWXILSeXnVL0In16d4HqJDbyFp5jRUIwNv7bmVt7Mh7zGKauNTTymJbrg
         4CXWYAu4XIbqWD+V/0pCH+YxP0MOo7DSkO4BNwhiLJtrh1f+1RlejpZKMCvBV3nLpC9h
         fEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCAo7IpqHyroEPQXtSm8kSnOvzhLaLHtFXJKdGhVkIM=;
        b=RyaO6LADlLB2TAJeEERxE5Uo+qtqUCfmtAdMpwLODJfm7gGFhhXC1pA0Qj5s1Sma4E
         bCQKgOjtOoyhIU+EwVXa34OUN+wyXcQlBwSN8n1j8AQakGKMxRTg0DGgn1q4H7CC/0FF
         r4YXiOjL9z51qJWcLtIXEr1EG4mmmDKU4cXgFZM4ct27s3MR5Nwur8RHakarBFz/txAb
         KkNYyThdja9iB8wsTUtU99Few+N4WQwxrpDa1ng8EPo9zgMtNnqAxq5wN8Tx0ySmZQn2
         NhX6i6aN8BHPG3V55PzRqvGJjLnzcfPW5BK2eqjYsqbFUdtYb1G9WylIKZ6Hu8K2Z6yO
         NvoQ==
X-Gm-Message-State: AOAM530pF2/mgvtH4jW1wAh75Y/U5x4ow5eFohM0KdIIVQnW14Od8bTE
        KhOUsIbXQ6+QRgqh1uxqoyH+Xw==
X-Google-Smtp-Source: ABdhPJy0XHZajV+eaHtfkG1J8LUM9zaSXutIY5MHZC2h+W/9LBOn1g3A7k3licrSevPsaCBqcWzfTQ==
X-Received: by 2002:a63:4e13:: with SMTP id c19mr19281261pgb.432.1613992749762;
        Mon, 22 Feb 2021 03:19:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id g19sm18116486pjv.43.2021.02.22.03.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 03:19:09 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-pm@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] cpufreq: cppc: Add support for frequency invariance
Date:   Mon, 22 Feb 2021 16:48:24 +0530
Message-Id: <51c2260e8760fdc0b489bed2ff2c6bb8209ea35d.1613991982.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1613991982.git.viresh.kumar@linaro.org>
References: <cover.1613991982.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Frequency Invariance Engine (FIE) is providing a frequency scaling
correction factor that helps achieve more accurate load-tracking.

Normally, this scaling factor can be obtained directly with the help of
the cpufreq drivers as they know the exact frequency the hardware is
running at. But that isn't the case for CPPC cpufreq driver.

Another way of obtaining that is using the arch specific counter
support, which is already present in kernel, but that hardware is
optional for platforms.

This patch thus obtains this scaling factor using the existing logic
present in the cppc driver. Note that the arch specific counters have
higher priority than CPPC counters if available, though the CPPC driver
doesn't need to have any special handling for that.

To allow platforms to disable frequency invariance support if they want,
this is all done under CONFIG_ACPI_CPPC_CPUFREQ_FIE, which is enabled by
default.

This also exports sched_setattr_nocheck() as the CPPC driver can be
built as a module.

Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |   9 ++
 drivers/cpufreq/cppc_cpufreq.c | 223 +++++++++++++++++++++++++++++++--
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 4 files changed, 222 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e65e0a43be64..a3e2d6dfea70 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -19,6 +19,15 @@ config ACPI_CPPC_CPUFREQ
 
 	  If in doubt, say N.
 
+config ACPI_CPPC_CPUFREQ_FIE
+	bool "Frequency Invariance support for CPPC cpufreq driver"
+	depends on ACPI_CPPC_CPUFREQ
+	default y
+	help
+	  This enables frequency invariance support for CPPC cpufreq driver.
+
+	  If in doubt, say N.
+
 config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
 	depends on ARCH_SUNXI
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8a482c434ea6..fa1692db93c4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -10,14 +10,18 @@
 
 #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
 
+#include <linux/arch_topology.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
+#include <linux/irq_work.h>
+#include <linux/kthread.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
+#include <uapi/linux/sched/types.h>
 
 #include <asm/unaligned.h>
 
@@ -57,6 +61,182 @@ static struct cppc_workaround_oem_info wa_info[] = {
 	}
 };
 
+#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
+
+/* Frequency invariance support */
+struct cppc_freq_invariance {
+	int cpu;
+	struct irq_work irq_work;
+	struct kthread_work work;
+	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
+	struct cppc_cpudata *cpu_data;
+};
+
+static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
+static struct kthread_worker *kworker_fie;
+
+static struct cpufreq_driver cppc_cpufreq_driver;
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t1);
+
+static void cppc_scale_freq_workfn(struct kthread_work *work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_cpudata *cpu_data;
+	unsigned long local_freq_scale;
+	u64 perf;
+
+	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
+	cpu_data = cppc_fi->cpu_data;
+
+	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
+		pr_warn("%s: failed to read perf counters\n", __func__);
+		return;
+	}
+
+	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+	perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
+				     fb_ctrs);
+
+	perf <<= SCHED_CAPACITY_SHIFT;
+	local_freq_scale = div64_u64(perf, cpu_data->perf_caps.highest_perf);
+	if (WARN_ON(local_freq_scale > 1024))
+		local_freq_scale = 1024;
+
+	per_cpu(freq_scale, cppc_fi->cpu) = local_freq_scale;
+}
+
+static void cppc_irq_work(struct irq_work *irq_work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+
+	cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
+	kthread_queue_work(kworker_fie, &cppc_fi->work);
+}
+
+static void cppc_scale_freq_tick(void)
+{
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
+
+	/*
+	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
+	 * context.
+	 */
+	irq_work_queue(&cppc_fi->irq_work);
+}
+
+static struct scale_freq_data cppc_sftd = {
+	.source = SCALE_FREQ_SOURCE_CPPC,
+	.set_freq_scale = cppc_scale_freq_tick,
+};
+
+static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
+					     struct cppc_cpudata *cpu_data)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int i;
+
+	for_each_cpu(i, policy->cpus) {
+		cppc_fi = &per_cpu(cppc_freq_inv, i);
+		cppc_fi->cpu = i;
+		cppc_fi->cpu_data = cpu_data;
+	}
+}
+
+static void cppc_freq_invariance_exit(void)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int i;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
+
+	for_each_possible_cpu(i) {
+		cppc_fi = &per_cpu(cppc_freq_inv, i);
+		irq_work_sync(&cppc_fi->irq_work);
+	}
+
+	kthread_destroy_worker(kworker_fie);
+	kworker_fie = NULL;
+}
+
+static void __init cppc_freq_invariance_init(void)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_freq_invariance *cppc_fi;
+	struct sched_attr attr = {
+		.size		= sizeof(struct sched_attr),
+		.sched_policy	= SCHED_DEADLINE,
+		.sched_nice	= 0,
+		.sched_priority	= 0,
+		/*
+		 * Fake (unused) bandwidth; workaround to "fix"
+		 * priority inheritance.
+		 */
+		.sched_runtime	= 1000000,
+		.sched_deadline = 10000000,
+		.sched_period	= 10000000,
+	};
+	int i, ret;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	kworker_fie = kthread_create_worker(0, "cppc_fie");
+	if (IS_ERR(kworker_fie))
+		return;
+
+	for_each_possible_cpu(i) {
+		cppc_fi = &per_cpu(cppc_freq_inv, i);
+
+		/* A policy failed to initialize, abort */
+		if (unlikely(!cppc_fi->cpu_data))
+			return cppc_freq_invariance_exit();
+
+		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+		ret = sched_setattr_nocheck(kworker_fie->task, &attr);
+		if (ret) {
+			pr_warn("%s: failed to set SCHED_DEADLINE: %d\n",
+				__func__, ret);
+			return cppc_freq_invariance_exit();
+		}
+
+		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
+		if (ret) {
+			pr_warn("%s: failed to read perf counters: %d\n",
+				__func__, ret);
+			return cppc_freq_invariance_exit();
+		}
+
+		cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+	}
+
+	/* Register for freq-invariance */
+	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
+}
+
+#else
+static inline void
+cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
+				 struct cppc_cpudata *cpu_data)
+{
+}
+
+static inline void cppc_freq_invariance_exit(void)
+{
+}
+
+static inline void cppc_freq_invariance_init(void)
+{
+}
+#endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
+
 /* Callback function used to retrieve the max frequency from DMI */
 static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 {
@@ -355,9 +535,12 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
+	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
+	} else {
+		cppc_freq_invariance_policy_init(policy, cpu_data);
+	}
 
 	return ret;
 }
@@ -370,12 +553,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf, delivered_perf;
+	u64 reference_perf;
 
 	reference_perf = fb_ctrs_t0.reference_perf;
 
@@ -384,12 +567,21 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 	delta_delivered = get_delta(fb_ctrs_t1.delivered,
 				    fb_ctrs_t0.delivered);
 
-	/* Check to avoid divide-by zero */
-	if (delta_reference || delta_delivered)
-		delivered_perf = (reference_perf * delta_delivered) /
-					delta_reference;
-	else
-		delivered_perf = cpu_data->perf_ctrls.desired_perf;
+	/* Check to avoid divide-by zero and invalid delivered_perf */
+	if (!delta_reference || !delta_delivered)
+		return cpu_data->perf_ctrls.desired_perf;
+
+	return (reference_perf * delta_delivered) / delta_reference;
+}
+
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delivered_perf;
+
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
+					       fb_ctrs_t1);
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -514,6 +706,8 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
+	int ret;
+
 	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
@@ -521,7 +715,11 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_check_hisi_workaround();
 
-	return cpufreq_register_driver(&cppc_cpufreq_driver);
+	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (!ret)
+		cppc_freq_invariance_init();
+
+	return ret;
 }
 
 static inline void free_cpu_data(void)
@@ -538,6 +736,7 @@ static inline void free_cpu_data(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	cppc_freq_invariance_exit();
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	free_cpu_data();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3bcfba5c21a7..47ac4b41c28d 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -37,6 +37,7 @@ bool topology_scale_freq_invariant(void);
 enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
+	SCALE_FREQ_SOURCE_CPPC,
 };
 
 struct scale_freq_data {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb629595f..3adedc7b1725 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6386,6 +6386,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.25.0.rc1.19.g042ed3e048af

