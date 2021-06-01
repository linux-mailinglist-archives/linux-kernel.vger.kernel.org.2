Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3432139783C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhFAQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:44:18 -0400
Received: from foss.arm.com ([217.140.110.172]:54144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233904AbhFAQoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA9B101E;
        Tue,  1 Jun 2021 09:42:35 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFABC3F719;
        Tue,  1 Jun 2021 09:42:33 -0700 (PDT)
Subject: Re: [PATCH] iommu: Print default strict or lazy mode at init time
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@lst.de
References: <1622209074-37899-1-git-send-email-john.garry@huawei.com>
 <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
 <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <58ea001c-4c37-9c5a-77be-38ac3bea2476@arm.com>
Date:   Tue, 1 Jun 2021 17:42:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-01 16:50, John Garry wrote:
> On 01/06/2021 10:09, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 808ab70d5df5..f25fae62f077 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -138,6 +138,11 @@ static int __init iommu_subsys_init(void)
>>>           (iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
>>>               "(set via kernel command line)" : "");
>>> +    pr_info("Default DMA domain mode: %s %s\n",
>>
>> Nit: I think this might be a little unclear for end-users - *I'm* not 
>> even sure whether "Default" here is meant to refer to the mode setting 
>> itself or to default domains (of DMA type). Maybe something like "DMA 
>> domain TLB invalidation policy"? Certainly it seems like a good idea 
>> to explicitly mention invalidation to correlate with the documentation 
>> of the "iommu.strict" parameter.
>>
>> Ack to the general idea though.
> 
> ok, so I'll go with this:
> 
> pr_info("DMA domain default TLB invalidation policy: %s mode %s\n",
>                iommu_dma_strict ? "strict" : "lazy",
>                 (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>                         "(set via kernel command line)" : "");
> 
> I think it's worth mentioning "default" somewhere, as not all IOMMUs or 
> devices will use lazy mode even if it's default.

But that's part of what I think is misleading - I boot and see that the 
default is something, so I reboot with iommu.strict to explicitly set it 
the other way, but now that's the default... huh?

The way I see it, we're saying what the current IOMMU API policy is - 
the value of iommu_dma_strict at any given time is fact - but we're not 
necessarily saying how widely that policy is enforced. We similarly 
report the type for default domains from global policy even though that 
may also be overridden per-group by drivers and/or userspace later; we 
don't say it's the *default* default domain type.

However, having now debugged the AMD issue from another thread, I think 
doing this at subsys_initcall is in fact going to be too early to be 
meaningful, since it ignores drivers' ability to change the global policy :(

Robin.
