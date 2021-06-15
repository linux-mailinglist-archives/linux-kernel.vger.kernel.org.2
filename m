Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48F63A896E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFOTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:23:09 -0400
Received: from foss.arm.com ([217.140.110.172]:44104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhFOTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:23:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20A9CED1;
        Tue, 15 Jun 2021 12:21:03 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21FC73F694;
        Tue, 15 Jun 2021 12:21:02 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
To:     Nadav Amit <namit@vmware.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-6-namit@vmware.com>
 <1913c012-e6c0-1d5e-01b3-5f6da367c6bd@arm.com>
 <7549686F-1F53-475D-950C-8F44A2165475@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4343ee2f-896f-e8cc-0c63-31c7e98467f2@arm.com>
Date:   Tue, 15 Jun 2021 20:20:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7549686F-1F53-475D-950C-8F44A2165475@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-15 19:14, Nadav Amit wrote:
> 
> 
>> On Jun 15, 2021, at 5:55 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-06-07 19:25, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>> AMD's IOMMU can flush efficiently (i.e., in a single flush) any range.
>>> This is in contrast, for instnace, to Intel IOMMUs that have a limit on
>>> the number of pages that can be flushed in a single flush.  In addition,
>>> AMD's IOMMU do not care about the page-size, so changes of the page size
>>> do not need to trigger a TLB flush.
>>> So in most cases, a TLB flush due to disjoint range or page-size changes
>>> are not needed for AMD. Yet, vIOMMUs require the hypervisor to
>>> synchronize the virtualized IOMMU's PTEs with the physical ones. This
>>> process induce overheads, so it is better not to cause unnecessary
>>> flushes, i.e., flushes of PTEs that were not modified.
>>> Implement and use amd_iommu_iotlb_gather_add_page() and use it instead
>>> of the generic iommu_iotlb_gather_add_page(). Ignore page-size changes
>>> and disjoint regions unless "non-present cache" feature is reported by
>>> the IOMMU capabilities, as this is an indication we are running on a
>>> physical IOMMU. A similar indication is used by VT-d (see "caching
>>> mode"). The new logic retains the same flushing behavior that we had
>>> before the introduction of page-selective IOTLB flushes for AMD.
>>> On virtualized environments, check if the newly flushed region and the
>>> gathered one are disjoint and flush if it is. Also check whether the new
>>> region would cause IOTLB invalidation of large region that would include
>>> unmodified PTE. The latter check is done according to the "order" of the
>>> IOTLB flush.
>>
>> If it helps,
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks!
> 
> 
>> I wonder if it might be more effective to defer the alignment-based splitting part to amd_iommu_iotlb_sync() itself, but that could be investigated as another follow-up.
> 
> Note that the alignment-based splitting is only used for virtualized AMD IOMMUs, so it has no impact for most users.
> 
> Right now, the performance is kind of bad on VMs since AMD’s IOMMU driver does a full IOTLB flush whenever it unmaps more than a single page. So, although your idea makes sense, I do not know exactly how to implement it right now, and regardless it is likely to provide much lower performance improvements than those that avoiding full IOTLB flushes would.
> 
> Having said that, if I figure out a way to implement it, I would give it a try (although I am admittedly afraid of a complicated logic that might cause subtle, mostly undetectable bugs).

I was mainly thinking that when you observe a change in "order" and sync 
to avoid over-invalidating adjacent pages, those pages may still be part 
of the current unmap and you've just not seen them added yet. Hence 
simply gathering contiguous pages regardless of alignment, then breaking 
the total range down into appropriately-aligned commands in the sync 
once you know you've seen everything, seems like it might allow issuing 
fewer commands overall. But I haven't quite grasped the alignment rules 
either, so possibly this is moot anyway.

Robin.
