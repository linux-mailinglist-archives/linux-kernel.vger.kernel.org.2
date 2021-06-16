Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463693A98DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhFPLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:11:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3248 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFPLLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:11:02 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4htW4gcVz6JBCJ;
        Wed, 16 Jun 2021 18:55:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 13:08:54 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 12:08:51 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v13 5/6] iommu/amd: Add support for IOMMU default DMA mode build options
Date:   Wed, 16 Jun 2021 19:03:56 +0800
Message-ID: <1623841437-211832-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Make IOMMU_DEFAULT_LAZY default for when AMD_IOMMU config is set, which
matches current behaviour.

For "fullflush" param, just call iommu_set_dma_strict(true) directly.

Since we get a strict vs lazy mode print already in iommu_subsys_init(),
and maintain a deprecation print when "fullflush" param is passed, drop the
prints in amd_iommu_init_dma_ops().

Finally drop global flag amd_iommu_unmap_flush, as it has no longer has any
purpose.

[jpg: Rebase for relocated file and drop amd_iommu_unmap_flush]
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/Kconfig               | 2 +-
 drivers/iommu/amd/amd_iommu_types.h | 6 ------
 drivers/iommu/amd/init.c            | 3 +--
 drivers/iommu/amd/iommu.c           | 6 ------
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c214a36eb2dc..fd1ad28dd5ee 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -94,7 +94,7 @@ choice
 	prompt "IOMMU default DMA IOTLB invalidation mode"
 	depends on IOMMU_DMA
 
-	default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
+	default IOMMU_DEFAULT_LAZY if (AMD_IOMMU || INTEL_IOMMU)
 	default IOMMU_DEFAULT_STRICT
 	help
 	  This option allows an IOMMU DMA IOTLB invalidation mode to be
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 94c1a7a9876d..8dbe61e2b3c1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -779,12 +779,6 @@ extern u16 amd_iommu_last_bdf;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/*
- * If true, the addresses will be flushed on unmap time, not when
- * they are reused
- */
-extern bool amd_iommu_unmap_flush;
-
 /* Smallest max PASID supported by any IOMMU in the system */
 extern u32 amd_iommu_max_pasid;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9f3096d650aa..fb3618af643b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -161,7 +161,6 @@ u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 					   to handle */
 LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
 					   we find in ACPI */
-bool amd_iommu_unmap_flush;		/* if true, flush on every unmap */
 
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -3100,7 +3099,7 @@ static int __init parse_amd_iommu_options(char *str)
 	for (; *str; ++str) {
 		if (strncmp(str, "fullflush", 9) == 0) {
 			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");
-			amd_iommu_unmap_flush = true;
+			iommu_set_dma_strict(true);
 		}
 		if (strncmp(str, "force_enable", 12) == 0)
 			amd_iommu_force_enable = true;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b1fbf2c83df5..32b541ee2e11 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1775,12 +1775,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 static void __init amd_iommu_init_dma_ops(void)
 {
 	swiotlb = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
-
-	if (amd_iommu_unmap_flush)
-		pr_info("IO/TLB flush on unmap enabled\n");
-	else
-		pr_info("Lazy IO/TLB flushing enabled\n");
-	iommu_set_dma_strict(amd_iommu_unmap_flush);
 }
 
 int __init amd_iommu_init_api(void)
-- 
2.26.2

