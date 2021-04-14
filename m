Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51E335FC94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhDNUZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233974AbhDNUZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 929D361158;
        Wed, 14 Apr 2021 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618431907;
        bh=EDyoZL7R5AMH7SmFRfNLvaodtaCVcxu14UA9HszVMuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J810ShOsTpDwAy/CgjWZlnYEJs4yWGVoo0W//hV2T2onXukkGibYa+jOZjdiKADcS
         sav7Cu2STm1iXo4G+EngkZ7iwtXWHpZTR5Lxu0C5gPh9sxwBOm34joDVvdxyvvEqbp
         0pHxLr4ClR4LiCixV1TBtz8sEbDutHtNfMfKOkcoVTV8tNLt6LeyCrECeJFWrz4DAX
         +KhAIMqI43nLnsgLPXPUKri9+VgqYtazu65FObh5FP1f1MWAEp9F4RZHyzmxJd3oD0
         6eS5ctVHON0asI8rlh+YV84q5GFrO8y8Cacq8EedLJdw5nv3q7R/7alY9BOO1apu+S
         k4waycbxeckNQ==
Date:   Wed, 14 Apr 2021 23:24:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <YHdPmtpzFxHE9mAt@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
 <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:52:57PM +0200, David Hildenbrand wrote:
> On 14.04.21 17:27, Ard Biesheuvel wrote:
> > On Wed, 14 Apr 2021 at 17:14, David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 07.04.21 19:26, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > The struct pages representing a reserved memory region are initialized
> > > > using reserve_bootmem_range() function. This function is called for each
> > > > reserved region just before the memory is freed from memblock to the buddy
> > > > page allocator.
> > > > 
> > > > The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> > > > values set by the memory map initialization which makes it necessary to
> > > > have a special treatment for such pages in pfn_valid() and
> > > > pfn_valid_within().
> > > 
> > > I assume these pages are never given to the buddy, because we don't have
> > > a direct mapping. So to the kernel, it's essentially just like a memory
> > > hole with benefits.
> > > 
> > > I can spot that we want to export such memory like any special memory
> > > thingy/hole in /proc/iomem -- "reserved", which makes sense.
> > > 
> > > I would assume that MEMBLOCK_NOMAP is a special type of *reserved*
> > > memory. IOW, that for_each_reserved_mem_range() should already succeed
> > > on these as well -- we should mark anything that is MEMBLOCK_NOMAP
> > > implicitly as reserved. Or are there valid reasons not to do so? What
> > > can anyone do with that memory?
> > > 
> > > I assume they are pretty much useless for the kernel, right? Like other
> > > reserved memory ranges.
> > > 
> > 
> > On ARM, we need to know whether any physical regions that do not
> > contain system memory contain something with device semantics or not.
> > One of the examples is ACPI tables: these are in reserved memory, and
> > so they are not covered by the linear region. However, when the ACPI
> > core ioremap()s an arbitrary memory region, we don't know whether it
> > is mapping a memory region or a device region unless we keep track of
> > this in some way. (Device mappings require device attributes, but
> > firmware tables require memory attributes, as they might be accessed
> > using misaligned reads)
> 
> Using generically sounding NOMAP ("don't create direct mapping") to identify
> device regions feels like a hack. I know, it was introduced just for that
> purpose.
> 
> Looking at memblock_mark_nomap(), we consider "device regions"
> 
> 1) ACPI tables
> 
> 2) VIDEO_TYPE_EFI memory
> 
> 3) some device-tree regions in of/fdt.c
> 
> 
> IIUC, right now we end up creating a memmap for this NOMAP memory, but hide
> it away in pfn_valid(). This patch set at least fixes that.

Currently we have memmap entries with struct page set to defaults for the
NOMAP memory. AFAIU hiding them in pfn_valid()/pfn_valid_within() was a
solution to failures in pfn walkers that presumed that for a pfn_valid()
there will be a struct page that really reflects the state of that page.

> Assuming these pages are never mapped to user space via the struct page
> (which better be the case), we could further use a new pagetype to mark
> these pages in a special way, such that we can identify them directly via
> pfn_to_page().

Not sure we really need a new pagetype here, PG_Reserved seems to be quite
enough to say "don't touch this".  I generally agree that we could make
PG_Reserved a PageType and then have several sub-types for reserved memory.
This definitely will add clarity but I'm not sure that this justifies
amount of churn and effort required to audit uses of PageResrved().
 
> Then, we could mostly avoid having to query memblock at runtime to figure
> out that this is special memory. This would obviously be an extension to
> this series. Just a thought. 

Stop pushing memblock out of kernel! ;-)

Now, seriously, we can minimize memblock involvement in run-time and this
series in yet another step in that direction.

-- 
Sincerely yours,
Mike.
