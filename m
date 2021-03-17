Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0133EEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCQKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:50:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:37624 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhCQKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:50:18 -0400
IronPort-SDR: aFoGlUtMTvtMlFlArnDdHWUW7Tt8fKRS6YNpqQ/WnXl6lMZNI5kiebMD9T8cvk9R63sK/CoCLx
 lk4ARnUnrt/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="177033674"
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="177033674"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 03:50:18 -0700
IronPort-SDR: lJxrk1Ea9liNowOIg/IECe5NzhRnlPf/GU0qkUHRTPgkZ86cvdIn+uvfscfjOVDHmBBAmxJfDq
 eQR5XqUOBWZw==
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="412599152"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Mar 2021 03:50:13 -0700
Date:   Wed, 17 Mar 2021 18:44:29 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
Subject: Re: [PATCH v2 06/11] iommu/arm-smmu-v3: Scan leaf TTD to sync
 hardware dirty log
Message-ID: <20210317104429.GT28580@yi.y.sun>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-7-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310090614.26668-7-zhukeqian1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-10 17:06:09, Keqian Zhu wrote:
> From: jiangkunkun <jiangkunkun@huawei.com>
> 
> During dirty log tracking, user will try to retrieve dirty log from
> iommu if it supports hardware dirty log.
> 
> This adds a new interface named sync_dirty_log in iommu layer and
> arm smmuv3 implements it, which scans leaf TTD and treats it's dirty
> if it's writable (As we just enable HTTU for stage1, so check whether
> AP[2] is not set).
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
> 
> changelog:
> 
> v2:
>  - Add new sanity check in arm_smmu_sync_dirty_log(). (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
>  - Document the purpose of flush_iotlb in arm_smmu_sync_dirty_log(). (Robin)
>  
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 30 +++++++
>  drivers/iommu/io-pgtable-arm.c              | 90 +++++++++++++++++++++
>  drivers/iommu/iommu.c                       | 38 +++++++++
>  include/linux/io-pgtable.h                  |  4 +
>  include/linux/iommu.h                       | 18 +++++
>  5 files changed, 180 insertions(+)
> 
Please split iommu common interface out. Thanks!

[...]

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2a10294b62a3..44dfb78f9050 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2850,6 +2850,44 @@ int iommu_stop_dirty_log(struct iommu_domain *domain, unsigned long iova,
>  }
>  EXPORT_SYMBOL_GPL(iommu_stop_dirty_log);
>  
> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
> +			 size_t size, unsigned long *bitmap,
> +			 unsigned long base_iova, unsigned long bitmap_pgshift)

One open question: shall we add PASID as one parameter to make iommu
know which address space to visit?

For live migration, the pasid should not be necessary. But considering
future extension, it may be required.

BRs,
Yi Sun
