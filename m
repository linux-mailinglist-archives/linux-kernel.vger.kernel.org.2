Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06D36834E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhDVP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:29:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16151 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhDVP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:29:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FR1T26DV9zpZmV;
        Thu, 22 Apr 2021 23:25:26 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 23:28:24 +0800
Subject: Re: [PATCH v2 0/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Will Deacon" <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
Date:   Thu, 22 Apr 2021 23:28:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YIEl8aKr8Ly0Zd3O@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/22 15:29, Mike Rapoport wrote:
> On Thu, Apr 22, 2021 at 03:00:20PM +0800, Kefeng Wang wrote:
>> On 2021/4/21 14:51, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Hi,
>>>
>>> These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
>>> pfn_valid_within() to 1.
>>>
>>> The idea is to mark NOMAP pages as reserved in the memory map and restore
>>> the intended semantics of pfn_valid() to designate availability of struct
>>> page for a pfn.
>>>
>>> With this the core mm will be able to cope with the fact that it cannot use
>>> NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
>>> will be treated correctly even without the need for pfn_valid_within.
>>>
>>> The patches are only boot tested on qemu-system-aarch64 so I'd really
>>> appreciate memory stress tests on real hardware.
>>>
>>> If this actually works we'll be one step closer to drop custom pfn_valid()
>>> on arm64 altogether.
>> Hi Mike，I have a question, without HOLES_IN_ZONE, the pfn_valid_within() in
>> move_freepages_block()->move_freepages()
>> will be optimized, if there are holes in zone, the 'struce page'(memory map)
>> for pfn range of hole will be free by
>> free_memmap(), and then the page traverse in the zone(with holes) from
>> move_freepages() will meet the wrong page，
>> then it could panic at PageLRU(page) test, check link[1],
> First, HOLES_IN_ZONE name us hugely misleading, this configuration option
> has nothing to to with memory holes, but rather it is there to deal with
> holes or undefined struct pages in the memory map, when these holes can be
> inside a MAX_ORDER_NR_PAGES region.
>
> In general pfn walkers use pfn_valid() and pfn_valid_within() to avoid
> accessing *missing* struct pages, like those that are freed at
> free_memmap(). But on arm64 these tests also filter out the nomap entries
> because their struct pages are not initialized.
>
> The panic you refer to happened because there was an uninitialized struct
> page in the middle of MAX_ORDER_NR_PAGES region because it corresponded to
> nomap memory.
>
> With these changes I make sure that such pages will be properly initialized
> as PageReserved and the pfn walkers will be able to rely on the memory map.
>
> Note also, that free_memmap() aligns the parts being freed on MAX_ORDER
> boundaries, so there will be no missing parts in the memory map within a
> MAX_ORDER_NR_PAGES region.

Ok, thanks, we met a same panic like the link on arm32(without 
HOLES_IN_ZONE),

the scheme for arm64 could be suit for arm32, right?  I will try the 
patchset with

some changes on arm32 and give some feedback.

Again, the stupid question, where will mark the region of memblock with

MEMBLOCK_NOMAP flag ?


>   
>> "The idea is to mark NOMAP pages as reserved in the memory map", I see the
>> patch2 check memblock_is_nomap() in memory region
>> of memblock, but it seems that memblock_mark_nomap() is not called(maybe I
>> missed), then memmap_init_reserved_pages() won't
>> work, so should the HOLES_IN_ZONE still be needed for generic mm code?
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/541193a6-2bce-f042-5bb2-88913d5f1047@arm.com/
>>
