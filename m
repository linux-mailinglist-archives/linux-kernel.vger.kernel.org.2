Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA03427E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 04:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhJJCf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 22:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhJJCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 22:35:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F86C061762
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 19:33:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z11so48241817lfj.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8MR/G+R6dUa+Wsak7wjS+wkWi7PQwjwNuQYwbKSDbs=;
        b=zsm4QGk8rPd0xznOtFQ4jM80KtqL6ElVzYNVtbULnt2VHGFGaqGQ7IBeRCpToy8QqY
         jhZJajveM8niezxDR4oPUnd6i2H+QSkDf0koHaqlaS/jjfuhzl1LDxD5n3UrISdt612y
         3QOjwAj8MnSWmCzR4bLzRBMKSxRgRuLZQkxq2ZM1CZttdVdZfbI8blnawJ+G5wHMimro
         OEcln7Qkhx0sFcTamb0Aa6vJloLkLAyPGGJm4pclFSG8/0/6zUpdjepSBRWKJwPIceKm
         RJtGgOkyHwxbcllHuO0MHDiJvyN3jRzuQAZUnei00npwrQaDOPCkpuhPqSSKi8XF0wTX
         xIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8MR/G+R6dUa+Wsak7wjS+wkWi7PQwjwNuQYwbKSDbs=;
        b=1OGNF2hquGiQf75yMa4HZQJFbltoW7MTAsayFOPwk5XYP6UaIdLeMrNEXGKo+aPf1q
         9Y39QqDlFcB7QERLgCnMKNrcmcnAzhmi5ybdl3rQctftJJ74qa/v+mn1V2FCi5ccKRLE
         RhubbOFxc5mgUJFAY+6J98y3GSrrlnqpnN5yNTJ6r/eaeV2FoulZ+VTYPUqGl0WRVVTK
         vYWgTnvpy0EMEkbd9n8slp+wYjci9cppXaLzjmCnkxKJXwwMwfGJB+RBcpUwb1fx9K01
         VdWrqbR9EiAMgA4+NIFcfW6EAasP8ffEz/Gf7WIxvVCZhGY/8FbW5FgMg3pEmcrRoVPi
         QTgQ==
X-Gm-Message-State: AOAM5301/+D039mhQ78vypcmXKHX4g7IHGct2Qt6r+B/Y/8do0X99gyx
        Xzei2JusppE+HQ7q4dxH2hCJKoKErCFLsw==
X-Google-Smtp-Source: ABdhPJwSGRHUjgYDj6ZuRGbJ8leAofMXLbnvvETRVb2XglZdualtHhvMW4bmUmSAHrmweRUkmAHnFw==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr13538657ljc.527.1633833232637;
        Sat, 09 Oct 2021 19:33:52 -0700 (PDT)
Received: from umbar.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p23sm345322lfd.127.2021.10.09.19.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 19:33:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <treding@nvidia.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
Date:   Sun, 10 Oct 2021 05:33:50 +0300
Message-Id: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
qcom_smmu_impl_init() is never called.

So, let's fix this by always calling qcom_smmu_impl_init(). It does not
touch the smmu passed unless the device is a non-Qualcomm one. Make
ARM_SMMU select QCOM_SCM for ARCH_QCOM.

Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/Kconfig                      | 1 +
 drivers/iommu/arm/arm-smmu/Makefile        | 3 +--
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 9 +++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c5c71b7ab7e8..a4593e53fe7d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -309,6 +309,7 @@ config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
 	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
+	select QCOM_SCM
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
 	help
diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
index b0cc01aa20c9..e240a7bcf310 100644
--- a/drivers/iommu/arm/arm-smmu/Makefile
+++ b/drivers/iommu/arm/arm-smmu/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
-arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
-arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 2c25cce38060..8199185dd262 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -215,8 +215,13 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	    of_device_is_compatible(np, "nvidia,tegra186-smmu"))
 		return nvidia_smmu_impl_init(smmu);
 
-	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
-		smmu = qcom_smmu_impl_init(smmu);
+	/*
+	 * qcom_smmu_impl_init() will not touch smmu if the device is not
+	 * a Qualcomm one.
+	 */
+	smmu = qcom_smmu_impl_init(smmu);
+	if (IS_ERR(smmu))
+		return smmu;
 
 	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
 		smmu->impl = &mrvl_mmu500_impl;
-- 
2.30.2

