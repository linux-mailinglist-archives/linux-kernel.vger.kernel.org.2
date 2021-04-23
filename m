Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED83368FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbhDWJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:53:20 -0400
Received: from foss.arm.com ([217.140.110.172]:60910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242032AbhDWJxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:53:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC83165C;
        Fri, 23 Apr 2021 02:52:40 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37B5E3F774;
        Fri, 23 Apr 2021 02:52:35 -0700 (PDT)
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
Subject: [PATCH RFC v1 09/11] iommu/virtio: Implement sva bind/unbind calls
Date:   Fri, 23 Apr 2021 15:21:45 +0530
Message-Id: <20210423095147.27922-10-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVA bind and unbind implementations will allow to prepare translation
context with CPU page tables that can be programmed into host iommu
hardware to realize shared address space utilization between the CPU
and virtualized devices using virtio-iommu.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c      | 199 +++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_iommu.h |   2 +
 2 files changed, 199 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 250c137a211b..08f1294baeab 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -14,6 +14,9 @@
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/io-pgtable.h>
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/module.h>
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
@@ -28,6 +31,7 @@
 #include <uapi/linux/virtio_iommu.h>
 #include "iommu-pasid-table.h"
 #include "iommu-sva-lib.h"
+#include "io-pgtable-arm.h"
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -41,6 +45,7 @@ DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
 
 static DEFINE_MUTEX(sva_lock);
 static DEFINE_MUTEX(iopf_lock);
+static DEFINE_MUTEX(viommu_asid_lock);
 
 struct viommu_dev_pri_work {
 	struct work_struct		work;
@@ -88,10 +93,22 @@ struct viommu_mapping {
 struct viommu_mm {
 	int				pasid;
 	u64				archid;
+	struct viommu_sva_bond		*bond;
 	struct io_pgtable_ops		*ops;
 	struct viommu_domain		*domain;
 };
 
+struct viommu_sva_bond {
+	struct iommu_sva		sva;
+	struct mm_struct		*mm;
+	struct iommu_psdtable_mmu_notifier	*viommu_mn;
+	struct list_head		list;
+	refcount_t			refs;
+};
+
+#define sva_to_viommu_bond(handle) \
+	container_of(handle, struct viommu_sva_bond, sva)
+
 struct viommu_domain {
 	struct iommu_domain		domain;
 	struct viommu_dev		*viommu;
@@ -136,6 +153,7 @@ struct viommu_endpoint {
 	bool				pri_supported;
 	bool				sva_enabled;
 	bool				iopf_enabled;
+	struct list_head		bonds;
 };
 
 struct viommu_ep_entry {
@@ -1423,14 +1441,15 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
 
 		pst_cfg->iommu_dev = viommu->dev->parent;
 
+		mutex_lock(&viommu_asid_lock);
 		/* Prepare PASID tables info to allocate a new table */
 		ret = viommu_prepare_pst(vdev, pst_cfg, fmt);
 		if (ret)
-			return ret;
+			goto err_out_unlock;
 
 		ret = iommu_psdtable_alloc(tbl, pst_cfg);
 		if (ret)
-			return ret;
+			goto err_out_unlock;
 
 		pst_cfg->iommu_dev = viommu->dev->parent;
 		pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
@@ -1452,6 +1471,7 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
 			if (ret)
 				goto err_free_ops;
 		}
+		mutex_unlock(&viommu_asid_lock);
 	} else {
 		/* TODO: otherwise, check for compatibility with vdev. */
 		return -ENOSYS;
@@ -1467,6 +1487,8 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
 err_free_psdtable:
 	iommu_psdtable_free(tbl, &tbl->cfg);
 
+err_out_unlock:
+	mutex_unlock(&viommu_asid_lock);
 	return ret;
 }
 
@@ -1706,6 +1728,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	vdev->dev = dev;
 	vdev->viommu = viommu;
 	INIT_LIST_HEAD(&vdev->resv_regions);
+	INIT_LIST_HEAD(&vdev->bonds);
 	dev_iommu_priv_set(dev, vdev);
 
 	if (viommu->probe_size) {
@@ -1755,6 +1778,175 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static u32 viommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
+
+	return bond->mm->pasid;
+}
+
+static void viommu_mmu_notifier_free(struct mmu_notifier *mn)
+{
+	kfree(mn_to_pstiommu(mn));
+}
+
+static struct mmu_notifier_ops viommu_mmu_notifier_ops = {
+	.free_notifier		= viommu_mmu_notifier_free,
+};
+
+/* Allocate or get existing MMU notifier for this {domain, mm} pair */
+static struct iommu_psdtable_mmu_notifier *
+viommu_mmu_notifier_get(struct viommu_domain *vdomain, struct mm_struct *mm,
+			u32 asid_bits)
+{
+	int ret;
+	struct iommu_psdtable_mmu_notifier *viommu_mn;
+	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
+
+	list_for_each_entry(viommu_mn, &tbl->mmu_notifiers, list) {
+		if (viommu_mn->mn.mm == mm) {
+			refcount_inc(&viommu_mn->refs);
+			return viommu_mn;
+		}
+	}
+
+	mutex_lock(&viommu_asid_lock);
+	viommu_mn = iommu_psdtable_alloc_shared(tbl, mm, &viommu_asid_xa,
+						asid_bits);
+	mutex_unlock(&viommu_asid_lock);
+	if (IS_ERR(viommu_mn))
+		return ERR_CAST(viommu_mn);
+
+	refcount_set(&viommu_mn->refs, 1);
+	viommu_mn->cookie = vdomain;
+	viommu_mn->mn.ops = &viommu_mmu_notifier_ops;
+
+	ret = mmu_notifier_register(&viommu_mn->mn, mm);
+	if (ret)
+		goto err_free_cd;
+
+	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid,
+				   viommu_mn->vendor.cd);
+	if (ret)
+		goto err_put_notifier;
+
+	list_add(&viommu_mn->list, &tbl->mmu_notifiers);
+	return viommu_mn;
+
+err_put_notifier:
+	/* Frees viommu_mn */
+	mmu_notifier_put(&viommu_mn->mn);
+err_free_cd:
+	iommu_psdtable_free_shared(tbl, &viommu_asid_xa, viommu_mn->vendor.cd);
+	return ERR_PTR(ret);
+}
+
+static void
+viommu_mmu_notifier_put(struct iommu_psdtable_mmu_notifier *viommu_mn)
+{
+	struct mm_struct *mm = viommu_mn->mn.mm;
+	struct viommu_domain *vdomain = viommu_mn->cookie;
+	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
+	u16 asid = viommu_mn->vendor.cd->asid;
+
+	if (!refcount_dec_and_test(&viommu_mn->refs))
+		return;
+
+	list_del(&viommu_mn->list);
+	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, NULL);
+
+	/*
+	 * If we went through clear(), we've already invalidated, and no
+	 * new TLB entry can have been formed.
+	 */
+	if (!viommu_mn->cleared)
+		iommu_psdtable_flush_tlb(tbl, vdomain, asid);
+
+	/* Frees smmu_mn */
+	mmu_notifier_put(&viommu_mn->mn);
+	iommu_psdtable_free_shared(tbl, &viommu_asid_xa, viommu_mn->vendor.cd);
+}
+
+static struct iommu_sva *
+__viommu_sva_bind(struct device *dev, struct mm_struct *mm)
+{
+	int ret;
+	struct viommu_sva_bond *bond;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct virtio_iommu_probe_table_format *desc = vdev->pgtf;
+
+	if (!vdev || !vdev->sva_enabled)
+		return ERR_PTR(-ENODEV);
+
+	/* If bind() was already called for this {dev, mm} pair, reuse it. */
+	list_for_each_entry(bond, &vdev->bonds, list) {
+		if (bond->mm == mm) {
+			refcount_inc(&bond->refs);
+			return &bond->sva;
+		}
+	}
+
+	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+	if (!bond)
+		return ERR_PTR(-ENOMEM);
+
+	/* Allocate a PASID for this mm if necessary */
+	ret = iommu_sva_alloc_pasid(mm, 1, (1U << vdev->pasid_bits) - 1);
+	if (ret)
+		goto err_free_bond;
+
+	bond->mm = mm;
+	bond->sva.dev = dev;
+	refcount_set(&bond->refs, 1);
+
+	bond->viommu_mn = viommu_mmu_notifier_get(vdomain, mm, desc->asid_bits);
+	if (IS_ERR(bond->viommu_mn)) {
+		ret = PTR_ERR(bond->viommu_mn);
+		goto err_free_pasid;
+	}
+
+	list_add(&bond->list, &vdev->bonds);
+	return &bond->sva;
+
+err_free_pasid:
+	iommu_sva_free_pasid(mm);
+err_free_bond:
+	kfree(bond);
+	return ERR_PTR(ret);
+}
+
+/* closely follows arm_smmu_sva_bind() */
+static struct iommu_sva *viommu_sva_bind(struct device *dev,
+					 struct mm_struct *mm, void *drvdata)
+{
+	struct iommu_sva *handle;
+
+	mutex_lock(&sva_lock);
+	handle = __viommu_sva_bind(dev, mm);
+	mutex_unlock(&sva_lock);
+	return handle;
+}
+
+void viommu_sva_unbind(struct iommu_sva *handle)
+{
+	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(handle->dev);
+
+	if (vdev->pri_supported)
+		iopf_queue_flush_dev(handle->dev);
+
+	mutex_lock(&sva_lock);
+	if (refcount_dec_and_test(&bond->refs)) {
+		list_del(&bond->list);
+		viommu_mmu_notifier_put(bond->viommu_mn);
+		iommu_sva_free_pasid(bond->mm);
+		kfree(bond);
+	}
+	mutex_unlock(&sva_lock);
+}
+
 static bool viommu_endpoint_iopf_supported(struct viommu_endpoint *vdev)
 {
 	/* TODO: support Stall model later */
@@ -1960,6 +2152,9 @@ static struct iommu_ops viommu_ops = {
 	.dev_feat_enabled	= viommu_dev_feature_enabled,
 	.dev_enable_feat	= viommu_dev_enable_feature,
 	.dev_disable_feat	= viommu_dev_disable_feature,
+	.sva_bind		= viommu_sva_bind,
+	.sva_unbind		= viommu_sva_unbind,
+	.sva_get_pasid		= viommu_sva_get_pasid,
 };
 
 static int viommu_init_vqs(struct viommu_dev *viommu)
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 88a3db493108..c12d9b6a7243 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -122,6 +122,8 @@ struct virtio_iommu_req_attach_pst_arm {
 #define VIRTIO_IOMMU_PGTF_ARM_HPD0		(1ULL << 41)
 #define VIRTIO_IOMMU_PGTF_ARM_EPD1		(1 << 23)
 
+#define VIRTIO_IOMMU_PGTF_ARM_IPS_SHIFT		32
+#define VIRTIO_IOMMU_PGTF_ARM_IPS_MASK		0x7
 #define VIRTIO_IOMMU_PGTF_ARM_TG0_SHIFT		14
 #define VIRTIO_IOMMU_PGTF_ARM_TG0_MASK		0x3
 #define VIRTIO_IOMMU_PGTF_ARM_SH0_SHIFT		12
-- 
2.17.1

