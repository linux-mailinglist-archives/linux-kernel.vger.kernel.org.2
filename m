Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403F3368FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbhDWJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:53:13 -0400
Received: from foss.arm.com ([217.140.110.172]:60836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241876AbhDWJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:53:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A00615EC;
        Fri, 23 Apr 2021 02:52:26 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 623793F774;
        Fri, 23 Apr 2021 02:52:22 -0700 (PDT)
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
Subject: [PATCH RFC v1 06/11] iommu/pasid-table: Add pasid table ops for shared context management
Date:   Fri, 23 Apr 2021 15:21:42 +0530
Message-Id: <20210423095147.27922-7-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pasid table ops to allocate and free shared contexts. These helpers
interact using mmu notifiers, so add a mmu notifier implementation
structure in pasid tables as well. This change can help pull out the
shared pasid (context-descriptor) implementation out of arm-smmu-v3.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      |  1 +
 drivers/iommu/iommu-pasid-table.h             | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index fa1a6a632559..ea94f57ad261 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -299,6 +299,7 @@ arm_smmu_register_cd_table(struct device *dev, void *cookie,
 	tbl->cookie = cookie;
 	tbl->ops = &arm_cd_table_ops;
 	tbl->cfg.sync = sync_ops;
+	INIT_LIST_HEAD(&tbl->mmu_notifiers);
 
 	return tbl;
 }
diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
index 00b1c66e6a9e..4d6590e60f9b 100644
--- a/drivers/iommu/iommu-pasid-table.h
+++ b/drivers/iommu/iommu-pasid-table.h
@@ -8,6 +8,7 @@
 #define __IOMMU_PASID_TABLE_H
 
 #include <linux/io-pgtable.h>
+#include <linux/mmu_notifier.h>
 
 #include "arm/arm-smmu-v3/arm-smmu-v3.h"
 
@@ -52,6 +53,21 @@ struct iommu_vendor_psdtable_cfg {
 
 struct iommu_vendor_psdtable_ops;
 
+/* In-line with 'struct arm_smmu_mmu_notifier' */
+struct iommu_psdtable_mmu_notifier {
+	struct mmu_notifier		mn;
+	bool				cleared;
+	refcount_t			refs;
+	struct list_head		list;
+	/* cookie captures the domain implementation */
+	void				*cookie;
+	union {
+		struct arm_smmu_ctx_desc	*cd;
+	} vendor;
+};
+#define mn_to_pstiommu(mn)	\
+	container_of(mn, struct iommu_psdtable_mmu_notifier, mn)
+
 /**
  * struct iommu_pasid_table - describes a set of PASID tables
  *
@@ -64,6 +80,7 @@ struct iommu_pasid_table {
 	void					*cookie;
 	struct iommu_vendor_psdtable_cfg	cfg;
 	const struct iommu_vendor_psdtable_ops	*ops;
+	struct list_head			mmu_notifiers;
 };
 
 #define pasid_table_cfg_to_table(pst_cfg) \
@@ -77,6 +94,11 @@ struct iommu_vendor_psdtable_ops {
 	int (*write)(struct iommu_vendor_psdtable_cfg *cfg, int ssid,
 		     void *cookie);
 	bool (*free_asid)(struct xarray *xa, void *cookie_cd);
+	struct iommu_psdtable_mmu_notifier *
+	(*alloc_shared)(struct iommu_pasid_table *tbl, struct mm_struct *mm,
+			struct xarray *xa, u32 asid_bits);
+	void (*free_shared)(struct iommu_pasid_table *tbl, struct xarray *xa,
+			    void *cookie_cd);
 };
 
 /* CD manipulation ops */
@@ -129,6 +151,26 @@ static inline bool iommu_psdtable_free_asid(struct iommu_pasid_table *tbl,
 	return tbl->ops->free_asid(xa, cookie_cd);
 }
 
+static inline struct iommu_psdtable_mmu_notifier *
+iommu_psdtable_alloc_shared(struct iommu_pasid_table *tbl,
+			    struct mm_struct *mm, struct xarray *xa,
+			    u32 asid_bits)
+{
+	if (!tbl->ops->alloc_shared)
+		return false;
+
+	return tbl->ops->alloc_shared(tbl, mm, xa, asid_bits);
+}
+
+static inline void iommu_psdtable_free_shared(struct iommu_pasid_table *tbl,
+					      struct xarray *xa, void *cookie)
+{
+	if (!tbl->ops->free_shared)
+		return;
+
+	tbl->ops->free_shared(tbl, xa, cookie);
+}
+
 /* Sync ops for CD cfg or tlb */
 static inline void iommu_psdtable_flush(struct iommu_pasid_table *tbl,
 					void *cookie, int ssid, bool leaf)
-- 
2.17.1

