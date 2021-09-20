Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7AD410F34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhITFK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:10:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32664 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhITFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:10:17 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18JNT3bO017248;
        Sun, 19 Sep 2021 22:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=qyV8+vEm4sZjB/wyqo1NOpKnxfPITMzCujbPuvHPUbY=;
 b=RBKFbwtndq4oVobqaTsLkoSzzucVGwxDGonuGfSOYhFsU5vywZWYAgJYf3fr3SkHgGIG
 6zTmxwYQBO0vIJ5PsuB6QMOH9P+xDqZ7uZC0aSHZrNgi2kR9BhpnYdp8+1vcUsrAEviK
 MeS9cvW2oweywQvSbiY9IhkDL56KDgQDb4U5BEUvipgL8LiBRQgp7d2K2/RzT86yMKy6
 GB8peOANBDXr/5r+udO93+O0s3c0uyveGFXi0mdS3AyJKwC72y7zbcyIrtZi94N1vhJ+
 7f9Opal3X2W0TjFZkenK4to+hCPTnZfPRoHh0VVW4Hy+qAA3lX3j7f2FJaZ/U01em3W/ XA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3b6ascgyt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 22:08:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Sep
 2021 22:08:42 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 19 Sep 2021 22:08:40 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v4 4/4] perf/marvell: cn10k DDR perf event core ownership
Date:   Mon, 20 Sep 2021 10:38:23 +0530
Message-ID: <20210920050823.10853-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210920050823.10853-1-bbhushan2@marvell.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: XxBy1iX-jFzQTMzyOgl5lbnLflWkyjXB
X-Proofpoint-ORIG-GUID: XxBy1iX-jFzQTMzyOgl5lbnLflWkyjXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_01,2021-09-17_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DDR perf event counters are not per core, so they should be accessed
only by one core at a time. Select new core when previously owning core
is going offline.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v1->v2->v3->v4:
 - No change

 drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
 include/linux/cpuhotplug.h           |  1 +
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 21fccb9090c5..bef0cee3a46a 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -129,6 +129,7 @@ struct cn10k_ddr_pmu {
 	int active_events;
 	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
 	struct hrtimer hrtimer;
+	struct hlist_node node;
 };
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
@@ -610,6 +611,24 @@ static enum hrtimer_restart cn10k_ddr_pmu_timer_handler(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
+static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct cn10k_ddr_pmu *pmu = hlist_entry_safe(node, struct cn10k_ddr_pmu,
+						     node);
+	unsigned int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+	return 0;
+}
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu;
@@ -661,18 +680,31 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ddr_pmu->hrtimer.function = cn10k_ddr_pmu_timer_handler;
 
+	cpuhp_state_add_instance_nocalls(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				&ddr_pmu->node);
+
 	ret = perf_pmu_register(&ddr_pmu->pmu, name, -1);
 	if (ret)
-		return ret;
+		goto error;
 
 	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
 	return 0;
+error:
+	cpuhp_state_remove_instance_nocalls(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				&ddr_pmu->node);
+	return ret;
 }
 
 static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = platform_get_drvdata(pdev);
 
+	cpuhp_state_remove_instance_nocalls(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				&ddr_pmu->node);
+
 	perf_pmu_unregister(&ddr_pmu->pmu);
 	return 0;
 }
@@ -695,12 +727,26 @@ static struct platform_driver cn10k_ddr_pmu_driver = {
 
 static int __init cn10k_ddr_pmu_init(void)
 {
-	return platform_driver_register(&cn10k_ddr_pmu_driver);
+	int ret;
+
+	ret = cpuhp_setup_state_multi(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				"perf/marvell/cn10k/ddr:online", NULL,
+				cn10k_ddr_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&cn10k_ddr_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE);
+	return ret;
 }
 
 static void __exit cn10k_ddr_pmu_exit(void)
 {
 	platform_driver_unregister(&cn10k_ddr_pmu_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE);
 }
 
 module_init(cn10k_ddr_pmu_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 832d8a74fa59..a4b521f12b58 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -227,6 +227,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
+	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.17.1

