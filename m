Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66742DF04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJNQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:19:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhJNQTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:19:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A378B11D4;
        Thu, 14 Oct 2021 09:17:27 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AA8A3F66F;
        Thu, 14 Oct 2021 09:17:26 -0700 (PDT)
Subject: Re: [RFC] iommu: Use put_pages_list
To:     John Garry <john.garry@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210930162043.3111119-1-willy@infradead.org>
 <YV85dvlyj5LBdsro@casper.infradead.org>
 <YWgShKtp+89f1a/J@casper.infradead.org>
 <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <93425cf4-3027-940f-3bee-29c4ee61105f@arm.com>
Date:   Thu, 14 Oct 2021 17:17:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-14 12:52, John Garry wrote:
> On 14/10/2021 12:20, Matthew Wilcox wrote:
>> I'm going to keep pinging this patch weekly.
>>
>> On Thu, Oct 07, 2021 at 07:17:02PM +0100, Matthew Wilcox wrote:
>>> ping?
> 
> Robin, Were you checking this? You mentioned "I got
> side-tracked trying to make io-pgtable use that freelist properly" in 
> another thread, which seems related.

Ooh, thanks for the heads-up John - I'm still only just starting to 
catch up on my mailing list folders since I got back off holiday.

Indeed I already started untangling the freelist handling in the flush 
queue code (to make the move into iommu-dma smaller). Once I'd figured 
out how it worked I did wonder whether there was any more "standard" 
field to borrow, since page->freelist did seem very much in the 
minority. If page->lru is it then great! From a quick skim of the patch 
I think I'd only have a few trivial review comments to make - certainly 
no objection to the fundamental change itself (indeed I hit a point in 
io-pgtable-arm where adding to the pointer chain got rather awkward, so 
having proper lists to splice would be lovely).

Matthew - is this something getting in the way of mm development, or 
just a nice cleanup? I'd be happy either to pursue merging it on its 
own, or to pick it up and work it into a series with my stuff.

Cheers,
Robin.

> 
> Thanks,
> John
> 
>>>
>>> On Thu, Sep 30, 2021 at 05:20:42PM +0100, Matthew Wilcox (Oracle) wrote:
>>>> page->freelist is for the use of slab.  We already have the ability
>>>> to free a list of pages in the core mm, but it requires the use of a
>>>> list_head and for the pages to be chained together through page->lru.
>>>> Switch the iommu code over to using free_pages_list().
>>>>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> ---
>>>>   drivers/iommu/amd/io_pgtable.c | 99 
>>>> +++++++++++++++-------------------
>>>>   drivers/iommu/dma-iommu.c      | 11 +---
>>>>   drivers/iommu/intel/iommu.c    | 89 +++++++++++-------------------
>>>>   include/linux/iommu.h          |  3 +-
>>>>   4 files changed, 77 insertions(+), 125 deletions(-)
>>>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
