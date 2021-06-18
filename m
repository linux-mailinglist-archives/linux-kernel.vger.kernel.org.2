Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905263AC09C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhFRBuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:50:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:16946 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhFRBuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:50:03 -0400
IronPort-SDR: v/1vlkpYSrIcQKK91alFET4BUDFxlmhGwr4SscZZD8mn49zbRuftmU0wLhFr32JebKumFnGuGC
 N7f9ZkIIN/Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267626191"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267626191"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 18:47:55 -0700
IronPort-SDR: kEflpgrQfTrMXjL0qCHu94Hq3SWkwi5YoXUQzL8ZbmBwaRiE6t7/IHjTdU+u+6WcP9Wq8FrGj/
 VS73Oscd56pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="472612100"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 18:47:51 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
 <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d53a6472-4628-313e-30a5-f76e016c9cb9@linux.intel.com>
Date:   Fri, 18 Jun 2021 09:46:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 6/17/21 4:00 PM, John Garry wrote:
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

Yes. You are right.

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

 From my p.o.v, pr_xxxx_once() is better.

How about using a pr_info_once()? I don't think it's a warning, it's
just a policy choice in VM environment.

Best regards,
baolu
