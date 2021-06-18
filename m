Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5A3AC0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhFRB4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:56:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:33130 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhFRB4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:56:08 -0400
IronPort-SDR: KYoHLS4KXRrwb2NU1pQmwg4vKP9r8C06glvOoCflgGR8spICw+K2oIUbkqtQRitJym6ZAbd3kl
 IbRqV5oNh4KA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206433565"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="206433565"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 18:53:59 -0700
IronPort-SDR: M+7j3e8w7yg2eVqLS5rDHawbsDeYbC4twNz64FToCwPMeSFGvwl1+C7/OBU26n4Mmu2kNQruxh
 Qt87RSrquZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="472613025"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 18:53:56 -0700
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
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
 <c61376c8-5285-1121-046f-3ab12eee9902@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cac021f9-8469-a3b4-a0c6-80a37e882b6f@linux.intel.com>
Date:   Fri, 18 Jun 2021 09:52:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c61376c8-5285-1121-046f-3ab12eee9902@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 3:41 PM, John Garry wrote:
> 
>>> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>>>   }
>>>   early_param("iommu.strict", iommu_dma_setup);
>>> -void iommu_set_dma_strict(bool strict)
>>> +void iommu_set_dma_strict(void)
>>>   {
>>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>> -        iommu_dma_strict = strict;
>>> +    iommu_dma_strict = true;
>>
>> Sorry, I still can't get how iommu.strict kernel option works.
>>
>> static int __init iommu_dma_setup(char *str)
>> {
>>          int ret = kstrtobool(str, &iommu_dma_strict);
>>
>>          if (!ret)
>>                  iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
>>          return ret;
>> }
>> early_param("iommu.strict", iommu_dma_setup);
>>
>> The bit IOMMU_CMD_LINE_STRICT is only set, but not used anywhere.
> 
> It is used in patch 2/6:
> 
> +    pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
> +        iommu_dma_strict ? "strict" : "lazy",
> +        (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
> +            "(set via kernel command line)" : "");
> 
>> Hence,
>> I am wondering how could it work? A bug or I missed anything?
> 
> It is really just used for informative purpose now.

I am clear now. Thanks!

Best regards,
baolu
