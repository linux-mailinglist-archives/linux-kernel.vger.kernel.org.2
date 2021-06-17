Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361233AADCD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFQHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:40:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:53686 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhFQHke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:40:34 -0400
IronPort-SDR: rt5VEOCLSk+eA5S+JOHcKjjG5wMOS34ga8fQ44o/+WqAoTTiFNF0P3wRbwj5DnbwQw6VrZmaQR
 yZIYXX961O9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="267468081"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="267468081"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:38:27 -0700
IronPort-SDR: 136uuNiQtSsp9UVMNfU0hELOyo7dqnGjHU3/mznhhTdIWs+Ee7LEbb4kX22PvK+SCfQsddUAHv
 VgYhkuJeAACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472331510"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:38:22 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
Date:   Thu, 17 Jun 2021 15:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623841437-211832-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 7:03 PM, John Garry wrote:
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
> index fb3618af643b..7bc460052678 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3099,7 +3099,7 @@ static int __init parse_amd_iommu_options(char *str)
>   	for (; *str; ++str) {
>   		if (strncmp(str, "fullflush", 9) == 0) {
>   			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d586990fa751..0618c35cfb51 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,7 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
>   			pr_warn("intel_iommu=strict deprecated; use iommu.strict instead\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		} else if (!strncmp(str, "sp_off", 6)) {
>   			pr_info("Disable supported super page\n");
>   			intel_iommu_superpage = 0;
> @@ -4382,7 +4382,7 @@ int __init intel_iommu_init(void)
>   		 */
>   		if (cap_caching_mode(iommu->cap)) {
>   			pr_warn("IOMMU batching disallowed due to virtualization\n");
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

Sorry, I still can't get how iommu.strict kernel option works.

static int __init iommu_dma_setup(char *str)
{
         int ret = kstrtobool(str, &iommu_dma_strict);

         if (!ret)
                 iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
         return ret;
}
early_param("iommu.strict", iommu_dma_setup);

The bit IOMMU_CMD_LINE_STRICT is only set, but not used anywhere. Hence,
I am wondering how could it work? A bug or I missed anything?

Best regards,
baolu

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
