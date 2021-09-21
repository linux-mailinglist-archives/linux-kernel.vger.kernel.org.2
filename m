Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C693414125
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhIVFOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:29329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhIVFOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012043"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012043"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107682"
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
Subject: [RFC 4/7] dma-iommu: Add support for DMA w/ PASID in KVA
Date:   Tue, 21 Sep 2021 13:29:38 -0700
Message-Id: <1632256181-36071-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharing virtual addresses between DMA and CPU has many advantages. It
simplifies the programming model, enhances DMA security over physical
addresses. This patch adds KVA support for DMA IOMMU API. Strict and
fast sub-modes are supported transparently based on the device
trustfulness.

The strict mode is intended for untrusted devices. KVA mapping is
established on-demand by a separate IOMMU page table referenced by a
supervisor PASID. An aux domain is allocated per device to carry
the supervisor PASID.

The fast mode is for trusted devices where KVA mapping is shared with
the CPU via kernel page table. Vendor IOMMU driver can choose to use a
global KVA domain for all devices in fast KVA mode.

The follow-up patches will introduce iommu_map_kva() API where KVA
domains will be used.The performance advantage of the fast mode rests
upon the fact that there is no need to build/teardown a separate IOMMU
page table for each DMA buffer.
                                                                       
Though multiple PASIDs and domains per device can be supported the    
lack of compelling usages leads to a single PASID option for now.       

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 75 ++++++++++++++++++++++++++++++++++-----
 drivers/iommu/iommu.c     |  6 ++++
 include/linux/dma-iommu.h |  6 ++--
 include/linux/iommu.h     |  6 ++++
 4 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 490731659def..5b25dbcef8ee 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -174,9 +174,15 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static bool dev_is_untrusted(struct device *dev)
+{
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+}
+
 /**
  * iommu_dma_pasid_enable --Enable device DMA request with PASID
  * @dev:	Device to be enabled
+ * @domain:	IOMMU domain returned for KVA mode mapping
  * @mode:	DMA addressing mode
  *
  * The following mutually exclusive DMA addressing modes are supported:
@@ -189,10 +195,25 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
  *     tables. PCI requester ID (RID) and RID+PASID will be pointed to the same
  *     PGD. i.e. the default DMA domain will be used by both RID and RID+PASID.
  *
+ *  3. KVA mode. DMA address == CPU virtual address. There are two sub-modes:
+ *     strict mode and fast mode.
+ *     The strict mode is intended for the untrusted devices, where DMA address
+ *     is identical to KVA but restricted per device on the supervisor PASID.
+ *     The fast mode is for trusted devices where its DMA is only restricted
+ *     by the kernel page tables used by the CPU. iommu_domains with UNMANAGED
+ *     and KVA types are returned respectively. They are used by iommu_map_kva()
+ *
+ *     The performance advantage of the fast mode (based on whether the device
+ *     is trusted or user allowed), relies on the fact that there is no need
+ *     to build/teardown a separate IOMMU page tables for KVA mapping.
+ *
+ *     Though multiple PASIDs and domains per device can be supported but the
+ *     lack of compelling usages lead to a single PASID option for now.
+ *
  * @return the supervisor PASID to be used for DMA. Or INVALID_IOASID upon
  *     failure.
  */
-int iommu_dma_pasid_enable(struct device *dev,
+int iommu_dma_pasid_enable(struct device *dev, struct iommu_domain **domain,
 			   enum iommu_dma_pasid_mode mode)
 {
 	int pasid = INVALID_IOASID;
@@ -201,8 +222,37 @@ int iommu_dma_pasid_enable(struct device *dev,
 	/* TODO: only allow a single mode each time, track PASID DMA enabling
 	 * status per device. Perhaps add a flag in struct device.dev_iommu.
 	 */
+	if (mode == IOMMU_DMA_PASID_KVA) {
+		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX)) {
+			dev_err(dev, "No aux domain support");
+			goto exit;
+		};
+		/*
+		 * Untrusted devices gets an unmanaged domain which will be
+		 * returned to the caller for strict IOMMU API KVA mapping.
+		 * Trusted device gets a special KVA domain with init_mm.pgd
+		 * assigned.
+		 */
+		if (dev_is_untrusted(dev))
+			dom = iommu_domain_alloc(dev->bus);
+		else
+			dom = iommu_domain_alloc_kva(dev->bus);
+		if (!dom) {
+			dev_err(dev, "No KVA iommu domain allocated");
+			goto exit_disable_aux;
+		}
+		if (iommu_aux_attach_device(dom, dev)) {
+			dev_err(dev, "Failed to attach KVA iommu domain");
+			goto exit_free_domain;
+		};
+		pasid = iommu_aux_get_pasid(dom, dev);
+
+		dev_dbg(dev, "KVA mode pasid %d", pasid);
+		*domain = dom;
+		goto exit;
+	}
 
-	/* Call vendor drivers to handle IOVA, bypass mode */
+	/* Call vendor drivers to handle IOVA, bypass, and KVA trusted mode */
 	dom = iommu_get_domain_for_dev(dev);
 	if (dom->ops->enable_pasid_dma(dev, IOASID_DMA_PASID, mode)) {
 		dev_dbg(dev, "Failed to enable DMA pasid in mode %d", mode);
@@ -212,15 +262,29 @@ int iommu_dma_pasid_enable(struct device *dev,
 
 	dev_dbg(dev, "Enable DMA pasid %d in mode %d", pasid, mode);
 	goto exit;
+
+exit_free_domain:
+	iommu_domain_free(dom);
+exit_disable_aux:
+	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_AUX);
 exit:
 	return pasid;
 }
 EXPORT_SYMBOL(iommu_dma_pasid_enable);
 
-int iommu_dma_pasid_disable(struct device *dev)
+int iommu_dma_pasid_disable(struct device *dev, struct iommu_domain *domain)
 {
 	struct iommu_domain *dom;
 
+	if (domain) {
+		/* s-pasid will be cleared during detach */
+		iommu_aux_detach_device(domain, dev);
+		iommu_domain_free(domain);
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_AUX);
+		dev_dbg(dev, "KVA aux domain freed");
+		return 0;
+	}
+
 	/* Call vendor iommu ops to clean up supervisor PASID context */
 	dom = iommu_get_domain_for_dev(dev);
 
@@ -364,11 +428,6 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 	domain->ops->flush_iotlb_all(domain);
 }
 
-static bool dev_is_untrusted(struct device *dev)
-{
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
-}
-
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..acfdcd7ebd6a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1950,6 +1950,12 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
+struct iommu_domain *iommu_domain_alloc_kva(struct bus_type *bus)
+{
+	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_KVA);
+}
+EXPORT_SYMBOL_GPL(iommu_domain_alloc_kva);
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	domain->ops->domain_free(domain);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 3c1555e0fd51..e858d42a6669 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -22,13 +22,15 @@ enum iommu_dma_pasid_mode {
 	IOMMU_DMA_PASID_BYPASS = 1,
 	/* Compatible with DMA APIs, same mapping as DMA w/o PASID */
 	IOMMU_DMA_PASID_IOVA,
+	/* Use kernel direct mapping memory, page_offset_base */
+	IOMMU_DMA_PASID_KVA,
 };
 /* For devices that can do DMA request with PASID, setup the system
  * based on the address mode selected.
  */
-int iommu_dma_pasid_enable(struct device *dev,
+int iommu_dma_pasid_enable(struct device *dev, struct iommu_domain **domain,
 			   enum iommu_dma_pasid_mode mode);
-int iommu_dma_pasid_disable(struct device *dev);
+int iommu_dma_pasid_disable(struct device *dev, struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 610cbfd03e6b..cd8225f6bc23 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -60,6 +60,7 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_KVA	(1U << 3)  /* Domain shares with CPU KVA */
 
 /*
  * This are the possible domain-types
@@ -72,12 +73,16 @@ struct iommu_domain_geometry {
  *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
  *				  This flag allows IOMMU drivers to implement
  *				  certain optimizations for these domains
+ *	IOMMU_DOMAIN_KVA	- DMA addresses are kernel virtual addresses.
+ *				  Mapping can be managed by IOMMU API or shares
+ *				  the CPU page table, i.e. SVA.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
+#define IOMMU_DOMAIN_KVA	(__IOMMU_DOMAIN_KVA)
 
 struct iommu_domain {
 	unsigned type;
@@ -389,6 +394,7 @@ extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
+extern struct iommu_domain *iommu_domain_alloc_kva(struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
-- 
2.25.1

