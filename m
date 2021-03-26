Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880F334A1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCZG00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:26:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14144 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCZGZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:25:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6Bjj4w3qznWsf;
        Fri, 26 Mar 2021 14:23:05 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 5/8] iommu: fix a couple of spelling mistakes
Date:   Fri, 26 Mar 2021 14:24:09 +0800
Message-ID: <20210326062412.1262-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210326062412.1262-1-thunder.leizhen@huawei.com>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several spelling mistakes, as follows:
funcions ==> functions
distiguish ==> distinguish
detroyed ==> destroyed

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iommu.c | 4 ++--
 drivers/iommu/iova.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba8413c..0f4e9a6122ee58f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1453,7 +1453,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 
 	/*
 	 * Look for existing groups on non-isolated functions on the same
-	 * slot and aliases of those funcions, if any.  No need to clear
+	 * slot and aliases of those functions, if any.  No need to clear
 	 * the search bitmap, the tested devfns are still valid.
 	 */
 	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
@@ -2267,7 +2267,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
  * iterating over the devices in a group.  Ideally we'd have a single
  * device which represents the requestor ID of the group, but we also
  * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
+ * the physical hardware may be able to distinguish members, but we
  * wish to group them at a higher level (ex. untrusted multi-function
  * PCI devices).  Thus we attach each device.
  */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c3f8..bf710b0a3713e21 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -524,7 +524,7 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	int cpu;
 
 	/*
-	 * This code runs when the iova_domain is being detroyed, so don't
+	 * This code runs when the iova_domain is being destroyed, so don't
 	 * bother to free iovas, just call the entry_dtor on all remaining
 	 * entries.
 	 */
-- 
1.8.3


