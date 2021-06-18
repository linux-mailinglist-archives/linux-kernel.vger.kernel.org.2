Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB73ACBD1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFRNPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:15:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:43189 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbhFRNO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:14:59 -0400
IronPort-SDR: fG8oKebLAw0W5KQ+vnI07QWkpVzxSOx7ehe5+7YotVEKsgOT3BS2/ouL0m2Knr9TYz6vCuIsde
 p0UQtzQKMwUw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267695196"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="267695196"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:12:49 -0700
IronPort-SDR: HoZxFEQod0VKcin9iZGxkCwHY2CBQcNur3HHKhv223Slcfm07jcUGAzBZBs7z+NrXFIWIsG7X9
 XkOLz7xf7HFw==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485684621"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157]) ([10.254.212.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:12:45 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-5-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dd20c637-1837-4ca2-8360-64d2a8d265d3@linux.intel.com>
Date:   Fri, 18 Jun 2021 21:12:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 19:34, John Garry wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Make IOMMU_DEFAULT_LAZY default for when INTEL_IOMMU config is set,
> as is current behaviour.
> 
> Also delete global flag intel_iommu_strict:
> - In intel_iommu_setup(), call iommu_set_dma_strict(true) directly. Also
>    remove the print, as iommu_subsys_init() prints the mode and we have
>    already marked this param as deprecated.
> 
> - For cap_caching_mode() check in intel_iommu_setup(), call
>    iommu_set_dma_strict(true) directly; also reword the accompanying print
>    with a level downgrade and also add the missing '\n'.
> 
> - For Ironlake GPU, again call iommu_set_dma_strict(true) directly and
>    keep the accompanying print.
> 
> [jpg: Remove intel_iommu_strict]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/Kconfig       |  1 +
>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 0327a942fdb7..c214a36eb2dc 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -94,6 +94,7 @@ choice
>   	prompt "IOMMU default DMA IOTLB invalidation mode"
>   	depends on IOMMU_DMA
>   
> +	default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>   	default IOMMU_DEFAULT_STRICT
>   	help
>   	  This option allows an IOMMU DMA IOTLB invalidation mode to be
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 29497113d748..06666f9d8116 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -361,7 +361,6 @@ int intel_iommu_enabled = 0;
>   EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>   
>   static int dmar_map_gfx = 1;
> -static int intel_iommu_strict;
>   static int intel_iommu_superpage = 1;
>   static int iommu_identity_mapping;
>   static int iommu_skip_te_disable;
> @@ -455,8 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
>   			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
> -			pr_info("Disable batched IOTLB flush\n");
> -			intel_iommu_strict = 1;
> +			iommu_set_dma_strict(true);
>   		} else if (!strncmp(str, "sp_off", 6)) {
>   			pr_info("Disable supported super page\n");
>   			intel_iommu_superpage = 0;
> @@ -4382,9 +4380,9 @@ int __init intel_iommu_init(void)
>   		 * is likely to be much lower than the overhead of synchronizing
>   		 * the virtual and physical IOMMU page-tables.
>   		 */
> -		if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
> -			pr_warn("IOMMU batching is disabled due to virtualization");
> -			intel_iommu_strict = 1;
> +		if (cap_caching_mode(iommu->cap)) {
> +			pr_info_once("IOMMU batching disallowed due to virtualization\n");
> +			iommu_set_dma_strict(true);
>   		}
>   		iommu_device_sysfs_add(&iommu->iommu, NULL,
>   				       intel_iommu_groups,
> @@ -4393,7 +4391,6 @@ int __init intel_iommu_init(void)
>   	}
>   	up_read(&dmar_global_lock);
>   
> -	iommu_set_dma_strict(intel_iommu_strict);
>   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
>   	if (si_domain && !hw_pass_through)
>   		register_memory_notifier(&intel_iommu_memory_nb);
> @@ -5702,8 +5699,8 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   	} else if (dmar_map_gfx) {
>   		/* we have to ensure the gfx device is idle before we flush */
>   		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> -		intel_iommu_strict = 1;
> -       }
> +		iommu_set_dma_strict(true);
> +	}
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
