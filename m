Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ADA459C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 07:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhKWGVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 01:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhKWGVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 01:21:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0873F60FC2;
        Tue, 23 Nov 2021 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637648315;
        bh=9q5PZmYIUfd5uvRnDykQ983UxaDrFCzj6jD1Sb39JZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gL4vlg1ZUU1waStVc3W5mTM5QuovyX7Imb9HG29o+WQnY4CFRmrqX+dc/KAxspfbu
         Vq6CmXkNVCtiOshmodsHTr3Si7R1RoiNGxQNkZNfeGMaHamyMKRIo8I9ty1LVzvpHE
         I0yUJED0tka8P1QGcTkCulsqTYJzNqvr0rupg6CG10ik8lXZTUyFudb8GCM9GEbT2H
         ADSaJKLJu7C0rxoENVI0BwIOL0Mr6allKQ5SjTBdPQ+gTC/Y2989lDY/Gu9X//Ug9k
         JdFfnkjyUJEvD9qrsVlrthBhyGJXDiilQCulLW3Qy7HV+oKAGPpa3kwg6JkqAEhpKu
         I38lLULc5+udw==
Received: by mail-ua1-f52.google.com with SMTP id x14so979913uao.0;
        Mon, 22 Nov 2021 22:18:34 -0800 (PST)
X-Gm-Message-State: AOAM530q5YcajUvsW/o2I7sZXAfS+TMj3pNAp+B9sv3LgZUa7Xv9TdGj
        8D9o6hpgLp+lDLBmJSE5zkffS2jcHJu0PZ4syjQ=
X-Google-Smtp-Source: ABdhPJyacyctRuRWpwxoo6qsjZpYyyLDBa+6mAN4sNblEFUBReDr/56cV/o4cDlvDGuw9EqQgIGpApkx9inD6uye9ZQ=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr4688469uae.57.1637648314117;
 Mon, 22 Nov 2021 22:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <20211123015717.542631-2-guoren@kernel.org>
 <CAAhSdy0LWyhgXetiXikCosSX4xasgROyua6XMd92dV8TiWp62w@mail.gmail.com>
In-Reply-To: <CAAhSdy0LWyhgXetiXikCosSX4xasgROyua6XMd92dV8TiWp62w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 23 Nov 2021 14:18:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRMBoCi--4V5+bgPopkLOF8+y7QBHjjENZDSr4cm5PNfw@mail.gmail.com>
Message-ID: <CAJF2gTRMBoCi--4V5+bgPopkLOF8+y7QBHjjENZDSr4cm5PNfw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] riscv: Remove 2MB offset in the mm layout
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:56 AM Anup Patel <anup@brainfault.org> wrote:
>
> +Alex
>
> On Tue, Nov 23, 2021 at 7:27 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The current RISC-V's mm layout is based on a 2MB offset and wasting
> > memory. Remove 2MB offset and map PAGE_OFFSET at start_of_DRAM.
> > Then we could reduce the memory reserved for opensbi in the next
> > patch.
>
> The real problem is that the generic kernel marks memory before
> __pa(PAGE_OFFSET) as reserved which is evident from the boot
> print "OF: fdt: Ignoring memory range 0x80000000 - 0x80200000".
>
> One simple way to re-claim the first 2MB of memory is by:
> 1) Not placing OpenSBI firmware at start of RAM and rather
> place it towards end/middle or RAM away from kernel and initrd
> 2) Load kernel at start of the RAM
>
> The point#1 is already supported by OpenSBI firmwares using
> position independent compilation. In fact, U-Boot SPL does
> not load OpenSBI firmware at the start of RAM.
This deviates from the original intention of this patch. Some users
have been used to 2MB/4MB LOAD_OFFSET and we also should save the
memory of opensbi for them.

>
> I would suggest Allwinner D1 to follow U-Boot SPL and have
> the booting stage before OpenSBI to load OpenSBI firmware
>
> Regards,
> Anup
>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Anup Patel <anup.patel@wdc.com>
> > Cc: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/page.h   |  8 ++++++++
> >  arch/riscv/kernel/head.S        | 10 +++-------
> >  arch/riscv/kernel/vmlinux.lds.S |  5 ++---
> >  arch/riscv/mm/init.c            | 11 ++++++++---
> >  4 files changed, 21 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index b3e5ff0125fe..299147c78b4a 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -16,6 +16,14 @@
> >  #define PAGE_SIZE      (_AC(1, UL) << PAGE_SHIFT)
> >  #define PAGE_MASK      (~(PAGE_SIZE - 1))
> >
> > +#if __riscv_xlen == 64
> > +/* Image load offset(2MB) from start of RAM */
> > +#define LOAD_OFFSET    0x200000
> > +#else
> > +/* Image load offset(4MB) from start of RAM */
> > +#define LOAD_OFFSET    0x400000
> > +#endif
> > +
> >  #ifdef CONFIG_64BIT
> >  #define HUGE_MAX_HSTATE                2
> >  #else
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index f52f01ecbeea..a6ac892d2ccf 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -61,13 +61,7 @@ ENTRY(_start)
> >         /* Image load offset (0MB) from start of RAM for M-mode */
> >         .dword 0
> >  #else
> > -#if __riscv_xlen == 64
> > -       /* Image load offset(2MB) from start of RAM */
> > -       .dword 0x200000
> > -#else
> > -       /* Image load offset(4MB) from start of RAM */
> > -       .dword 0x400000
> > -#endif
> > +       .dword LOAD_OFFSET
> >  #endif
> >         /* Effective size of kernel image */
> >         .dword _end - _start
> > @@ -94,6 +88,8 @@ relocate:
> >         la a1, kernel_map
> >         XIP_FIXUP_OFFSET a1
> >         REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
> > +       li a2, LOAD_OFFSET
> > +       add a1, a1, a2
> >         la a2, _start
> >         sub a1, a1, a2
> >         add ra, ra, a1
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index 5104f3a871e3..75b7c72cd4bd 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -11,10 +11,9 @@
> >  #else
> >
> >  #include <asm/pgtable.h>
> > -#define LOAD_OFFSET KERNEL_LINK_ADDR
> >
> > -#include <asm/vmlinux.lds.h>
> >  #include <asm/page.h>
> > +#include <asm/vmlinux.lds.h>
> >  #include <asm/cache.h>
> >  #include <asm/thread_info.h>
> >  #include <asm/set_memory.h>
> > @@ -32,7 +31,7 @@ PECOFF_FILE_ALIGNMENT = 0x200;
> >  SECTIONS
> >  {
> >         /* Beginning of code and text segment */
> > -       . = LOAD_OFFSET;
> > +       . = LOAD_OFFSET + KERNEL_LINK_ADDR;
> >         _start = .;
> >         HEAD_TEXT_SECTION
> >         . = ALIGN(PAGE_SIZE);
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 24b2b8044602..920e78f8c3e4 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -221,6 +221,11 @@ static void __init setup_bootmem(void)
> >         if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> >                 memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> >
> > +       /*
> > +        * Reserve OpenSBI region and depends on PMP to deny accesses.
> > +        */
> > +       memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
> > +
> >         early_init_fdt_scan_reserved_mem();
> >         dma_contiguous_reserve(dma32_phys_limit);
> >         if (IS_ENABLED(CONFIG_64BIT))
> > @@ -604,7 +609,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >
> >         kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
> >  #else
> > -       kernel_map.phys_addr = (uintptr_t)(&_start);
> > +       kernel_map.phys_addr = (uintptr_t)(&_start) - LOAD_OFFSET;
> >         kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
> >  #endif
> >         kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> > @@ -645,8 +650,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >         create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> >                            kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
> >  #else
> > -       create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> > -                          kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
> > +       create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr + LOAD_OFFSET,
> > +                          kernel_map.phys_addr + LOAD_OFFSET, PMD_SIZE, PAGE_KERNEL_EXEC);
> >  #endif
> >  #else
> >         /* Setup trampoline PGD */
> > --
> > 2.25.1
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
