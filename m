Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91C3DA348
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhG2MmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:42:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:28495 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234459AbhG2MmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:42:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="276650385"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="276650385"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 05:42:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="518185758"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.5]) ([10.254.209.5])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 05:42:04 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 18/24] iommu: Express DMA strictness via the domain
 type
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
 <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
 <f2858a7f-e665-ff6a-38d6-b9d591287fac@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b5167dc8-3b04-f65a-dd69-d338fda341f1@linux.intel.com>
Date:   Thu, 29 Jul 2021 20:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f2858a7f-e665-ff6a-38d6-b9d591287fac@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/29 17:36, Robin Murphy wrote:
> On 2021-07-29 08:13, Lu Baolu wrote:
>> Hi Robin,
>>
>> On 7/28/21 11:58 PM, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 982545234cf3..eecb5657de69 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -136,6 +136,9 @@ static int __init iommu_subsys_init(void)
>>>           }
>>>       }
>>> +    if (!iommu_default_passthrough() && !iommu_dma_strict)
>>> +        iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
>>
>> iommu_dma_strict could be changed later by the vendor iommu driver via
>> iommu_set_dma_strict(). This seems not to be the right place to set
>> iommu_def_domain_type.
> 
> Ah yes, good catch once again, thanks!
> 
> I think this *is* the right place to initially set it to honour the 
> command-line option, since that matches what we do for passthrough. 
> However also like passthrough we'll need to keep things in sync if it's 
> updated later, like this:
> 
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 87d7b299436e..593d4555bc57 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -359,6 +359,8 @@ early_param("iommu.strict", iommu_dma_setup);
>   void iommu_set_dma_strict(void)
>   {
>          iommu_dma_strict = true;
> +       if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
> +               iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   }
> 
>   static ssize_t iommu_group_attr_show(struct kobject *kobj,
> 
> 
> Does that seem reasonable? I'm not sure there's any cleaner way to do it 
> since we don't want to inadvertently clobber the default type if the 
> user has given us something funky like "intel_iommu=strict 
> iommu.passthrough=1".

Yeah! It's reasonable as far as I can see.

Best regards,
baolu

> 
> Cheers,
> Robin.
> 
>>
>>> +
>>>       pr_info("Default domain type: %s %s\n",
>>>           iommu_domain_type_str(iommu_def_domain_type),
>>>           (iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
>>
>> Best regards,
>> baolu
