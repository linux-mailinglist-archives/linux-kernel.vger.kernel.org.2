Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA60390117
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhEYMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhEYMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:40:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D67C061574;
        Tue, 25 May 2021 05:39:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id ED3081F4241D
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 4/4] iommu: rockchip: Add support for iommu v2
Date:   Tue, 25 May 2021 14:38:52 +0200
Message-Id: <20210525123853.658267-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This second version of the hardware block has a different bits
mapping for page table entries.
Add the ops matching to this new mapping.
Define a new compatible to distinguish it from the first version.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
version 7:
 - Set dma_bit_mask field.
 - Add rk_dma_addr_dte_v2 function
 - Rebased on v5.13-rc3

version 5:
 - Use internal ops to support v2 hardware block
 - Use GENMASK macro.
 - Keep rk_dte_pt_address() and rk_dte_pt_address_v2() separated
   because I believe that is more readable like this.
 - Do not duplicate code.

 drivers/iommu/rockchip-iommu.c | 85 ++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index bd2cf7f08c71..16dd2bf4a859 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -189,6 +189,33 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
 	return (phys_addr_t)dte & RK_DTE_PT_ADDRESS_MASK;
 }
 
+/*
+ * In v2:
+ * 31:12 - PT address bit 31:0
+ * 11: 8 - PT address bit 35:32
+ *  7: 4 - PT address bit 39:36
+ *  3: 1 - Reserved
+ *     0 - 1 if PT @ PT address is valid
+ */
+#define RK_DTE_PT_ADDRESS_MASK_V2 GENMASK_ULL(31, 4)
+#define DTE_HI_MASK1	GENMASK(11, 8)
+#define DTE_HI_MASK2	GENMASK(7, 4)
+#define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
+#define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
+#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
+#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
+
+static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
+{
+	u64 dte_v2 = dte;
+
+	dte_v2 = ((dte_v2 & DTE_HI_MASK2) << DTE_HI_SHIFT2) |
+		 ((dte_v2 & DTE_HI_MASK1) << DTE_HI_SHIFT1) |
+		 (dte_v2 & RK_DTE_PT_ADDRESS_MASK);
+
+	return (phys_addr_t)dte_v2;
+}
+
 static inline bool rk_dte_is_pt_valid(u32 dte)
 {
 	return dte & RK_DTE_PT_VALID;
@@ -199,6 +226,15 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
 	return (pt_dma & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
 }
 
+static inline u32 rk_mk_dte_v2(dma_addr_t pt_dma)
+{
+	pt_dma = (pt_dma & RK_DTE_PT_ADDRESS_MASK) |
+		 ((pt_dma & PAGE_DESC_HI_MASK1) >> DTE_HI_SHIFT1) |
+		 (pt_dma & PAGE_DESC_HI_MASK2) >> DTE_HI_SHIFT2;
+
+	return (pt_dma & RK_DTE_PT_ADDRESS_MASK_V2) | RK_DTE_PT_VALID;
+}
+
 /*
  * Each PTE has a Page address, some flags and a valid bit:
  * +---------------------+---+-------+-+
@@ -240,6 +276,29 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
 	return page | flags | RK_PTE_PAGE_VALID;
 }
 
+/*
+ * In v2:
+ * 31:12 - Page address bit 31:0
+ *  11:9 - Page address bit 34:32
+ *   8:4 - Page address bit 39:35
+ *     3 - Security
+ *     2 - Readable
+ *     1 - Writable
+ *     0 - 1 if Page @ Page address is valid
+ */
+#define RK_PTE_PAGE_READABLE_V2      BIT(2)
+#define RK_PTE_PAGE_WRITABLE_V2      BIT(1)
+
+static u32 rk_mk_pte_v2(phys_addr_t page, int prot)
+{
+	u32 flags = 0;
+
+	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE_V2 : 0;
+	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE_V2 : 0;
+
+	return rk_mk_dte_v2(page) | flags;
+}
+
 static u32 rk_mk_pte_invalid(u32 pte)
 {
 	return pte & ~RK_PTE_PAGE_VALID;
@@ -485,6 +544,21 @@ static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
 	return dt_dma;
 }
 
+#define DT_HI_MASK GENMASK_ULL(39, 32)
+#define DT_SHIFT   28
+
+static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
+{
+	return (phys_addr_t)(addr & RK_DTE_PT_ADDRESS_MASK) |
+	       ((addr & DT_HI_MASK) << DT_SHIFT);
+}
+
+static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
+{
+	return (dt_dma & RK_DTE_PT_ADDRESS_MASK) |
+	       ((dt_dma & DT_HI_MASK) >> DT_SHIFT);
+}
+
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -1316,11 +1390,22 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
 	.dma_bit_mask = DMA_BIT_MASK(32),
 };
 
+static struct rk_iommu_ops iommu_data_ops_v2 = {
+	.pt_address = &rk_dte_pt_address_v2,
+	.mk_dtentries = &rk_mk_dte_v2,
+	.mk_ptentries = &rk_mk_pte_v2,
+	.dte_addr_phys = &rk_dte_addr_phys_v2,
+	.dma_addr_dte = &rk_dma_addr_dte_v2,
+	.dma_bit_mask = DMA_BIT_MASK(40),
+};
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{	.compatible = "rockchip,iommu",
 		.data = &iommu_data_ops_v1,
 	},
+	{	.compatible = "rockchip,rk3568-iommu",
+		.data = &iommu_data_ops_v2,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

