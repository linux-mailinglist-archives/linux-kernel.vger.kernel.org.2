Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C911636650D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhDUFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235285AbhDUFxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:53:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D42916140C;
        Wed, 21 Apr 2021 05:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618984357;
        bh=g72o3X3Q6Y/a2mSNpa0HjIO9b/1mdQbo0EaTxru/zZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDwRsR/E5mE9ve2Akk/3k+XO8YXnjrfevy9BmPLxs+lWkLg/W8jvzL1dYtVYW+3Rf
         c0TNDace3LJilMFVznrYeCRDwGrbHzJWGhCicEdzHL6l8Ssmr+GPd2k1tR0J/Oz8gY
         HNlkCXKomx+V/ot9YHj+QTDszjYr8FZyUKXC3ov3JbPn6ar8+9fn4C2rsNGgfwD1xK
         jxVIemH8Bz2l6DRPlexUeyQ5bNbq1sXxlzRv+Ip3azOMMDa2+YNNQtjVpoPrF/KHOO
         C7w6maQQFuV4pFX+kZC5rXtQY8I5cntBPjYPkw4E8WX1mZ5dZcqHIin3LRMZrwh4pk
         FPk4mfTeux5gA==
Date:   Wed, 21 Apr 2021 08:52:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YH+9nbDkPyVav3xn@kernel.org>
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-5-rppt@kernel.org>
 <8e7171e7-a85c-6066-4ab6-d2bc98ec103b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7171e7-a85c-6066-4ab6-d2bc98ec103b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:00:55PM +0200, David Hildenbrand wrote:
> On 20.04.21 11:09, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The arm64's version of pfn_valid() differs from the generic because of two
> > reasons:
> > 
> > * Parts of the memory map are freed during boot. This makes it necessary to
> >    verify that there is actual physical memory that corresponds to a pfn
> >    which is done by querying memblock.
> > 
> > * There are NOMAP memory regions. These regions are not mapped in the
> >    linear map and until the previous commit the struct pages representing
> >    these areas had default values.
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
> > 
> > pfn_valid() can be slightly simplified by replacing
> > memblock_is_map_memory() with memblock_is_memory().
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   arch/arm64/Kconfig   | 3 ---
> >   arch/arm64/mm/init.c | 4 ++--
> >   2 files changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e4e1b6550115..58e439046d05 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1040,9 +1040,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> >   	def_bool y
> >   	depends on NUMA
> > -config HOLES_IN_ZONE
> > -	def_bool y
> > -
> >   source "kernel/Kconfig.hz"
> >   config ARCH_SPARSEMEM_ENABLE
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index c54e329aca15..370f33765b64 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -243,7 +243,7 @@ int pfn_valid(unsigned long pfn)
> >   	/*
> >   	 * ZONE_DEVICE memory does not have the memblock entries.
> > -	 * memblock_is_map_memory() check for ZONE_DEVICE based
> > +	 * memblock_is_memory() check for ZONE_DEVICE based
> >   	 * addresses will always fail. Even the normal hotplugged
> >   	 * memory will never have MEMBLOCK_NOMAP flag set in their
> >   	 * memblock entries. Skip memblock search for all non early
> > @@ -254,7 +254,7 @@ int pfn_valid(unsigned long pfn)
> >   		return pfn_section_valid(ms, pfn);
> >   }
> >   #endif
> > -	return memblock_is_map_memory(addr);
> > +	return memblock_is_memory(addr);
> >   }
> >   EXPORT_SYMBOL(pfn_valid);
> > 
> 
> What are the steps needed to get rid of custom pfn_valid() completely?
> 
> I'd assume we would have to stop freeing parts of the mem map during boot.
> How relevant is that for arm64 nowadays, especially with reduced section
> sizes?

Yes, for arm64 to use the generic pfn_valid() it'd need to stop freeing
parts of the memory map.

Presuming struct page is 64 bytes, the memory map takes 2M per section in
the worst case (128M per section, 4k pages). 

So for systems that have less than 128M populated in each section freeing
unused memory map would mean significant savings.

But nowadays when a clock has at least 1G of RAM I doubt this is relevant
to many systems if at all.

-- 
Sincerely yours,
Mike.
