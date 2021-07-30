Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689923DB35A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhG3GOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:14:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:21409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237369AbhG3GOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:14:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="298623579"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="298623579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465345398"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:14:03 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 22/24] iommu: Allow enabling non-strict mode
 dynamically
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <de75b36b3b31cd328de3811c0725f3d0af448abc.1627468310.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <94645a8e-471d-2daa-d385-95a337025721@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:11:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <de75b36b3b31cd328de3811c0725f3d0af448abc.1627468310.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> Allocating and enabling a flush queue is in fact something we can
> reasonably do while a DMA domain is active, without having to rebuild it
> from scratch. Thus we can allow a strict -> non-strict transition from
> sysfs without requiring to unbind the device's driver, which is of
> particular interest to users who want to make selective relaxations to
> critical devices like the one serving their root filesystem.
> 
> Disabling and draining a queue also seems technically possible to
> achieve without rebuilding the whole domain, but would certainly be more
> involved. Furthermore there's not such a clear use-case for tightening
> up security *after* the device may already have done whatever it is that
> you don't trust it not to do, so we only consider the relaxation case.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 25c1adc1ec67..be399d630953 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3200,6 +3200,13 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>   		goto out;
>   	}
>   
> +	/* We can bring up a flush queue without tearing down the domain */
> +	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
> +		prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
> +		ret = iommu_dma_init_fq(prev_dom);
> +		goto out;
> +	}
> +
>   	/* Sets group->default_domain to the newly allocated domain */
>   	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
>   	if (ret)
> @@ -3240,9 +3247,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>   }
>   
>   /*
> - * Changing the default domain through sysfs requires the users to ubind the
> - * drivers from the devices in the iommu group. Return failure if this doesn't
> - * meet.
> + * Changing the default domain through sysfs requires the users to unbind the
> + * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
> + * transition. Return failure if this isn't met.
>    *
>    * We need to consider the race between this and the device release path.
>    * device_lock(dev) is used here to guarantee that the device release path
> @@ -3318,7 +3325,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   
>   	/* Check if the device in the group still has a driver bound to it */
>   	device_lock(dev);
> -	if (device_is_bound(dev)) {
> +	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
> +	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
>   		pr_err_ratelimited("Device is still bound to driver\n");
>   		ret = -EBUSY;
>   		goto out;
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
