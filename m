Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26838C205
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhEUIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhEUIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:38:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40EC061763;
        Fri, 21 May 2021 01:36:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id D7F961F42944
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 3/4] iommu: rockchip: Add internal ops to handle variants
Date:   Fri, 21 May 2021 10:36:36 +0200
Message-Id: <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521083637.3221304-1-benjamin.gaignard@collabora.com>
References: <20210521083637.3221304-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add internal ops to be able to handle incoming variant v2.
The goal is to keep the overall structure of the framework but
to allow to add the evolution of this hardware block.

The ops are global for a SoC because iommu domains are not
attached to a specific devices if they are for a virtuel device like
drm. Use a global variable shouldn't be since SoC usually doesn't
embedded different versions of the iommu hardware block.
If that happen one day a WARN_ON will be displayed at probe time.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 5:
 - Use of_device_get_match_data()
 - Add internal ops inside the driver

 drivers/iommu/rockchip-iommu.c | 69 ++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 7a2932772fdf..e7b9bcf174b1 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
@@ -96,6 +97,14 @@ static const char * const rk_iommu_clocks[] = {
 	"aclk", "iface",
 };
 
+struct rk_iommu_ops {
+	phys_addr_t (*pt_address)(u32 dte);
+	u32 (*mk_dtentries)(dma_addr_t pt_dma);
+	u32 (*mk_ptentries)(phys_addr_t page, int prot);
+	phys_addr_t (*dte_addr_phys)(phys_addr_t addr);
+	u32 pt_address_mask;
+};
+
 struct rk_iommu {
 	struct device *dev;
 	void __iomem **bases;
@@ -116,6 +125,7 @@ struct rk_iommudata {
 };
 
 static struct device *dma_dev;
+static const struct rk_iommu_ops *rk_ops;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
@@ -215,11 +225,6 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
 #define RK_PTE_PAGE_READABLE      BIT(1)
 #define RK_PTE_PAGE_VALID         BIT(0)
 
-static inline phys_addr_t rk_pte_page_address(u32 pte)
-{
-	return (phys_addr_t)pte & RK_PTE_PAGE_ADDRESS_MASK;
-}
-
 static inline bool rk_pte_is_page_valid(u32 pte)
 {
 	return pte & RK_PTE_PAGE_VALID;
@@ -451,7 +456,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, DTE_ADDR_DUMMY);
 
 		dte_addr = rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR);
-		if (dte_addr != (DTE_ADDR_DUMMY & RK_DTE_PT_ADDRESS_MASK)) {
+		if (dte_addr != (DTE_ADDR_DUMMY & rk_ops->pt_address_mask)) {
 			dev_err(iommu->dev, "Error during raw reset. MMU_DTE_ADDR is not functioning\n");
 			return -EFAULT;
 		}
@@ -470,6 +475,11 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
+static inline phys_addr_t rk_dte_addr_phys(phys_addr_t addr)
+{
+	return addr;
+}
+
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -489,7 +499,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = (phys_addr_t)mmu_dte_addr;
+	mmu_dte_addr_phys = rk_ops->dte_addr_phys((phys_addr_t)mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -498,14 +508,14 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	if (!rk_dte_is_pt_valid(dte))
 		goto print_it;
 
-	pte_addr_phys = rk_dte_pt_address(dte) + (pte_index * 4);
+	pte_addr_phys = rk_ops->pt_address(dte) + (pte_index * 4);
 	pte_addr = phys_to_virt(pte_addr_phys);
 	pte = *pte_addr;
 
 	if (!rk_pte_is_page_valid(pte))
 		goto print_it;
 
-	page_addr_phys = rk_pte_page_address(pte) + page_offset;
+	page_addr_phys = rk_ops->pt_address(pte) + page_offset;
 	page_flags = pte & RK_PTE_PAGE_FLAGS_MASK;
 
 print_it:
@@ -601,13 +611,13 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
 	if (!rk_dte_is_pt_valid(dte))
 		goto out;
 
-	pt_phys = rk_dte_pt_address(dte);
+	pt_phys = rk_ops->pt_address(dte);
 	page_table = (u32 *)phys_to_virt(pt_phys);
 	pte = page_table[rk_iova_pte_index(iova)];
 	if (!rk_pte_is_page_valid(pte))
 		goto out;
 
-	phys = rk_pte_page_address(pte) + rk_iova_page_offset(iova);
+	phys = rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
 out:
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
 
@@ -679,14 +689,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	dte = rk_mk_dte(pt_dma);
+	dte = rk_ops->mk_dtentries(pt_dma);
 	*dte_addr = dte;
 
 	rk_table_flush(rk_domain, pt_dma, NUM_PT_ENTRIES);
 	rk_table_flush(rk_domain,
 		       rk_domain->dt_dma + dte_index * sizeof(u32), 1);
 done:
-	pt_phys = rk_dte_pt_address(dte);
+	pt_phys = rk_ops->pt_address(dte);
 	return (u32 *)phys_to_virt(pt_phys);
 }
 
@@ -728,7 +738,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 		if (rk_pte_is_page_valid(pte))
 			goto unwind;
 
-		pte_addr[pte_count] = rk_mk_pte(paddr, prot);
+		pte_addr[pte_count] = rk_ops->mk_ptentries(paddr, prot);
 
 		paddr += SPAGE_SIZE;
 	}
@@ -750,7 +760,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 			    pte_count * SPAGE_SIZE);
 
 	iova += pte_count * SPAGE_SIZE;
-	page_phys = rk_pte_page_address(pte_addr[pte_count]);
+	page_phys = rk_ops->pt_address(pte_addr[pte_count]);
 	pr_err("iova: %pad already mapped to %pa cannot remap to phys: %pa prot: %#x\n",
 	       &iova, &page_phys, &paddr, prot);
 
@@ -785,7 +795,8 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 	dte_index = rk_domain->dt[rk_iova_dte_index(iova)];
 	pte_index = rk_iova_pte_index(iova);
 	pte_addr = &page_table[pte_index];
-	pte_dma = rk_dte_pt_address(dte_index) + pte_index * sizeof(u32);
+
+	pte_dma = rk_ops->pt_address(dte_index) + pte_index * sizeof(u32);
 	ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
 				paddr, size, prot);
 
@@ -821,7 +832,7 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 		return 0;
 	}
 
-	pt_phys = rk_dte_pt_address(dte);
+	pt_phys = rk_ops->pt_address(dte);
 	pte_addr = (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iova);
 	pte_dma = pt_phys + rk_iova_pte_index(iova) * sizeof(u32);
 	unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma, size);
@@ -1037,7 +1048,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 	for (i = 0; i < NUM_DT_ENTRIES; i++) {
 		u32 dte = rk_domain->dt[i];
 		if (rk_dte_is_pt_valid(dte)) {
-			phys_addr_t pt_phys = rk_dte_pt_address(dte);
+			phys_addr_t pt_phys = rk_ops->pt_address(dte);
 			u32 *page_table = phys_to_virt(pt_phys);
 			dma_unmap_single(dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
@@ -1138,6 +1149,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
 
+	if (!rk_ops)
+		rk_ops = of_device_get_match_data(dev);
+
+	/*
+	 * That should not happen unless different versions of the
+	 * hardware block are embedded the same SoC
+	 */
+	WARN_ON(rk_ops != of_device_get_match_data(dev));
+
 	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
 				    GFP_KERNEL);
 	if (!iommu->bases)
@@ -1277,10 +1297,21 @@ static const struct dev_pm_ops rk_iommu_pm_ops = {
 				pm_runtime_force_resume)
 };
 
+static struct rk_iommu_ops iommu_data_ops_v1 = {
+	.pt_address = &rk_dte_pt_address,
+	.mk_dtentries = &rk_mk_dte,
+	.mk_ptentries = &rk_mk_pte,
+	.dte_addr_phys = &rk_dte_addr_phys,
+	.pt_address_mask = RK_DTE_PT_ADDRESS_MASK,
+};
+
 static const struct of_device_id rk_iommu_dt_ids[] = {
-	{ .compatible = "rockchip,iommu" },
+	{	.compatible = "rockchip,iommu",
+		.data = &iommu_data_ops_v1,
+	},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
-- 
2.25.1

