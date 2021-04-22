Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2436824F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhDVORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:17:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52294 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbhDVOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:16:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 749FD1F432A1
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 4/4] iommu: rockchip: Add support iommu v2
Date:   Thu, 22 Apr 2021 16:16:02 +0200
Message-Id: <20210422141602.350746-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
References: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Xue <xxm@rock-chips.com>

RK356x SoC got new IOMMU hardware block (version 2).
Add a compatible to distinguish it from the first version.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
[Benjamin]
- port driver from kernel 4.19 to 5.12
- change functions prototype.
- squash all fixes in this commit.
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 422 +++++++++++++++++++++++++++++++--
 1 file changed, 406 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e5d86b7177de..0d345d0f44fc 100644
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
@@ -81,6 +82,30 @@
   */
 #define RK_IOMMU_PGSIZE_BITMAP 0x007ff000
 
+#define DT_LO_MASK 0xfffff000
+#define DT_HI_MASK GENMASK_ULL(39, 32)
+#define DT_SHIFT   28
+
+#define DTE_BASE_HI_MASK GENMASK(11, 4)
+
+#define PAGE_DESC_LO_MASK   0xfffff000
+#define PAGE_DESC_HI1_LOWER 32
+#define PAGE_DESC_HI1_UPPER 35
+#define PAGE_DESC_HI2_LOWER 36
+#define PAGE_DESC_HI2_UPPER 39
+#define PAGE_DESC_HI_MASK1  GENMASK_ULL(PAGE_DESC_HI1_UPPER, PAGE_DESC_HI1_LOWER)
+#define PAGE_DESC_HI_MASK2  GENMASK_ULL(PAGE_DESC_HI2_UPPER, PAGE_DESC_HI2_LOWER)
+
+#define DTE_HI1_LOWER 8
+#define DTE_HI1_UPPER 11
+#define DTE_HI2_LOWER 4
+#define DTE_HI2_UPPER 7
+#define DTE_HI_MASK1  GENMASK(DTE_HI1_UPPER, DTE_HI1_LOWER)
+#define DTE_HI_MASK2  GENMASK(DTE_HI2_UPPER, DTE_HI2_LOWER)
+
+#define PAGE_DESC_HI_SHIFT1 (PAGE_DESC_HI1_LOWER - DTE_HI1_LOWER)
+#define PAGE_DESC_HI_SHIFT2 (PAGE_DESC_HI2_LOWER - DTE_HI2_LOWER)
+
 struct rk_iommu_domain {
 	struct list_head iommus;
 	u32 *dt; /* page directory table */
@@ -91,6 +116,10 @@ struct rk_iommu_domain {
 	struct iommu_domain domain;
 };
 
+struct rockchip_iommu_data {
+	u32 version;
+};
+
 /* list of clocks required by IOMMU */
 static const char * const rk_iommu_clocks[] = {
 	"aclk", "iface",
@@ -108,6 +137,7 @@ struct rk_iommu {
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 	struct iommu_group *group;
+	u32 version;
 };
 
 struct rk_iommudata {
@@ -174,11 +204,32 @@ static struct rk_iommu_domain *to_rk_domain(struct iommu_domain *dom)
 #define RK_DTE_PT_ADDRESS_MASK    0xfffff000
 #define RK_DTE_PT_VALID           BIT(0)
 
+/*
+ * In v2:
+ * 31:12 - PT address bit 31:0
+ * 11: 8 - PT address bit 35:32
+ *  7: 4 - PT address bit 39:36
+ *  3: 1 - Reserved
+ *     0 - 1 if PT @ PT address is valid
+ */
+#define RK_DTE_PT_ADDRESS_MASK_V2 0xfffffff0
+
 static inline phys_addr_t rk_dte_pt_address(u32 dte)
 {
 	return (phys_addr_t)dte & RK_DTE_PT_ADDRESS_MASK;
 }
 
+static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
+{
+	u64 dte_v2 = dte;
+
+	dte_v2 = ((dte_v2 & DTE_HI_MASK2) << PAGE_DESC_HI_SHIFT2) |
+		 ((dte_v2 & DTE_HI_MASK1) << PAGE_DESC_HI_SHIFT1) |
+		 (dte_v2 & PAGE_DESC_LO_MASK);
+
+	return (phys_addr_t)dte_v2;
+}
+
 static inline bool rk_dte_is_pt_valid(u32 dte)
 {
 	return dte & RK_DTE_PT_VALID;
@@ -189,6 +240,15 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
 	return (pt_dma & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
 }
 
+static inline u32 rk_mk_dte_v2(dma_addr_t pt_dma)
+{
+	pt_dma = (pt_dma & PAGE_DESC_LO_MASK) |
+		 ((pt_dma & PAGE_DESC_HI_MASK1) >> PAGE_DESC_HI_SHIFT1) |
+		 (pt_dma & PAGE_DESC_HI_MASK2) >> PAGE_DESC_HI_SHIFT2;
+
+	return (pt_dma & RK_DTE_PT_ADDRESS_MASK_V2) | RK_DTE_PT_VALID;
+}
+
 /*
  * Each PTE has a Page address, some flags and a valid bit:
  * +---------------------+---+-------+-+
@@ -215,11 +275,37 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
 #define RK_PTE_PAGE_READABLE      BIT(1)
 #define RK_PTE_PAGE_VALID         BIT(0)
 
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
+#define RK_PTE_PAGE_ADDRESS_MASK_V2  0xfffffff0
+#define RK_PTE_PAGE_FLAGS_MASK_V2    0x0000000e
+#define RK_PTE_PAGE_READABLE_V2      BIT(2)
+#define RK_PTE_PAGE_WRITABLE_V2      BIT(1)
+
 static inline phys_addr_t rk_pte_page_address(u32 pte)
 {
 	return (phys_addr_t)pte & RK_PTE_PAGE_ADDRESS_MASK;
 }
 
+static inline phys_addr_t rk_pte_page_address_v2(u32 pte)
+{
+	u64 pte_v2 = pte;
+
+	pte_v2 = ((pte_v2 & DTE_HI_MASK2) << PAGE_DESC_HI_SHIFT2) |
+		 ((pte_v2 & DTE_HI_MASK1) << PAGE_DESC_HI_SHIFT1) |
+		 (pte_v2 & PAGE_DESC_LO_MASK);
+
+	return (phys_addr_t)pte_v2;
+}
+
 static inline bool rk_pte_is_page_valid(u32 pte)
 {
 	return pte & RK_PTE_PAGE_VALID;
@@ -229,12 +315,26 @@ static inline bool rk_pte_is_page_valid(u32 pte)
 static u32 rk_mk_pte(phys_addr_t page, int prot)
 {
 	u32 flags = 0;
+
 	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE : 0;
 	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE : 0;
 	page &= RK_PTE_PAGE_ADDRESS_MASK;
 	return page | flags | RK_PTE_PAGE_VALID;
 }
 
+static u32 rk_mk_pte_v2(phys_addr_t page, int prot)
+{
+	u32 flags = 0;
+
+	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE_V2 : 0;
+	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE_V2 : 0;
+	page = (page & PAGE_DESC_LO_MASK) |
+	       ((page & PAGE_DESC_HI_MASK1) >> PAGE_DESC_HI_SHIFT1) |
+	       (page & PAGE_DESC_HI_MASK2) >> PAGE_DESC_HI_SHIFT2;
+	page &= RK_PTE_PAGE_ADDRESS_MASK_V2;
+	return page | flags | RK_PTE_PAGE_VALID;
+}
+
 static u32 rk_mk_pte_invalid(u32 pte)
 {
 	return pte & ~RK_PTE_PAGE_VALID;
@@ -439,6 +539,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	int ret, i;
 	u32 dte_addr;
 	bool val;
+	u32 address_mask;
 
 	if (iommu->reset_disabled)
 		return 0;
@@ -447,11 +548,19 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	 * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMMY
 	 * and verifying that upper 5 nybbles are read back.
 	 */
+
+	/*
+	 * In v2: upper 7 nybbles are read back.
+	 */
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, DTE_ADDR_DUMMY);
 
+		if (iommu->version >= 0x2)
+			address_mask = RK_DTE_PT_ADDRESS_MASK_V2;
+		else
+			address_mask = RK_DTE_PT_ADDRESS_MASK;
 		dte_addr = rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR);
-		if (dte_addr != (DTE_ADDR_DUMMY & RK_DTE_PT_ADDRESS_MASK)) {
+		if (dte_addr != (DTE_ADDR_DUMMY & address_mask)) {
 			dev_err(iommu->dev, "Error during raw reset. MMU_DTE_ADDR is not functioning\n");
 			return -EFAULT;
 		}
@@ -490,6 +599,10 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
 	mmu_dte_addr_phys = (phys_addr_t)mmu_dte_addr;
+	if (iommu->version >= 0x2) {
+		mmu_dte_addr_phys = (mmu_dte_addr_phys & DT_LO_MASK) |
+				    ((mmu_dte_addr_phys & DTE_BASE_HI_MASK) << DT_SHIFT);
+	}
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -498,14 +611,20 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	if (!rk_dte_is_pt_valid(dte))
 		goto print_it;
 
-	pte_addr_phys = rk_dte_pt_address(dte) + (pte_index * 4);
+	if (iommu->version >= 0x2)
+		pte_addr_phys = rk_dte_pt_address_v2(dte) + (pte_index * 4);
+	else
+		pte_addr_phys = rk_dte_pt_address(dte) + (pte_index * 4);
 	pte_addr = phys_to_virt(pte_addr_phys);
 	pte = *pte_addr;
 
 	if (!rk_pte_is_page_valid(pte))
 		goto print_it;
 
-	page_addr_phys = rk_pte_page_address(pte) + page_offset;
+	if (iommu->version >= 0x2)
+		page_addr_phys = rk_pte_page_address_v2(pte) + page_offset;
+	else
+		page_addr_phys = rk_pte_page_address(pte) + page_offset;
 	page_flags = pte & RK_PTE_PAGE_FLAGS_MASK;
 
 print_it:
@@ -522,6 +641,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	struct rk_iommu *iommu = dev_id;
 	u32 status;
 	u32 int_status;
+	u32 int_mask;
 	dma_addr_t iova;
 	irqreturn_t ret = IRQ_NONE;
 	int i, err;
@@ -566,7 +686,15 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 				dev_err(iommu->dev, "Page fault while iommu not attached to domain?\n");
 
 			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
-			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_PAGE_FAULT_DONE);
+
+			/*
+			 * Master may clear the int_mask to prevent iommu
+			 * re-enter interrupt when mapping. So we postpone
+			 * sending PAGE_FAULT_DONE command to mapping finished.
+			 */
+			int_mask = rk_iommu_read(iommu->bases[i], RK_MMU_INT_MASK);
+			if (int_mask != 0x0)
+				rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_PAGE_FAULT_DONE);
 		}
 
 		if (int_status & RK_MMU_IRQ_BUS_ERROR)
@@ -614,6 +742,34 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static phys_addr_t rk_iommu_iova_to_phys_v2(struct iommu_domain *domain,
+					    dma_addr_t iova)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+	phys_addr_t pt_phys, phys = 0;
+	u32 dte, pte;
+	u32 *page_table;
+
+	spin_lock_irqsave(&rk_domain->dt_lock, flags);
+
+	dte = rk_domain->dt[rk_iova_dte_index(iova)];
+	if (!rk_dte_is_pt_valid(dte))
+		goto out;
+
+	pt_phys = rk_dte_pt_address_v2(dte);
+	page_table = (u32 *)phys_to_virt(pt_phys);
+	pte = page_table[rk_iova_pte_index(iova)];
+	if (!rk_pte_is_page_valid(pte))
+		goto out;
+
+	phys = rk_pte_page_address_v2(pte) + rk_iova_page_offset(iova);
+out:
+	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
+
+	return phys;
+}
+
 static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 			      dma_addr_t iova, size_t size)
 {
@@ -690,6 +846,44 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	return (u32 *)phys_to_virt(pt_phys);
 }
 
+static u32 *rk_dte_get_page_table_v2(struct rk_iommu_domain *rk_domain,
+				     dma_addr_t iova)
+{
+	u32 *page_table, *dte_addr;
+	u32 dte_index, dte;
+	phys_addr_t pt_phys;
+	dma_addr_t pt_dma;
+
+	assert_spin_locked(&rk_domain->dt_lock);
+
+	dte_index = rk_iova_dte_index(iova);
+	dte_addr = &rk_domain->dt[dte_index];
+	dte = *dte_addr;
+	if (rk_dte_is_pt_valid(dte))
+		goto done;
+
+	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
+	if (!page_table)
+		return ERR_PTR(-ENOMEM);
+
+	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, pt_dma)) {
+		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
+		free_page((unsigned long)page_table);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dte = rk_mk_dte_v2(pt_dma);
+	*dte_addr = dte;
+
+	rk_table_flush(rk_domain, pt_dma, NUM_PT_ENTRIES);
+	rk_table_flush(rk_domain,
+		       rk_domain->dt_dma + dte_index * sizeof(u32), 1);
+done:
+	pt_phys = rk_dte_pt_address_v2(dte);
+	return (u32 *)phys_to_virt(pt_phys);
+}
+
 static size_t rk_iommu_unmap_iova(struct rk_iommu_domain *rk_domain,
 				  u32 *pte_addr, dma_addr_t pte_dma,
 				  size_t size)
@@ -757,6 +951,45 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 	return -EADDRINUSE;
 }
 
+static int rk_iommu_map_iova_v2(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
+				dma_addr_t pte_dma, dma_addr_t iova,
+				phys_addr_t paddr, size_t size, int prot)
+{
+	unsigned int pte_count;
+	unsigned int pte_total = size / SPAGE_SIZE;
+	phys_addr_t page_phys;
+
+	assert_spin_locked(&rk_domain->dt_lock);
+
+	for (pte_count = 0; pte_count < pte_total; pte_count++) {
+		u32 pte = pte_addr[pte_count];
+
+		if (rk_pte_is_page_valid(pte))
+			goto unwind;
+
+		pte_addr[pte_count] = rk_mk_pte_v2(paddr, prot);
+
+		paddr += SPAGE_SIZE;
+	}
+
+	rk_table_flush(rk_domain, pte_dma, pte_total);
+
+	rk_iommu_zap_iova_first_last(rk_domain, iova, size);
+
+	return 0;
+unwind:
+	/* Unmap the range of iovas that we just mapped */
+	rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma,
+			    pte_count * SPAGE_SIZE);
+
+	iova += pte_count * SPAGE_SIZE;
+	page_phys = rk_pte_page_address_v2(pte_addr[pte_count]);
+	pr_err("iova: %pad already mapped to %pa cannot remap to phys: %pa prot: %#x\n",
+	       &iova, &page_phys, &paddr, prot);
+
+	return -EADDRINUSE;
+}
+
 static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -764,7 +997,7 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 	unsigned long flags;
 	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
 	u32 *page_table, *pte_addr;
-	u32 dte_index, pte_index;
+	u32 dte, pte_index;
 	int ret;
 
 	spin_lock_irqsave(&rk_domain->dt_lock, flags);
@@ -782,10 +1015,10 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 		return PTR_ERR(page_table);
 	}
 
-	dte_index = rk_domain->dt[rk_iova_dte_index(iova)];
+	dte = rk_domain->dt[rk_iova_dte_index(iova)];
 	pte_index = rk_iova_pte_index(iova);
 	pte_addr = &page_table[pte_index];
-	pte_dma = rk_dte_pt_address(dte_index) + pte_index * sizeof(u32);
+	pte_dma = rk_dte_pt_address(dte) + pte_index * sizeof(u32);
 	ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
 				paddr, size, prot);
 
@@ -794,6 +1027,43 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 	return ret;
 }
 
+static int rk_iommu_map_v2(struct iommu_domain *domain, unsigned long _iova,
+			   phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
+	u32 *page_table, *pte_addr;
+	u32 dte, pte_index;
+	int ret;
+
+	spin_lock_irqsave(&rk_domain->dt_lock, flags);
+
+	/*
+	 * pgsize_bitmap specifies iova sizes that fit in one page table
+	 * (1024 4-KiB pages = 4 MiB).
+	 * So, size will always be 4096 <= size <= 4194304.
+	 * Since iommu_map() guarantees that both iova and size will be
+	 * aligned, we will always only be mapping from a single dte here.
+	 */
+	page_table = rk_dte_get_page_table_v2(rk_domain, iova);
+	if (IS_ERR(page_table)) {
+		spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
+		return PTR_ERR(page_table);
+	}
+
+	dte = rk_domain->dt[rk_iova_dte_index(iova)];
+	pte_index = rk_iova_pte_index(iova);
+	pte_addr = &page_table[pte_index];
+	pte_dma = rk_dte_pt_address_v2(dte) + pte_index * sizeof(u32);
+	ret = rk_iommu_map_iova_v2(rk_domain, pte_addr, pte_dma, iova,
+				   paddr, size, prot);
+
+	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
+
+	return ret;
+}
+
 static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 			     size_t size, struct iommu_iotlb_gather *gather)
 {
@@ -834,6 +1104,46 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 	return unmap_size;
 }
 
+static size_t rk_iommu_unmap_v2(struct iommu_domain *domain, unsigned long _iova,
+				size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
+	phys_addr_t pt_phys;
+	u32 dte;
+	u32 *pte_addr;
+	size_t unmap_size;
+
+	spin_lock_irqsave(&rk_domain->dt_lock, flags);
+
+	/*
+	 * pgsize_bitmap specifies iova sizes that fit in one page table
+	 * (1024 4-KiB pages = 4 MiB).
+	 * So, size will always be 4096 <= size <= 4194304.
+	 * Since iommu_unmap() guarantees that both iova and size will be
+	 * aligned, we will always only be unmapping from a single dte here.
+	 */
+	dte = rk_domain->dt[rk_iova_dte_index(iova)];
+	/* Just return 0 if iova is unmapped */
+	if (!rk_dte_is_pt_valid(dte)) {
+		spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
+		return 0;
+	}
+
+	pt_phys = rk_dte_pt_address_v2(dte);
+	pte_addr = (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iova);
+	pte_dma = pt_phys + rk_iova_pte_index(iova) * sizeof(u32);
+	unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma, size);
+
+	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
+
+	/* Shootdown iotlb entries for iova range that was just unmapped */
+	rk_iommu_zap_iova(rk_domain, iova, unmap_size);
+
+	return unmap_size;
+}
+
 static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 {
 	struct rk_iommudata *data = dev_iommu_priv_get(dev);
@@ -864,6 +1174,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 	struct iommu_domain *domain = iommu->domain;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	int ret, i;
+	u32 dt_v2;
 
 	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
 	if (ret)
@@ -878,8 +1189,14 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 		goto out_disable_stall;
 
 	for (i = 0; i < iommu->num_mmu; i++) {
-		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_domain->dt_dma);
+		if (iommu->version >= 0x2) {
+			dt_v2 = (rk_domain->dt_dma & DT_LO_MASK) |
+				((rk_domain->dt_dma & DT_HI_MASK) >> DT_SHIFT);
+			rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dt_v2);
+		} else {
+			rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
+				       rk_domain->dt_dma);
+		}
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
@@ -1054,6 +1371,34 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 	kfree(rk_domain);
 }
 
+static void rk_iommu_domain_free_v2(struct iommu_domain *domain)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	int i;
+
+	WARN_ON(!list_empty(&rk_domain->iommus));
+
+	for (i = 0; i < NUM_DT_ENTRIES; i++) {
+		u32 dte = rk_domain->dt[i];
+
+		if (rk_dte_is_pt_valid(dte)) {
+			phys_addr_t pt_phys = rk_dte_pt_address_v2(dte);
+			u32 *page_table = phys_to_virt(pt_phys);
+
+			dma_unmap_single(dma_dev, pt_phys,
+					 SPAGE_SIZE, DMA_TO_DEVICE);
+			free_page((unsigned long)page_table);
+		}
+	}
+	dma_unmap_single(dma_dev, rk_domain->dt_dma,
+			 SPAGE_SIZE, DMA_TO_DEVICE);
+	free_page((unsigned long)rk_domain->dt);
+
+	if (domain->type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&rk_domain->domain);
+	kfree(rk_domain);
+}
+
 static struct iommu_device *rk_iommu_probe_device(struct device *dev)
 {
 	struct rk_iommudata *data;
@@ -1122,6 +1467,40 @@ static const struct iommu_ops rk_iommu_ops = {
 	.of_xlate = rk_iommu_of_xlate,
 };
 
+static const struct iommu_ops rk_iommu_ops_v2 = {
+	.domain_alloc = rk_iommu_domain_alloc,
+	.domain_free = rk_iommu_domain_free_v2,
+	.attach_dev = rk_iommu_attach_device,
+	.detach_dev = rk_iommu_detach_device,
+	.map = rk_iommu_map_v2,
+	.unmap = rk_iommu_unmap_v2,
+	.probe_device = rk_iommu_probe_device,
+	.release_device = rk_iommu_release_device,
+	.iova_to_phys = rk_iommu_iova_to_phys_v2,
+	.device_group = rk_iommu_device_group,
+	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
+	.of_xlate = rk_iommu_of_xlate,
+};
+
+static const struct rockchip_iommu_data iommu_data_v1 = {
+	.version = 0x1,
+};
+
+static const struct rockchip_iommu_data iommu_data_v2 = {
+	.version = 0x2,
+};
+
+static const struct of_device_id rk_iommu_dt_ids[] = {
+	{	.compatible = "rockchip,iommu",
+		.data = &iommu_data_v1,
+	}, {
+		.compatible = "rockchip,iommu-v2",
+		.data = &iommu_data_v2,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
+
 static int rk_iommu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1129,11 +1508,21 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct resource *res;
 	int num_res = pdev->num_resources;
 	int err, i;
+	const struct of_device_id *match;
+	struct rockchip_iommu_data *data;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return -ENOMEM;
 
+	match = of_match_device(rk_iommu_dt_ids, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct rockchip_iommu_data *)match->data;
+	iommu->version = data->version;
+	dev_info(dev, "version = %x\n", iommu->version);
+
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
@@ -1196,7 +1585,10 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		goto err_put_group;
 
-	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
+	if (iommu->version >= 0x2)
+		iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops_v2);
+	else
+		iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
 
 	err = iommu_device_register(&iommu->iommu);
@@ -1211,7 +1603,10 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
-	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
+	if (iommu->version >= 0x2)
+		bus_set_iommu(&platform_bus_type, &rk_iommu_ops_v2);
+	else
+		bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
 
 	pm_runtime_enable(dev);
 
@@ -1280,11 +1675,6 @@ static const struct dev_pm_ops rk_iommu_pm_ops = {
 				pm_runtime_force_resume)
 };
 
-static const struct of_device_id rk_iommu_dt_ids[] = {
-	{ .compatible = "rockchip,iommu" },
-	{ /* sentinel */ }
-};
-
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
 	.shutdown = rk_iommu_shutdown,
-- 
2.25.1

