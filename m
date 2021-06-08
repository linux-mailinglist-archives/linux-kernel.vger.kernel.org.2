Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6430039F7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhFHNZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:25:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3179 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhFHNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:24:56 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzrKN52vhz6H76q;
        Tue,  8 Jun 2021 21:13:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:23:02 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:22:59 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <rdunlap@infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v11 3/3] iommu/amd: Add support for IOMMU default DMA mode build options
Date:   Tue, 8 Jun 2021 21:18:28 +0800
Message-ID: <1623158308-180604-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The default DMA mode lazy, but allow this to be set to strict mode at
build time. It may still be overridden by the relevant boot option.

Also make IOMMU_DEFAULT_LAZY default for when AMD_IOMMU config is set.

[jpg: Rebase for relocated file]
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/Kconfig    | 2 +-
 drivers/iommu/amd/init.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b68ec7ed23c0..6d99150050b9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -95,7 +95,7 @@ choice
 	depends on IOMMU_API
 	depends on X86 || IA64 || X86_64 || ARM || ARM64
 
-	default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
+	default IOMMU_DEFAULT_LAZY if (AMD_IOMMU || INTEL_IOMMU)
 	default IOMMU_DEFAULT_STRICT
 	help
 	  This option allows an IOMMU DMA mode to be chosen at build time, to
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..af662fc37cbe 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,7 +160,8 @@ u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 					   to handle */
 LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
 					   we find in ACPI */
-bool amd_iommu_unmap_flush;		/* if true, flush on every unmap */
+/* if true, flush on every unmap */
+bool amd_iommu_unmap_flush = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
 
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
-- 
2.26.2

