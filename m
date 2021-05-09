Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6E3775A7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 07:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhEIGAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 02:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhEIGAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 02:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CEF561364;
        Sun,  9 May 2021 05:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620539978;
        bh=F9gqyGBpHvA5BP4VIejNuaHDQi9t//ZqzxoUtXHZIBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pg6c3El7f8wTosM1GHBA2Kmlc0+0eBs2evwd1DCes38mEsljDvr4GOET2y7BDPi0c
         L2AUKUVe8Iy2L5FFC5mrYAfumqdKP09p+LYX8GA0QrfcCG6SN2NVPnHW4FkETfwzXX
         OR3Qp/nyQ4g733GxrKLB8kyAuq5GPxWaiUDePC9D/O/kDMRLzPNqsWZtMU2Cqwn5Rw
         2nTiBom6NZz7a/ETXo2sLS0lKFixn2K8Mu4aN96x7VubtFTIeTEtPnADkFRASjesAp
         7t6tPQykwNdJNYoLm8iRRHsRPnasprnsnSIhY4MIIv9DRs0McBHwIOWYK7WzOwZccl
         FvFfB99NMgyig==
Date:   Sun, 9 May 2021 08:59:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YJd6QXcmVl+HM4Ob@kernel.org>
References: <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
 <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
 <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
 <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
 <YJUWywpGwOpM8hzo@kernel.org>
 <33c67e13-dc48-9a2f-46d8-a532e17380fb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33c67e13-dc48-9a2f-46d8-a532e17380fb@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 08:34:52PM +0800, Kefeng Wang wrote:
> 
> 
> On 2021/5/7 18:30, Mike Rapoport wrote:
> > On Fri, May 07, 2021 at 03:17:08PM +0800, Kefeng Wang wrote:
> > > 
> > > On 2021/5/6 20:47, Kefeng Wang wrote:
> > > > 
> > > > > > > > no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
> > > > > > > > move_freepages at
> > > > > > > > 
> > > > > > > > start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000]
> > > > > > > > :  pfn =de600, page
> > > > > > > > =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
> > > > > > > > 
> > > > > > > > > > __free_memory_core, range: 0xb0200000 -
> > > > > > > > > > 0xc0000000, pfn: b0200 - b0200
> > > > > > > > > > __free_memory_core, range: 0xcc000000 -
> > > > > > > > > > 0xdca00000, pfn: cc000 - b0200
> > > > > > > > > > __free_memory_core, range: 0xde700000 -
> > > > > > > > > > 0xdea00000, pfn: de700 - b0200
> > > > > > > 
> > > > > > > Hmm, [de600, de7ff] is not added to the free lists which is
> > > > > > > correct. But
> > > > > > > then it's unclear how the page for de600 gets to move_freepages()...
> > > > > > > 
> > > > > > > Can't say I have any bright ideas to try here...
> > > > > > 
> > > > > > Are we missing some checks (e.g., PageReserved()) that
> > > > > > pfn_valid_within()
> > > > > > would have "caught" before?
> > > > > 
> > > > > Unless I'm missing something the crash happens in __rmqueue_fallback():
> > > > > 
> > > > > do_steal:
> > > > >      page = get_page_from_free_area(area, fallback_mt);
> > > > > 
> > > > >      steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
> > > > >                                  can_steal);
> > > > >          -> move_freepages()
> > > > >              -> BUG()
> > > > > 
> > > > > So a page from free area should be sane as the freed range was never
> > > > > added
> > > > > it to the free lists.
> > > > 
> > > > Sorry for the late response due to the vacation.
> > > > 
> > > > The pfn in range [de600, de7ff] won't be added into the free lists via
> > > > __free_memory_core(), but the pfn could be added into freelists via
> > > > free_highmem_page()
> > > > 
> > > > I add some debug[1] in add_to_free_list(), we could see the calltrace
> > > > 
> > > > free_highpages, range_pfn [b0200, c0000], range_addr [b0200000, c0000000]
> > > > free_highpages, range_pfn [cc000, dca00], range_addr [cc000000, dca00000]
> > > > free_highpages, range_pfn [de700, dea00], range_addr [de700000, dea00000]
> > > > add_to_free_list, ===> pfn = de700
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:900 add_to_free_list+0x8c/0xec
> > > > pfn = de700
> > > > Modules linked in:
> > > > CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #48
> > > > Hardware name: Hisilicon A9
> > > > [<c010a600>] (show_stack) from [<c04b21c4>] (dump_stack+0x9c/0xc0)
> > > > [<c04b21c4>] (dump_stack) from [<c011c708>] (__warn+0xc0/0xec)
> > > > [<c011c708>] (__warn) from [<c011c7a8>] (warn_slowpath_fmt+0x74/0xa4)
> > > > [<c011c7a8>] (warn_slowpath_fmt) from [<c023721c>]
> > > > (add_to_free_list+0x8c/0xec)
> > > > [<c023721c>] (add_to_free_list) from [<c0237e00>]
> > > > (free_pcppages_bulk+0x200/0x278)
> > > > [<c0237e00>] (free_pcppages_bulk) from [<c0238d14>]
> > > > (free_unref_page+0x58/0x68)
> > > > [<c0238d14>] (free_unref_page) from [<c023bb54>]
> > > > (free_highmem_page+0xc/0x50)
> > > > [<c023bb54>] (free_highmem_page) from [<c070620c>] (mem_init+0x21c/0x254)
> > > > [<c070620c>] (mem_init) from [<c0700b38>] (start_kernel+0x258/0x5c0)
> > > > [<c0700b38>] (start_kernel) from [<00000000>] (0x0)
> > > > 
> > > > so any idea?
> > > 
> > > If pfn = 0xde700, due to the pageblock_nr_pages = 0x200, then the
> > > start_pfn,end_pfn passed to move_freepages() will be [de600, de7ff],
> > > but the range of [de600,de700] without ‘struct page' will lead to
> > > this panic when pfn_valid_within not enabled if no HOLES_IN_ZONE,
> > > and the same issue will occurred in isolate_freepages_block(), maybe
> > 
> > I think your analysis is correct except one minor detail. With the #ifdef
> > fix I've proposed earlieri [1] the memmap for [0xde600, 0xde700] should not
> > be freed so there should be a struct page. Did you check what parts of the
> > memmap are actually freed with this patch applied?
> > Would you get a panic if you add
> > 
> > 	dump_page(pfn_to_page(0xde600), "");
> > 
> > say, in the end of memblock_free_all()?
> 
> The memory is not continuous, see MEMBLOCK:
>  memory size = 0x4c0fffff reserved size = 0x027ef058
>  memory.cnt  = 0xa
>  memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
>  memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
>  memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
>  memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
>  memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
>  memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
>  memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
> ...
> 
> The pfn_range [0xde600,0xde700] => addr_range [0xde600000,0xde700000]
> is not available memory, and we won't create memmap , so with or without
> your patch, we can't see the range in free_memmap(), right?
 

This is not available memory and we won't see the reange in free_memmap(),
but we still should create memmap for it and that's what my patch tried to
do.

There are a lot of places in core mm that operate on pageblocks and
free_unused_memmap() should make sure that any pageblock has a valid memory
map.

Currently, that's not the case when SPARSEMEM=y and my patch tried to fix
it.

Can you please send log with my patch applied and with the printing of
ranges that are freed in free_unused_memmap() you've used in previous
mails?
 
> > > there are some scene, so I select HOLES_IN_ZONE in ARCH_HISI(ARM) to solve
> > > this issue in our 5.10, should we select HOLES_IN_ZONE in all ARM or only in
> > > ARCH_HISI, any better solution?  Thanks.
> > 
> > I don't think that HOLES_IN_ZONE is the right solution. I believe that we
> > must keep the memory map aligned on pageblock boundaries. That's surely not the
> > case for SPARSEMEM as of now, and if my fix is not enough we need to find
> > where it went wrong.
> > 
> > Besides, I'd say that if it is possible to update your firmware to make the
> > memory layout reported to the kernel less, hmm, esoteric, you would hit
> > less corner cases.
> 
> Sorry, memory layout is customized and we can't change it, some memory is
> for special purposes by our production.
 
I understand that this memory cannot be used by Linux, but the firmware may
supply the kernel with actual physical memory layout and then mark all
the special purpose memory that kernel should not touch as reserved.

> > [1] https://lore.kernel.org/lkml/YIpY8TXCSc7Lfa2Z@kernel.org
> > 

-- 
Sincerely yours,
Mike.
