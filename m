Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2913254FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBYR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:56:50 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:23394 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhBYRwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:52:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614275516; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZDGR5WTE71UWjGbLXummZenmiFD67TKIVvSM4QXt9uU=; b=AZSYDtZxM17V7ldFXDMs6RNPlrA2wERJb2byeveZJMkvK+FgxbfEjU5FER/b4JU/l9fofuyG
 D5lwIBCaJu32dtRcPHuYPHathzo4p2WJdF9Ic80k9Dh7ENusNNzaOFxMwMeHEzOVmVpPIWR1
 yoAXyG1aHZUXwmGyecgpGoaBYhs=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6037e3b67f306299bfc9704f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 17:51:49
 GMT
Sender: jcrouse=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E792C43467; Thu, 25 Feb 2021 17:51:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B5ABC433C6;
        Thu, 25 Feb 2021 17:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B5ABC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Rob Clark <robdclark@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/msm: Add an adreno-smmu-priv callback to get pagefault info
Date:   Thu, 25 Feb 2021 10:51:34 -0700
Message-Id: <20210225175135.91922-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225175135.91922-1-jcrouse@codeaurora.org>
References: <20210225175135.91922-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a callback in adreno-smmu-priv to read interesting SMMU
registers to provide an opportunity for a richer debug experience
in the GPU driver.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
 include/linux/adreno-smmu-priv.h           | 31 +++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 98b3a1c2a181..8413bfbafed4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -32,6 +32,24 @@ static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
 
+static void qcom_adreno_smmu_get_fault_info(const void *cookie,
+		struct adreno_smmu_fault_info *info)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
+	/* FIXME: return error here if we aren't really in a fault? */
+
+	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
+	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
+	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
+	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
+	info->ttbr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
+	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
+}
+
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
@@ -156,6 +174,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->cookie = smmu_domain;
 	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
+	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index d2a2d1bc58ba..9e84daf27dab 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -224,6 +224,8 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_FSYNR0		0x68
 #define ARM_SMMU_FSYNR0_WNR		BIT(4)
 
+#define ARM_SMMU_CB_FSYNR1		0x6c
+
 #define ARM_SMMU_CB_S1_TLBIVA		0x600
 #define ARM_SMMU_CB_S1_TLBIASID		0x610
 #define ARM_SMMU_CB_S1_TLBIVAL		0x620
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index a889f28afb42..53fe32fb9214 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -8,6 +8,32 @@
 
 #include <linux/io-pgtable.h>
 
+/**
+ * struct adreno_smmu_fault_info - container for key fault information
+ *
+ * @far: The faulting IOVA from ARM_SMMU_CB_FAR
+ * @ttbr0: The current TTBR0 pagetable from ARM_SMMU_CB_TTBR0
+ * @contextidr: The value of ARM_SMMU_CB_CONTEXTIDR
+ * @fsr: The fault status from ARM_SMMU_CB_FSR
+ * @fsynr0: The value of FSYNR0 from ARM_SMMU_CB_FSYNR0
+ * @fsynr1: The value of FSYNR1 from ARM_SMMU_CB_FSYNR0
+ * @cbfrsynra: The value of CBFRSYNRA from ARM_SMMU_GR1_CBFRSYNRA(idx)
+ *
+ * This struct passes back key page fault information to the GPU driver
+ * through the get_fault_info function pointer.
+ * The GPU driver can use this information to print informative
+ * log messages and provide deeper GPU specific insight into the fault.
+ */
+struct adreno_smmu_fault_info {
+	u64 far;
+	u64 ttbr0;
+	u32 contextidr;
+	u32 fsr;
+	u32 fsynr0;
+	u32 fsynr1;
+	u32 cbfrsynra;
+};
+
 /**
  * struct adreno_smmu_priv - private interface between adreno-smmu and GPU
  *
@@ -17,6 +43,8 @@
  * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
  *                 NULL config disables TTBR0 translation, otherwise
  *                 TTBR0 translation is enabled with the specified cfg
+ * @get_fault_info: Called by the GPU fault handler to get information about
+ *                  the fault
  *
  * The GPU driver (drm/msm) and adreno-smmu work together for controlling
  * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
@@ -31,6 +59,7 @@ struct adreno_smmu_priv {
     const void *cookie;
     const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
     int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
+    void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
 };
 
-#endif /* __ADRENO_SMMU_PRIV_H */
\ No newline at end of file
+#endif /* __ADRENO_SMMU_PRIV_H */
-- 
2.25.1

