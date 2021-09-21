Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB07414126
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhIVFOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:29329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbhIVFOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012044"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012044"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107690"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:13 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: [RFC 5/7] iommu/vt-d: Add support for KVA PASID mode
Date:   Tue, 21 Sep 2021 13:29:39 -0700
Message-Id: <1632256181-36071-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support KVA fast mode, the VT-d driver must support domain allocation
of IOMMU_DOMAIN_KVA type. Since all devices in fast KVA mode share the
same kernel mapping, a single KVA domain is sufficient. This global KVA
domain contains the kernel mapping, i.e. init_mm.pgd.

The programming of the KVA domain follows the existing flow of auxiliary
domain attachment.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 59 ++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cbcfd178c16f..0dabd5f75acf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -293,6 +293,9 @@ static inline void context_clear_entry(struct context_entry *context)
  *	3. Each iommu mapps to this domain if successful.
  */
 static struct dmar_domain *si_domain;
+
+/* This domain is used for shared virtual addressing with CPU kernel mapping */
+static struct dmar_domain *kva_domain;
 static int hw_pass_through = 1;
 
 #define for_each_domain_iommu(idx, domain)			\
@@ -1989,6 +1992,10 @@ static void domain_exit(struct dmar_domain *domain)
 	/* Remove associated devices and clear attached or cached domains */
 	domain_remove_dev_info(domain);
 
+	/* There is no IOMMU page table for KVA */
+	if (domain->pgd == (struct dma_pte *)init_mm.pgd)
+		return;
+
 	/* destroy iovas */
 	if (domain->domain.type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(&domain->domain);
@@ -2533,6 +2540,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	int agaw, level;
 	int flags = 0;
 
+	if (domain->domain.type == IOMMU_DOMAIN_KVA) {
+		flags |= PASID_FLAG_SUPERVISOR_MODE;
+		goto do_setup;
+	}
 	/*
 	 * Skip top levels of page tables for iommu which has
 	 * less agaw than default. Unnecessary for PT mode.
@@ -2554,7 +2565,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 
 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
 		flags |= PASID_FLAG_PAGE_SNOOP;
-
+do_setup:
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
 					     domain->iommu_did[iommu->seq_id],
 					     flags);
@@ -2713,7 +2724,28 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static int __init kva_domain_init(void)
+{
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
 
+	kva_domain = alloc_domain(0);
+	if (!kva_domain) {
+		pr_err("Can't allocate KVA domain\n");
+		return -EFAULT;
+	}
+	kva_domain->pgd = (struct dma_pte *)init_mm.pgd;
+	domain = &kva_domain->domain;
+	domain->type = IOMMU_DOMAIN_KVA;
+	/* REVISIT: may not need this other than sanity check */
+	domain->geometry.aperture_start = 0;
+	domain->geometry.aperture_end   =
+		__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+	domain->geometry.force_aperture = true;
+	return 0;
+}
+#endif
 static int __init si_domain_init(int hw)
 {
 	struct dmar_rmrr_unit *rmrr;
@@ -3363,6 +3395,11 @@ static int __init init_dmars(void)
 			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
+			/* For in-kernel DMA with PASID in SVA */
+			ret = kva_domain_init();
+			if (ret)
+				goto free_iommu;
+
 		}
 #endif
 		ret = dmar_set_interrupt(iommu);
@@ -4558,6 +4595,9 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.force_aperture = true;
 
 		return domain;
+	case IOMMU_DOMAIN_KVA:
+		/* Use a global domain for shared KVA mapping */
+		return &kva_domain->domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
 	default:
@@ -4583,7 +4623,8 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
 	struct device_domain_info *info = get_domain_info(dev);
 
 	return info && info->auxd_enabled &&
-			domain->type == IOMMU_DOMAIN_UNMANAGED;
+		(domain->type == IOMMU_DOMAIN_UNMANAGED ||
+			domain->type == IOMMU_DOMAIN_KVA);
 }
 
 static inline struct subdev_domain_info *
@@ -4693,8 +4734,8 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	if (ret)
 		goto attach_failed;
 
-	/* Setup the PASID entry for mediated devices: */
-	if (domain_use_first_level(domain))
+	/* Setup the PASID entry for devices do DMA with the default PASID */
+	if (domain_use_first_level(domain) || domain->domain.type == IOMMU_DOMAIN_KVA)
 		ret = domain_setup_first_level(iommu, domain, dev,
 					       domain->default_pasid);
 	else
@@ -4761,6 +4802,10 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if (domain->type == IOMMU_DOMAIN_KVA) {
+		pr_info("TODO: KVA dom check if device can do full 64bit DMA");
+		return 0;
+	}
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5588,6 +5633,12 @@ static int intel_enable_pasid_dma(struct device *dev, u32 pasid, int mode)
 		ret = domain_setup_first_level(info->iommu, info->domain, dev,
 						pasid);
 		break;
+	case IOMMU_DMA_PASID_KVA:
+		/*
+		 * KVA mode should be handled in the aux domain attach where the default
+		 * PASID of the aux domain is used for setting up PASID FL.
+		 */
+		fallthrough;
 	default:
 		dev_err(dev, "Invalid PASID DMA mode %d", mode);
 		ret = -EINVAL;
-- 
2.25.1

