Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74D63479B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhCXNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:35:56 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56450 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhCXNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:35:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D27823F306;
        Wed, 24 Mar 2021 14:35:43 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="jLDwV+Er";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JCCawRD9HjzC; Wed, 24 Mar 2021 14:35:42 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5BC633F240;
        Wed, 24 Mar 2021 14:35:41 +0100 (CET)
Received: from [10.249.254.166] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 1094F3605CC;
        Wed, 24 Mar 2021 14:35:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616592940; bh=xXXPaXg/ez/sdT5QhHcHgxfrUBmPliIL2wIReLDhQjg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jLDwV+ErQCFc9TDEXXtEKVz3UmVZeq8QhPHnWwi1TirvzsnfI9q3YDlRhzlQo9Jdb
         rk12O2Ix72T/YIQT+f5qDz1zPAUTO3Clcf4MPsp8s7O6hWzwRbI+Kta7xrDj1SWjL8
         yytllN4Da6Ny67AVboYIif4JsFGznBS98kkmWoeY=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local> <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
Date:   Wed, 24 Mar 2021 14:35:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324124127.GY2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/21 1:41 PM, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 01:35:17PM +0100, Thomas Hellström (Intel) wrote:
>> On 3/24/21 1:24 PM, Jason Gunthorpe wrote:
>>> On Wed, Mar 24, 2021 at 10:56:43AM +0100, Daniel Vetter wrote:
>>>> On Tue, Mar 23, 2021 at 06:06:53PM +0100, Thomas Hellström (Intel) wrote:
>>>>> On 3/23/21 5:37 PM, Jason Gunthorpe wrote:
>>>>>> On Tue, Mar 23, 2021 at 05:34:51PM +0100, Thomas Hellström (Intel) wrote:
>>>>>>
>>>>>>>>> @@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
>>>>>>>>>      	if ((pfn & (fault_page_size - 1)) != 0)
>>>>>>>>>      		goto out_fallback;
>>>>>>>>> +	/*
>>>>>>>>> +	 * Huge entries must be special, that is marking them as devmap
>>>>>>>>> +	 * with no backing device map range. If there is a backing
>>>>>>>>> +	 * range, Don't insert a huge entry.
>>>>>>>>> +	 * If this check turns out to be too much of a performance hit,
>>>>>>>>> +	 * we can instead have drivers indicate whether they may have
>>>>>>>>> +	 * backing device map ranges and if not, skip this lookup.
>>>>>>>>> +	 */
>>>>>>>> I think we can do this statically:
>>>>>>>> - if it's system memory we know there's no devmap for it, and we do the
>>>>>>>>       trick to block gup_fast
>>>>>>> Yes, that should work.
>>>>>>>> - if it's iomem, we know gup_fast wont work anyway if don't set PFN_DEV,
>>>>>>>>       so might as well not do that
>>>>>>> I think gup_fast will unfortunately mistake a huge iomem page for an
>>>>>>> ordinary page and try to access a non-existant struct page for it, unless we
>>>>>>> do the devmap trick.
>>>>>>>
>>>>>>> And the lookup would then be for the rare case where a driver would have
>>>>>>> already registered a dev_pagemap for an iomem area which may also be mapped
>>>>>>> through TTM (like the patch from Felix a couple of weeks ago). If a driver
>>>>>>> can promise not to do that, then we can safely remove the lookup.
>>>>>> Isn't the devmap PTE flag arch optional? Does this fall back to not
>>>>>> using huge pages on arches that don't support it?
>>>>> Good point. No, currently it's only conditioned on transhuge page support.
>>>>> Need to condition it on also devmap support.
>>>>>
>>>>>> Also, I feel like this code to install "pte_special" huge pages does
>>>>>> not belong in the drm subsystem..
>>>>> I could add helpers in huge_memory.c:
>>>>>
>>>>> vmf_insert_pfn_pmd_prot_special() and
>>>>> vmf_insert_pfn_pud_prot_special()
>>>> The somewhat annoying thing is that we'd need an error code so we fall
>>>> back to pte fault handling. That's at least my understanding of how
>>>> pud/pmd fault handling works. Not sure how awkward that is going to be
>>>> with the overall fault handling flow.
>>>>
>>>> But aside from that I think this makes tons of sense.
>>> Why should the driver be so specific?
>>>
>>> vmf_insert_pfn_range_XXX()
>>>
>>> And it will figure out the optimal way to build the page tables.
>>>
>>> Driver should provide the largest physically contiguous range it can
>> I figure that would probably work, but since the huge_fault() interface is
>> already providing the size of the fault based on how the pagetable is
>> currently populated I figure that would have to move a lot of that logic
>> into that helper...
> But we don't really care about the size of the fault when we stuff the
> pfns.
>
> The device might use it when handling the fault, but once the fault is
> handled the device knows what the contiguous pfn range is that it has
> available to stuff into the page tables, it just tells the vmf_insert
> what it was able to create, and it creates the necessary page table
> structure.
>
> The size of the hole in the page table is really only advisory, the
> device may not want to make a 2M or 1G page entry and may prefer to
> only create 4k.
>
> In an ideal world the creation/destruction of page table levels would
> by dynamic at this point, like THP.

Hmm, but I'm not sure what problem we're trying to solve by changing the 
interface in this way?

Currently if the core vm requests a huge pud, we give it one, and if we 
can't or don't want to (because of dirty-tracking, for example, which is 
always done on 4K page-level) we just return VM_FAULT_FALLBACK, and the 
fault is retried at a lower level. Also, determining whether we have a 
contigous range is not free, so we  don't want to do that unnecessarily.

/Thomas


