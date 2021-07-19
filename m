Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9CA3CCDC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhGSGEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:04:10 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:52498
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229916AbhGSGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=OHtXPeheLKt25R6qdl+TNvmKAmxTmqb0MxhK2ixgViI=; b=X
        IbDjUKJcxKOQTCFX0mso/24KvENgvOGgZ2lbFLgvHyKIJ9x6OH89tPvmd+7JGKgJ
        ZiVD656QfGsMr9LNHF90JXGz63zH0Q3ijIF5S63EG1cL8xB2lE7J04HGsjJe9JXI
        JGFn+aGJyLbDfCtp1LzFS2DxMz+9nbdeXC0H0BDFQo=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app2 (Coremail) with SMTP id XQUFCgAn32gHFfVgD0joBA--.1817S3;
        Mon, 19 Jul 2021 14:00:40 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on device_state->count
Date:   Mon, 19 Jul 2021 14:00:37 +0800
Message-Id: <1626674437-56007-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgAn32gHFfVgD0joBA--.1817S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZFykZr15CF15Jwb_yoW8Kr1kpF
        4DGFy5KFW8Xrn7Kr13Aw17ur90g34kZ3yfKryjy3s7KFy3J3y5K3WkZFy7ArWUJFZ3Zry7
        X3Wj9rs5uayjgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUqFALUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/iommu/amd/iommu_v2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index f8d4ad421e07..15d64f916fe5 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
 
+#include <linux/refcount.h>
 #include <linux/mmu_notifier.h>
 #include <linux/amd-iommu.h>
 #include <linux/mm_types.h>
@@ -51,7 +52,7 @@ struct pasid_state {
 struct device_state {
 	struct list_head list;
 	u16 devid;
-	atomic_t count;
+	refcount_t count;
 	struct pci_dev *pdev;
 	struct pasid_state **states;
 	struct iommu_domain *domain;
@@ -113,7 +114,7 @@ static struct device_state *get_device_state(u16 devid)
 	spin_lock_irqsave(&state_lock, flags);
 	dev_state = __get_device_state(devid);
 	if (dev_state != NULL)
-		atomic_inc(&dev_state->count);
+		refcount_inc(&dev_state->count);
 	spin_unlock_irqrestore(&state_lock, flags);
 
 	return dev_state;
@@ -144,7 +145,7 @@ static void free_device_state(struct device_state *dev_state)
 
 static void put_device_state(struct device_state *dev_state)
 {
-	if (atomic_dec_and_test(&dev_state->count))
+	if (refcount_dec_and_test(&dev_state->count))
 		wake_up(&dev_state->wq);
 }
 
@@ -765,7 +766,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
 		dev_state->pasid_levels += 1;
 
-	atomic_set(&dev_state->count, 1);
+	refcount_set(&dev_state->count, 1);
 	dev_state->max_pasids = pasids;
 
 	ret = -ENOMEM;
@@ -856,7 +857,7 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 	 * Wait until the last reference is dropped before freeing
 	 * the device state.
 	 */
-	wait_event(dev_state->wq, !atomic_read(&dev_state->count));
+	wait_event(dev_state->wq, !refcount_read(&dev_state->count));
 	free_device_state(dev_state);
 }
 EXPORT_SYMBOL(amd_iommu_free_device);
-- 
2.7.4

