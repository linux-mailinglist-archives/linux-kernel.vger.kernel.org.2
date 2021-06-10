Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D33A26E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFJI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFJI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:26:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FDEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:24:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so3294824pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ts2ApCK9xnJQUj3HLY0ucjPpblWOxwdFx65VhUgZ2Z4=;
        b=m3DlcIj/aVptNqUHKX8oUUf+lJ5m3vlVM9aXVU8bLDIOpm2rSnifUHo0xvKS1bmSPP
         Z9+3xTMFL33TbexfAYLt9ByLW2mLUUFgDeg9JNE178xurzULxbZQuRFaevMs/qUGzubm
         V8EJzeBp0z+kYLjMIV0xRtqaHvkD220uIBG5erXbcRCk5kYbTBiKwTncOz0krO75n9rw
         7Q0opG0COPQHi6Bj+2EKSvUBEZi7OezH8KXfzvc5zAtSjsUF/1h0dIDQ4A7aK34cq+Xm
         EEtDq/BiUaFJks4VJbbiTYfeb96gHqa+odSnqwWnZbcL/Q/G/D+BmaUyfDmatGU+xeTY
         BdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ts2ApCK9xnJQUj3HLY0ucjPpblWOxwdFx65VhUgZ2Z4=;
        b=eG1mwxQO/y7OUm1Kjv3pIzwKq+V3M48X9ePjZCJqFwYQ/9qvm4dkSNPAD+guXk86bq
         EbqvD9mgwx921lcOVBERuTGNwkkqyLhqMXyOc11F8LsSMgS1dOhLuARcK0uTocrMz2Hv
         s0c1Cv5eQwJ1LzyPLcebRjHlo1WZqyjozTbIoIem+2IA+B/lpOXLvGYD7ZgBZU7i0sXH
         /b3W5dGcUQOfyeO28O8t/EeJBccV83P5gMluN1YwAjJPKu1O1GXIHrn+7Babvs4tGZkE
         bYuAinZ3bR2O3G5TlgS7Wa+1MZJlSUAwyk8oBdfd2RThItasYzfpbTHqCuIrGAoeK7s9
         xwBA==
X-Gm-Message-State: AOAM531n6bzjIFSy2h+PI7r5H4AW/R5xTqB2tHcx1xe3EnF+OT8tx2ug
        V1HesyPp9vMsNZTa0RF5x4VixA==
X-Google-Smtp-Source: ABdhPJxGEKh8lQGqm26xlut8Bs9isUrJehy0qehJJ01+aGGtE8p7elJr0nyDrya29eyQXQ9z2gQ3XQ==
X-Received: by 2002:a17:902:9a8c:b029:113:d891:2eaf with SMTP id w12-20020a1709029a8cb0290113d8912eafmr3878715plp.61.1623313463895;
        Thu, 10 Jun 2021 01:24:23 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id z8sm2081118pgi.94.2021.06.10.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] cpufreq: cppc: Fix suspend/resume specific races with the FIE code
Date:   Thu, 10 Jun 2021 13:54:01 +0530
Message-Id: <1256ee94a515216ab58553181de175cc74f396bd.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623313323.git.viresh.kumar@linaro.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPPC driver currently stops the frequency invariance related
kthread_work and irq_work from cppc_freq_invariance_exit() which is only
called during driver's removal.

This is not sufficient as the CPUs can get hot-plugged out while the
driver is in use, the same also happens during system suspend/resume.

In such a cases we can reach a state where the CPU is removed by the
kernel but its kthread_work or irq_work aren't stopped.

Fix this by implementing the start_cpu() and stop_cpu() callbacks of the
cpufreq core, which will be called for each CPU's addition/removal.

The FIE feature was marked BROKEN earlier, revert that.

Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |   1 -
 drivers/cpufreq/cppc_cpufreq.c | 117 +++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 614c34350f41..a5c5f70acfc9 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -22,7 +22,6 @@ config ACPI_CPPC_CPUFREQ
 config ACPI_CPPC_CPUFREQ_FIE
 	bool "Frequency Invariance support for CPPC cpufreq driver"
 	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
-	depends on BROKEN
 	default y
 	help
 	  This extends frequency invariance support in the CPPC cpufreq driver,
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 30a861538784..82167c657098 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -74,7 +74,6 @@ struct cppc_freq_invariance {
 
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;
-static bool fie_disabled;
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
@@ -151,35 +150,64 @@ static struct scale_freq_data cppc_sftd = {
 	.set_freq_scale = cppc_scale_freq_tick,
 };
 
-static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
-					     struct cppc_cpudata *cpu_data)
+static void cppc_cpufreq_start_cpu(struct cpufreq_policy *policy,
+				   unsigned int cpu)
 {
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
-	struct cppc_freq_invariance *cppc_fi;
-	int i, ret;
+	int ret;
 
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
-		return;
+	cppc_fi->cpu = cpu;
+	cppc_fi->cpu_data = policy->driver_data;
+	kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+	init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
-	if (fie_disabled)
+	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs);
+	if (ret) {
+		pr_warn("%s: failed to read perf counters: %d\n",
+				__func__, ret);
 		return;
+	} else {
+		cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+	}
 
-	for_each_cpu(i, policy->cpus) {
-		cppc_fi = &per_cpu(cppc_freq_inv, i);
-		cppc_fi->cpu = i;
-		cppc_fi->cpu_data = cpu_data;
-		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
-		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+	/* Register for freq-invariance */
+	topology_set_scale_freq_source(&cppc_sftd, cpumask_of(cpu));
+}
 
-		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
-		if (ret) {
-			pr_warn("%s: failed to read perf counters: %d\n",
-				__func__, ret);
-			fie_disabled = true;
-		} else {
-			cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
-		}
-	}
+static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy,
+				  unsigned int cpu)
+{
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpumask_of(cpu));
+
+	irq_work_sync(&cppc_fi->irq_work);
+	kthread_cancel_work_sync(&cppc_fi->work);
+}
+
+static int cppc_freq_invariance_policy_init(struct cpufreq_policy *policy)
+{
+	int cpu;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return 0;
+
+	for_each_cpu(cpu, policy->cpus)
+		cppc_cpufreq_start_cpu(policy, cpu);
+
+	return 0;
+}
+
+static void cppc_freq_invariance_policy_exit(struct cpufreq_policy *policy)
+{
+	int cpu;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	for_each_cpu(cpu, policy->cpus)
+		cppc_cpufreq_stop_cpu(policy, cpu);
 }
 
 static void __init cppc_freq_invariance_init(void)
@@ -202,9 +230,6 @@ static void __init cppc_freq_invariance_init(void)
 	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
 		return;
 
-	if (fie_disabled)
-		return;
-
 	kworker_fie = kthread_create_worker(0, "cppc_fie");
 	if (IS_ERR(kworker_fie))
 		return;
@@ -217,36 +242,28 @@ static void __init cppc_freq_invariance_init(void)
 		return;
 	}
 
-	/* Register for freq-invariance */
-	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
+	cppc_cpufreq_driver.start_cpu = cppc_cpufreq_start_cpu;
+	cppc_cpufreq_driver.stop_cpu = cppc_cpufreq_stop_cpu;
 }
 
 static void cppc_freq_invariance_exit(void)
 {
-	struct cppc_freq_invariance *cppc_fi;
-	int i;
-
 	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
 		return;
 
-	if (fie_disabled)
-		return;
-
-	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
-
-	for_each_possible_cpu(i) {
-		cppc_fi = &per_cpu(cppc_freq_inv, i);
-		irq_work_sync(&cppc_fi->irq_work);
-	}
-
 	kthread_destroy_worker(kworker_fie);
 	kworker_fie = NULL;
 }
 
 #else
+static inline int
+cppc_freq_invariance_policy_init(struct cpufreq_policy *polic)
+{
+	return 0;
+}
+
 static inline void
-cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
-				 struct cppc_cpudata *cpu_data)
+cppc_freq_invariance_policy_exit(struct cpufreq_policy *policy)
 {
 }
 
@@ -529,11 +546,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
-	} else {
-		cppc_freq_invariance_policy_init(policy, cpu_data);
+		return ret;
 	}
 
-	return ret;
+	return cppc_freq_invariance_policy_init(policy);
 }
 
 static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
@@ -543,6 +559,8 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_freq_invariance_policy_exit(policy);
+
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -728,10 +746,11 @@ static int __init cppc_cpufreq_init(void)
 	INIT_LIST_HEAD(&cpu_data_list);
 
 	cppc_check_hisi_workaround();
+	cppc_freq_invariance_init();
 
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-	if (!ret)
-		cppc_freq_invariance_init();
+	if (ret)
+		cppc_freq_invariance_exit();
 
 	return ret;
 }
@@ -750,8 +769,8 @@ static inline void free_cpu_data(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	cppc_freq_invariance_exit();
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
+	cppc_freq_invariance_exit();
 
 	free_cpu_data();
 }
-- 
2.31.1.272.g89b43f80a514

