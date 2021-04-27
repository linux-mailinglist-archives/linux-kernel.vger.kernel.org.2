Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0636BF39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhD0GYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhD0GY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:24:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33D3E61078;
        Tue, 27 Apr 2021 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619504627;
        bh=H9mfZaoUPbytKzo1CW7LGc6AgxaokoTvu4RSbW88iuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iid/tTwf4KJufGwuAGjdYmbKELRkkNMignQ1yf3EzeeVLbZ+sPQHbsYhh/YiRgybI
         SZdf5eJS2kj7HIqs2NYixO+T7GjaRrlPBqbBJJIneOs3JheGGMvn3Zkn89xamDUBLT
         X/uKSiMzjWFAVzxp5cPlXa+iTOjDmrbLYG9pcyWUbbiHjznoqqV+am2w7kKGkzH0ZD
         xnRsf6u617oysA3/X0m0jgHee8OaJYA8FJJwAQ2I0fG8/VWNV+RSczev3nAVs2DVvX
         rqkxcbR6KmHWwGBkyFs+vKHN1YqPNpYtmYr2rktde982ADOgrlIYmg4j9tBPILeafv
         7QYFjSkYtvIlg==
Date:   Tue, 27 Apr 2021 09:23:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YIet5X7lgygD9rpZ@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:26:38PM +0800, Kefeng Wang wrote:
> 
> On 2021/4/26 13:20, Mike Rapoport wrote:
> > On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
> > > On 2021/4/25 15:19, Mike Rapoport wrote:
> > > 
> > >      On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
> > > 
> > >          I tested this patchset(plus arm32 change, like arm64 does)
> > >          based on lts 5.10，add some debug log, the useful info shows
> > >          below, if we enable HOLES_IN_ZONE, no panic, any idea,
> > >          thanks.
> > > 
> > >      Are there any changes on top of 5.10 except for pfn_valid() patch?
> > >      Do you see this panic on 5.10 without the changes?
> > > 
> > > Yes, there are some BSP support for arm board based on 5.10,

Is it possible to test 5.12?

> > > with or without your patch will get same panic, the panic pfn=de600
> > > in the range of [dcc00,de00] which is freed by free_memmap, start_pfn
> > > = dcc00,  dcc00000 end_pfn = de700, de700000
> > > 
> > > we see the PC is at PageLRU, same reason like arm64 panic log,
> > > 
> > >     "PageBuddy in move_freepages returns false
> > >      Then we call PageLRU, the macro calls PF_HEAD which is compound_page()
> > >      compound_page reads page->compound_head, it is 0xffffffffffffffff, so it
> > >      resturns 0xfffffffffffffffe - and accessing this address causes crash"
> > > 
> > >      Can you see stack backtrace beyond move_freepages_block?
> > > 
> > > I do some oom test, so the log is about memory allocate,
> > > 
> > > [<c02383c8>] (move_freepages_block) from [<c0238668>]
> > > (steal_suitable_fallback+0x174/0x1f4)
> > > 
> > > [<c0238668>] (steal_suitable_fallback) from [<c023999c>] (get_page_from_freelist+0x490/0x9a4)
> >
> > Hmm, this is called with a page from free list, having a page from a freed
> > part of the memory map passed to steal_suitable_fallback() means that there
> > is an issue with creation of the free list.
> > 
> > Can you please add "memblock=debug" to the kernel command line and post the
> > log?
> 
> Here is the log,
> 
> CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=1ac5387d
> 
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> OF: fdt: Machine model: HISI-CA9
> memblock_add: [0x80a00000-0x855fffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0x86a00000-0x87dfffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0x8bd00000-0x8c4fffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0x8e300000-0x8ecfffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0x90d00000-0xbfffffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xcc000000-0xdc9fffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xe0800000-0xe0bfffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xf5300000-0xf5bfffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xf5c00000-0xf6ffffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xfe100000-0xfebfffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xfec00000-0xffffffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xde700000-0xde9fffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xf4b00000-0xf52fffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_add: [0xfda00000-0xfe0fffff] early_init_dt_scan_memory+0x11c/0x188
> memblock_reserve: [0x80a01000-0x80a02d2e] setup_arch+0x68/0x5c4
> Malformed early option 'vecpage_wrprotect'
> Memory policy: Data cache writealloc
> memblock_reserve: [0x80b00000-0x812e8057] arm_memblock_init+0x34/0x14c
> memblock_reserve: [0x83000000-0x84ffffff] arm_memblock_init+0x100/0x14c
> memblock_reserve: [0x80a04000-0x80a07fff] arm_memblock_init+0xa0/0x14c
> memblock_reserve: [0x80a00000-0x80a02fff] hisi_mem_reserve+0x14/0x30
> MEMBLOCK configuration:
>  memory size = 0x4c0fffff reserved size = 0x027ef058
>  memory.cnt  = 0xa
>  memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
>  memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
>  memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
>  memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
>  memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
>  memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
>  memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
>  memory[0x7]    [0xe0800000-0xe0bfffff], 0x00400000 bytes flags: 0x0
>  memory[0x8]    [0xf4b00000-0xf6ffffff], 0x02500000 bytes flags: 0x0
>  memory[0x9]    [0xfda00000-0xfffffffe], 0x025fffff bytes flags: 0x0
>  reserved.cnt  = 0x4
>  reserved[0x0]    [0x80a00000-0x80a02fff], 0x00003000 bytes flags: 0x0
>  reserved[0x1]    [0x80a04000-0x80a07fff], 0x00004000 bytes flags: 0x0
>  reserved[0x2]    [0x80b00000-0x812e8057], 0x007e8058 bytes flags: 0x0
>  reserved[0x3]    [0x83000000-0x84ffffff], 0x02000000 bytes flags: 0x0
...
> Zone ranges:
>   Normal   [mem 0x0000000080a00000-0x00000000b01fffff]
>   HighMem  [mem 0x00000000b0200000-0x00000000ffffefff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000080a00000-0x00000000855fffff]
>   node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
>   node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
>   node   0: [mem 0x000000008e300000-0x000000008ecfffff]
>   node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
>   node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
>   node   0: [mem 0x00000000de700000-0x00000000de9fffff]
>   node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
>   node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
>   node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
> Zeroed struct page in unavailable ranges: 513 pages
> Initmem setup node 0 [mem 0x0000000080a00000-0x00000000ffffefff]
> On node 0 totalpages: 311551
>   Normal zone: 1230 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 157440 pages, LIFO batch:31
>   HighMem zone: 154111 pages, LIFO batch:31

AFAICT the range [de600000, de7ff000] should not be added to the free
lists.

Can you try with the below patch:

diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..7f3c33d53f87 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1994,6 +1994,8 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	unsigned long end_pfn = min_t(unsigned long,
 				      PFN_DOWN(end), max_low_pfn);
 
+	pr_info("%s: range: %pa - %pa, pfn: %lx - %lx\n", __func__, &start, &end, start_pfn, end_pfn);
+
 	if (start_pfn >= end_pfn)
 		return 0;
 
 
> > > [<c023999c>] (get_page_from_freelist) from [<c023a4dc>] (__alloc_pages_nodemask+0x188/0xc08)
> > > [<c023a4dc>] (__alloc_pages_nodemask) from [<c0223078>] (alloc_zeroed_user_highpage_movable+0x14/0x3c)
> > > [<c0223078>] (alloc_zeroed_user_highpage_movable) from [<c0226768>] (handle_mm_fault+0x254/0xac8)
> > > [<c0226768>] (handle_mm_fault) from [<c04ba09c>] (do_page_fault+0x228/0x2f4)
> > > [<c04ba09c>] (do_page_fault) from [<c0111d80>] (do_DataAbort+0x48/0xd0)
> > > [<c0111d80>] (do_DataAbort) from [<c0100e00>] (__dabt_usr+0x40/0x60)
> > > 
> > >          Zone ranges:
> > >            Normal   [mem 0x0000000080a00000-0x00000000b01fffff]
> > >            HighMem  [mem 0x00000000b0200000-0x00000000ffffefff]
> > >          Movable zone start for each node
> > >          Early memory node ranges
> > >            node   0: [mem 0x0000000080a00000-0x00000000855fffff]
> > >            node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
> > >            node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
> > >            node   0: [mem 0x000000008e300000-0x000000008ecfffff]
> > >            node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
> > >            node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
> > >            node   0: [mem 0x00000000de700000-0x00000000de9fffff]
> > >            node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
> > >            node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
> > >            node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
> > > 
> > >          ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86a00, 86a00000
> > >          ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e300, 8e300000
> > >          ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
> > >          ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700, de700000
> > >          ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
> > >          ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
> > >          ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
> > >          === >move_freepages: start_pfn/end_pfn [de601, de7ff], [de600000, de7ff000]
> > >          :  pfn =de600 pfn2phy = de600000 , page = ef3cc000, page-flags = ffffffff
> > >          8<--- cut here ---
> > >          Unable to handle kernel paging request at virtual address fffffffe
> > >          pgd = 5dd50df5
> > >          [fffffffe] *pgd=affff861, *pte=00000000, *ppte=00000000
> > >          Internal error: Oops: 37 [#1] SMP ARM
> > >          Modules linked in: gmac(O)
> > >          CPU: 2 PID: 635 Comm: test-oom Tainted: G           O      5.10.0+ #31
> > >          Hardware name: Hisilicon A9
> > >          PC is at move_freepages_block+0x150/0x278
> > >          LR is at move_freepages_block+0x150/0x278
> > >          pc : [<c02383a4>]    lr : [<c02383a4>]    psr: 200e0393
> > >          sp : c4179cf8  ip : 00000000  fp : 00000001
> > >          r10: c4179d58  r9 : 000de7ff  r8 : 00000000
> > >          r7 : c0863280  r6 : 000de600  r5 : 000de600  r4 : ef3cc000
> > >          r3 : ffffffff  r2 : 00000000  r1 : ef5d069c  r0 : fffffffe
> > >          Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > >          Control: 1ac5387d  Table: 83b0c04a  DAC: 55555555
> > >          Process test-oom (pid: 635, stack limit = 0x25d667df)
> > > 
> > > 

-- 
Sincerely yours,
Mike.
