Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3DB366AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbhDUMYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234625AbhDUMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:24:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A066F61413;
        Wed, 21 Apr 2021 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619007849;
        bh=yh6as9NWrw83rUxIIucPP9c/DuWOHZ6hcJhSm2Fn9Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f860jUcnW8H/ZBnBJQDe/Z6caOzDRAGPY71Yij6AZzc/ZM/zzjOtrh/+5CE5GsVGq
         pcCQEa6epu4I83oTKrt74ImgnXKtd9KyRgmfsqGZlr8Bt59P8mseStzqzZTTH+JDEv
         cbASQV89YWSTPadoCjBpoVNYoVZbCHv0LUMT5QYw4AJn8DnrowVzXcs76egO3nAEsD
         SYrstjJsa5Io7QYCgk/PjQ3RSqScp6IHEZpfmMUBy4G8/OpnJJOhVxKPX5lRTdWVDV
         mwcCMR9hEV/F0b2ygmBKDOm4YPpGvmDG+pNyGhOOBdY1GklZRKtgBMeykKpPRCVOqv
         /5gpsy2wh2JtQ==
Date:   Wed, 21 Apr 2021 15:24:01 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YIAZYVI/HZWBr7BI@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <20210421065108.1987-5-rppt@kernel.org>
 <66d50afe-77e6-70ee-6b51-5db28a086c68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d50afe-77e6-70ee-6b51-5db28a086c68@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:36:46PM +0530, Anshuman Khandual wrote:
> 
> On 4/21/21 12:21 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The arm64's version of pfn_valid() differs from the generic because of two
> > reasons:
> > 
> > * Parts of the memory map are freed during boot. This makes it necessary to
> >   verify that there is actual physical memory that corresponds to a pfn
> >   which is done by querying memblock.
> > 
> > * There are NOMAP memory regions. These regions are not mapped in the
> >   linear map and until the previous commit the struct pages representing
> >   these areas had default values.
> > 
> > As the consequence of absence of the special treatment of NOMAP regions in
> > the memory map it was necessary to use memblock_is_map_memory() in
> > pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> > generic mm functionality would not treat a NOMAP page as a normal page.
> > 
> > Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> > the rest of core mm will treat them as unusable memory and thus
> > pfn_valid_within() is no longer required at all and can be disabled by
> > removing CONFIG_HOLES_IN_ZONE on arm64.
> 
> This makes sense.
> 
> > 
> > pfn_valid() can be slightly simplified by replacing
> > memblock_is_map_memory() with memblock_is_memory().
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm64/Kconfig   | 3 ---
> >  arch/arm64/mm/init.c | 4 ++--
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e4e1b6550115..58e439046d05 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1040,9 +1040,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> >  	def_bool y
> >  	depends on NUMA
> >  
> > -config HOLES_IN_ZONE
> > -	def_bool y
> > -
> 
> Right.
> 
> >  source "kernel/Kconfig.hz"
> >  
> >  config ARCH_SPARSEMEM_ENABLE
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index dc03bdc12c0f..eb3f56fb8c7c 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -243,7 +243,7 @@ int pfn_valid(unsigned long pfn)
> >  
> >  	/*
> >  	 * ZONE_DEVICE memory does not have the memblock entries.
> > -	 * memblock_is_map_memory() check for ZONE_DEVICE based
> > +	 * memblock_is_memory() check for ZONE_DEVICE based
> >  	 * addresses will always fail. Even the normal hotplugged
> >  	 * memory will never have MEMBLOCK_NOMAP flag set in their
> >  	 * memblock entries. Skip memblock search for all non early
> > @@ -254,7 +254,7 @@ int pfn_valid(unsigned long pfn)
> >  		return pfn_section_valid(ms, pfn);
> >  }
> >  #endif
> > -	return memblock_is_map_memory(addr);
> > +	return memblock_is_memory(addr);
> 
> Wondering if MEMBLOCK_NOMAP is now being treated similarly to other
> memory pfns for page table walking purpose but with PageReserved(),
> why memblock_is_memory() is still required ? At this point, should
> not we just return valid for early_section() memory. As pfn_valid()
> now just implies that pfn has a struct page backing which has been
> already verified with valid_section() etc.

memblock_is_memory() is required because arm64 frees unused parts of the
memory map. So, for instance, if we have 64M out of 128M populated in a
section the section based calculation would return 1 for a pfn in the
second half of the section, but there would be no memory map there.


> >  }
> >  EXPORT_SYMBOL(pfn_valid);
> >  
> > 

-- 
Sincerely yours,
Mike.
