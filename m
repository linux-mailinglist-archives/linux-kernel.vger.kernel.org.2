Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B6445CC23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350588AbhKXSgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:36:37 -0500
Received: from foss.arm.com ([217.140.110.172]:41936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242504AbhKXSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:36:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DDB1FB;
        Wed, 24 Nov 2021 10:33:21 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79AE13F66F;
        Wed, 24 Nov 2021 10:33:20 -0800 (PST)
Message-ID: <4bce6339-095f-a7cb-fb7c-436b8ece9588@arm.com>
Date:   Wed, 24 Nov 2021 18:33:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/9] iommu: Refactor flush queues into iommu-dma
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1637671820.git.robin.murphy@arm.com>
 <7f7daf42-8aff-b9ed-0f48-d4158896012e@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7f7daf42-8aff-b9ed-0f48-d4158896012e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-24 17:21, John Garry wrote:
> On 23/11/2021 14:10, Robin Murphy wrote:
>> As promised, this series cleans up the flush queue code and streamlines
>> it directly into iommu-dma. Since we no longer have per-driver DMA ops
>> implementations, a lot of the abstraction is now no longer necessary, so
>> there's a nice degree of simplification in the process. Un-abstracting
>> the queued page freeing mechanism is also the perfect opportunity to
>> revise which struct page fields we use so we can be better-behaved
>> from the MM point of view, thanks to Matthew.
>>
>> These changes should also make it viable to start using the gather
>> freelist in io-pgtable-arm, and eliminate some more synchronous
>> invalidations from the normal flow there, but that is proving to need a
>> bit more careful thought than I have time for in this cycle, so I've
>> parked that again for now and will revisit it in the new year.
>>
>> For convenience, branch at:
>>    https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/iova
>>
>> I've build-tested for x86_64, and boot-tested arm64 to the point of
>> confirming that put_pages_list() gets passed a valid empty list when
>> flushing, while everything else still works.
> My interest is in patches 2, 3, 7, 8, 9, and they look ok. I did a bit 
> of testing for strict and non-strict mode on my arm64 system and no 
> problems.
> 
> Apart from this, I noticed that one possible optimization could be to 
> avoid so many reads of fq_flush_finish_cnt, as we seem to have a pattern 
> of fq_flush_iotlb()->atomic64_inc(fq_flush_finish_cnt) followed by a 
> read of fq_flush_finish_cnt in fq_ring_free(), so we could use 
> atomic64_inc_return(fq_flush_finish_cnt) and reuse the value. I think 
> that any racing in fq_flush_finish_cnt accesses are latent, but maybe 
> there is a flaw in this. However I tried something along these lines and 
> got a 2.4% throughput gain for my storage scenario.

Yes, that sounds reasonable - off-hand I can't see that there's any more 
potential for harmful races either. All that jumps out is the case where 
the flush count gets bumped via queue_iova() while another CPU is 
already running fq_flush_timeout(), where freeing newer IOVAs added 
since the timeout is then more likely to be left to the local CPU, or 
postponed until the next flush cycle entirely, rather than being piled 
on to the guy already processing the for_each_possible_cpu() loop. And I 
can't help thinking that could only be a *good* thing, given how the FQ 
timeout seems to be a smoking gun in your "performance never recovers 
after falling off the cliff" scenario :)

Robin.
