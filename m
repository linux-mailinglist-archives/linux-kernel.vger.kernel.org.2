Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C087368FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbhDWJxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:53:15 -0400
Received: from foss.arm.com ([217.140.110.172]:60862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242025AbhDWJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:53:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AA06161B;
        Fri, 23 Apr 2021 02:52:31 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 030173F774;
        Fri, 23 Apr 2021 02:52:26 -0700 (PDT)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        Vivek Gautam <vivek.gautam@arm.com>
Subject: [PATCH RFC v1 07/11] iommu/arm-smmu-v3: Move shared context descriptor code to cd-lib
Date:   Fri, 23 Apr 2021 15:21:43 +0530
Message-Id: <20210423095147.27922-8-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to adding shared descriptor allocation and free pasid
table ops, pull out the alloc_shared_cd and free_shared_cd helpers from
arm-smmu-v3 and place them in arm-smmu-v3-cd-lib library driver.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 149 ++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 147 -----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  12 ++
 drivers/iommu/iommu-pasid-table.h             |   1 +
 4 files changed, 162 insertions(+), 147 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index ea94f57ad261..537b7c784d40 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -6,9 +6,11 @@
  */
 
 #include <linux/dma-iommu.h>
+#include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
 #include "../../iommu-pasid-table.h"
+#include "../../io-pgtable-arm.h"
 
 static int arm_smmu_alloc_cd_leaf_table(struct device *dev,
 					struct arm_smmu_l1_ctx_desc *l1_desc)
@@ -278,6 +280,153 @@ static bool arm_smmu_free_asid(struct xarray *xa, void *cookie_cd)
 	return free;
 }
 
+/*
+ * Check if the CPU ASID is available on the SMMU side. If a private context
+ * descriptor is using it, try to replace it.
+ */
+static struct arm_smmu_ctx_desc *
+arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
+{
+	int ret;
+	u32 new_asid;
+	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *smmu_domain;
+	struct iommu_pasid_table *tbl;
+
+	cd = xa_load(&arm_smmu_asid_xa, asid);
+	if (!cd)
+		return NULL;
+
+	if (cd->mm) {
+		if (WARN_ON(cd->mm != mm))
+			return ERR_PTR(-EINVAL);
+		/* All devices bound to this mm use the same cd struct. */
+		refcount_inc(&cd->refs);
+		return cd;
+	}
+
+	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu = smmu_domain->smmu;
+	tbl = smmu_domain->tbl;
+
+	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
+		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	if (ret)
+		return ERR_PTR(-ENOSPC);
+	/*
+	 * Race with unmap: TLB invalidations will start targeting the new ASID,
+	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
+	 * later, so it doesn't matter.
+	 */
+	cd->asid = new_asid;
+	/*
+	 * Update ASID and invalidate CD in all associated masters. There will
+	 * be some overlap between use of both ASIDs, until we invalidate the
+	 * TLB.
+	 */
+	ret = iommu_psdtable_write(tbl, &tbl->cfg, 0, cd);
+	if (ret)
+		return ERR_PTR(-ENOSYS);
+
+	/* Invalidate TLB entries previously associated with that context */
+	iommu_psdtable_flush_tlb(tbl, smmu_domain, asid);
+
+	xa_erase(&arm_smmu_asid_xa, asid);
+	return NULL;
+}
+
+struct arm_smmu_ctx_desc *
+arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
+{
+	u16 asid;
+	int err = 0;
+	u64 tcr, par, reg;
+	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_ctx_desc *ret = NULL;
+
+	asid = arm64_mm_context_get(mm);
+	if (!asid)
+		return ERR_PTR(-ESRCH);
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd) {
+		err = -ENOMEM;
+		goto out_put_context;
+	}
+
+	refcount_set(&cd->refs, 1);
+
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_share_asid(mm, asid);
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		goto out_free_cd;
+	}
+
+	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	if (err)
+		goto out_free_asid;
+
+	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - vabits_actual) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
+	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
+
+	switch (PAGE_SIZE) {
+	case SZ_4K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
+		break;
+	case SZ_16K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
+		break;
+	case SZ_64K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
+		break;
+	default:
+		WARN_ON(1);
+		err = -EINVAL;
+		goto out_free_asid;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
+
+	cd->ttbr = virt_to_phys(mm->pgd);
+	cd->tcr = tcr;
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cd->mair = read_sysreg(mair_el1);
+	cd->asid = asid;
+	cd->mm = mm;
+
+	return cd;
+
+out_free_asid:
+	iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd);
+out_free_cd:
+	kfree(cd);
+out_put_context:
+	arm64_mm_context_put(mm);
+	return err < 0 ? ERR_PTR(err) : ret;
+}
+
+void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
+			     struct arm_smmu_ctx_desc *cd)
+{
+	if (iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd)) {
+		/* Unpin ASID */
+		arm64_mm_context_put(cd->mm);
+		kfree(cd);
+	}
+}
+
 struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
 	.alloc	 = arm_smmu_alloc_cd_tables,
 	.free	 = arm_smmu_free_cd_tables,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 775c34899935..da35d4cc0c1e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -37,153 +37,6 @@ struct arm_smmu_bond {
 
 static DEFINE_MUTEX(sva_lock);
 
-/*
- * Check if the CPU ASID is available on the SMMU side. If a private context
- * descriptor is using it, try to replace it.
- */
-static struct arm_smmu_ctx_desc *
-arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
-{
-	int ret;
-	u32 new_asid;
-	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_device *smmu;
-	struct arm_smmu_domain *smmu_domain;
-	struct iommu_pasid_table *tbl;
-
-	cd = xa_load(&arm_smmu_asid_xa, asid);
-	if (!cd)
-		return NULL;
-
-	if (cd->mm) {
-		if (WARN_ON(cd->mm != mm))
-			return ERR_PTR(-EINVAL);
-		/* All devices bound to this mm use the same cd struct. */
-		refcount_inc(&cd->refs);
-		return cd;
-	}
-
-	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
-	smmu = smmu_domain->smmu;
-	tbl = smmu_domain->tbl;
-
-	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	if (ret)
-		return ERR_PTR(-ENOSPC);
-	/*
-	 * Race with unmap: TLB invalidations will start targeting the new ASID,
-	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
-	 * later, so it doesn't matter.
-	 */
-	cd->asid = new_asid;
-	/*
-	 * Update ASID and invalidate CD in all associated masters. There will
-	 * be some overlap between use of both ASIDs, until we invalidate the
-	 * TLB.
-	 */
-	ret = iommu_psdtable_write(tbl, &tbl->cfg, 0, cd);
-	if (ret)
-		return ERR_PTR(-ENOSYS);
-
-	/* Invalidate TLB entries previously associated with that context */
-	iommu_psdtable_flush_tlb(tbl, smmu_domain, asid);
-
-	xa_erase(&arm_smmu_asid_xa, asid);
-	return NULL;
-}
-
-static struct arm_smmu_ctx_desc *
-arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
-{
-	u16 asid;
-	int err = 0;
-	u64 tcr, par, reg;
-	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_ctx_desc *ret = NULL;
-
-	asid = arm64_mm_context_get(mm);
-	if (!asid)
-		return ERR_PTR(-ESRCH);
-
-	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
-	if (!cd) {
-		err = -ENOMEM;
-		goto out_put_context;
-	}
-
-	refcount_set(&cd->refs, 1);
-
-	mutex_lock(&arm_smmu_asid_lock);
-	ret = arm_smmu_share_asid(mm, asid);
-	if (ret) {
-		mutex_unlock(&arm_smmu_asid_lock);
-		goto out_free_cd;
-	}
-
-	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
-	mutex_unlock(&arm_smmu_asid_lock);
-
-	if (err)
-		goto out_free_asid;
-
-	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - vabits_actual) |
-	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
-	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
-	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
-	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-
-	switch (PAGE_SIZE) {
-	case SZ_4K:
-		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
-		break;
-	case SZ_16K:
-		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
-		break;
-	case SZ_64K:
-		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
-		break;
-	default:
-		WARN_ON(1);
-		err = -EINVAL;
-		goto out_free_asid;
-	}
-
-	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
-	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
-
-	cd->ttbr = virt_to_phys(mm->pgd);
-	cd->tcr = tcr;
-	/*
-	 * MAIR value is pretty much constant and global, so we can just get it
-	 * from the current CPU register
-	 */
-	cd->mair = read_sysreg(mair_el1);
-	cd->asid = asid;
-	cd->mm = mm;
-
-	return cd;
-
-out_free_asid:
-	iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd);
-out_free_cd:
-	kfree(cd);
-out_put_context:
-	arm64_mm_context_put(mm);
-	return err < 0 ? ERR_PTR(err) : ret;
-}
-
-static void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
-				    struct arm_smmu_ctx_desc *cd)
-{
-	if (iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd)) {
-		/* Unpin ASID */
-		arm64_mm_context_put(cd->mm);
-		kfree(cd);
-	}
-}
-
 static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d5cf2d521c29..13ff024ab0d5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -773,6 +773,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
+struct arm_smmu_ctx_desc *
+arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm);
+void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
+			     struct arm_smmu_ctx_desc *cd);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -828,5 +832,13 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
+struct arm_smmu_ctx_desc *
+arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
+					   struct arm_smmu_ctx_desc *cd) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
index 4d6590e60f9b..0e774ae6682a 100644
--- a/drivers/iommu/iommu-pasid-table.h
+++ b/drivers/iommu/iommu-pasid-table.h
@@ -8,6 +8,7 @@
 #define __IOMMU_PASID_TABLE_H
 
 #include <linux/io-pgtable.h>
+#include <linux/mmu_context.h>
 #include <linux/mmu_notifier.h>
 
 #include "arm/arm-smmu-v3/arm-smmu-v3.h"
-- 
2.17.1

