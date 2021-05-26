Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B490039234D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhEZXiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:38:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:13515 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhEZXiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:38:51 -0400
IronPort-SDR: jfV+7oGrbRFdwDjQwaczWso+Kj9WcAR1kbWOMWtuUwcg8/t5KSmhv4AeKLdB+QUmMT96EP6Q7A
 RzHa7Dj2zI7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189981486"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="189981486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 16:37:12 -0700
IronPort-SDR: VGMGcsHaBfMVaw3+OeLJgmirYTGOsyb4Z2xgVD4XttQKVzXL8F2cS9jQ+3jma4oEDBvMo4NTS7
 G77JYYK7WG0g==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="633708385"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 16:37:10 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, kyung.min.park@intel.com, yian.chen@intel.com,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ashok.raj@intel.com
Subject: [PATCH] iommu/vt-d: Dump DMAR translation structure
Date:   Wed, 26 May 2021 16:35:49 -0700
Message-Id: <20210526233549.31569-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dmar translation fault happens, the kernel prints a single line
fault reason with corresponding hexadecimal code defined in the Intel VT-d
specification.

Currently, when user wants to debug the translation fault in detail,
debugfs is used for dumping the dmar_translation_struct, which is not
available when the kernel failed to boot.

Dump the DMAR translation structure, pagewalk the IO page table and print
the page table entry when the fault happens.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/dmar.c  |   7 ++-
 drivers/iommu/intel/iommu.c | 108 ++++++++++++++++++++++++++++++++++++
 include/linux/dmar.h        |   3 +
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 11e37d2c2af2..6f4be1be8917 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1915,18 +1915,21 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
-	else if (pasid == INVALID_IOASID)
+	else if (pasid == INVALID_IOASID) {
 		pr_err("[%s w/o PASID] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
-	else
+		dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
+	} else {
 		pr_err("[%s w/ PASID %x] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
 		       type ? "DMA Read" : "DMA Write", pasid,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
+		dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
+	}
 	return 0;
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 708f430af1c4..dbd11993ccfa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -172,6 +172,8 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
+static inline struct device_domain_info *
+dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -998,6 +1000,112 @@ static void free_context_table(struct intel_iommu *iommu)
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u8 devfn)
+{
+	struct dma_pte *parent, *pte = NULL;
+	struct dmar_domain *domain = NULL;
+	struct device_domain_info *info;
+	int offset, level;
+
+	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	if (!info) {
+		pr_info("no iommu info for this device.\n");
+		return;
+	}
+
+	domain = info->domain;
+	if (!domain) {
+		pr_info("iommu domain does not exist for this device.\n");
+		return;
+	}
+	level = agaw_to_level(domain->agaw);
+	parent = domain->pgd;
+	if (!parent) {
+		pr_info("NULL pointer of page table entry.\n");
+		return;
+	}
+
+	while (1) {
+		offset = pfn_level_offset(pfn, level);
+		pte = &parent[offset];
+		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
+			pr_info("pte not present at level %d", level);
+			break;
+		}
+		pr_info("pte level: %d, pte value: %llx\n", level, pte->val);
+
+		if (level == 1)
+			break;
+		parent = phys_to_virt(dma_pte_addr(pte));
+		level--;
+	}
+}
+
+void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id, unsigned long long addr,
+			  u32 pasid)
+{
+	struct pasid_dir_entry *dir, *pde;
+	struct pasid_entry *entries, *pte;
+	struct context_entry *ctx_entry;
+	struct root_entry *rt_entry;
+	u8 devfn = source_id & 0xff;
+	u8 bus = source_id >> 8;
+	int i, dir_index, index;
+
+	/* root entry dump */
+	rt_entry = &iommu->root_entry[bus];
+	if (!rt_entry) {
+		pr_info("root table entry is not present\n");
+		return;
+	}
+	if (!sm_supported(iommu))
+		pr_info("%s, root_entry[63:0]: %llx", iommu->name, rt_entry->lo);
+	else
+		pr_info("%s, root_entry[127:0]: %llx, %llx\n", iommu->name,
+			rt_entry->hi, rt_entry->lo);
+
+	/* context entry dump */
+	ctx_entry = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!ctx_entry) {
+		pr_info("context table entry is not present\n");
+		return;
+	}
+	pr_info("%s, ctx_entry[127:0]: %llx, %llx\n", iommu->name, ctx_entry->hi, ctx_entry->lo);
+
+	/* legacy mode does not require PASID entries */
+	if (!sm_supported(iommu))
+		goto pgtable_walk;
+
+	/* get the pointer to pasid directory entry */
+	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
+	if (!dir) {
+		pr_info("pasid directory entry is not present\n");
+		return;
+	}
+	/* For request-without-pasid, get the pasid from context entry */
+	if (intel_iommu_sm && pasid == INVALID_IOASID)
+		pasid = PASID_RID2PASID;
+
+	dir_index = pasid >> PASID_PDE_SHIFT;
+	pde = &dir[dir_index];
+	pr_info("%s, pasid_dir_entry: %llx\n", iommu->name, pde->val);
+
+	/* get the pointer to the pasid table entry */
+	entries = get_pasid_table_from_pde(pde);
+	if (!entries) {
+		pr_info("pasid table entry is not present\n");
+		return;
+	}
+	index = pasid & PASID_PTE_MASK;
+	pte = &entries[index];
+	/* VT-d specification defines only 3 pasid table entries currently */
+	for (i = 0; i < 3; i++)
+		pr_info("%s, pasid_table_entry[%d]: %llx\n", iommu->name, i, pte->val[i]);
+
+pgtable_walk:
+	pgtable_walk(iommu, addr >> VTD_PAGE_SHIFT, bus, devfn);
+}
+
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				      unsigned long pfn, int *target_level)
 {
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e04436a7ff27..7b43741b79ee 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -70,6 +70,9 @@ struct dmar_pci_notify_info {
 extern struct rw_semaphore dmar_global_lock;
 extern struct list_head dmar_drhd_units;
 
+void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
+			  unsigned long long addr, u32 pasid);
+
 #define for_each_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
 				dmar_rcu_check())
-- 
2.17.1

