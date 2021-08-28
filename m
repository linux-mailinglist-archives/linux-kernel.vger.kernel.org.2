Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2C3FA40A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 08:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhH1Gno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 02:43:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14429 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhH1Gnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 02:43:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GxRkT5CJyzbd7V;
        Sat, 28 Aug 2021 14:38:57 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 14:42:49 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 28 Aug
 2021 14:42:49 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <thunder.leizhen@huawei.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next v3 2/2] iommu/arm-smmu-v3: Add suspend and resume support
Date:   Sat, 28 Aug 2021 14:39:15 +0800
Message-ID: <20210828063916.39633-2-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210828063916.39633-1-cuibixuan@huawei.com>
References: <20210828063916.39633-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend and resume support for arm-smmu-v3 by low-power mode.

When the smmu is suspended, it is powered off and the registers are
cleared. So saves the msi_msg context during msi interrupt initialization
of smmu. When resume happens it calls arm_smmu_device_reset() to restore
the registers.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
Changes in v3:
* Move the code of save msg context into msi platform (A new patch: "platform-msi: Save the msg context to desc in platform_msi_write_msg()").

* Add bypass member to the struct arm_smmu_device for per-SMMU bypass control(used by resume mode).

* Separate interrupt requests and register operations in arm_smmu_device_reset(). The arm_smmu_setup_irqs() is added to request interrupts and is called before arm_smmu_device_reset(). The arm_smmu_device_reset() resets irq registers (can also be called in resume mode).

Changes in v2:
* Using get_cached_msi_msg() instead of the descriptor to resume msi_msg
  in arm_smmu_resume_msis();

* Move arm_smmu_resume_msis() from arm_smmu_setup_unique_irqs() into
  arm_smmu_setup_irqs() and rename it to arm_smmu_resume_unique_irqs();

  Call arm_smmu_setup_unique_irqs() to configure the IRQ during probe and
  call arm_smmu_resume_unique_irqs() in resume mode to restore the IRQ
  registers to make the code more reasonable.

* Call arm_smmu_device_disable() to disable smmu and clear CR0_SMMUEN on
  suspend. Then the warning about CR0_SMMUEN being enabled can be cleared
  on resume.

* Using SET_SYSTEM_SLEEP_PM_OPS();

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 99 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a388e318f86e..95a1c2689685 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3282,6 +3282,61 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static void arm_smmu_reset_unique_irqs(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	desc = irq_get_msi_desc(smmu->evtq.q.irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	desc = irq_get_msi_desc(smmu->gerr_irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->gerr_irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		desc = irq_get_msi_desc(smmu->priq.q.irq);
+		if (desc) {
+			get_cached_msi_msg(smmu->priq.q.irq, &msg);
+			arm_smmu_write_msi_msg(desc, &msg);
+		}
+	}
+}
+
+static int arm_smmu_reset_irqs(struct arm_smmu_device *smmu)
+{
+	int ret, irq;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+
+	/* Disable IRQs first */
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				      ARM_SMMU_IRQ_CTRLACK);
+	if (ret) {
+		dev_err(smmu->dev, "failed to disable irqs\n");
+		return ret;
+	}
+
+	irq = smmu->combined_irq;
+	if (!irq)
+		arm_smmu_reset_unique_irqs(smmu);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+
+	/* Enable interrupt generation on the SMMU */
+	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
+				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
+	if (ret)
+		dev_warn(smmu->dev, "failed to reset irqs\n");
+
+	return 0;
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -3293,7 +3348,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
 	u32 reg, enables;
@@ -3401,9 +3456,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
+	ret = arm_smmu_reset_irqs(smmu);
 	if (ret) {
-		dev_err(smmu->dev, "failed to setup irqs\n");
+		dev_err(smmu->dev, "failed to reset irqs\n");
 		return ret;
 	}
 
@@ -3411,7 +3466,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
-	if (!bypass || disable_bypass) {
+	if (!smmu->bypass || disable_bypass) {
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
@@ -3758,6 +3813,25 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 	return devm_ioremap_resource(dev, &res);
 }
 
+static int __maybe_unused arm_smmu_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	/* disable smmu to clear CR0 */
+	arm_smmu_device_disable(smmu);
+
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_device_reset(smmu);
+
+	return 0;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3765,7 +3839,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -3781,7 +3854,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	/* Set bypass mode according to firmware probing result */
-	bypass = !!ret;
+	smmu->bypass = !!ret;
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -3839,8 +3912,15 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 
+	/* Setup irqs */
+	ret = arm_smmu_setup_irqs(smmu);
+	if (ret) {
+		dev_err(smmu->dev, "failed to setup irqs\n");
+		return ret;
+	}
+
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu);
 	if (ret)
 		return ret;
 
@@ -3893,6 +3973,10 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_suspend, arm_smmu_resume)
+};
+
 static void arm_smmu_driver_unregister(struct platform_driver *drv)
 {
 	arm_smmu_sva_notifier_synchronize();
@@ -3904,6 +3988,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
 		.suppress_bind_attrs	= true,
+		.pm			= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f07914..7777a7445bc2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -675,6 +675,7 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	bool				bypass;
 };
 
 struct arm_smmu_stream {
-- 
2.17.1

