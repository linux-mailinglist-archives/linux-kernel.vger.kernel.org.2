Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2954211F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhJDOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:50:56 -0400
Received: from foss.arm.com ([217.140.110.172]:45680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235150AbhJDOun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:50:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8DDD6E;
        Mon,  4 Oct 2021 07:48:54 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F33813F70D;
        Mon,  4 Oct 2021 07:48:52 -0700 (PDT)
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
To:     Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <20211004114418.GC27373@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <87b782d7-339a-fcd0-8fae-659e2d9da078@arm.com>
Date:   Mon, 4 Oct 2021 15:48:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211004114418.GC27373@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-04 12:44, Will Deacon wrote:
> On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
>> The IOVA domain structure is a bit overloaded, holding:
>> - IOVA tree management
>> - FQ control
>> - IOVA rcache memories
>>
>> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
>> uses the FQ feature.
>>
>> This series separates out that structure. In addition, it moves the FQ
>> code into dma-iommu.c . This is not strictly necessary, but it does make
>> it easier for the FQ domain lookup the rcache domain.
>>
>> The rcache code stays where it is, as it may be reworked in future, so
>> there is not much point in relocating and then discarding.
>>
>> This topic was initially discussed and suggested (I think) by Robin here:
>> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/
> 
> It would be useful to have Robin's Ack on patches 2-4. The implementation
> looks straightforward to me, but the thread above isn't very clear about
> what is being suggested.

FWIW I actually got about half-way through writing my own equivalent of 
patches 2-3, except tackling it from the other direction - simplifying 
the FQ code *before* moving whatever was left to iommu-dma, then I got 
side-tracked trying to make io-pgtable use that freelist properly, and 
then I've been on holiday the last 2 weeks. I've got other things to 
catch up on first but I'll try to get to this later this week.

> To play devil's advocate: there aren't many direct users of the iovad code:
> either they'll die out entirely (and everybody will use the dma-iommu code)
> and it's fine having the flush queue code where it is, or we'll get more
> users and the likelihood of somebody else wanting flush queues increases.

I think the FQ code is mostly just here as a historical artefact, since 
the IOVA allocator was the only thing common to the Intel and AMD DMA 
ops when the common FQ implementation was factored out of those, so 
although it's essentially orthogonal it was still related enough that it 
was an easy place to stick it.

Cheers,
Robin.
