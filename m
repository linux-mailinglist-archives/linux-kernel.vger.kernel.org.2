Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1330A7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBAMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:42:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12375 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBAMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:42:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DTnbG0smRz7f58;
        Mon,  1 Feb 2021 20:40:10 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.92.226) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 20:41:20 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <jean-philippe@linaro.org>, <will@kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@openeuler.org>
Subject: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Date:   Mon, 1 Feb 2021 12:40:49 +0000
Message-ID: <20210201124049.19956-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.92.226]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device iommu probe/attach might have failed leaving dev->iommu
to NULL and device drivers may still invoke these functions resulting
in a crash in iommu vendor driver code. Hence make sure we check that.

Also added iommu_ops to the "struct dev_iommu" and set it if the dev
is successfully associated with an iommu. 

Fixes: a3a195929d40 ("iommu: Add APIs for multiple domains per device")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v1 --> v2:
 -Added iommu_ops to struct dev_iommu based on the discussion with Robin.
 -Rebased against iommu-tree core branch.
---
 drivers/iommu/iommu.c | 19 +++++++------------
 include/linux/iommu.h |  2 ++
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fd76e2f579fe..6023d0b7c542 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -217,6 +217,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	dev->iommu->iommu_dev = iommu_dev;
+	dev->iommu->ops = iommu_dev->ops;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -2865,10 +2866,8 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  */
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
-
-	if (ops && ops->dev_enable_feat)
-		return ops->dev_enable_feat(dev, feat);
+	if (dev->iommu && dev->iommu->ops->dev_enable_feat)
+		return dev->iommu->ops->dev_enable_feat(dev, feat);
 
 	return -ENODEV;
 }
@@ -2881,10 +2880,8 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
  */
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
-
-	if (ops && ops->dev_disable_feat)
-		return ops->dev_disable_feat(dev, feat);
+	if (dev->iommu && dev->iommu->ops->dev_disable_feat)
+		return dev->iommu->ops->dev_disable_feat(dev, feat);
 
 	return -EBUSY;
 }
@@ -2892,10 +2889,8 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
-
-	if (ops && ops->dev_feat_enabled)
-		return ops->dev_feat_enabled(dev, feat);
+	if (dev->iommu && dev->iommu->ops->dev_feat_enabled)
+		return dev->iommu->ops->dev_feat_enabled(dev, feat);
 
 	return false;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 524ffc2ff64f..ff0c76bdfb67 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -354,6 +354,7 @@ struct iommu_fault_param {
  * @fault_param: IOMMU detected device fault reporting data
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
+ * @ops:	 iommu-ops for talking to the iommu_dev
  * @priv:	 IOMMU Driver private data
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
@@ -364,6 +365,7 @@ struct dev_iommu {
 	struct iommu_fault_param	*fault_param;
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
+	const struct iommu_ops		*ops;
 	void				*priv;
 };
 
-- 
2.17.1

