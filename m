Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB241411B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhIVFOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:29325 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhIVFOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012038"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107660"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:10 -0700
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
Subject: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Date:   Tue, 21 Sep 2021 13:29:34 -0700
Message-Id: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg/Jason/Christoph et all,

The current in-kernel supervisor PASID support is based on the SVM/SVA
machinery in sva-lib. Kernel SVA is achieved by extending a special flag
to indicate the binding of the device and a page table should be performed
on init_mm instead of the mm of the current process.Page requests and other
differences between user and kernel SVA are handled as special cases.

This unrestricted binding with the kernel page table is being challenged
for security and the convention that in-kernel DMA must be compatible with
DMA APIs.
(https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
There is also the lack of IOTLB synchronization upon kernel page table updates.

This patchset is trying to address these concerns by having an explicit DMA
API compatible model while continue to support in-kernel use of DMA requests
with PASID. Specifically, the following DMA-IOMMU APIs are introduced:

int iommu_dma_pasid_enable/disable(struct device *dev,
				   struct iommu_domain **domain,
				   enum iommu_dma_pasid_mode mode);
int iommu_map/unmap_kva(struct iommu_domain *domain,
			void *cpu_addr,size_t size, int prot);

The following three addressing modes are supported with example API usages
by device drivers.

1. Physical address (bypass) mode. Similar to DMA direct where trusted devices
can DMA pass through IOMMU on a per PASID basis.
Example:
	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_BYPASS);
	/* Use the returning PASID and PA for work submission */

2. IOVA mode. DMA API compatible. Map a supervisor PASID the same way as the
PCI requester ID (RID)
Example:
	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_IOVA);
	/* Use the PASID and DMA API allocated IOVA for work submission */

3. KVA mode. New kva map/unmap APIs. Support fast and strict sub-modes
transparently based on device trustfulness.
Example:
	pasid = iommu_dma_pasid_enable(dev, &domain, IOMMU_DMA_PASID_KVA);
	iommu_map_kva(domain, &buf, size, prot);
	/* Use the returned PASID and KVA to submit work */
Where:
	Fast mode: Shared CPU page tables for trusted devices only
	Strict mode: IOMMU domain returned for the untrusted device to
	replicate KVA-PA mapping in IOMMU page tables.

On a per device basis, DMA address and performance modes are enabled by the
device drivers. Platform information such as trustability, user command line
input (not included in this set) could also be taken into consideration (not
implemented in this RFC).

This RFC is intended to communicate the API directions. Little testing is done
outside IDXD and DMA engine tests.

For PA and IOVA modes, the implementation is straightforward and tested with
Intel IDXD driver. But several opens remain in KVA fast mode thus not tested:
1. Lack of IOTLB synchronization, kernel direct map alias can be updated as a
result of module loading/eBPF load. Adding kernel mmu notifier?
2. The use of the auxiliary domain for KVA map, will aux domain stay in the
long term? Is there another way to represent sub-device granu isolation?
3. Is limiting the KVA sharing to the direct map range reasonable and
practical for all architectures?


Many thanks to Ashok Raj, Kevin Tian, and Baolu who provided feedback and
many ideas in this set.

Thanks,

Jacob

Jacob Pan (7):
  ioasid: reserve special PASID for in-kernel DMA
  dma-iommu: Add API for DMA request with PASID
  iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
  dma-iommu: Add support for DMA w/ PASID in KVA
  iommu/vt-d: Add support for KVA PASID mode
  iommu: Add KVA map API
  dma/idxd: Use dma-iommu PASID API instead of SVA lib

 drivers/dma/idxd/idxd.h                       |   4 +-
 drivers/dma/idxd/init.c                       |  36 ++--
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/dma-iommu.c                     | 123 +++++++++++++-
 drivers/iommu/intel/iommu.c                   | 154 +++++++++++++++++-
 drivers/iommu/ioasid.c                        |   2 +
 drivers/iommu/iommu-sva-lib.c                 |   1 +
 drivers/iommu/iommu.c                         |  63 +++++++
 include/linux/dma-iommu.h                     |  14 ++
 include/linux/intel-iommu.h                   |   7 +-
 include/linux/ioasid.h                        |   4 +
 include/linux/iommu.h                         |  13 ++
 12 files changed, 390 insertions(+), 33 deletions(-)

-- 
2.25.1

