Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9357437B752
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhELIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhELIAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:00:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D5F613C9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620806385;
        bh=/jbrQezTL8G/ui6Q5vjZ+00LR2hUCslIdKJk+xNCZgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dqUIkOHH4A0b11/IJHaaCwCI3sbOltoRHV8RLoBhbUg9wrc3JeVK66bUge4gOmfTd
         VI27E3h4zuKvm1vDW0+zxiofKuQ5ewAAf7whkg5H0wHe/Rr13KUwFx49LunR1lpJWH
         iatdg7FSlp5qY1qV+R9Vfn0MyaSWy4MM0N8zLi5FuezPQ7Ji/m2F8aQaQWpzuFGTxb
         BcPUKT2uSJ79VOF0N/OUYEHCrFcO3bcmUlSnDIBL4fj8feXm7pmQLlU04VX3TaSatn
         vBLdvuXGKRD6MC93+ifGXhhJqUOwpgbvDAht5+lfPUDjGxGLeCh7HnIwzHJt9zn5Js
         kuGyGnp6XjrdA==
Received: by mail-oi1-f180.google.com with SMTP id x15so7750395oic.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:59:44 -0700 (PDT)
X-Gm-Message-State: AOAM533L+oI2J1rBbBT3SjNACt69p1E9Z3w69uboXZt+oFrdnRwWWMfi
        bEQxCDtnEhvCoUcAg1bjw1aWt783BFWjBS2lm5Y=
X-Google-Smtp-Source: ABdhPJwiXQK1n/wBurFk/qMzA9zSmBQYyMp/smLZRpZ5mb6HG5OLIvzlMqKlDQM6+S8vLVEBuAav/8FG2yoiJ7+A87A=
X-Received: by 2002:aca:4056:: with SMTP id n83mr6713227oia.47.1620806384150;
 Wed, 12 May 2021 00:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210511100550.28178-1-rppt@kernel.org> <CAMj1kXFHLkmgZKEb8BtgGt6GQ93Qd+yv6NtiCvtgX0ex9wSeyw@mail.gmail.com>
 <YJuE5O8nWNc1TGZ6@linux.ibm.com>
In-Reply-To: <YJuE5O8nWNc1TGZ6@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 May 2021 09:59:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE3G5v=1HFvGoW9weArBLpR_rDyAj0TZxTsZfdrNfgpyw@mail.gmail.com>
Message-ID: <CAMj1kXE3G5v=1HFvGoW9weArBLpR_rDyAj0TZxTsZfdrNfgpyw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 at 09:34, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, May 12, 2021 at 09:00:02AM +0200, Ard Biesheuvel wrote:
> > On Tue, 11 May 2021 at 12:05, Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Hi,
> > >
> > > These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> > > pfn_valid_within() to 1.
> > >
> > > The idea is to mark NOMAP pages as reserved in the memory map and restore
> > > the intended semantics of pfn_valid() to designate availability of struct
> > > page for a pfn.
> > >
> > > With this the core mm will be able to cope with the fact that it cannot use
> > > NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> > > will be treated correctly even without the need for pfn_valid_within.
> > >
> > > The patches are boot tested on qemu-system-aarch64.
> > >
> >
> > Did you use EFI boot when testing this? The memory map is much more
> > fragmented in that case, so this would be a good data point.
>
> Right, something like this:
>

Yes, although it is not always that bad.

> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000ffffbfff]
> [    0.000000]   node   0: [mem 0x00000000ffffc000-0x00000000ffffffff]

This is allocated below 4 GB by the firmware, for reasons that are
only valid on x86 (where some of the early boot chain is IA32 only)

> [    0.000000]   node   0: [mem 0x0000000100000000-0x00000004386fffff]
> [    0.000000]   node   0: [mem 0x0000000438700000-0x000000043899ffff]
> [    0.000000]   node   0: [mem 0x00000004389a0000-0x00000004389bffff]
> [    0.000000]   node   0: [mem 0x00000004389c0000-0x0000000438b5ffff]
> [    0.000000]   node   0: [mem 0x0000000438b60000-0x000000043be3ffff]
> [    0.000000]   node   0: [mem 0x000000043be40000-0x000000043becffff]
> [    0.000000]   node   0: [mem 0x000000043bed0000-0x000000043bedffff]
> [    0.000000]   node   0: [mem 0x000000043bee0000-0x000000043bffffff]
> [    0.000000]   node   0: [mem 0x000000043c000000-0x000000043fffffff]
>
> This is a pity really, because I don't see a fundamental reason for those
> tiny holes all over the place.
>

There is a config option in the firmware build that allows these
regions to be preallocated using larger windows, which greatly reduces
the fragmentation.
> I know that EFI/ACPI mandates "IO style" memory access for those regions,
> but I fail to get why...
>

Not sure what you mean by 'IO style memory access'.



> > > I beleive it would be best to route these via mmotm tree.
> > >
> > > v4:
> > > * rebase on v5.13-rc1
> > >
> > > v3: Link: https://lore.kernel.org/lkml/20210422061902.21614-1-rppt@kernel.org
> > > * Fix minor issues found by Anshuman
> > > * Freshen up the declaration of pfn_valid() to make it consistent with
> > >   pfn_is_map_memory()
> > > * Add more Acked-by and Reviewed-by tags, thanks Anshuman and David
> > >
> > > v2: Link: https://lore.kernel.org/lkml/20210421065108.1987-1-rppt@kernel.org
> > > * Add check for PFN overflow in pfn_is_map_memory()
> > > * Add Acked-by and Reviewed-by tags, thanks David.
> > >
> > > v1: Link: https://lore.kernel.org/lkml/20210420090925.7457-1-rppt@kernel.org
> > > * Add comment about the semantics of pfn_valid() as Anshuman suggested
> > > * Extend comments about MEMBLOCK_NOMAP, per Anshuman
> > > * Use pfn_is_map_memory() name for the exported wrapper for
> > >   memblock_is_map_memory(). It is still local to arch/arm64 in the end
> > >   because of header dependency issues.
> > >
> > > rfc: Link: https://lore.kernel.org/lkml/20210407172607.8812-1-rppt@kernel.org
> > >
> > > Mike Rapoport (4):
> > >   include/linux/mmzone.h: add documentation for pfn_valid()
> > >   memblock: update initialization of reserved pages
> > >   arm64: decouple check whether pfn is in linear map from pfn_valid()
> > >   arm64: drop pfn_valid_within() and simplify pfn_valid()
> > >
> > >  arch/arm64/Kconfig              |  3 ---
> > >  arch/arm64/include/asm/memory.h |  2 +-
> > >  arch/arm64/include/asm/page.h   |  3 ++-
> > >  arch/arm64/kvm/mmu.c            |  2 +-
> > >  arch/arm64/mm/init.c            | 14 +++++++++++++-
> > >  arch/arm64/mm/ioremap.c         |  4 ++--
> > >  arch/arm64/mm/mmu.c             |  2 +-
> > >  include/linux/memblock.h        |  4 +++-
> > >  include/linux/mmzone.h          | 11 +++++++++++
> > >  mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
> > >  10 files changed, 60 insertions(+), 13 deletions(-)
> > >
> > >
> > > base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> > > --
> > > 2.28.0
> > >
>
> --
> Sincerely yours,
> Mike.
