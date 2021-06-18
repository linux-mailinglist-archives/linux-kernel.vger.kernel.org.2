Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97743ACBC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFRNL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:11:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:44518 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhFRNL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:11:57 -0400
IronPort-SDR: 8H10y1Asdv9zuikdoDgPhnhxiVofy/YZTjK1F16dHshL1DSTRN0R+MMx4QTqMyH4aGJiVLGJpW
 mBEaJJvYgtJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206501766"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="206501766"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:09:46 -0700
IronPort-SDR: k0VNKFgc6/+ZCs+/29CFEINWXy8j5ryxt4Kiuk5WVmtQSAapGGKzOhEQiK4osW6tBDtXBMXpFP
 /enHauR5gPDQ==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485683414"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157]) ([10.254.212.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:09:42 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 1/6] iommu: Deprecate Intel and AMD cmdline methods to
 enable strict mode
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-2-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <31d7ec79-79e8-4ae9-6705-e08c1256f432@linux.intel.com>
Date:   Fri, 18 Jun 2021 21:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 19:34, John Garry wrote:
> Now that the x86 drivers support iommu.strict, deprecate the custom
> methods.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 9 ++-------
>   drivers/iommu/amd/init.c                        | 4 +++-
>   drivers/iommu/intel/iommu.c                     | 1 +
>   3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 30e9dd52464e..673952379900 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -290,10 +290,7 @@
>   	amd_iommu=	[HW,X86-64]
>   			Pass parameters to the AMD IOMMU driver in the system.
>   			Possible values are:
> -			fullflush - enable flushing of IO/TLB entries when
> -				    they are unmapped. Otherwise they are
> -				    flushed before they will be reused, which
> -				    is a lot of faster
> +			fullflush - Deprecated, equivalent to iommu.strict=1
>   			off	  - do not initialize any AMD IOMMU found in
>   				    the system
>   			force_isolation - Force device isolation for all
> @@ -1948,9 +1945,7 @@
>   			this case, gfx device will use physical address for
>   			DMA.
>   		strict [Default Off]
> -			With this option on every unmap_single operation will
> -			result in a hardware IOTLB flush operation as opposed
> -			to batching them for performance.
> +			Deprecated, equivalent to iommu.strict=1.
>   		sp_off [Default Off]
>   			By default, super page will be supported if Intel IOMMU
>   			has the capability. With this option, super page will
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 46280e6e1535..3a2fb805f11e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
>   static int __init parse_amd_iommu_options(char *str)
>   {
>   	for (; *str; ++str) {
> -		if (strncmp(str, "fullflush", 9) == 0)
> +		if (strncmp(str, "fullflush", 9) == 0) {
> +			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
>   			amd_iommu_unmap_flush = true;
> +		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
>   		if (strncmp(str, "off", 3) == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bd93c7ec879e..29497113d748 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> +			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
>   			pr_info("Disable batched IOTLB flush\n");
>   			intel_iommu_strict = 1;
>   		} else if (!strncmp(str, "sp_off", 6)) {
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
