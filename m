Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35393A15C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhFINiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:38:23 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:56474
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S236421AbhFINiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=OkHkIhhIF+nUZjZbINQyI6axCFfaFtk6/n5ulBOsI1c=; b=p
        1OJw7Oz6ZFv5QyUgpCZuL0ZJGG76QEDgucdurJoE+KKwV06vF6I1NBJlrGXV4kjp
        I1Q3WHuNYpMYNV+uCMz+6v4H1QE2qOHvI7xfnFXIP4Tu3bK8XN1xhEhLdASvKnBw
        k6XBKibVWx3TiCj7VlgtIyc9u8/LIa27i5ez2YLfKQ=
Received: from localhost.localdomain (unknown [10.162.183.236])
        by app1 (Coremail) with SMTP id XAUFCgAX+CCSw8BgN34+AA--.4410S3;
        Wed, 09 Jun 2021 21:35:14 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
Date:   Wed,  9 Jun 2021 21:35:07 +0800
Message-Id: <1623245709-11123-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgAX+CCSw8BgN34+AA--.4410S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryxJw1kuFWDKr48XF1kKrg_yoW5JFykpa
        1Uu390vF4kGFy0yr1DAw40vF98W3yIvF9Fyr4xGas8ur13t3s8KF12y34a9a4kCrW8Ja13
        Ar42qr45CF15AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
refcount of the "smmu" even though the return value is less than 0.

The reference counting issue happens in some error handling paths of
arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
fails, the caller functions forget to decrease the refcount of "smmu"
increased by arm_smmu_rpm_get(), causing a refcount leak.

Fix this issue by calling arm_smmu_rpm_put() or jumping to the "rpm_put"
label when arm_smmu_rpm_get() fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..177ee54c5534 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -840,7 +840,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return;
+		goto rpm_put;
 
 	/*
 	 * Disable the context bank and free the page tables before freeing
@@ -857,6 +857,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 
+rpm_put:
 	arm_smmu_rpm_put(smmu);
 }
 
@@ -1153,7 +1154,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return ret;
+		goto rpm_put;
 
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu, dev);
@@ -1404,7 +1405,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		goto out_cfg_free;
+		goto rpm_put;
 
 	ret = arm_smmu_master_alloc_smes(dev);
 	arm_smmu_rpm_put(smmu);
@@ -1417,6 +1418,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	return &smmu->iommu;
 
+rpm_put:
+	arm_smmu_rpm_put(smmu);
 out_cfg_free:
 	kfree(cfg);
 out_free:
@@ -1438,8 +1441,10 @@ static void arm_smmu_release_device(struct device *dev)
 	smmu = cfg->smmu;
 
 	ret = arm_smmu_rpm_get(smmu);
-	if (ret < 0)
+	if (ret < 0) {
+		arm_smmu_rpm_put(smmu);
 		return;
+	}
 
 	arm_smmu_master_free_smes(cfg, fwspec);
 
-- 
2.7.4

