Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8173A1870
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFIPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:05:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232146AbhFIPFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A01F1D6E;
        Wed,  9 Jun 2021 08:03:08 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45D713F73D;
        Wed,  9 Jun 2021 08:03:07 -0700 (PDT)
Subject: Re: [PATCH v11 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
 <1623158308-180604-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b9575a44-24c7-a05b-6f02-0495e95a4cec@arm.com>
Date:   Wed, 9 Jun 2021 16:03:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623158308-180604-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08 14:18, John Garry wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
> opportunity to set {lazy|strict} mode as default at build time. Then put
> the two config options in a choice, as they are mutually exclusive.
> 
> [jpg: Make choice between strict and lazy only (and not passthrough)]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/Kconfig | 35 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c |  3 ++-
>   2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..369a3af9e5bf 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -90,6 +90,41 @@ config IOMMU_DEFAULT_PASSTHROUGH
>   
>   	  If unsure, say N here.
>   
> +choice
> +	prompt "IOMMU default DMA mode"
> +	depends on IOMMU_API
> +	depends on X86 || IA64 || X86_64 || ARM || ARM64

Simply "depends on IOMMU_DMA" should suffice, since that's now the only 
place where flush queues matter.

> +
> +	default IOMMU_DEFAULT_STRICT
> +	help
> +	  This option allows an IOMMU DMA mode to be chosen at build time, to
> +	  override the default DMA mode of each ARCH, removing the need to
> +	  pass in kernel parameters through command line. It is still possible
> +	  to provide ARCH-specific or common boot options to override this
> +	  option.
> +
> +	  If unsure, keep the default.
> +
> +config IOMMU_DEFAULT_LAZY
> +	bool "lazy"
> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused.
> +
> +config IOMMU_DEFAULT_STRICT
> +	bool "strict"
> +	help
> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> +	  the free operation of IOVA are guaranteed to be done in the unmap
> +	  function.
> +
> +	  This mode is safer than lazy mode, but it may be slower in some high
> +	  performance scenarios.

FWIW, as an end user who doesn't care much about the implementation 
details I'd probably appreciate the actual implications being clearer, 
i.e. what does "safer" mean in practice and what is it relative to?

Robin.

> +
> +endchoice
> +
>   config OF_IOMMU
>   	def_bool y
>   	depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 966426a96520..177b0dafc535 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
>   
>   static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly =
> +			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
>   static u32 iommu_cmd_line __read_mostly;
>   
>   struct iommu_group {
> 
