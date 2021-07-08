Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA883C17E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGHRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:17:15 -0400
Received: from foss.arm.com ([217.140.110.172]:34884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGHRRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:17:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 886CAED1;
        Thu,  8 Jul 2021 10:14:32 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20A413F73B;
        Thu,  8 Jul 2021 10:14:31 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
To:     Joerg Roedel <joro@8bytes.org>,
        David Stevens <stevensd@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@google.com>
References: <20210707075505.2896824-1-stevensd@google.com>
 <YObFbqEk1nGVuHLF@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a20a8f33-a047-cd89-0a2b-85e4f19c8ffa@arm.com>
Date:   Thu, 8 Jul 2021 18:14:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YObFbqEk1nGVuHLF@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-08 10:29, Joerg Roedel wrote:
> Adding Robin too.
> 
> On Wed, Jul 07, 2021 at 04:55:01PM +0900, David Stevens wrote:
>> Add support for per-domain dynamic pools of iommu bounce buffers to the
>> dma-iommu API. This allows iommu mappings to be reused while still
>> maintaining strict iommu protection. Allocating buffers dynamically
>> instead of using swiotlb carveouts makes per-domain pools more amenable
>> on systems with large numbers of devices or where devices are unknown.

But isn't that just as true for the currently-supported case? All you 
need is a large enough Thunderbolt enclosure and you could suddenly plug 
in a dozen untrusted GPUs all wanting to map hundreds of megabytes of 
memory. If there's a real concern worth addressing, surely it's worth 
addressing properly for everyone.

>> When enabled, all non-direct streaming mappings below a configurable
>> size will go through bounce buffers. Note that this means drivers which
>> don't properly use the DMA API (e.g. i915) cannot use an iommu when this
>> feature is enabled. However, all drivers which work with swiotlb=force
>> should work.
>>
>> Bounce buffers serve as an optimization in situations where interactions
>> with the iommu are very costly. For example, virtio-iommu operations in
>> a guest on a linux host require a vmexit, involvement the VMM, and a
>> VFIO syscall. For relatively small DMA operations, memcpy can be
>> significantly faster.

Yup, back when the bounce-buffering stuff first came up I know 
networking folks were interested in terms of latency for small packets - 
virtualised IOMMUs are indeed another interesting case I hadn't thought 
of. It's definitely been on the radar as another use-case we'd like to 
accommodate with the bounce-buffering scheme. However, that's the thing: 
bouncing is bouncing and however you look at it it still overlaps so 
much with the untrusted case - there's no reason that couldn't use 
pre-mapped bounce buffers too, for instance - that the only necessary 
difference is really the policy decision of when to bounce. iommu-dma 
has already grown complicated enough, and having *three* different ways 
of doing things internally just seems bonkers and untenable. Pre-map the 
bounce buffers? Absolutely. Dynamically grow them on demand? Yes please! 
Do it all as a special thing in its own NIH module and leave the 
existing mess to rot? Sorry, but no.

Thanks,
Robin.

>> As a performance comparison, on a device with an i5-10210U, I ran fio
>> with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
>> --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
>> 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
>> spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
>> 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
>> by >99%, as bounce buffers don't require syncing here in the read case.
>> Running with multiple jobs doesn't serve as a useful performance
>> comparison because virtio-iommu and vfio_iommu_type1 both have big
>> locks that significantly limit mulithreaded DMA performance.
>>
>> This patch set is based on v5.13-rc7 plus the patches at [1].
>>
>> David Stevens (4):
>>    dma-iommu: add kalloc gfp flag to alloc helper
>>    dma-iommu: replace device arguments
>>    dma-iommu: expose a few helper functions to module
>>    dma-iommu: Add iommu bounce buffers to dma-iommu api
>>
>>   drivers/iommu/Kconfig          |  10 +
>>   drivers/iommu/Makefile         |   1 +
>>   drivers/iommu/dma-iommu.c      | 119 ++++--
>>   drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
>>   drivers/iommu/io-buffer-pool.h |  91 +++++
>>   include/linux/dma-iommu.h      |  12 +
>>   6 files changed, 861 insertions(+), 28 deletions(-)
>>   create mode 100644 drivers/iommu/io-buffer-pool.c
>>   create mode 100644 drivers/iommu/io-buffer-pool.h
>>
>> -- 
>> 2.32.0.93.g670b81a890-goog
