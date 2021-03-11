Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE0336D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCKIPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhCKIOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:14:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE46E64EC6;
        Thu, 11 Mar 2021 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615450482;
        bh=a3b4TtFfggtZVB8E1vmzTQlVeIFZQfTnkixKH/vWHHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyUDDmYV+k+pnkiQGiBHE/zGBr5bgPSafkHqV2CsbXJOoYcYfFmutNQku0O5VIeiC
         h2TvwatDhw8pNHXzfArY/lDLFykTQMe8utgh/Ar+kuMYDyTgaQIOTvlULzE4Hd0SNW
         T7YJrepd0AgeRdVGq6rimfcckSC0K+tdBbOhjPmMCo+8OSzwFMIxyps7FkTds48HD4
         5ZzBs0dUce2ZjFZg/g+E+/HxtFh9AS4Ujc+Lcy8E0HtMvJ2auIkklqEVIjLEaXBNIt
         6IsLv/+ixlCmcFj5xCZ/DvDBEa25xnxSxE8R5r5+4OLz+IHyI5XvKedCfpGhDfZhK7
         s7qm5GpzJDsig==
Date:   Thu, 11 Mar 2021 10:14:35 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
Message-ID: <YEnRa232X9GJsM3u@kernel.org>
References: <1615174073-10520-1-git-send-email-anshuman.khandual@arm.com>
 <YEXme5SI+GxsYli8@kernel.org>
 <003d8a4b-9687-3e9a-c27b-908db280b44c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003d8a4b-9687-3e9a-c27b-908db280b44c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:22:53PM +0530, Anshuman Khandual wrote:
> 
> On 3/8/21 2:25 PM, Mike Rapoport wrote:
> > Hi Anshuman,
> > 
> > On Mon, Mar 08, 2021 at 08:57:53AM +0530, Anshuman Khandual wrote:
> >> Platforms like arm and arm64 have redefined pfn_valid() because their early
> >> memory sections might have contained memmap holes caused by memblock areas
> >> tagged with MEMBLOCK_NOMAP, which should be skipped while validating a pfn
> >> for struct page backing. This scenario could be captured with a new option
> >> CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES and then generic pfn_valid() can be
> >> improved to accommodate such platforms. This reduces overall code footprint
> >> and also improves maintainability.
> > 
> > I wonder whether arm64 would still need to free parts of its memmap after
> 
> free_unused_memmap() is applicable when CONFIG_SPARSEMEM_VMEMMAP is not enabled.
> I am not sure whether there still might be some platforms or boards which would
> benefit from this. Hence lets just keep this unchanged for now.

For builds with VMEMMAP off free_unused_memmap() would still provide some
memory savings. But the question is whether these savings are really
important for somebody? When the section size was 512M no doubt smaller
systems would waste a lot of memory for empty memory map. But with the
section size of 128M and the general increase in memory sizes even on
smaller devices we might be not actually saving anything. OTOH, we need to
keep arm64::pfn_valid() up to date with memory hot(un)plug, ZONE_DEVICE
etc.

Maybe as a compromise we can start with making free_unused_memmap() and
arm64::pfn_valid() only available in "legacy" mode that does not support
memory hotplug, pmem and so on?
 
> > the section size was reduced. Maybe the pain of arm64::pfn_valid() is not
> > worth the memory savings anymore?
> 
> arm64 pfn_valid() special case was primarily because of MEMBLOCK_NOMAP tagged
> memory areas, which are reserved by the firmware.

I'm confused now. AFAIU, pfn_valid() means that there is a struct page for that
pfn and nothing else. Why is that related to MEMBLOCK_NOMAP?

> > 
> >> Commit 4f5b0c178996 ("arm, arm64: move free_unused_memmap() to generic mm")
> >> had used CONFIG_HAVE_ARCH_PFN_VALID to gate free_unused_memmap(), which in
> >> turn had expanded its scope to new platforms like arc and m68k. Rather lets
> >> restrict back the scope for free_unused_memmap() to arm and arm64 platforms
> >> using this new config option i.e CONFIG_HAVE_EARLY_SECTION_MEMMAP.
> > 
> > The whole point of 4f5b0c178996 was to let arc and m68k to free unused
> > memory map with FLATMEM so they won't need DISCONTIGMEM or SPARSEMEM. So
> > whatever implementation there will be for arm/arm64, please keep arc and
> > m68k functionally intact.
> 
> Okay. Will protect free_unused_memmap() on HAVE_EARLY_SECTION_MEMMAP_HOLES
> config as well.
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d9fa2e62ab7a..11b624e94127 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1927,8 +1927,11 @@ static void __init free_unused_memmap(void)
>         unsigned long start, end, prev_end = 0;
>         int i;
>  
> -       if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ||
> -           IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +       if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +               return;
> +
> +       if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) &&
> +           !IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
>                 return;

-- 
Sincerely yours,
Mike.
