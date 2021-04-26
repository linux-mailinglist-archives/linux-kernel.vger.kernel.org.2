Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647936ABD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhDZFVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhDZFVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:21:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5D746008E;
        Mon, 26 Apr 2021 05:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619414451;
        bh=685vzft1UpPTZWzP/wT5CXw7b1mT0zK3efSf8y1p2WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6Slv6qlya+xpQVA06BiWCjMjBS8rZUtrjr7pbsxHgtXEcKOwLJZvDxsBIndbJOHD
         suxJ4+7M60Cf7bCUNYKBY5gECQOMzcRfMIDdIe90Z4nWliQCdjqlFKwOsBdK85ZilE
         3anSC2AQi13U9mf0NhVeuh0c4bgk1XfcBOL0Z9DEE853hO3ymv1luCV2piBg0DOyLi
         ml/yx1n/REGPPJcTTCLZ8EfI5XTfsEr3LIkbSj60jGy2JDzGNHhwIEe/2QeGPvWHF0
         +2nioLe6KnheTG2nIN0zGZf8qN5klKL2O2T6/GnJlPzPQ+EuMM8alUKiKoXqrasaF8
         Qpgn2sWQHxDQg==
Date:   Mon, 26 Apr 2021 08:20:43 +0300
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
Message-ID: <YIZNq5HMfJ1rWytv@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
> 
> On 2021/4/25 15:19, Mike Rapoport wrote:
> 
>     On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
> 
>         I tested this patchset(plus arm32 change, like arm64 does) based on lts
>         5.10，add
> 
>         some debug log, the useful info shows below, if we enable HOLES_IN_ZONE, no
>         panic,
> 
>         any idea, thanks.
> 
> 
>     Are there any changes on top of 5.10 except for pfn_valid() patch?
>     Do you see this panic on 5.10 without the changes?
> 
> Yes, there are some BSP support for arm board based on 5.10, with or without
> 
> your patch will get same panic, the panic pfn=de600 in the range of
> [dcc00,de00]
> 
> which is freed by free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700,
> de700000
> 
> we see the PC is at PageLRU, same reason like arm64 panic log,
> 
>    "PageBuddy in move_freepages returns false
>     Then we call PageLRU, the macro calls PF_HEAD which is compound_page()
>     compound_page reads page->compound_head, it is 0xffffffffffffffff, so it
>     resturns 0xfffffffffffffffe - and accessing this address causes crash"
> 
>     Can you see stack backtrace beyond move_freepages_block?
> 
> I do some oom test, so the log is about memory allocate,
> 
> [<c02383c8>] (move_freepages_block) from [<c0238668>]
> (steal_suitable_fallback+0x174/0x1f4)
> 
> [<c0238668>] (steal_suitable_fallback) from [<c023999c>] (get_page_from_freelist+0x490/0x9a4)

Hmm, this is called with a page from free list, having a page from a freed
part of the memory map passed to steal_suitable_fallback() means that there
is an issue with creation of the free list.

Can you please add "memblock=debug" to the kernel command line and post the
log?

> [<c023999c>] (get_page_from_freelist) from [<c023a4dc>] (__alloc_pages_nodemask+0x188/0xc08)
> [<c023a4dc>] (__alloc_pages_nodemask) from [<c0223078>] (alloc_zeroed_user_highpage_movable+0x14/0x3c)
> [<c0223078>] (alloc_zeroed_user_highpage_movable) from [<c0226768>] (handle_mm_fault+0x254/0xac8)
> [<c0226768>] (handle_mm_fault) from [<c04ba09c>] (do_page_fault+0x228/0x2f4)
> [<c04ba09c>] (do_page_fault) from [<c0111d80>] (do_DataAbort+0x48/0xd0)
> [<c0111d80>] (do_DataAbort) from [<c0100e00>] (__dabt_usr+0x40/0x60)
> 
> 
> 
>         Zone ranges:
>           Normal   [mem 0x0000000080a00000-0x00000000b01fffff]
>           HighMem  [mem 0x00000000b0200000-0x00000000ffffefff]
>         Movable zone start for each node
>         Early memory node ranges
>           node   0: [mem 0x0000000080a00000-0x00000000855fffff]
>           node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
>           node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
>           node   0: [mem 0x000000008e300000-0x000000008ecfffff]
>           node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
>           node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
>           node   0: [mem 0x00000000de700000-0x00000000de9fffff]
>           node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
>           node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
>           node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
> 
>         ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86a00, 86a00000
>         ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e300, 8e300000
>         ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
>         ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700, de700000
>         ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
>         ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
>         ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
>         === >move_freepages: start_pfn/end_pfn [de601, de7ff], [de600000, de7ff000]
>         :  pfn =de600 pfn2phy = de600000 , page = ef3cc000, page-flags = ffffffff
>         8<--- cut here ---
>         Unable to handle kernel paging request at virtual address fffffffe
>         pgd = 5dd50df5
>         [fffffffe] *pgd=affff861, *pte=00000000, *ppte=00000000
>         Internal error: Oops: 37 [#1] SMP ARM
>         Modules linked in: gmac(O)
>         CPU: 2 PID: 635 Comm: test-oom Tainted: G           O      5.10.0+ #31
>         Hardware name: Hisilicon A9
>         PC is at move_freepages_block+0x150/0x278
>         LR is at move_freepages_block+0x150/0x278
>         pc : [<c02383a4>]    lr : [<c02383a4>]    psr: 200e0393
>         sp : c4179cf8  ip : 00000000  fp : 00000001
>         r10: c4179d58  r9 : 000de7ff  r8 : 00000000
>         r7 : c0863280  r6 : 000de600  r5 : 000de600  r4 : ef3cc000
>         r3 : ffffffff  r2 : 00000000  r1 : ef5d069c  r0 : fffffffe
>         Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
>         Control: 1ac5387d  Table: 83b0c04a  DAC: 55555555
>         Process test-oom (pid: 635, stack limit = 0x25d667df)
> 
> 

-- 
Sincerely yours,
Mike.
