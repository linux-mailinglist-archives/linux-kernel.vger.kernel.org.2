Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE75333D0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhCPJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:24:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:46862 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236223AbhCPJXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:23:49 -0400
IronPort-SDR: fBF0X3rxgJUcQVWEPD4kLyVdgK0EYWh0y7KvNOpl5v9f8mh0sKnqfgXiPqTLBCrtuf2PHNyrGg
 DMkWPSsUYV0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176359553"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176359553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 02:23:40 -0700
IronPort-SDR: CrQEz3Ag/ybTmE/AKIhoS6JlqMs8jIsDGXGu3qBz2a7xb6J+XW5eh5kL00OMxdeOM628wp1Rb5
 /se5GT1T9v/Q==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449660949"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Mar 2021 02:23:35 -0700
Date:   Tue, 16 Mar 2021 17:17:51 +0800
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
Subject: Re: [PATCH v2 04/11] iommu/arm-smmu-v3: Split block descriptor when
 start dirty log
Message-ID: <20210316091751.GN28580@yi.y.sun>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-5-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310090614.26668-5-zhukeqian1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-10 17:06:07, Keqian Zhu wrote:
> From: jiangkunkun <jiangkunkun@huawei.com>
> 
> Block descriptor is not a proper granule for dirty log tracking.
> Take an extreme example, if DMA writes one byte, under 1G mapping,
> the dirty amount reported to userspace is 1G, but under 4K mapping,
> the dirty amount is just 4K.
> 
> This adds a new interface named start_dirty_log in iommu layer and
> arm smmuv3 implements it, which splits block descriptor to an span
> of page descriptors. Other types of IOMMU will perform architecture
> specific actions to start dirty log.
> 
> To allow code reuse, the split_block operation is realized as an
> iommu_ops too. We flush all iotlbs after the whole procedure is
> completed to ease the pressure of iommu, as we will hanle a huge
> range of mapping in general.
> 
> Spliting block does not simultaneously work with other pgtable ops,
> as the only designed user is vfio, which always hold a lock, so race
> condition is not considered in the pgtable ops.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
> 
> changelog:
> 
> v2:
>  - Change the return type of split_block(). size_t -> int.
>  - Change commit message to properly describe race condition. (Robin)
>  - Change commit message to properly describe the need of split block.
>  - Add a new interface named start_dirty_log(). (Sun Yi)
>  - Change commit message to explain the realtionship of split_block() and start_dirty_log().
> 
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  52 +++++++++
>  drivers/iommu/io-pgtable-arm.c              | 122 ++++++++++++++++++++
>  drivers/iommu/iommu.c                       |  48 ++++++++
>  include/linux/io-pgtable.h                  |   2 +
>  include/linux/iommu.h                       |  24 ++++
>  5 files changed, 248 insertions(+)
> 
Could you please split iommu common interface to a separate patch?
This may make review and comments easier.

IMHO, I think the start/stop interfaces could be merged into one, e.g:
    int iommu_domain_set_hwdbm(struct iommu_domain *domain, bool enable,
                               unsigned long iova, size_t size,
                               int prot);

Same comments to patch 5.

BRs,
Yi Sun

> -- 
> 2.19.1
