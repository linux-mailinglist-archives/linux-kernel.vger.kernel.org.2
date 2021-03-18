Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664C933FD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCRDNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:13:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:4440 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhCRDNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:13:01 -0400
IronPort-SDR: fU/kAqDbY100CLcsm4tmpcELwRrNFoXEwl6ummeWBtaaZkvs0tHEt/Px+38m/ob/8BQtonS3Py
 mfrM8YCclp4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="274646172"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="274646172"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 20:13:00 -0700
IronPort-SDR: Vnx2oAyvyukdZlcAlstH7BILdaPTgSZ4JzbZ1NXTAuRxz/+bbmk/5w+XoAZD7qOEB5v3jBQmr1
 C/Zb+pW/13yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="433653512"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2021 20:12:58 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        chenjiashang <chenjiashang@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To:     Nadav Amit <nadav.amit@gmail.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f4c562d-fcee-3212-0880-f67fd45b1462@linux.intel.com>
Date:   Thu, 18 Mar 2021 11:03:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

On 3/18/21 2:12 AM, Nadav Amit wrote:
> 
> 
>> On Mar 17, 2021, at 2:35 AM, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) <longpeng2@huawei.com> wrote:
>>
>> Hi Nadav,
>>
>>> -----Original Message-----
>>> From: Nadav Amit [mailto:nadav.amit@gmail.com]
>>>>   reproduce the problem with high probability (~50%).
>>>
>>> I saw Lu replied, and he is much more knowledgable than I am (I was just intrigued
>>> by your email).
>>>
>>> However, if I were you I would try also to remove some “optimizations” to look for
>>> the root-cause (e.g., use domain specific invalidations instead of page-specific).
>>>
>>
>> Good suggestion! But we did it these days, we tried to use global invalidations as follow:
>> 		iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> 						DMA_TLB_DSI_FLUSH);
>> But can not resolve the problem.
>>
>>> The first thing that comes to my mind is the invalidation hint (ih) in
>>> iommu_flush_iotlb_psi(). I would remove it to see whether you get the failure
>>> without it.
>>
>> We also notice the IH, but the IH is always ZERO in our case, as the spec says:
>> '''
>> Paging-structure-cache entries caching second-level mappings associated with the specified
>> domain-id and the second-level-input-address range are invalidated, if the Invalidation Hint
>> (IH) field is Clear.
>> '''
>>
>> It seems the software is everything fine, so we've no choice but to suspect the hardware.
> 
> Ok, I am pretty much out of ideas. I have two more suggestions, but
> they are much less likely to help. Yet, they can further help to rule
> out software bugs:
> 
> 1. dma_clear_pte() seems to be wrong IMHO. It should have used WRITE_ONCE()
> to prevent split-write, which might potentially cause “invalid” (partially
> cleared) PTE to be stored in the TLB. Having said that, the subsequent
> IOTLB flush should have prevented the problem.

Agreed. The pte read/write should use READ/WRITE_ONCE() instead.

> 
> 2. Consider ensuring that the problem is not somehow related to queued
> invalidations. Try to use __iommu_flush_iotlb() instead of
> qi_flush_iotlb().
> 
> Regards,
> Nadav
> 

Best regards,
baolu
