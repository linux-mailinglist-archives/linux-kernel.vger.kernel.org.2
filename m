Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454023A779F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFOHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:09:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:10848 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhFOHJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:09:00 -0400
IronPort-SDR: myPEn0/Wn89407FVlKCLXGKDkslEetI5j4uzG1m6KBigaBSrHyaNk5PSGzHrRxrqsfkHOWgwiF
 VPCxFQvziO8g==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="202912844"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="202912844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 00:06:54 -0700
IronPort-SDR: mNrIp/+YQDnS3YmS1uGIMe/QxU0bRmTPEa/daQnYhi6UAm6CfU3GKyLCRi6wDdwP6+vNe1YmmA
 QnFLPH0A11CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554354556"
Received: from unknown (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 00:06:52 -0700
Cc:     baolu.lu@linux.intel.com, will@kernel.org, john.garry@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Update "iommu.strict" documentation
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a84bb803-1495-bca4-abd3-e5b2654d95ce@linux.intel.com>
Date:   Tue, 15 Jun 2021 15:05:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 10:57 PM, Robin Murphy wrote:
> Consolidating the flush queue logic also meant that the "iommu.strict"
> option started taking effect on x86 as well. Make sure we document that.
> 
> Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..20a32de990ed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1987,7 +1987,7 @@
>   			  forcing Dual Address Cycle for PCI cards supporting
>   			  greater than 32-bit addressing.
>   
> -	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
> +	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
>   			Format: { "0" | "1" }
>   			0 - Lazy mode.
>   			  Request that DMA unmap operations use deferred
> @@ -1998,6 +1998,10 @@
>   			1 - Strict mode (default).
>   			  DMA unmap operations invalidate IOMMU hardware TLBs
>   			  synchronously.
> +			Note: on x86, the default behaviour depends on the
> +			equivalent driver-specific parameters, but a strict
> +			mode explicitly specified by either method takes
> +			precedence.
>   
>   	iommu.passthrough=
>   			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
