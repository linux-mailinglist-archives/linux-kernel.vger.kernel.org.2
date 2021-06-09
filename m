Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D73A15BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhFINiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:38:09 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:60120
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232746AbhFINiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=mpWgQxD/es1HAvw4vQKokeYKFNfj/Tm+Idn8T6cKuKs=; b=o
        KwoOt0lSJ1oFPH3WfdLLIcDlZCw26xNgOQZAEUZZdrrQVELkm+bRyPbMho4k0Ypj
        YbvFhVA68pu/STaGmDpseXkOKjaQ9gDLz47FFz3O4Ih/UqEmw6296nijK31iJWaL
        IfNT6aSqFW0K47j+2GuuTwuwTwXUItT/4/arePD2Zk=
Received: from localhost.localdomain (unknown [10.162.183.236])
        by app1 (Coremail) with SMTP id XAUFCgD3_QGGw8BgAX4+AA--.4490S3;
        Wed, 09 Jun 2021 21:35:03 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation
Date:   Wed,  9 Jun 2021 21:33:24 +0800
Message-Id: <1623245616-11057-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgD3_QGGw8BgAX4+AA--.4490S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryxJw43ZF1kKr18Cr47XFb_yoW8ur13pF
        48Wr9YyF1rW3WUJFyDJw4vvF90vayIyFyjgFW7Gas8Cw15trWrK3WrKF9IgF1kCry8Cw43
        Zr12qFW5uF4UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
refcount of the "smmu" even though the return value is less than 0.

The reference counting issue happens in several exception handling paths
of arm_smmu_iova_to_phys_hard(). When those error scenarios occur, the
function forgets to decrease the refcount of "smmu" increased by
arm_smmu_rpm_get(), causing a refcount leak.

Fix this issue by jumping to "out" label when those error scenarios
occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..023dcd72ed35 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1271,10 +1271,11 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	u64 phys;
 	unsigned long va, flags;
 	int ret, idx = cfg->cbndx;
+	phys_addr_t addr = 0;
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return 0;
+		goto out;
 
 	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
 	va = iova & ~0xfffUL;
@@ -1290,6 +1291,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		dev_err(dev,
 			"iova to phys timed out on %pad. Falling back to software table walk.\n",
 			&iova);
+		arm_smmu_rpm_put(smmu);
 		return ops->iova_to_phys(ops, iova);
 	}
 
@@ -1298,12 +1300,14 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	if (phys & ARM_SMMU_CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
 		dev_err(dev, "PAR = 0x%llx\n", phys);
-		return 0;
+		goto out;
 	}
 
+	addr = (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+out:
 	arm_smmu_rpm_put(smmu);
 
-	return (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+	return addr;
 }
 
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-- 
2.7.4

