Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D663D74E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhG0MQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:16:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7068 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhG0MQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:16:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GYwcG1Z6VzYgRB;
        Tue, 27 Jul 2021 20:10:54 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 20:16:48 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 20:16:48 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <will@kernel.org>
CC:     <cuibixuan@huawei.com>, <weiyongjun1@huawei.com>,
        <john.wanghui@huawei.com>, <dingtianhong@huawei.com>,
        <thunder.leizhen@huawei.com>, <guohanjun@huawei.com>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next v2] iommu/arm-smmu-v3: Add suspend and resume support
Date:   Tue, 27 Jul 2021 20:14:08 +0800
Message-ID: <20210727121408.81883-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 ++++++++++++++++++---
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 235f9bdaeaf2..66f35d5c7a70 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
 
 static bool disable_msipolling;
 module_param(disable_msipolling, bool, 0444);
+static bool bypass;
 MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
@@ -3129,11 +3130,38 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
+	/* Saves the msg context for resume if desc->msg is empty */
+	if (desc->msg.address_lo == 0x0 && desc->msg.address_hi == 0x0) {
+		desc->msg.address_lo = msg->address_lo;
+		desc->msg.address_hi = msg->address_hi;
+		desc->msg.data = msg->data;
+	}
+
 	writeq_relaxed(doorbell, smmu->base + cfg[0]);
 	writel_relaxed(msg->data, smmu->base + cfg[1]);
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	desc = irq_get_msi_desc(smmu->evtq.q.irq);
+	get_cached_msi_msg(smmu->evtq.q.irq, &msg);
+	arm_smmu_write_msi_msg(desc, &msg);
+
+	desc = irq_get_msi_desc(smmu->gerr_irq);
+	get_cached_msi_msg(smmu->gerr_irq, &msg);
+	arm_smmu_write_msi_msg(desc, &msg);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		desc = irq_get_msi_desc(smmu->priq.q.irq);
+		get_cached_msi_msg(smmu->priq.q.irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	struct msi_desc *desc;
@@ -3230,7 +3258,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	}
 }
 
-static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu, bool resume_mode)
 {
 	int ret, irq;
 	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
@@ -3256,8 +3284,12 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 					"arm-smmu-v3-combined-irq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
-	} else
-		arm_smmu_setup_unique_irqs(smmu);
+	} else {
+		if (!resume_mode)
+			arm_smmu_setup_unique_irqs(smmu);
+		else
+			arm_smmu_resume_unique_irqs(smmu);
+	}
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
@@ -3282,7 +3314,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume_mode)
 {
 	int ret;
 	u32 reg, enables;
@@ -3392,7 +3424,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
+	ret = arm_smmu_setup_irqs(smmu, resume_mode);
 	if (ret) {
 		dev_err(smmu->dev, "failed to setup irqs\n");
 		return ret;
@@ -3749,6 +3781,25 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
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
+	arm_smmu_device_reset(smmu, true);
+
+	return 0;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3756,7 +3807,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -3831,7 +3881,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu, false);
 	if (ret)
 		return ret;
 
@@ -3884,6 +3934,10 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_suspend, arm_smmu_resume)
+};
+
 static void arm_smmu_driver_unregister(struct platform_driver *drv)
 {
 	arm_smmu_sva_notifier_synchronize();
@@ -3895,6 +3949,7 @@ static struct platform_driver arm_smmu_driver = {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
 		.suppress_bind_attrs	= true,
+		.pm			= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
2.17.1

