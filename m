Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187073325CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCIMvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:51:06 -0500
Received: from foss.arm.com ([217.140.110.172]:52576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhCIMug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:50:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092291042;
        Tue,  9 Mar 2021 04:50:36 -0800 (PST)
Received: from [10.57.55.135] (unknown [10.57.55.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F493F70D;
        Tue,  9 Mar 2021 04:50:34 -0800 (PST)
Subject: Re: [PATCH v3] iommu: Check dev->iommu in iommu_dev_xxx functions
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, jean-philippe@linaro.org, will@kernel.org,
        prime.zeng@hisilicon.com, linuxarm@openeuler.org
References: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ed0f8327-a23d-c9fd-672d-a431b3327593@arm.com>
Date:   Tue, 9 Mar 2021 12:50:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-03 17:36, Shameer Kolothum wrote:
> The device iommu probe/attach might have failed leaving dev->iommu
> to NULL and device drivers may still invoke these functions resulting
> in a crash in iommu vendor driver code.
> 
> Hence make sure we check that.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: a3a195929d40 ("iommu: Add APIs for multiple domains per device")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v2 --> v3
>   -Removed iommu_ops from struct dev_iommu.
> v1 --> v2:
>   -Added iommu_ops to struct dev_iommu based on the discussion with Robin.
>   -Rebased against iommu-tree core branch.
> ---
>   drivers/iommu/iommu.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d0b0a15dba84..e10cfa99057c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2878,10 +2878,12 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>    */
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>   {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	if (dev->iommu && dev->iommu->iommu_dev) {
> +		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
>   
> -	if (ops && ops->dev_enable_feat)
> -		return ops->dev_enable_feat(dev, feat);
> +		if (ops->dev_enable_feat)
> +			return ops->dev_enable_feat(dev, feat);
> +	}
>   
>   	return -ENODEV;
>   }
> @@ -2894,10 +2896,12 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
>    */
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>   {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	if (dev->iommu && dev->iommu->iommu_dev) {
> +		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
>   
> -	if (ops && ops->dev_disable_feat)
> -		return ops->dev_disable_feat(dev, feat);
> +		if (ops->dev_disable_feat)
> +			return ops->dev_disable_feat(dev, feat);
> +	}
>   
>   	return -EBUSY;
>   }
> @@ -2905,10 +2909,12 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
>   
>   bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>   {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	if (dev->iommu && dev->iommu->iommu_dev) {
> +		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
>   
> -	if (ops && ops->dev_feat_enabled)
> -		return ops->dev_feat_enabled(dev, feat);
> +		if (ops->dev_feat_enabled)
> +			return ops->dev_feat_enabled(dev, feat);
> +	}
>   
>   	return false;
>   }
> 
