Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996023C5B72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhGLLWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:22:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3387 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbhGLLUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:20:00 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNgtS1T7Tz6GFgJ;
        Mon, 12 Jul 2021 19:06:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 13:17:10 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:17:07 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>,
        <dianders@chromium.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v15 6/6] iommu: Remove mode argument from iommu_set_dma_strict()
Date:   Mon, 12 Jul 2021 19:12:20 +0800
Message-ID: <1626088340-5838-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
References: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only ever now set strict mode enabled in iommu_set_dma_strict(), so
just remove the argument.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/init.c    | 2 +-
 drivers/iommu/intel/iommu.c | 6 +++---
 drivers/iommu/iommu.c       | 5 ++---
 include/linux/iommu.h       | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1e641cb6dddc..6e12a615117b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3099,7 +3099,7 @@ static int __init parse_amd_iommu_options(char *str)
 	for (; *str; ++str) {
 		if (strncmp(str, "fullflush", 9) == 0) {
 			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
-			iommu_set_dma_strict(true);
+			iommu_set_dma_strict();
 		}
 		if (strncmp(str, "force_enable", 12) == 0)
 			amd_iommu_force_enable = true;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d06e8f71c259..6666089c2607 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -454,7 +454,7 @@ static int __init intel_iommu_setup(char *str)
 			iommu_dma_forcedac = true;
 		} else if (!strncmp(str, "strict", 6)) {
 			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
-			iommu_set_dma_strict(true);
+			iommu_set_dma_strict();
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
@@ -4382,7 +4382,7 @@ int __init intel_iommu_init(void)
 		 */
 		if (cap_caching_mode(iommu->cap)) {
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
-			iommu_set_dma_strict(true);
+			iommu_set_dma_strict();
 		}
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
@@ -5700,7 +5700,7 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	} else if (dmar_map_gfx) {
 		/* we have to ensure the gfx device is idle before we flush */
 		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
-		iommu_set_dma_strict(true);
+		iommu_set_dma_strict();
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 60b1ec42e73b..ff221d3ddcbc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
 }
 early_param("iommu.strict", iommu_dma_setup);
 
-void iommu_set_dma_strict(bool strict)
+void iommu_set_dma_strict(void)
 {
-	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
-		iommu_dma_strict = strict;
+	iommu_dma_strict = true;
 }
 
 bool iommu_get_dma_strict(struct iommu_domain *domain)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..754f67d6dd90 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -476,7 +476,7 @@ int iommu_enable_nesting(struct iommu_domain *domain);
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
-void iommu_set_dma_strict(bool val);
+void iommu_set_dma_strict(void);
 bool iommu_get_dma_strict(struct iommu_domain *domain);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
-- 
2.26.2

