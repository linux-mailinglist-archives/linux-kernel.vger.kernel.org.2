Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5607C43703A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhJVC7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:59:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:12121 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhJVC7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:59:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229076023"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="229076023"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 19:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="484494597"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2021 19:56:46 -0700
Cc:     baolu.lu@linux.intel.com, Sven Peter <sven@svenpeter.dev>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Alexander Graf <graf@amazon.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
To:     Marc Zyngier <maz@kernel.org>
References: <20211019163737.46269-1-sven@svenpeter.dev>
 <20211019163737.46269-5-sven@svenpeter.dev>
 <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
 <8735ovdbcv.wl-maz@kernel.org>
 <6a886030-cbc6-9e92-bf79-77b659da2915@linux.intel.com>
 <87wnm6bxx2.wl-maz@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <106088e3-2928-dace-e1b6-e1e74ffec366@linux.intel.com>
Date:   Fri, 22 Oct 2021 10:52:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87wnm6bxx2.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 4:10 PM, Marc Zyngier wrote:
> On Thu, 21 Oct 2021 03:22:30 +0100,
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 10/20/21 10:22 PM, Marc Zyngier wrote:
>>> On Wed, 20 Oct 2021 06:21:44 +0100,
>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> On 2021/10/20 0:37, Sven Peter via iommu wrote:
>>>>> +	/*
>>>>> +	 * Check that CPU pages can be represented by the IOVA granularity.
>>>>> +	 * This has to be done after ops->attach_dev since many IOMMU drivers
>>>>> +	 * only limit domain->pgsize_bitmap after having attached the first
>>>>> +	 * device.
>>>>> +	 */
>>>>> +	ret = iommu_check_page_size(domain);
>>>>> +	if (ret) {
>>>>> +		__iommu_detach_device(domain, dev);
>>>>> +		return ret;
>>>>> +	}
>>>>
>>>> It looks odd. __iommu_attach_device() attaches an I/O page table for a
>>>> device. How does it relate to CPU pages? Why is it a failure case if CPU
>>>> page size is not covered?
>>>
>>> If you allocate a CPU PAGE_SIZE'd region, and point it at a device
>>> that now can DMA to more than what you have allocated because the
>>> IOMMU's own page size is larger, the device has now access to data it
>>> shouldn't see. In my book, that's a pretty bad thing.
>>
>> But even you enforce the CPU page size check here, this problem still
>> exists unless all DMA buffers are PAGE_SIZE aligned and sized, right?
> 
> Let me take a CPU analogy: you have a page that contains some user
> data *and* a kernel secret. How do you map this page into userspace
> without leaking the kernel secret?
> 
> PAGE_SIZE allocations are the unit of isolation, and this applies to
> both CPU and IOMMU. If you have allocated a DMA buffer that is less
> than a page, you then have to resort to bounce buffering, or accept
> that your data isn't safe.

I can understand the problems when IOMMU page sizes is larger than CPU
page size. But the code itself is not clean. The vendor iommu drivers
know more hardware details than the iommu core. It looks odd that the
vendor iommu says "okay, I can attach this I/O page table to the
device", but the iommu core says "no, you can't" and rolls everything
back.

Best regards,
baolu
