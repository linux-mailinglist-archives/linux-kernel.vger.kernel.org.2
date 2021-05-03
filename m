Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9537119F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 08:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhECG1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 02:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhECG1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 02:27:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A376461185;
        Mon,  3 May 2021 06:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620023221;
        bh=ARgCJkbvRnhDoHk3mV9x6qfowVNrQmhn5MqXTbvPEYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLCHzBplf919bfRjQhdvb086292DMWBVZ45XMSphxu+pcjDiMcckytIgWXw8oIMvl
         z18xh8OtBWrApFxp0Ap7DYavNOBdHbF2GD9xw92gKbbluKtpPRzgQzkjWTt2pRg3Bg
         wBhtw0n2qCbOyCudUIRfXQPYxbJIHPI9r/vQtzoJdLfoqQwsHc3DO0snvF4vcUGdP8
         Mlk/usfjkMj3HVCII0mYn451J74eeuCXvepkDWSRrDg5TugCTJasOKobmY9n9tah12
         TMr62xVdWVrQTTVeIrlfu9AMNqwI3MWcfSfk2gMjdB3lSwvuf6A4yLjtDHYLsFG9my
         ljVCh+EdI3S5w==
Date:   Mon, 3 May 2021 09:26:52 +0300
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
Message-ID: <YI+XrAg4KOzOyt7c@kernel.org>
References: <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
 <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 07:24:37PM +0800, Kefeng Wang wrote:
> 
> 
> On 2021/4/30 17:51, Mike Rapoport wrote:
> > On Thu, Apr 29, 2021 at 06:22:55PM +0800, Kefeng Wang wrote:
> > > 
> > > On 2021/4/29 14:57, Mike Rapoport wrote:
> > > 
> > > > > > Do you use SPARSMEM? If yes, what is your section size?
> > > > > > What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
> > > > > Yes,
> > > > > 
> > > > > CONFIG_SPARSEMEM=y
> > > > > 
> > > > > CONFIG_SPARSEMEM_STATIC=y
> > > > > 
> > > > > CONFIG_FORCE_MAX_ZONEORDER = 11
> > > > > 
> > > > > CONFIG_PAGE_OFFSET=0xC0000000
> > > > > CONFIG_HAVE_ARCH_PFN_VALID=y
> > > > > CONFIG_HIGHMEM=y
> > > > > #define SECTION_SIZE_BITS    26
> > > > > #define MAX_PHYSADDR_BITS    32
> > > > > #define MAX_PHYSMEM_BITS     32
> > > 
> > > 
> > > With the patch,  the addr is aligned, but the panic still occurred,
> > 
> > Is this the same panic at move_freepages() for range [de600, de7ff]?
> > 
> > Do you enable CONFIG_ARM_LPAE?
> 
> no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
> move_freepages at
> 
> start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000] :  pfn =de600, page
> =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
> 
> > > __free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
> > > __free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
> > > __free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200

Hmm, [de600, de7ff] is not added to the free lists which is correct. But
then it's unclear how the page for de600 gets to move_freepages()...

Can't say I have any bright ideas to try here...

> the __free_memory_core will check the start pfn and end pfn,
> 
>  if (start_pfn >= end_pfn)
>          return 0;
> 
>  __free_pages_memory(start_pfn, end_pfn);
> so the memory will not be freed to buddy, confused...

It's a check for range validity, all valid ranges are added.

> > > __free_memory_core, range: 0xe0800000 - 0xe0c00000, pfn: e0800 - b0200
> > > __free_memory_core, range: 0xf4b00000 - 0xf7000000, pfn: f4b00 - b0200
> > > __free_memory_core, range: 0xfda00000 - 0xffffffff, pfn: fda00 - b0200
> > > > It seems that with SPARSEMEM we don't align the freed parts on pageblock
> > > > boundaries.
> > > > 
> > > > Can you try the patch below:
> > > > 
> > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > index afaefa8fc6ab..1926369b52ec 100644
> > > > --- a/mm/memblock.c
> > > > +++ b/mm/memblock.c
> > > > @@ -1941,14 +1941,13 @@ static void __init free_unused_memmap(void)
> > > >    		 * due to SPARSEMEM sections which aren't present.
> > > >    		 */
> > > >    		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
> > > > -#else
> > > > +#endif
> > > >    		/*
> > > >    		 * Align down here since the VM subsystem insists that the
> > > >    		 * memmap entries are valid from the bank start aligned to
> > > >    		 * MAX_ORDER_NR_PAGES.
> > > >    		 */
> > > >    		start = round_down(start, MAX_ORDER_NR_PAGES);
> > > > -#endif
> > > >    		/*
> > > >    		 * If we had a previous bank, and there is a space
> > > > 
> > 

-- 
Sincerely yours,
Mike.
