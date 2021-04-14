Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2649A35EE51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349736AbhDNHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:25:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:38252 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349710AbhDNHYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:24:36 -0400
IronPort-SDR: zYFUc1Z3Bhf+6/AqwZTL1v89T6AkF1AuPrynnURcFUyybNuDY9vOV34m6X2G4DTeOAhknHKBFA
 xfDXn1KbSLfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="258552405"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="258552405"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 00:24:13 -0700
IronPort-SDR: 35lROPy9KaI3sWZf4uqKtjH/Qunpt9OTUZ5AFPasffdrQiGF7IKnLpGAMJwBXoXQVlETsZ32D6
 mVt3msA3+Tgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="443720741"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2021 00:24:09 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-3-zhukeqian1@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
Date:   Wed, 14 Apr 2021 15:14:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413085457.25400-3-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 4:54 PM, Keqian Zhu wrote:
> Block(largepage) mapping is not a proper granule for dirty log tracking.
> Take an extreme example, if DMA writes one byte, under 1G mapping, the
> dirty amount reported is 1G, but under 4K mapping, the dirty amount is
> just 4K.
> 
> This adds a new interface named iommu_split_block in IOMMU base layer.
> A specific IOMMU driver can invoke it during start dirty log. If so, the
> driver also need to realize the split_block iommu ops.
> 
> We flush all iotlbs after the whole procedure is completed to ease the
> pressure of IOMMU, as we will hanle a huge range of mapping in general.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>   drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h | 11 +++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 667b2d6d2fc0..bb413a927870 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2721,6 +2721,47 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
>   
> +int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
> +		      size_t size)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	unsigned int min_pagesz;
> +	size_t pgsize;
> +	bool flush = false;
> +	int ret = 0;
> +
> +	if (unlikely(!ops || !ops->split_block))
> +		return -ENODEV;
> +
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +	if (!IS_ALIGNED(iova | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
> +		       iova, size, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	while (size) {
> +		flush = true;
> +
> +		pgsize = iommu_pgsize(domain, iova, size);
> +
> +		ret = ops->split_block(domain, iova, pgsize);
> +		if (ret)
> +			break;
> +
> +		pr_debug("split handled: iova 0x%lx size 0x%zx\n", iova, pgsize);
> +
> +		iova += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	if (flush)
> +		iommu_flush_iotlb_all(domain);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_split_block);

Do you really have any consumers of this interface other than the dirty
bit tracking? If not, I don't suggest to make this as a generic IOMMU
interface.

There is an implicit requirement for such interfaces. The
iommu_map/unmap(iova, size) shouldn't be called at the same time.
Currently there's no such sanity check in the iommu core. A poorly
written driver could mess up the kernel by misusing this interface.

This also applies to iommu_merge_page().

Best regards,
baolu
