Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB13ACBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhFRNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:15:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:15673 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhFRNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:15:23 -0400
IronPort-SDR: NYVyOXcK2hNQ7whDqA/pCXSCLVEkaZEcZftmuVdM8VkFpMRRk5YXX184KLdUvaVfY+e62T2pPy
 Q2xs+YDVSaWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270398993"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="270398993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:13:14 -0700
IronPort-SDR: vqt62rlt4WZpPqRivpJWzS01x8ipWt/4pOiQT41ie5yfW6m8A9HUTyU2BKUx9lH4jtLk15kN3N
 sxax4kq6/pOA==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485684747"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157]) ([10.254.212.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:13:10 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <23887d11-2174-6909-c9d7-36a50f070e44@linux.intel.com>
Date:   Fri, 18 Jun 2021 21:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 19:34, John Garry wrote:
> We only ever now set strict mode enabled in iommu_set_dma_strict(), so
> just remove the argument.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/amd/init.c    | 2 +-
>   drivers/iommu/intel/iommu.c | 6 +++---
>   drivers/iommu/iommu.c       | 5 ++---
>   include/linux/iommu.h       | 2 +-
>   4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1e641cb6dddc..6e12a615117b 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3099,7 +3099,7 @@ static int __init parse_amd_iommu_options(char *str)
>   	for (; *str; ++str) {
>   		if (strncmp(str, "fullflush", 9) == 0) {
>   			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 06666f9d8116..77d0834fb0df 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,7 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
>   			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		} else if (!strncmp(str, "sp_off", 6)) {
>   			pr_info("Disable supported super page\n");
>   			intel_iommu_superpage = 0;
> @@ -4382,7 +4382,7 @@ int __init intel_iommu_init(void)
>   		 */
>   		if (cap_caching_mode(iommu->cap)) {
>   			pr_info_once("IOMMU batching disallowed due to virtualization\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		}
>   		iommu_device_sysfs_add(&iommu->iommu, NULL,
>   				       intel_iommu_groups,
> @@ -5699,7 +5699,7 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   	} else if (dmar_map_gfx) {
>   		/* we have to ensure the gfx device is idle before we flush */
>   		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> -		iommu_set_dma_strict(true);
> +		iommu_set_dma_strict();
>   	}
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60b1ec42e73b..ff221d3ddcbc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>   }
>   early_param("iommu.strict", iommu_dma_setup);
>   
> -void iommu_set_dma_strict(bool strict)
> +void iommu_set_dma_strict(void)
>   {
> -	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> -		iommu_dma_strict = strict;
> +	iommu_dma_strict = true;
>   }
>   
>   bool iommu_get_dma_strict(struct iommu_domain *domain)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..754f67d6dd90 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -476,7 +476,7 @@ int iommu_enable_nesting(struct iommu_domain *domain);
>   int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirks);
>   
> -void iommu_set_dma_strict(bool val);
> +void iommu_set_dma_strict(void);
>   bool iommu_get_dma_strict(struct iommu_domain *domain);
>   
>   extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
