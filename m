Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4A45B98A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbhKXMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhKXMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:02:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D52F8600EF;
        Wed, 24 Nov 2021 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637755139;
        bh=MvIK4njDymo/2ZRxEewHraQypk4QKFkHR40PDGdal+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cp/rZpGcqTIi1PeMcD9mYYH3FW4FMgRdAwWPy2fSwSsAsyrYbkt8tAUkI4Ue4E5Ia
         Y0+YKyG9EOnvYTjuwv3b9N9ogcqvypdgjn999VIFRs9sa37doUL6LjHcwzFXXS4D/7
         a0vIGf59nGiD1IkvwHJpwhnJHlTLFKfnUw5B91eKoBYDFQEKzN/yK0pjD7zJIiTeu+
         MyrYmPxov7UsAxayWeFlN6fI4BN9DLk2K0dnZKEjUFCHssb01ohtdeFp2qeLXgLign
         HnEyQELE5pU1FCKWsLdn33iRnXy4lwJIknsFttmIQjN+byDwhItHbG8it3m5OYu5Wq
         up3aAcy0f5xjQ==
Received: by mail-vk1-f178.google.com with SMTP id u68so1312095vke.11;
        Wed, 24 Nov 2021 03:58:59 -0800 (PST)
X-Gm-Message-State: AOAM530W+v1LItlY49Cn4tjGnx4UOiEYYIHI+53lf4U1nYpP8bzwZIdE
        emzUkLhDwpSCPqqU2MYEY5gZVEPS/q05aeEANz4=
X-Google-Smtp-Source: ABdhPJxhacpNM59NxypS0T/KAUahS5ojXmSzXoFPzoB0PdFHKTFcIj1yDMUFCrNG7hxMeznB11r7+os9Dwluu3N+zdw=
X-Received: by 2002:a05:6122:2005:: with SMTP id l5mr25744006vkd.4.1637755139010;
 Wed, 24 Nov 2021 03:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <20211123015717.542631-2-guoren@kernel.org>
 <CAAhSdy0LWyhgXetiXikCosSX4xasgROyua6XMd92dV8TiWp62w@mail.gmail.com> <CA+zEjCspyB49tMUkMCug+R=vhgA0NPOyo7B33rRECi6kj0txZA@mail.gmail.com>
In-Reply-To: <CA+zEjCspyB49tMUkMCug+R=vhgA0NPOyo7B33rRECi6kj0txZA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 24 Nov 2021 19:58:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSDGD6eC6J0AmgT5HyNDUriPv9b4ZWM8us4Xs066CWk9A@mail.gmail.com>
Message-ID: <CAJF2gTSDGD6eC6J0AmgT5HyNDUriPv9b4ZWM8us4Xs066CWk9A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] riscv: Remove 2MB offset in the mm layout
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 9:37 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Tue, Nov 23, 2021 at 4:56 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > +Alex
> >
> > On Tue, Nov 23, 2021 at 7:27 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The current RISC-V's mm layout is based on a 2MB offset and wasting
> > > memory. Remove 2MB offset and map PAGE_OFFSET at start_of_DRAM.
> > > Then we could reduce the memory reserved for opensbi in the next
> > > patch.
> >
> > The real problem is that the generic kernel marks memory before
> > __pa(PAGE_OFFSET) as reserved which is evident from the boot
> > print "OF: fdt: Ignoring memory range 0x80000000 - 0x80200000".
>
> Agreed, memblock 'rejects' this region because MIN_MEMBLOCK_ADDR is
> defined as __pa(PAGE_OFFSET) which points to 0x80200000. I have a
> patch to enable the use of hugepages for the linear mapping [1] that
> does just that, things are not that easy since then it breaks initrd
> initialization which is an early caller of __va, I updated this
> patchset a few months ago, I can push that soon @Guo Ren.
Seems your patch makes the mapping of early_pg_dir & swapper_pg_dir different.

early_pg_dir: 0x80200000 -> 0xffffffe000000000
swapper_pg_dir: 0x80000000 -> 0xffffffe000000000

It breaks the vmlinux.ld.S, doesn't it?

>
> [1] https://lkml.org/lkml/2020/6/3/696
>
>
>
> >
> > One simple way to re-claim the first 2MB of memory is by:
> > 1) Not placing OpenSBI firmware at start of RAM and rather
> > place it towards end/middle or RAM away from kernel and initrd
> > 2) Load kernel at start of the RAM
> >
> > The point#1 is already supported by OpenSBI firmwares using
> > position independent compilation. In fact, U-Boot SPL does
> > not load OpenSBI firmware at the start of RAM.
> >
> > I would suggest Allwinner D1 to follow U-Boot SPL and have
> > the booting stage before OpenSBI to load OpenSBI firmware
> > somewhere else.
> >
> > Regards,
> > Anup
> >
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Anup Patel <anup.patel@wdc.com>
> > > Cc: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/page.h   |  8 ++++++++
> > >  arch/riscv/kernel/head.S        | 10 +++-------
> > >  arch/riscv/kernel/vmlinux.lds.S |  5 ++---
> > >  arch/riscv/mm/init.c            | 11 ++++++++---
> > >  4 files changed, 21 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > > index b3e5ff0125fe..299147c78b4a 100644
> > > --- a/arch/riscv/include/asm/page.h
> > > +++ b/arch/riscv/include/asm/page.h
> > > @@ -16,6 +16,14 @@
> > >  #define PAGE_SIZE      (_AC(1, UL) << PAGE_SHIFT)
> > >  #define PAGE_MASK      (~(PAGE_SIZE - 1))
> > >
> > > +#if __riscv_xlen == 64
> > > +/* Image load offset(2MB) from start of RAM */
> > > +#define LOAD_OFFSET    0x200000
> > > +#else
> > > +/* Image load offset(4MB) from start of RAM */
> > > +#define LOAD_OFFSET    0x400000
> > > +#endif
> > > +
> > >  #ifdef CONFIG_64BIT
> > >  #define HUGE_MAX_HSTATE                2
> > >  #else
> > > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > > index f52f01ecbeea..a6ac892d2ccf 100644
> > > --- a/arch/riscv/kernel/head.S
> > > +++ b/arch/riscv/kernel/head.S
> > > @@ -61,13 +61,7 @@ ENTRY(_start)
> > >         /* Image load offset (0MB) from start of RAM for M-mode */
> > >         .dword 0
> > >  #else
> > > -#if __riscv_xlen == 64
> > > -       /* Image load offset(2MB) from start of RAM */
> > > -       .dword 0x200000
> > > -#else
> > > -       /* Image load offset(4MB) from start of RAM */
> > > -       .dword 0x400000
> > > -#endif
> > > +       .dword LOAD_OFFSET
> > >  #endif
> > >         /* Effective size of kernel image */
> > >         .dword _end - _start
> > > @@ -94,6 +88,8 @@ relocate:
> > >         la a1, kernel_map
> > >         XIP_FIXUP_OFFSET a1
> > >         REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
> > > +       li a2, LOAD_OFFSET
> > > +       add a1, a1, a2
> > >         la a2, _start
> > >         sub a1, a1, a2
> > >         add ra, ra, a1
> > > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > > index 5104f3a871e3..75b7c72cd4bd 100644
> > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > @@ -11,10 +11,9 @@
> > >  #else
> > >
> > >  #include <asm/pgtable.h>
> > > -#define LOAD_OFFSET KERNEL_LINK_ADDR
> > >
> > > -#include <asm/vmlinux.lds.h>
> > >  #include <asm/page.h>
> > > +#include <asm/vmlinux.lds.h>
> > >  #include <asm/cache.h>
> > >  #include <asm/thread_info.h>
> > >  #include <asm/set_memory.h>
> > > @@ -32,7 +31,7 @@ PECOFF_FILE_ALIGNMENT = 0x200;
> > >  SECTIONS
> > >  {
> > >         /* Beginning of code and text segment */
> > > -       . = LOAD_OFFSET;
> > > +       . = LOAD_OFFSET + KERNEL_LINK_ADDR;
> > >         _start = .;
> > >         HEAD_TEXT_SECTION
> > >         . = ALIGN(PAGE_SIZE);
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 24b2b8044602..920e78f8c3e4 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -221,6 +221,11 @@ static void __init setup_bootmem(void)
> > >         if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> > >                 memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> > >
> > > +       /*
> > > +        * Reserve OpenSBI region and depends on PMP to deny accesses.
> > > +        */
> > > +       memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
> > > +
> > >         early_init_fdt_scan_reserved_mem();
> > >         dma_contiguous_reserve(dma32_phys_limit);
> > >         if (IS_ENABLED(CONFIG_64BIT))
> > > @@ -604,7 +609,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > >
> > >         kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
> > >  #else
> > > -       kernel_map.phys_addr = (uintptr_t)(&_start);
> > > +       kernel_map.phys_addr = (uintptr_t)(&_start) - LOAD_OFFSET;
> > >         kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
> > >  #endif
> > >         kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> > > @@ -645,8 +650,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > >         create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> > >                            kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
> > >  #else
> > > -       create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> > > -                          kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
> > > +       create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr + LOAD_OFFSET,
> > > +                          kernel_map.phys_addr + LOAD_OFFSET, PMD_SIZE, PAGE_KERNEL_EXEC);
> > >  #endif
> > >  #else
> > >         /* Setup trampoline PGD */
> > > --
> > > 2.25.1
> > >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
