Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581AD3F7A16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbhHYQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:41 -0400
Received: from foss.arm.com ([217.140.110.172]:54768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240924AbhHYQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FE5D142F;
        Wed, 25 Aug 2021 09:17:36 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C2A3F66F;
        Wed, 25 Aug 2021 09:17:34 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 15/39] drivers/perf: Expose the cpumask of CPUs that support SPE
Date:   Wed, 25 Aug 2021 17:17:51 +0100
Message-Id: <20210825161815.266051-16-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM SPE emulation will require the list of CPUs that have hardware support
for SPE. Add a function that returns the cpumask of supported CPUs
discovered by the driver during probing.

CC: Will Deacon <will@kernel.org>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/perf/arm_spe_pmu.c   | 30 ++++++++++++++++++------------
 include/linux/perf/arm_pmu.h |  7 +++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d99c..40749665f102 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -50,7 +50,6 @@ struct arm_spe_pmu_buf {
 struct arm_spe_pmu {
 	struct pmu				pmu;
 	struct platform_device			*pdev;
-	cpumask_t				supported_cpus;
 	struct hlist_node			hotplug_node;
 
 	int					irq; /* PPI */
@@ -72,6 +71,8 @@ struct arm_spe_pmu {
 	struct perf_output_handle __percpu	*handle;
 };
 
+static cpumask_t supported_cpus;
+
 #define to_spe_pmu(p) (container_of(p, struct arm_spe_pmu, pmu))
 
 /* Convert a free-running index from perf into an SPE buffer offset */
@@ -234,9 +235,7 @@ static const struct attribute_group arm_spe_pmu_format_group = {
 static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
-
-	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+	return cpumap_print_to_pagebuf(true, buf, &supported_cpus);
 }
 static DEVICE_ATTR_RO(cpumask);
 
@@ -677,7 +676,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (event->cpu >= 0 &&
-	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
+	    !cpumask_test_cpu(event->cpu, &supported_cpus))
 		return -ENOENT;
 
 	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
@@ -797,11 +796,10 @@ static void arm_spe_pmu_stop(struct perf_event *event, int flags)
 static int arm_spe_pmu_add(struct perf_event *event, int flags)
 {
 	int ret = 0;
-	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int cpu = event->cpu == -1 ? smp_processor_id() : event->cpu;
 
-	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
+	if (!cpumask_test_cpu(cpu, &supported_cpus))
 		return -ENOENT;
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
@@ -883,6 +881,13 @@ static void arm_spe_pmu_free_aux(void *aux)
 	kfree(buf);
 }
 
+#if IS_BUILTIN(CONFIG_ARM_SPE_PMU)
+const cpumask_t *arm_spe_pmu_supported_cpus(void)
+{
+	return &supported_cpus;
+}
+#endif
+
 /* Initialisation and teardown functions */
 static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 {
@@ -1039,7 +1044,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 
 	dev_info(dev,
 		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
-		 cpumask_pr_args(&spe_pmu->supported_cpus),
+		 cpumask_pr_args(&supported_cpus),
 		 spe_pmu->max_record_sz, spe_pmu->align, spe_pmu->features);
 
 	spe_pmu->features |= SPE_PMU_FEAT_DEV_PROBED;
@@ -1083,7 +1088,7 @@ static int arm_spe_pmu_cpu_startup(unsigned int cpu, struct hlist_node *node)
 	struct arm_spe_pmu *spe_pmu;
 
 	spe_pmu = hlist_entry_safe(node, struct arm_spe_pmu, hotplug_node);
-	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
+	if (!cpumask_test_cpu(cpu, &supported_cpus))
 		return 0;
 
 	__arm_spe_pmu_setup_one(spe_pmu);
@@ -1095,7 +1100,7 @@ static int arm_spe_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 	struct arm_spe_pmu *spe_pmu;
 
 	spe_pmu = hlist_entry_safe(node, struct arm_spe_pmu, hotplug_node);
-	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
+	if (!cpumask_test_cpu(cpu, &supported_cpus))
 		return 0;
 
 	__arm_spe_pmu_stop_one(spe_pmu);
@@ -1105,7 +1110,7 @@ static int arm_spe_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe_pmu)
 {
 	int ret;
-	cpumask_t *mask = &spe_pmu->supported_cpus;
+	cpumask_t *mask = &supported_cpus;
 
 	/* Make sure we probe the hardware on a relevant CPU */
 	ret = smp_call_function_any(mask,  __arm_spe_pmu_dev_probe, spe_pmu, 1);
@@ -1151,7 +1156,7 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 		return -EINVAL;
 	}
 
-	if (irq_get_percpu_devid_partition(irq, &spe_pmu->supported_cpus)) {
+	if (irq_get_percpu_devid_partition(irq, &supported_cpus)) {
 		dev_err(&pdev->dev, "failed to get PPI partition (%d)\n", irq);
 		return -EINVAL;
 	}
@@ -1216,6 +1221,7 @@ static int arm_spe_pmu_device_probe(struct platform_device *pdev)
 	arm_spe_pmu_dev_teardown(spe_pmu);
 out_free_handle:
 	free_percpu(spe_pmu->handle);
+	cpumask_clear(&supported_cpus);
 	return ret;
 }
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 505480217cf1..3121d95c575b 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -8,6 +8,7 @@
 #ifndef __ARM_PMU_H__
 #define __ARM_PMU_H__
 
+#include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
@@ -177,4 +178,10 @@ void armpmu_free_irq(int irq, int cpu);
 
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
 
+#if IS_BUILTIN(CONFIG_ARM_SPE_PMU)
+extern const cpumask_t *arm_spe_pmu_supported_cpus(void);
+#else
+static inline const cpumask_t *arm_spe_pmu_supported_cpus(void) { return NULL; };
+#endif
+
 #endif /* __ARM_PMU_H__ */
-- 
2.33.0

