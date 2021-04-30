Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57A36F825
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhD3Jwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhD3Jwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CFF961407;
        Fri, 30 Apr 2021 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619776316;
        bh=Px2AMr4e1QMYYfndBRW+4O9uoWJPIKb0VAJFMbMPdls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+fIYuDsW759TrYASvgsJEYis+WkbQI1lLeuNfwE57ngu1WuFws3BVi2LIaW8UEIQ
         gt84CE9dY2iE/z0vr6E1VZzJzJuLwtEkoBZvo709R+n/06XiAIMQUOnomzBl362bLU
         tDTYtn3exnOLp7VMc8LZpOM5EW7ExnmoF/SWOsHpuk9I5izfhBGGLovE9iIslRJcJ/
         HK+iC+TedK/fJmhDt4z8BCY7JEtg4H3aQtEHg4ZbE7qdG39guB4RKswrdevVRhysJy
         rFnyb+cU2VJzmrT4pr14s7mS4JatHHYZVJjhlQOah3/4IuZLQsp5rdHS7UDr0IlQcN
         KM1dquuO4pf5A==
Date:   Fri, 30 Apr 2021 12:51:47 +0300
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
Message-ID: <YIvTM5Yqit8AB4W8@kernel.org>
References: <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
 <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 06:22:55PM +0800, Kefeng Wang wrote:
> 
> On 2021/4/29 14:57, Mike Rapoport wrote:
> 
> > > > Do you use SPARSMEM? If yes, what is your section size?
> > > > What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
> > > Yes,
> > > 
> > > CONFIG_SPARSEMEM=y
> > > 
> > > CONFIG_SPARSEMEM_STATIC=y
> > > 
> > > CONFIG_FORCE_MAX_ZONEORDER = 11
> > > 
> > > CONFIG_PAGE_OFFSET=0xC0000000
> > > CONFIG_HAVE_ARCH_PFN_VALID=y
> > > CONFIG_HIGHMEM=y
> > > #define SECTION_SIZE_BITS    26
> > > #define MAX_PHYSADDR_BITS    32
> > > #define MAX_PHYSMEM_BITS     32
> 
> 
> With the patch,� the addr is aligned, but the panic still occurred,

Is this the same panic at move_freepages() for range [de600, de7ff]?

Do you enable CONFIG_ARM_LPAE?

> new free memory log is below,
> 
> memblock_free: [0xaf430000-0xaf44ffff] mem_init+0x158/0x23c
> 
> memblock_free: [0xaf510000-0xaf53ffff] mem_init+0x158/0x23c
> memblock_free: [0xaf560000-0xaf57ffff] mem_init+0x158/0x23c
> memblock_free: [0xafd98000-0xafdc7fff] mem_init+0x158/0x23c
> memblock_free: [0xafdd8000-0xafdfffff] mem_init+0x158/0x23c
> memblock_free: [0xafe18000-0xafe7ffff] mem_init+0x158/0x23c
> memblock_free: [0xafee0000-0xafefffff] mem_init+0x158/0x23c
> __free_memory_core, range: 0x80a03000 - 0x80a04000, pfn: 80a03 - 80a04
> __free_memory_core, range: 0x80a08000 - 0x80b00000, pfn: 80a08 - 80b00
> __free_memory_core, range: 0x812e8058 - 0x83000000, pfn: 812e9 - 83000
> __free_memory_core, range: 0x85000000 - 0x85600000, pfn: 85000 - 85600
> __free_memory_core, range: 0x86a00000 - 0x87e00000, pfn: 86a00 - 87e00
> __free_memory_core, range: 0x8bd00000 - 0x8c500000, pfn: 8bd00 - 8c500
> __free_memory_core, range: 0x8e300000 - 0x8ed00000, pfn: 8e300 - 8ed00
> __free_memory_core, range: 0x90d00000 - 0xaf2c0000, pfn: 90d00 - af2c0
> __free_memory_core, range: 0xaf430000 - 0xaf450000, pfn: af430 - af450
> __free_memory_core, range: 0xaf510000 - 0xaf540000, pfn: af510 - af540
> __free_memory_core, range: 0xaf560000 - 0xaf580000, pfn: af560 - af580
> __free_memory_core, range: 0xafd98000 - 0xafdc8000, pfn: afd98 - afdc8
> __free_memory_core, range: 0xafdd8000 - 0xafe00000, pfn: afdd8 - afe00
> __free_memory_core, range: 0xafe18000 - 0xafe80000, pfn: afe18 - afe80
> __free_memory_core, range: 0xafee0000 - 0xaff00000, pfn: afee0 - aff00
> __free_memory_core, range: 0xaff80000 - 0xaff8d000, pfn: aff80 - aff8d
> __free_memory_core, range: 0xafff2000 - 0xafff4580, pfn: afff2 - afff4
> __free_memory_core, range: 0xafffe000 - 0xafffe0e0, pfn: afffe - afffe
> __free_memory_core, range: 0xafffe4fc - 0xafffe500, pfn: affff - afffe
> __free_memory_core, range: 0xafffe6e4 - 0xafffe700, pfn: affff - afffe
> __free_memory_core, range: 0xafffe8dc - 0xafffe8e0, pfn: affff - afffe
> __free_memory_core, range: 0xafffe970 - 0xafffe980, pfn: affff - afffe
> __free_memory_core, range: 0xafffe990 - 0xafffe9a0, pfn: affff - afffe
> __free_memory_core, range: 0xafffe9a4 - 0xafffe9c0, pfn: affff - afffe
> __free_memory_core, range: 0xafffeb54 - 0xafffeb60, pfn: affff - afffe
> __free_memory_core, range: 0xafffecf4 - 0xafffed00, pfn: affff - afffe
> __free_memory_core, range: 0xafffefc4 - 0xafffefd8, pfn: affff - afffe
> __free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
> __free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
> __free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200

The range [de600, de7ff] 

> __free_memory_core, range: 0xe0800000 - 0xe0c00000, pfn: e0800 - b0200
> __free_memory_core, range: 0xf4b00000 - 0xf7000000, pfn: f4b00 - b0200
> __free_memory_core, range: 0xfda00000 - 0xffffffff, pfn: fda00 - b0200
> > It seems that with SPARSEMEM we don't align the freed parts on pageblock
> > boundaries.
> > 
> > Can you try the patch below:
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index afaefa8fc6ab..1926369b52ec 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1941,14 +1941,13 @@ static void __init free_unused_memmap(void)
> >   		 * due to SPARSEMEM sections which aren't present.
> >   		 */
> >   		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
> > -#else
> > +#endif
> >   		/*
> >   		 * Align down here since the VM subsystem insists that the
> >   		 * memmap entries are valid from the bank start aligned to
> >   		 * MAX_ORDER_NR_PAGES.
> >   		 */
> >   		start = round_down(start, MAX_ORDER_NR_PAGES);
> > -#endif
> >   		/*
> >   		 * If we had a previous bank, and there is a space
> > 

-- 
Sincerely yours,
Mike.
