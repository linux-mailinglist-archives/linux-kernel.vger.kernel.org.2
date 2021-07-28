Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82B3D92A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhG1QAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:00:24 -0400
Received: from foss.arm.com ([217.140.110.172]:59488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237485AbhG1P7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:59:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031BE1FB;
        Wed, 28 Jul 2021 08:59:47 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 862A93F70D;
        Wed, 28 Jul 2021 08:59:45 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
Date:   Wed, 28 Jul 2021 16:58:44 +0100
Message-Id: <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make io-pgtable aware of a flush queue being dynamically enabled,
allow IO_PGTABLE_QUIRK_NON_STRICT to be set even after a domain has been
attached to, and hook up the final piece of the puzzle in iommu-dma.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 11 +++++++++++
 drivers/iommu/dma-iommu.c                   |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 19400826eba7..40fa9cb382c3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2711,6 +2711,20 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
+static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
+		unsigned long quirks)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT && smmu_domain->pgtbl_ops) {
+		struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+
+		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2825,6 +2839,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
+	.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 109e4723f9f5..f18684f308b9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1518,6 +1518,17 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	int ret = 0;
 
+	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT) {
+		struct io_pgtable *iop;
+
+		if (!smmu_domain->pgtbl_ops)
+			return -EINVAL;
+
+		iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+		return 0;
+	}
+
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
 		ret = -EPERM;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 304a3ec71223..6e3eca778267 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -16,6 +16,7 @@
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
+#include <linux/io-pgtable.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
@@ -326,6 +327,8 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 		return -ENODEV;
 	}
 	cookie->fq_domain = domain;
+	if (domain->ops->set_pgtable_quirks)
+		domain->ops->set_pgtable_quirks(domain, IO_PGTABLE_QUIRK_NON_STRICT);
 	return 0;
 }
 
-- 
2.25.1

