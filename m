Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C843AE6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUKCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:02:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:4721 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhFUKCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:02:47 -0400
IronPort-SDR: Svb8YS3vppKP2m48CdaVawxBdtvMiG512cIrDGzwLSOhB24qgG9o+I/agYWJjCBpnhbeCXdiKJ
 qKXht+R3md8A==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="194123643"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="194123643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 03:00:31 -0700
IronPort-SDR: sfKkS2pGcsLCq+ai4r7335G8stFAKnSGccjXqqvwZwqpJZTBJS97KEo/uX69xlsptIa9Osx+rb
 NK9JEsmx0yIw==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="452131304"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.249]) ([10.254.211.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 03:00:27 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
Message-ID: <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
Date:   Mon, 21 Jun 2021 18:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/21 16:12, John Garry wrote:
> On 21/06/2021 06:17, Lu Baolu wrote:
>> On 2021/6/18 19:34, John Garry wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 60b1ec42e73b..ff221d3ddcbc 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>>>   }
>>>   early_param("iommu.strict", iommu_dma_setup);
>>> -void iommu_set_dma_strict(bool strict)
>>> +void iommu_set_dma_strict(void)
>>>   {
>>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>> -        iommu_dma_strict = strict;
>>> +    iommu_dma_strict = true;
>>>   }
>>
> 
> Hi baolu,

Hi John,

> 
>> Sorry for this late comment.
>>  > Normally the cache invalidation policy should come from the user. We
>> have pre-build kernel option and also a kernel boot command iommu.strict
>> to override it. These seem reasonable.
>>
>> We also have a helper (iommu_set_dma_strict()) so that the vendor iommu
>> driver could squeeze in and change the previous settings mostly due to:
>>
>> a) vendor iommu driver specific kernel boot command. (We are about to
>>     deprecate those.)
>>
>> b) quirky hardware.
>>
>> c) kernel optimization (e.x. strict mode in VM environment).
>>
>> a) and b) are mandatory, while c) is optional. In any instance should c)
>> override the flush mode specified by the user. Hence, probably we should
>> also have another helper like:
>>
>> void iommu_set_dma_strict_optional()
>> {
>>      if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>          iommu_dma_strict = true;
>> }
>>
>> Any thoughts?
> 
> What you are suggesting is a change in policy from mainline code. 
> Currently for c) we always set strict enabled, regardless of any user 
> cmdline input. But now you are saying that you want iommu.strict to 
> override in particular scenario, right?
> 
> In that case I would think it's better to rework the current API, like 
> adding an option to "force" strict mode:
> 
> void iommu_set_dma_strict(bool force)
> {
>           if (force == true)
>          iommu_dma_strict = true;
>      else if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>          iommu_dma_strict = true;
> }
> 
> So we would use iommu_set_dma_strict(true) for a) and b), but 
> iommu_set_dma_strict(false) for c).

Yes. We need to distinguish the "must" and "nice-to-have" cases of
setting strict mode.

> 
> Then I am not sure what you want to do with the accompanying print for 
> c). It was:
> "IOMMU batching is disabled due to virtualization"
> 
> And now is from this series:
> "IOMMU batching disallowed due to virtualization"
> 
> Using iommu_get_dma_strict(domain) is not appropriate here to know the 
> current mode (so we know whether to print).
> 
> Note that this change would mean that the current series would require 
> non-trivial rework, which would be unfortunate so late in the cycle.

This patch series looks good to me and I have added by reviewed-by.
Probably we could make another patch series to improve it so that the
kernel optimization should not override the user setting.

Best regards,
baolu
