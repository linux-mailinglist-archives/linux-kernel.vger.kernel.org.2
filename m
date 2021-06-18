Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71543ACBCD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFRNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:14:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:54049 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232858AbhFRNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:14:06 -0400
IronPort-SDR: 9wAIvuyQbJgvsh1NwUOfHxhSPyrwHvmTN+SZuWfzqblSPAeoez27oOuuzs7tI+LP9uqwYdacjx
 YdUz9lXdYj7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193863555"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193863555"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:11:56 -0700
IronPort-SDR: fUXp1eNyFe8UHrCwz/mApMUTcrdnOKODGqLQOfQ62eLnCaWEHWd9I2KQ/oYkSldHOKvWhTQkSW
 5d8xDSpzz37w==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485684332"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157]) ([10.254.212.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:11:52 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 3/6] iommu: Enhance IOMMU default DMA mode build
 options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-4-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4bd4b850-720e-bd02-c04d-01013be49456@linux.intel.com>
Date:   Fri, 18 Jun 2021 21:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 19:34, John Garry wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
> opportunity to set {lazy|strict} mode as default at build time. Then put
> the two config options in an choice, as they are mutually exclusive.
> 
> [jpg: Make choice between strict and lazy only (and not passthrough)]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  3 +-
>   drivers/iommu/Kconfig                         | 40 +++++++++++++++++++
>   drivers/iommu/iommu.c                         |  2 +-
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 673952379900..a1b7c8526bb5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2046,9 +2046,10 @@
>   			  throughput at the cost of reduced device isolation.
>   			  Will fall back to strict mode if not supported by
>   			  the relevant IOMMU driver.
> -			1 - Strict mode (default).
> +			1 - Strict mode.
>   			  DMA unmap operations invalidate IOMMU hardware TLBs
>   			  synchronously.
> +			unset - Use value of CONFIG_IOMMU_DEFAULT_{LAZY,STRICT}.
>   			Note: on x86, the default behaviour depends on the
>   			equivalent driver-specific parameters, but a strict
>   			mode explicitly specified by either method takes
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..0327a942fdb7 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -90,6 +90,46 @@ config IOMMU_DEFAULT_PASSTHROUGH
>   
>   	  If unsure, say N here.
>   
> +choice
> +	prompt "IOMMU default DMA IOTLB invalidation mode"
> +	depends on IOMMU_DMA
> +
> +	default IOMMU_DEFAULT_STRICT
> +	help
> +	  This option allows an IOMMU DMA IOTLB invalidation mode to be
> +	  chosen at build time, to override the default mode of each ARCH,
> +	  removing the need to pass in kernel parameters through command line.
> +	  It is still possible to provide common boot params to override this
> +	  config.
> +
> +	  If unsure, keep the default.
> +
> +config IOMMU_DEFAULT_STRICT
> +	bool "strict"
> +	help
> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> +	  the free operation of IOVA are guaranteed to be done in the unmap
> +	  function.
> +
> +config IOMMU_DEFAULT_LAZY
> +	bool "lazy"
> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused.
> +
> +	  The isolation provided in this mode is not as secure as STRICT mode,
> +	  such that a vulnerable time window may be created between the DMA
> +	  unmap and the mappings cached in the IOMMU IOTLB or device TLB
> +	  finally being invalidated, where the device could still access the
> +	  memory which has already been unmapped by the device driver.
> +	  However this mode may provide better performance in high throughput
> +	  scenarios, and is still considerably more secure than passthrough
> +	  mode or no IOMMU.
> +
> +endchoice
> +
>   config OF_IOMMU
>   	def_bool y
>   	depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cf58949cc2f3..60b1ec42e73b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -29,7 +29,7 @@ static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
>   
>   static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
>   static u32 iommu_cmd_line __read_mostly;
>   
>   struct iommu_group {
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
