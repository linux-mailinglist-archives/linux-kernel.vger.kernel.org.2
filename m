Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C36430EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhJREXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:23:04 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55242 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230099AbhJREXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:23:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I3nuvK024810;
        Sun, 17 Oct 2021 21:20:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=CQ13fktDeUWERref1uPyVaPqCTkiMRqTZLfvTBs7bQc=;
 b=MVRc5L4x1QkMngvN0+hsXSl7Dni5nCjJXUi1GFs35Bbb5pXh4YY2x5zzelMDrlAD2NR5
 fwdpGyDEzlmZAIsDYDv7AJ7/czmqZZ4YKrt+r+SUyZz6yk1f54bFRW5DrZPCfoCNfwtb
 2/Lhlt2z+m0KzWGZrsodjCEPt1MgyaXSJdZlgTd2guDLbPAgOycbCV1DknkNblKeNyVt
 SVnHYtolwfqZPof2JATX0E2Ta4Qtg1xmzl762OBrUo5daBf/Ptg+pfCg/5sZwmZk9BQg
 6tuWd1sXz7Fqz9Pl6WVx+ryfobmcDgHtXB9X/fOOLgGSkgy9zEuEq9tJMadaWFJDZZAC Aw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bug2ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 21:20:42 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 17 Oct
 2021 21:20:40 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 17 Oct 2021 21:20:37 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v5 4/4] perf/marvell: cn10k DDR perf event core ownership
Date:   Mon, 18 Oct 2021 09:50:15 +0530
Message-ID: <20211018042015.25151-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211018042015.25151-1-bbhushan2@marvell.com>
References: <20211018042015.25151-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GVXCYxzV-eFgGF_53dz6dNGUhKShxtn4
X-Proofpoint-ORIG-GUID: GVXCYxzV-eFgGF_53dz6dNGUhKShxtn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_01,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DDR perf event counters are not per core, so they should be accessed
only by one core at a time. Select new core when previously owning core
is going offline.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v1->v2->v3->v4->v5:
 - No Change

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

