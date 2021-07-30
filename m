Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946373DB362
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhG3GOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:14:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:61597 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237294AbhG3GOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:14:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="192634130"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="192634130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465345547"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:14:37 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 24/24] iommu: Only log strictness for DMA domains
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <b2da9ba999b54acded9198cf92cf9b7d0fce1b45.1627468310.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7a071314-ee88-fcff-baf0-fb8e33a86dd4@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:12:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b2da9ba999b54acded9198cf92cf9b7d0fce1b45.1627468310.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> When passthrough is enabled, the default strictness policy becomes
> irrelevant, since any subsequent runtime override to a DMA domain type
> now embodies an explicit choice of strictness as well. Save on noise by
> only logging the default policy when it is meaningfully in effect.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index be399d630953..87d7b299436e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -144,10 +144,11 @@ static int __init iommu_subsys_init(void)
>   		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
>   			"(set via kernel command line)" : "");
>   
> -	pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
> -		iommu_dma_strict ? "strict" : "lazy",
> -		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
> -			"(set via kernel command line)" : "");
> +	if (!iommu_default_passthrough())
> +		pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
> +			iommu_dma_strict ? "strict" : "lazy",
> +			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
> +				"(set via kernel command line)" : "");
>   
>   	return 0;
>   }
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
