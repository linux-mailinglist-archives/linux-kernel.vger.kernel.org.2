Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B885341D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCSMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:52:30 -0400
Received: from foss.arm.com ([217.140.110.172]:49244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhCSMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:52:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D9F2101E;
        Fri, 19 Mar 2021 05:52:07 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD1A83F718;
        Fri, 19 Mar 2021 05:52:06 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu: Streamline registration interface
Date:   Fri, 19 Mar 2021 12:52:02 +0000
Message-Id: <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have separate opaque setter functions that are easy to
overlook and lead to repetitive boilerplate in drivers, let's pass the
relevant initialisation parameters directly to iommu_device_register().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/init.c                    |  3 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  5 +---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  5 +---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  5 +---
 drivers/iommu/exynos-iommu.c                |  5 +---
 drivers/iommu/fsl_pamu_domain.c             |  4 +--
 drivers/iommu/intel/dmar.c                  |  4 +--
 drivers/iommu/intel/iommu.c                 |  3 +--
 drivers/iommu/iommu.c                       |  7 ++++-
 drivers/iommu/ipmmu-vmsa.c                  |  6 +----
 drivers/iommu/msm_iommu.c                   |  5 +---
 drivers/iommu/mtk_iommu.c                   |  5 +---
 drivers/iommu/mtk_iommu_v1.c                |  4 +--
 drivers/iommu/omap-iommu.c                  |  5 +---
 drivers/iommu/rockchip-iommu.c              |  5 +---
 drivers/iommu/s390-iommu.c                  |  4 +--
 drivers/iommu/sprd-iommu.c                  |  5 +---
 drivers/iommu/sun50i-iommu.c                |  5 +---
 drivers/iommu/tegra-gart.c                  |  5 +---
 drivers/iommu/tegra-smmu.c                  |  5 +---
 drivers/iommu/virtio-iommu.c                |  5 +---
 include/linux/iommu.h                       | 29 ++++-----------------
 22 files changed, 31 insertions(+), 98 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed..e1ef922d9f8f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1935,8 +1935,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
 			       amd_iommu_groups, "ivhd%d", iommu->index);
-	iommu_device_set_ops(&iommu->iommu, &amd_iommu_ops);
-	iommu_device_register(&iommu->iommu);
+	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
 
 	return pci_enable_device(iommu->dev);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b82000519af6..ecc6cfe3ae90 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3621,10 +3621,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	iommu_device_set_ops(&smmu->iommu, &arm_smmu_ops);
-	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
-
-	ret = iommu_device_register(&smmu->iommu);
+	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 11ca963c4b93..0a697cb0d2f8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2222,10 +2222,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	iommu_device_set_ops(&smmu->iommu, &arm_smmu_ops);
-	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
-
-	err = iommu_device_register(&smmu->iommu);
+	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (err) {
 		dev_err(dev, "Failed to register iommu\n");
 		return err;
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 7f280c8d5c53..4294abe389b2 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -847,10 +847,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	iommu_device_set_ops(&qcom_iommu->iommu, &qcom_iommu_ops);
-	iommu_device_set_fwnode(&qcom_iommu->iommu, dev->fwnode);
-
-	ret = iommu_device_register(&qcom_iommu->iommu);
+	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
 		return ret;
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index de324b4eedfe..f887c3e111c1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -630,10 +630,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
-	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
-
-	ret = iommu_device_register(&data->iommu);
+	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index b2110767caf4..1a15bd5da358 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1053,9 +1053,7 @@ int __init pamu_domain_init(void)
 	if (ret)
 		return ret;
 
-	iommu_device_set_ops(&pamu_iommu, &fsl_pamu_ops);
-
-	ret = iommu_device_register(&pamu_iommu);
+	ret = iommu_device_register(&pamu_iommu, &fsl_pamu_ops, NULL);
 	if (ret) {
 		iommu_device_sysfs_remove(&pamu_iommu);
 		pr_err("Can't register iommu device\n");
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6971397805f3..1757ac1e1623 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1140,9 +1140,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		if (err)
 			goto err_unmap;
 
-		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
-
-		err = iommu_device_register(&iommu->iommu);
+		err = iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 		if (err)
 			goto err_unmap;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 167219ea8d70..db0addebefc3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4379,8 +4379,7 @@ int __init intel_iommu_init(void)
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
 				       "%s", iommu->name);
-		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
-		iommu_device_register(&iommu->iommu);
+		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 	}
 	up_read(&dmar_global_lock);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e10cfa99057c..bef7325661d6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -152,8 +152,13 @@ static int __init iommu_subsys_init(void)
 }
 subsys_initcall(iommu_subsys_init);
 
-int iommu_device_register(struct iommu_device *iommu)
+int iommu_device_register(struct iommu_device *iommu, const struct iommu_ops *ops,
+			    struct device *hwdev)
 {
+	iommu->ops = ops;
+	if (hwdev)
+		iommu->fwnode = hwdev->fwnode;
+
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index eaaec0a55cc6..aaa6a4d59057 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1076,11 +1076,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		iommu_device_set_ops(&mmu->iommu, &ipmmu_ops);
-		iommu_device_set_fwnode(&mmu->iommu,
-					&pdev->dev.of_node->fwnode);
-
-		ret = iommu_device_register(&mmu->iommu);
+		ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f0ba6a09b434..7880f307cb2d 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -792,10 +792,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	iommu_device_set_ops(&iommu->iommu, &msm_iommu_ops);
-	iommu_device_set_fwnode(&iommu->iommu, &pdev->dev.of_node->fwnode);
-
-	ret = iommu_device_register(&iommu->iommu);
+	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
 		goto fail;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6ecc007f07cd..fb3abc23a000 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -898,10 +898,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_link_remove;
 
-	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
-	iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
-
-	ret = iommu_device_register(&data->iommu);
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
 	if (ret)
 		goto out_sysfs_remove;
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 82ddfe9170d4..3aa07995060b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -620,9 +620,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
-
-	ret = iommu_device_register(&data->iommu);
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 71f29c0927fc..26e517eb0dd3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1235,10 +1235,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		if (err)
 			goto out_group;
 
-		iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
-		iommu_device_set_fwnode(&obj->iommu, &of->fwnode);
-
-		err = iommu_device_register(&obj->iommu);
+		err = iommu_device_register(&obj->iommu, &omap_iommu_ops, &pdev->dev);
 		if (err)
 			goto out_sysfs;
 	}
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e5d86b7177de..7a2932772fdf 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1196,10 +1196,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		goto err_put_group;
 
-	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
-	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
-
-	err = iommu_device_register(&iommu->iommu);
+	err = iommu_device_register(&iommu->iommu, &rk_iommu_ops, dev);
 	if (err)
 		goto err_remove_sysfs;
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 8895dbb705eb..6019e58ce4fb 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -333,9 +333,7 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 	if (rc)
 		goto out_err;
 
-	iommu_device_set_ops(&zdev->iommu_dev, &s390_iommu_ops);
-
-	rc = iommu_device_register(&zdev->iommu_dev);
+	rc = iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops, NULL);
 	if (rc)
 		goto out_sysfs;
 
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 024a0cdd26a6..0b5f88a28417 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -508,10 +508,7 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_group;
 
-	iommu_device_set_ops(&sdev->iommu, &sprd_iommu_ops);
-	iommu_device_set_fwnode(&sdev->iommu, &dev->of_node->fwnode);
-
-	ret = iommu_device_register(&sdev->iommu);
+	ret = iommu_device_register(&sdev->iommu, &sprd_iommu_ops, dev);
 	if (ret)
 		goto remove_sysfs;
 
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index ea6db1341916..181bb1c3437c 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -968,10 +968,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_group;
 
-	iommu_device_set_ops(&iommu->iommu, &sun50i_iommu_ops);
-	iommu_device_set_fwnode(&iommu->iommu, &pdev->dev.of_node->fwnode);
-
-	ret = iommu_device_register(&iommu->iommu);
+	ret = iommu_device_register(&iommu->iommu, &sun50i_iommu_ops, &pdev->dev);
 	if (ret)
 		goto err_remove_sysfs;
 
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 6f130e51f072..6a358f92c7e5 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -353,10 +353,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	if (err)
 		goto free_gart;
 
-	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
-	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
-
-	err = iommu_device_register(&gart->iommu);
+	err = iommu_device_register(&gart->iommu, &gart_iommu_ops, dev);
 	if (err)
 		goto remove_sysfs;
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 602aab98c079..1e98dc63ad13 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1145,10 +1145,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	if (err)
 		return ERR_PTR(err);
 
-	iommu_device_set_ops(&smmu->iommu, &tegra_smmu_ops);
-	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
-
-	err = iommu_device_register(&smmu->iommu);
+	err = iommu_device_register(&smmu->iommu, &tegra_smmu_ops, dev);
 	if (err)
 		goto remove_sysfs;
 
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 594ed827e944..7c02481a81b4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1066,10 +1066,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
-	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
-
-	iommu_device_register(&viommu->iommu);
+	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &viommu_ops) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index dce8c5e12ea0..e70c1b859b9f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -368,7 +368,8 @@ struct dev_iommu {
 	void				*priv;
 };
 
-int  iommu_device_register(struct iommu_device *iommu);
+int iommu_device_register(struct iommu_device *iommu, const struct iommu_ops *ops,
+			  struct device *hwdev);
 void iommu_device_unregister(struct iommu_device *iommu);
 int  iommu_device_sysfs_add(struct iommu_device *iommu,
 			    struct device *parent,
@@ -379,18 +380,6 @@ int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
 
-static inline void iommu_device_set_ops(struct iommu_device *iommu,
-					  const struct iommu_ops *ops)
-{
-	iommu->ops = ops;
-}
-
-static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
-					   struct fwnode_handle *fwnode)
-{
-	iommu->fwnode = fwnode;
-}
-
 static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 {
 	return (struct iommu_device *)dev_get_drvdata(dev);
@@ -894,21 +883,13 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
-static inline int  iommu_device_register(struct iommu_device *iommu)
+static inline int iommu_device_register(struct iommu_device *iommu,
+					const struct iommu_ops *ops,
+					struct device *hwdev)
 {
 	return -ENODEV;
 }
 
-static inline void iommu_device_set_ops(struct iommu_device *iommu,
-					const struct iommu_ops *ops)
-{
-}
-
-static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
-					   struct fwnode_handle *fwnode)
-{
-}
-
 static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 {
 	return NULL;
-- 
2.21.0.dirty

