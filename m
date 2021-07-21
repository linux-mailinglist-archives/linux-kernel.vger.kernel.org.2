Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79E73D1646
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhGURlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:41:21 -0400
Received: from foss.arm.com ([217.140.110.172]:33524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238369AbhGURkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F9FE13A1;
        Wed, 21 Jul 2021 11:21:23 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1ED343F694;
        Wed, 21 Jul 2021 11:21:21 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 22/23] iommu: Allow enabling non-strict mode dynamically
Date:   Wed, 21 Jul 2021 19:20:33 +0100
Message-Id: <5b3933e8c5c57dae52d398e4dcf3fdfec9779539.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating and enabling a flush queue is in fact something we can
reasonably do while a DMA domain is active, without having to rebuild it
from scratch. Thus we can allow a strict -> non-strict transition from
sysfs without requiring to unbind the device's driver, which is of
particular interest to users who want to make selective relaxations to
critical devices like the one serving their root filesystem.

Disabling and draining a queue also seems technically possible to
achieve without rebuilding the whole domain, but would certainly be more
involved. Furthermore there's not such a clear use-case for tightening
up security *after* the device may already have done whatever it is that
you don't trust it not to do, so we only consider the relaxation case.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4fad6d427d9d..43a2041d9629 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3130,6 +3130,13 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
+	/* We can bring up a flush queue without tearing down the domain */
+	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
+		prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
+		ret = iommu_dma_init_fq(prev_dom);
+		goto out;
+	}
+
 	/* Sets group->default_domain to the newly allocated domain */
 	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
 	if (ret)
@@ -3170,9 +3177,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 }
 
 /*
- * Changing the default domain through sysfs requires the users to ubind the
- * drivers from the devices in the iommu group. Return failure if this doesn't
- * meet.
+ * Changing the default domain through sysfs requires the users to unbind the
+ * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
+ * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
  * device_lock(dev) is used here to guarantee that the device release path
@@ -3248,7 +3255,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev)) {
+	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
+	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
 		ret = -EBUSY;
 		goto out;
-- 
2.25.1

