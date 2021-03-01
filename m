Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2332327E17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhCAMR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:17:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13399 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhCAMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:17:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dpzjb4nvLzjSpj;
        Mon,  1 Mar 2021 20:15:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 20:16:29 +0800
From:   John Garry <john.garry@huawei.com>
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
Date:   Mon, 1 Mar 2021 20:12:20 +0800
Message-ID: <1614600741-15696-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core code handles flushing per-IOVA domain CPU rcaches,
remove the handling here.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/intel/iommu.c | 31 -------------------------------
 include/linux/cpuhotplug.h  |  1 -
 2 files changed, 32 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..d1e66e1b07b8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4065,35 +4065,6 @@ static struct notifier_block intel_iommu_memory_nb = {
 	.priority = 0
 };
 
-static void free_all_cpu_cached_iovas(unsigned int cpu)
-{
-	int i;
-
-	for (i = 0; i < g_num_of_iommus; i++) {
-		struct intel_iommu *iommu = g_iommus[i];
-		struct dmar_domain *domain;
-		int did;
-
-		if (!iommu)
-			continue;
-
-		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
-			domain = get_iommu_domain(iommu, (u16)did);
-
-			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
-				continue;
-
-			iommu_dma_free_cpu_cached_iovas(cpu, &domain->domain);
-		}
-	}
-}
-
-static int intel_iommu_cpu_dead(unsigned int cpu)
-{
-	free_all_cpu_cached_iovas(cpu);
-	return 0;
-}
-
 static void intel_disable_iommus(void)
 {
 	struct intel_iommu *iommu = NULL;
@@ -4388,8 +4359,6 @@ int __init intel_iommu_init(void)
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
-	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
-			  intel_iommu_cpu_dead);
 
 	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index cedac9986557..85996494bec1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -57,7 +57,6 @@ enum cpuhp_state {
 	CPUHP_PAGE_ALLOC_DEAD,
 	CPUHP_NET_DEV_DEAD,
 	CPUHP_PCI_XGENE_DEAD,
-	CPUHP_IOMMU_INTEL_DEAD,
 	CPUHP_IOMMU_IOVA_DEAD,
 	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
-- 
2.26.2

