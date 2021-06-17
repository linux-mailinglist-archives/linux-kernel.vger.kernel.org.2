Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB33ABC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhFQTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:04:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhFQTEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:04:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CFC013A1;
        Thu, 17 Jun 2021 12:02:05 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683143F694;
        Thu, 17 Jun 2021 12:02:03 -0700 (PDT)
Subject: Re: [PATCH v13 1/6] iommu: Deprecate Intel and AMD cmdline methods to
 enable strict mode
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com, linux-doc@vger.kernel.org
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f95252ce-f834-103b-f96d-7e35fa59d5ec@arm.com>
Date:   Thu, 17 Jun 2021 20:01:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623841437-211832-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-16 12:03, John Garry wrote:
> Now that the x86 drivers support iommu.strict, deprecate the custom
> methods.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>   drivers/iommu/amd/init.c                        | 4 +++-
>   drivers/iommu/intel/iommu.c                     | 1 +
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 30e9dd52464e..fcbb36d6eea7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -290,7 +290,8 @@
>   	amd_iommu=	[HW,X86-64]
>   			Pass parameters to the AMD IOMMU driver in the system.
>   			Possible values are:
> -			fullflush - enable flushing of IO/TLB entries when
> +			fullflush   [Deprecated, use iommu.strict instead]
> +				  - enable flushing of IO/TLB entries when
>   				    they are unmapped. Otherwise they are
>   				    flushed before they will be reused, which
>   				    is a lot of faster
> @@ -1947,7 +1948,7 @@
>   			bypassed by not enabling DMAR with this option. In
>   			this case, gfx device will use physical address for
>   			DMA.
> -		strict [Default Off]
> +		strict [Default Off] [Deprecated, use iommu.strict instead]
>   			With this option on every unmap_single operation will
>   			result in a hardware IOTLB flush operation as opposed
>   			to batching them for performance.

FWIW I'd be inclined to replace both whole descriptions with just 
something like "Deprecated, equivalent to iommu.strict=1".

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 46280e6e1535..9f3096d650aa 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
>   static int __init parse_amd_iommu_options(char *str)
>   {
>   	for (; *str; ++str) {
> -		if (strncmp(str, "fullflush", 9) == 0)
> +		if (strncmp(str, "fullflush", 9) == 0) {
> +			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");

Nit: maybe we should spell out "...use <option>=1 instead" in all of 
these messages just in case anyone takes them literally? (I'm not sure 
the options parse correctly with no argument)

Either way,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

>   			amd_iommu_unmap_flush = true;
> +		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
>   		if (strncmp(str, "off", 3) == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bd93c7ec879e..821d8227a4e6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> +			pr_warn("intel_iommu=strict deprecated; use iommu.strict instead\n");
>   			pr_info("Disable batched IOTLB flush\n");
>   			intel_iommu_strict = 1;
>   		} else if (!strncmp(str, "sp_off", 6)) {
> 
