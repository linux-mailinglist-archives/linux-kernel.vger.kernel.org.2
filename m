Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F107351F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhDASy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:54:57 -0400
Received: from foss.arm.com ([217.140.110.172]:47230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239171AbhDASpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:45:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2135931B;
        Thu,  1 Apr 2021 06:56:33 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54D7E3F719;
        Thu,  1 Apr 2021 06:56:32 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: [PATCH v2 1/2] iommu: Statically set module owner
Date:   Thu,  1 Apr 2021 14:56:25 +0100
Message-Id: <31423b99ff609c3d4b291c701a7a7a810d9ce8dc.1617285386.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It happens that the 3 drivers which first supported being modular are
also ones which play games with their pgsize_bitmap, so have non-const
iommu_ops where dynamically setting the owner manages to work out OK.
However, it's less than ideal to force that upon all drivers which want
to be modular - like the new sprd-iommu driver which now has a potential
bug in that regard - so let's just statically set the module owner and
let ops remain const wherever possible.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 +
 drivers/iommu/sprd-iommu.c                  | 1 +
 drivers/iommu/virtio-iommu.c                | 1 +
 include/linux/iommu.h                       | 9 +--------
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8594b4a83043..b82000519af6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2632,6 +2632,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.sva_unbind		= arm_smmu_sva_unbind,
 	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.owner			= THIS_MODULE,
 };
 
 /* Probing and initialisation functions */
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d8c6bfde6a61..11ca963c4b93 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1638,6 +1638,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.owner			= THIS_MODULE,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index e1dc2f7d5639..b5edf0e82176 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -436,6 +436,7 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.device_group	= sprd_iommu_device_group,
 	.of_xlate	= sprd_iommu_of_xlate,
 	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
+	.owner		= THIS_MODULE,
 };
 
 static const struct of_device_id sprd_iommu_of_match[] = {
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 2bfdd5734844..594ed827e944 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -945,6 +945,7 @@ static struct iommu_ops viommu_ops = {
 	.get_resv_regions	= viommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.of_xlate		= viommu_of_xlate,
+	.owner			= THIS_MODULE,
 };
 
 static int viommu_init_vqs(struct viommu_dev *viommu)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..dce8c5e12ea0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -379,19 +379,12 @@ int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
 
-static inline void __iommu_device_set_ops(struct iommu_device *iommu,
+static inline void iommu_device_set_ops(struct iommu_device *iommu,
 					  const struct iommu_ops *ops)
 {
 	iommu->ops = ops;
 }
 
-#define iommu_device_set_ops(iommu, ops)				\
-do {									\
-	struct iommu_ops *__ops = (struct iommu_ops *)(ops);		\
-	__ops->owner = THIS_MODULE;					\
-	__iommu_device_set_ops(iommu, __ops);				\
-} while (0)
-
 static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
 					   struct fwnode_handle *fwnode)
 {
-- 
2.21.0.dirty

