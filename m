Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58583ABC45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhFQTFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:05:45 -0400
Received: from foss.arm.com ([217.140.110.172]:58672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhFQTFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:05:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B459313A1;
        Thu, 17 Jun 2021 12:03:35 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A150E3F694;
        Thu, 17 Jun 2021 12:03:33 -0700 (PDT)
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com, linux-doc@vger.kernel.org
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
 <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cc22fd7e-2cb6-d33a-33ab-bbca0a389507@arm.com>
Date:   Thu, 17 Jun 2021 20:03:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-17 09:00, John Garry wrote:
> On 17/06/2021 08:32, Lu Baolu wrote:
>> On 6/16/21 7:03 PM, John Garry wrote:
>>> @@ -4382,9 +4380,9 @@ int __init intel_iommu_init(void)
>>>            * is likely to be much lower than the overhead of 
>>> synchronizing
>>>            * the virtual and physical IOMMU page-tables.
>>>            */
>>> -        if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
>>> -            pr_warn("IOMMU batching is disabled due to 
>>> virtualization");
>>> -            intel_iommu_strict = 1;
>>> +        if (cap_caching_mode(iommu->cap)) {
>>> +            pr_warn("IOMMU batching disallowed due to 
>>> virtualization\n");
>>> +            iommu_set_dma_strict(true);
>>
>> With this change, VM guest will always show this warning.
> 
> Would they have got it before also normally?
> 
> I mean, default is intel_iommu_strict=0, so if 
> cap_caching_mode(iommu->cap) is true and intel_iommu_strict not set to 1 
> elsewhere previously, then we would get this print.
> 
>> How about
>> removing this message? Users could get the same information through the
>> kernel message added by "[PATCH v13 2/6] iommu: Print strict or lazy
>> mode at init time".
> 
> I think that the print from 2/6 should occur before this print.
> 
> Regardless I would think that you would still like to be notified of 
> this change in policy, right?
> 
> However I now realize that the print is in a loop per iommu, so we would 
> get it per iommu:
> 
> for_each_active_iommu(iommu, drhd) {
>      /*
>       * The flush queue implementation does not perform
>       * page-selective invalidations that are required for efficient
>       * TLB flushes in virtual environments.  The benefit of batching
>       * is likely to be much lower than the overhead of synchronizing
>       * the virtual and physical IOMMU page-tables.
>       */
>      if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
>          pr_warn("IOMMU batching is disabled due to virtualization");
>          intel_iommu_strict = 1;
>      }
>      ...
> }
> 
> I need to change that. How about this:
> 
> bool print_warning = false;
> 
> for_each_active_iommu(iommu, drhd) {
>      /*
>       * The flush queue implementation does not perform
>       * page-selective invalidations that are required for efficient
>       * TLB flushes in virtual environments.  The benefit of batching
>       * is likely to be much lower than the overhead of synchronizing
>       * the virtual and physical IOMMU page-tables.
>       */
>      if (!print_warning && cap_caching_mode(iommu->cap)) {
>          pr_warn("IOMMU batching disallowed due to virtualization\n");
>          iommu_set_dma_strict(true);
>          print_warning = true;
>      }
>      ...
> }
> 
> or use pr_warn_once().

Maybe even downgrade it to pr_info_once(), since AIUI it's not really 
anything scary?

I suppose you could technically fake up a domain on the stack to get the 
global setting out of iommu_get_dma_strict(), or perhaps give 
iommu_set_dma_strict() a cheeky return value to indicate what the 
previous setting was, in order to suppress the message entirely if 
strict is already set, but I'm not at all convinced it's worth the bother.

Robin.
