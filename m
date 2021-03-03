Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC57B32C0EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580898AbhCCSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:47:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhCCRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:38:11 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DrLjx3KNMzjTqL;
        Thu,  4 Mar 2021 01:35:17 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.83.26) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 01:36:29 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <jean-philippe@linaro.org>, <will@kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@openeuler.org>
Subject: [PATCH v3] iommu: Check dev->iommu in iommu_dev_xxx functions
Date:   Wed, 3 Mar 2021 17:36:11 +0000
Message-ID: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.83.26]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device iommu probe/attach might have failed leaving dev->iommu
to NULL and device drivers may still invoke these functions resulting
in a crash in iommu vendor driver code.

Hence make sure we check that.

Fixes: a3a195929d40 ("iommu: Add APIs for multiple domains per device")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v2 --> v3
 -Removed iommu_ops from struct dev_iommu.
v1 --> v2:
 -Added iommu_ops to struct dev_iommu based on the discussion with Robin.
 -Rebased against iommu-tree core branch.
---
 drivers/iommu/iommu.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..e10cfa99057c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2878,10 +2878,12 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  */
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	if (dev->iommu && dev->iommu->iommu_dev) {
+		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
 
-	if (ops && ops->dev_enable_feat)
-		return ops->dev_enable_feat(dev, feat);
+		if (ops->dev_enable_feat)
+			return ops->dev_enable_feat(dev, feat);
+	}
 
 	return -ENODEV;
 }
@@ -2894,10 +2896,12 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
  */
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	if (dev->iommu && dev->iommu->iommu_dev) {
+		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
 
-	if (ops && ops->dev_disable_feat)
-		return ops->dev_disable_feat(dev, feat);
+		if (ops->dev_disable_feat)
+			return ops->dev_disable_feat(dev, feat);
+	}
 
 	return -EBUSY;
 }
@@ -2905,10 +2909,12 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	if (dev->iommu && dev->iommu->iommu_dev) {
+		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
 
-	if (ops && ops->dev_feat_enabled)
-		return ops->dev_feat_enabled(dev, feat);
+		if (ops->dev_feat_enabled)
+			return ops->dev_feat_enabled(dev, feat);
+	}
 
 	return false;
 }
-- 
2.17.1

