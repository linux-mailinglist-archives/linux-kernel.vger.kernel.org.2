Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8778B3763C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhEGKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234674AbhEGKbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17B75613F0;
        Fri,  7 May 2021 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620383443;
        bh=xO2yiNtWQ2O7eOAXqEu52tCA2HTisM05D8ogUeVRGIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3wci5mv4Gs6EyRYz2OZSjpzVQI/OLGQ7wJFnSwJzXhSaAZezyd872uqmd8eixDl2
         rFFe4IKS7TI1CU69Ujl5e9Qak2z6h7yGx0BJacxyzPTLMnHFOeTfrCTAQvPgGxOZ/3
         2MtQGiRFNnfqAjpay08cGhYotePU1XN36qEKlKPqQiNZgDVPcYRIJ4wOJDDZ8SjD0V
         QMcmkJr6dqXSPBgebph8z/PdGUnNKfZLKvG7sVr944ubJVoyhTk2YEQxv5vRYHKsAo
         75YjeuioJyCebAUNHpVf0f6O6/x/FqVOx5f1rf+PIOFaZadL9MsZadfp0YvXsJPFf3
         0t9HnWVV6NieA==
Date:   Fri, 7 May 2021 13:30:35 +0300
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
Message-ID: <YJUWywpGwOpM8hzo@kernel.org>
References: <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
 <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
 <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
 <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
 <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 03:17:08PM +0800, Kefeng Wang wrote:
> 
> On 2021/5/6 20:47, Kefeng Wang wrote:
> > 
> > 
> > > > > > no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
> > > > > > move_freepages at
> > > > > > 
> > > > > > start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000]
> > > > > > :  pfn =de600, page
> > > > > > =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
> > > > > > 
> > > > > > > > __free_memory_core, range: 0xb0200000 -
> > > > > > > > 0xc0000000, pfn: b0200 - b0200
> > > > > > > > __free_memory_core, range: 0xcc000000 -
> > > > > > > > 0xdca00000, pfn: cc000 - b0200
> > > > > > > > __free_memory_core, range: 0xde700000 -
> > > > > > > > 0xdea00000, pfn: de700 - b0200
> > > > > 
> > > > > Hmm, [de600, de7ff] is not added to the free lists which is
> > > > > correct. But
> > > > > then it's unclear how the page for de600 gets to move_freepages()...
> > > > > 
> > > > > Can't say I have any bright ideas to try here...
> > > > 
> > > > Are we missing some checks (e.g., PageReserved()) that
> > > > pfn_valid_within()
> > > > would have "caught" before?
> > > 
> > > Unless I'm missing something the crash happens in __rmqueue_fallback():
> > > 
> > > do_steal:
> > >     page = get_page_from_free_area(area, fallback_mt);
> > > 
> > >     steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
> > >                                 can_steal);
> > >         -> move_freepages()
> > >             -> BUG()
> > > 
> > > So a page from free area should be sane as the freed range was never
> > > added
> > > it to the free lists.
> > 
> > Sorry for the late response due to the vacation.
> > 
> > The pfn in range [de600, de7ff] won't be added into the free lists via
> > __free_memory_core(), but the pfn could be added into freelists via
> > free_highmem_page()
> > 
> > I add some debug[1] in add_to_free_list(), we could see the calltrace
> > 
> > free_highpages, range_pfn [b0200, c0000], range_addr [b0200000, c0000000]
> > free_highpages, range_pfn [cc000, dca00], range_addr [cc000000, dca00000]
> > free_highpages, range_pfn [de700, dea00], range_addr [de700000, dea00000]
> > add_to_free_list, ===> pfn = de700
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:900 add_to_free_list+0x8c/0xec
> > pfn = de700
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #48
> > Hardware name: Hisilicon A9
> > [<c010a600>] (show_stack) from [<c04b21c4>] (dump_stack+0x9c/0xc0)
> > [<c04b21c4>] (dump_stack) from [<c011c708>] (__warn+0xc0/0xec)
> > [<c011c708>] (__warn) from [<c011c7a8>] (warn_slowpath_fmt+0x74/0xa4)
> > [<c011c7a8>] (warn_slowpath_fmt) from [<c023721c>]
> > (add_to_free_list+0x8c/0xec)
> > [<c023721c>] (add_to_free_list) from [<c0237e00>]
> > (free_pcppages_bulk+0x200/0x278)
> > [<c0237e00>] (free_pcppages_bulk) from [<c0238d14>]
> > (free_unref_page+0x58/0x68)
> > [<c0238d14>] (free_unref_page) from [<c023bb54>]
> > (free_highmem_page+0xc/0x50)
> > [<c023bb54>] (free_highmem_page) from [<c070620c>] (mem_init+0x21c/0x254)
> > [<c070620c>] (mem_init) from [<c0700b38>] (start_kernel+0x258/0x5c0)
> > [<c0700b38>] (start_kernel) from [<00000000>] (0x0)
> > 
> > so any idea?
> 
> If pfn = 0xde700, due to the pageblock_nr_pages = 0x200, then the
> start_pfn,end_pfn passed to move_freepages() will be [de600, de7ff],
> but the range of [de600,de700] without ‘struct page' will lead to
> this panic when pfn_valid_within not enabled if no HOLES_IN_ZONE,
> and the same issue will occurred in isolate_freepages_block(), maybe

I think your analysis is correct except one minor detail. With the #ifdef
fix I've proposed earlieri [1] the memmap for [0xde600, 0xde700] should not
be freed so there should be a struct page. Did you check what parts of the
memmap are actually freed with this patch applied?
Would you get a panic if you add

	dump_page(pfn_to_page(0xde600), "");

say, in the end of memblock_free_all()?

> there are some scene, so I select HOLES_IN_ZONE in ARCH_HISI(ARM) to solve
> this issue in our 5.10, should we select HOLES_IN_ZONE in all ARM or only in
> ARCH_HISI, any better solution?  Thanks.

I don't think that HOLES_IN_ZONE is the right solution. I believe that we
must keep the memory map aligned on pageblock boundaries. That's surely not the
case for SPARSEMEM as of now, and if my fix is not enough we need to find
where it went wrong.

Besides, I'd say that if it is possible to update your firmware to make the
memory layout reported to the kernel less, hmm, esoteric, you would hit
less corner cases.

[1] https://lore.kernel.org/lkml/YIpY8TXCSc7Lfa2Z@kernel.org

-- 
Sincerely yours,
Mike.
