Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3353DB34E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhG3GMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:12:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:19641 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237060AbhG3GMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:12:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="274111327"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="274111327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465345165"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:12:46 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 19/24] iommu: Expose DMA domain strictness via sysfs
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c9093f55-a88f-d8d7-95e2-8350db3741df@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> The sysfs interface for default domain types exists primarily so users
> can choose the performance/security tradeoff relevant to their own
> workload. As such, the choice between the policies for DMA domains fits
> perfectly as an additional point on that scale - downgrading a
> particular device from a strict default to non-strict may be enough to
> let it reach the desired level of performance, while still retaining
> more peace of mind than with a wide-open identity domain. Now that we've
> abstracted non-strict mode as a distinct type of DMA domain, allow it to
> be chosen through the user interface as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/ABI/testing/sysfs-kernel-iommu_groups | 2 ++
>   drivers/iommu/iommu.c                               | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> index eae2f1c1e11e..43ba764ba5b7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> @@ -42,6 +42,8 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
>   		========  ======================================================
>   		DMA       All the DMA transactions from the device in this group
>   		          are translated by the iommu.
> +		DMA-FQ    As above, but using batched invalidation to lazily
> +		          remove translations after use.
>   		identity  All the DMA transactions from the device in this group
>   		          are not translated by the iommu.
>   		auto      Change to the type the device was booted with.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index eecb5657de69..5a08e0806cbb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3265,6 +3265,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   		req_type = IOMMU_DOMAIN_IDENTITY;
>   	else if (sysfs_streq(buf, "DMA"))
>   		req_type = IOMMU_DOMAIN_DMA;
> +	else if (sysfs_streq(buf, "DMA-FQ"))
> +		req_type = IOMMU_DOMAIN_DMA_FQ;
>   	else if (sysfs_streq(buf, "auto"))
>   		req_type = 0;
>   	else
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
