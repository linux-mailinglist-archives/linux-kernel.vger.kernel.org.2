Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD130D23D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBCDvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:51:10 -0500
Received: from foss.arm.com ([217.140.110.172]:33708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhBCDvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:51:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88E77ED1;
        Tue,  2 Feb 2021 19:50:14 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE703F694;
        Tue,  2 Feb 2021 19:50:10 -0800 (PST)
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
Date:   Wed, 3 Feb 2021 09:20:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 6:26 PM, David Hildenbrand wrote:
> On 02.02.21 13:51, Will Deacon wrote:
>> On Tue, Feb 02, 2021 at 01:39:29PM +0100, David Hildenbrand wrote:
>>> On 02.02.21 13:35, Will Deacon wrote:
>>>> On Tue, Feb 02, 2021 at 12:32:15PM +0000, Will Deacon wrote:
>>>>> On Tue, Feb 02, 2021 at 09:41:53AM +0530, Anshuman Khandual wrote:
>>>>>> pfn_valid() validates a pfn but basically it checks for a valid struct page
>>>>>> backing for that pfn. It should always return positive for memory ranges
>>>>>> backed with struct page mapping. But currently pfn_valid() fails for all
>>>>>> ZONE_DEVICE based memory types even though they have struct page mapping.
>>>>>>
>>>>>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>>>>>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>>>>>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>>>>>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>>>>>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>>>>>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>>>>>> into the system via memremap_pages() called from a driver, their respective
>>>>>> memory sections will not have SECTION_IS_EARLY set.
>>>>>>
>>>>>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>>>>>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>>>>>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>>>>>> skipped as its always going to be positive and that will be an optimization
>>>>>> for the normal hotplug memory. Like ZONE_DEVICE based memory, all normal
>>>>>> hotplugged memory too will not have SECTION_IS_EARLY set for their sections
>>>>>>
>>>>>> Skipping memblock_is_map_memory() for all non early memory sections would
>>>>>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>>>>>> performance for normal hotplug memory as well.
>>>>>
>>>>> Hmm. Although I follow your logic, this does seem to rely on an awful lot of
>>>>> assumptions to continue to hold true as the kernel evolves. In particular,
>>>>> how do we ensure that early sections are always fully backed with
>>>>
>>>> Sorry, typo here:       ^^^ should be *non-early* sections.
>>>
>>> It might be a good idea to have a look at generic
>>> include/linux/mmzone.h:pfn_valid()
>>
>> The generic implementation already makes assumptions that aren't true on
>> arm64, so that's why we've ended up with our own implementation. But the
>> patches here put us in a position where I worry that pfn_valid() may return
>> 'true' in future for cases where the underlying struct page is either
>> non-existent or bogus, and debugging those failures really sucks. We had a
>> raft of those back when NOMAP was introduced and I don't want to re-live
>> that experience.
> 
> Yeah, and I agree when it comes to boot mem. However, the way generic memory hotplug/memremap infrastructure (->!early sections) works does not allow for such special cases you mention and would break quite some other code if messed up. So I wouldn't worry about that part too much for now.

Agreed.

> 
>>
>>> As I expressed already, long term we should really get rid of the arm64
>>> variant and rather special-case the generic one. Then we won't go out of
>>> sync - just as it happened with ZONE_DEVICE handling here.
>>
>> Why does this have to be long term? This ZONE_DEVICE stuff could be the
>> carrot on the stick :)
> 
> Yes, I suggested to do it now, but Anshuman convinced me that doing a simple fix upfront might be cleaner --- for example when it comes to backporting :)

Right. The current pfn_valid() breaks for ZONE_DEVICE memory and this fixes
the problem in the present context which can be easily backported if required.

Changing or rather overhauling the generic code with new configs as proposed
earlier (which I am planning to work on subsequently) would definitely be an
improvement for the current pfn_valid() situation in terms of maintainability
but then it should not stop us from fixing the problem now.
