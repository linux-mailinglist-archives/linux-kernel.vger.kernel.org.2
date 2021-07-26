Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74363D5639
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhGZIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:30:33 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29256 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232773AbhGZIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:30:30 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q91drC020157;
        Mon, 26 Jul 2021 02:10:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=muAfgvad35VDGRyfpTzQW7ognyD8g5xg0/p+wGM3DkA=;
 b=kpE+Z6fRtIkbPk3BcaM55/8GLNQPwfNgLis9rN8HC+C2njgIy0mgRkCBkrdrRvX2rYOv
 bXSa86pgp9fmg2BCCaWspA+K/qA3ZXsDw53wj6EatrKdAoEFdCmn84jCGHHMLpJ6Sz1D
 03Zk3n1CqVnhhSKMTd6H3PfWjwi6hSx/2ggFQK/hz5jTM5ie5nvLEcLSJzLCaHm8ktuv
 5sZGNGpNN5BWlMWeVwh2vLquQf/9cvJN4miY2H/SeIQXO9qHvDTG8TgGjqg0N7JL6PDh
 rLqoBCrCahvYdTrX6cAULdLntkagF40M/CbhelTAwKCiA5WqybwmXPO6JHrHVkeWIsbe Vw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a1avpa2r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 02:10:54 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 26 Jul
 2021 02:10:52 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 26 Jul 2021 02:10:49 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 4/4] perf/marvell: cn10k DDR perf event core ownership
Date:   Mon, 26 Jul 2021 14:40:27 +0530
Message-ID: <20210726091027.798-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726091027.798-1-bbhushan2@marvell.com>
References: <20210726091027.798-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 4jIrSX0WeH-Ga4xnj1KONMVKbiBAjFP3
X-Proofpoint-ORIG-GUID: 4jIrSX0WeH-Ga4xnj1KONMVKbiBAjFP3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_05:2021-07-26,2021-07-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DDR perf event counters are not per core, so they
should be accessed only by one core at a time.
Select new core when previously owning core is going
offline.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
 include/linux/cpuhotplug.h           |  1 +
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 5e88fb7ffcb8..0b20c20c7f2f 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -130,6 +130,7 @@ struct cn10k_ddr_pmu {
 	int active_events;
 	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
 	struct hrtimer hrtimer;
+	struct hlist_node node;
 };
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
@@ -616,6 +617,24 @@ static enum hrtimer_restart cn10k_ddr_pmu_timer_handler(struct hrtimer *hrtimer)
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
@@ -669,20 +688,33 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
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
 
 	ddr_pmu->id = index++;
 	pr_info("CN10K DDR PMU Driver for ddrc@%llx - id-%d\n",
 		res->start, ddr_pmu->id);
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
@@ -705,12 +737,26 @@ static struct platform_driver cn10k_ddr_pmu_driver = {
 
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
index 47e13582d9fc..ce7f2740d7db 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -185,6 +185,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
+	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.17.1

