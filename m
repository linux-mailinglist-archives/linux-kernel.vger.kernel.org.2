Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9037B7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhELI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhELI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:27:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 511E561184;
        Wed, 12 May 2021 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620808006;
        bh=ANUm1s3nzk4a972P1R3SVq9VKMMi4T5091M36nOjwpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CV6Skh+PVxSoJ4SHxCfTr5/1oXG44TT4I8yK2ZypMmgLvjle7NcpX1caXh1QWPOte
         lqk+B44KHsxBKxv573ZGGfrFa+PFmRC++OMzYSx/BY6k6YdW3VQ9oM7vwuszIrlfJ7
         FURbTxh1LTY7+cqPROSAQphejNFZQbDQqdi/PB2rV3U3960aWmMT2iYxwPuRy0YjnL
         7/MtyiMtZ7Gzl2tmLys+t5+ON4OuNNE7O1QOgKVsNx4500Qyrmjqyy96elqOj1bD+Y
         d9TvKrv+jJ8c4QoTGvpSKXVl8XGkztgmWU29gXKw0J7BMGf0z0DFitOUrhCN1zw9l9
         l1P89aDpbbaMQ==
Date:   Wed, 12 May 2021 11:26:37 +0300
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
Message-ID: <YJuRPVWubjQKyKBj@kernel.org>
References: <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
 <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
 <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
 <YJUWywpGwOpM8hzo@kernel.org>
 <33c67e13-dc48-9a2f-46d8-a532e17380fb@huawei.com>
 <YJd6QXcmVl+HM4Ob@kernel.org>
 <b91cd653-842b-0e77-5c00-17a0ac9c4b50@huawei.com>
 <YJpEwF2cGjS5mKma@kernel.org>
 <c3006cd0-fff6-ab45-da83-a216d40388f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3006cd0-fff6-ab45-da83-a216d40388f2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:08:14AM +0800, Kefeng Wang wrote:
> 
> On 2021/5/11 16:48, Mike Rapoport wrote:
> > On Mon, May 10, 2021 at 11:10:20AM +0800, Kefeng Wang wrote:
> > > 
> > > > > The memory is not continuous, see MEMBLOCK:
> > > > >    memory size = 0x4c0fffff reserved size = 0x027ef058
> > > > >    memory.cnt  = 0xa
> > > > >    memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
> > > > >    memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
> > > > >    memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
> > > > >    memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
> > > > >    memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
> > > > >    memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
> > > > >    memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
> > > > > ...
> > > > > 
> > > > > The pfn_range [0xde600,0xde700] => addr_range [0xde600000,0xde700000]
> > > > > is not available memory, and we won't create memmap , so with or without
> > > > > your patch, we can't see the range in free_memmap(), right?
> > > > 
> > > > This is not available memory and we won't see the reange in free_memmap(),
> > > > but we still should create memmap for it and that's what my patch tried to
> > > > do.
> > > > 
> > > > There are a lot of places in core mm that operate on pageblocks and
> > > > free_unused_memmap() should make sure that any pageblock has a valid memory
> > > > map.
> > > > 
> > > > Currently, that's not the case when SPARSEMEM=y and my patch tried to fix
> > > > it.
> > > > 
> > > > Can you please send log with my patch applied and with the printing of
> > > > ranges that are freed in free_unused_memmap() you've used in previous
> > > > mails?
> > 
> > > with your patch[1] and debug print in free_memmap,
> > > ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86800, 86800000
> > > ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e000, 8e000000
> > > ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
> > > ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de400, de400000
> > > ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
> > > ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
> > > ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
> > 
> > It seems that freeing of the memory map is suboptimal still because that
> > code was not designed for memory layout that has more holes than Swiss
> > cheese.
> > 
> > Still, the range [0xde600,0xde700] is not freed and there should be struct
> > pages for this range.
> > 
> > Can you add
> > 
> > 	dump_page(pfn_to_page(0xde600), "");
> > 
> > say, in the end of memblock_free_all()?
> > 
> The range [0xde600,0xde700] is not memory, so it won't create struct page
> for it when sparse_init?

sparse_init() indeed does not create memory map for unpopulated memory, but
it has pretty coarse granularity, i.e. 64M in your configuration. A hole
should be at least 64M in order to skip allocation of the memory map for
it.

For example, your memory layout has a hole of 192M at pfn 0xc0000 and this
hole won't have the memory map.

However the hole 0xdca00 - 0xde70 will still have a memory map in the
section  that covers 0xdc000 - 0xe0000.

I've tried outline this in a sketch below, hope it helps.

Memory:
                          c0000      cc000                      dca00
--------------------------+          +--------------------------+ +----+
 memory bank              |<- hole ->| memory bank              | | mb |
--------------------------+          +--------------------------+ +----+
                                                                de700  dea00

Memory map:

b0000    b4000            c0000      cc000   d0000    d8000    dc000
+--------+--------+- ... -+          +--------+- ... -+--------+---------+
| memmap | memmap | ...   |<- hole ->| memmap |  ...  | memmap | memmap  |
+--------+--------+- ... -+          +--------+- ... -+--------+---------+


> After apply patch[1], the dump_page log,
> 
> page:ef3cc000 is uninitialized and poisoned
> raw: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
> page dumped because:

This means that there is a memory map entry, and it got poisoned during the
initialization and never got reinitialized to sensible values, which would
be PageReserved() in this case.

I believe this was fixed by commit 0740a50b9baa ("mm/page_alloc.c: refactor
initialization of struct page for holes in memory layout") in the mainline
tree.

Can you backport it to your 5.10 tree and check if it helps?
 
-- 
Sincerely yours,
Mike.
