Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0D459ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 04:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhKWD7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 22:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWD7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:59:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:56:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 137so13874265wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbYyFnbPmkgrQrlw4urINtBSHt+A48GB7ljtOsMPFgM=;
        b=Bxy7/TU9pGrA6C4yzYaDzlDtZDzXpr6L3TXKDg6avhbUj5cv8DHux/+S2RVXuQFrCi
         blQ8Ekg4K4TDAA5maRbVp+U5+C5Nq5ywcxso2mcgeK+lUu3ZhZFJroDnBKYj/Pe+35nj
         ghyqJifqWLL6F1Bq37R+R6/r0xWsiOc4dEebjp5enMWSp5t4MQqQmRH9KGNmdkeqRDj7
         r8SiF8kS5GsCDR9sjjaTwlMglcrV0Q7P5Kc4A7js1VO/BDkgm8YNWoTwbhtflT2ohsVa
         2vjixfVQtrJvDKg8ax+LLouvcB9iOLIU+JNtskHuGU0bi+GiNww03/XVsloujTYw63wW
         aSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbYyFnbPmkgrQrlw4urINtBSHt+A48GB7ljtOsMPFgM=;
        b=nb0VOVT64MkFzWf/e0eKydPX46aCkA71pqqOCFu3SCGt1foBKi/DIfKkFeldoeghjH
         5XOh/PJN+3KVdS0VZtN4QVoGoRAOXoygFkQ+fZyKFCN4pQKhattwGOHITUDyM/zGXcZb
         jgf8mRNVWmtPIOlH9BK5tHw+3BtqH60msP1hvuZhZBra5Rj9qoLcjZRyKVZVSUh2cRUJ
         7S5WdUvo4t0t13eZhwn2Qi8iBEYFIVU7CCD4q8k5x/uYUcYDmOWdyofMmpk58Rnh4Fzo
         SfPIv4A/8aN+U43lUm2FJ74bjWDLA9pzpuOMVaMr9A/8tk2ddM9O/TyYfikf5szIqjxK
         RsLQ==
X-Gm-Message-State: AOAM5311zCM7Z1PiRQ3JNugbwASUtnmAd+iIpUH8TOh0F1S/7jGCARfi
        y1iZ9dQ0D1VP5Kn8ZSC9gF4SIKtdYinTWyGjsuWIEg==
X-Google-Smtp-Source: ABdhPJxbmLSK0FMbEk6SIjAna1Y09Eya7/is9oohFf5JdZKW95Wp9FtEFCgUvS6DRHyvIQsUlU91u230P9etWrvFcZo=
X-Received: by 2002:a7b:c017:: with SMTP id c23mr3073023wmb.137.1637639781581;
 Mon, 22 Nov 2021 19:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <20211123015717.542631-2-guoren@kernel.org>
In-Reply-To: <20211123015717.542631-2-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 23 Nov 2021 09:26:10 +0530
Message-ID: <CAAhSdy0LWyhgXetiXikCosSX4xasgROyua6XMd92dV8TiWp62w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] riscv: Remove 2MB offset in the mm layout
To:     Guo Ren <guoren@kernel.org>
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

+Alex

On Tue, Nov 23, 2021 at 7:27 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current RISC-V's mm layout is based on a 2MB offset and wasting
> memory. Remove 2MB offset and map PAGE_OFFSET at start_of_DRAM.
> Then we could reduce the memory reserved for opensbi in the next
> patch.

The real problem is that the generic kernel marks memory before
__pa(PAGE_OFFSET) as reserved which is evident from the boot
print "OF: fdt: Ignoring memory range 0x80000000 - 0x80200000".

One simple way to re-claim the first 2MB of memory is by:
1) Not placing OpenSBI firmware at start of RAM and rather
place it towards end/middle or RAM away from kernel and initrd
2) Load kernel at start of the RAM

The point#1 is already supported by OpenSBI firmwares using
position independent compilation. In fact, U-Boot SPL does
not load OpenSBI firmware at the start of RAM.

I would suggest Allwinner D1 to follow U-Boot SPL and have
the booting stage before OpenSBI to load OpenSBI firmware
somewhere else.

Regards,
Anup

>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/page.h   |  8 ++++++++
>  arch/riscv/kernel/head.S        | 10 +++-------
>  arch/riscv/kernel/vmlinux.lds.S |  5 ++---
>  arch/riscv/mm/init.c            | 11 ++++++++---
>  4 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index b3e5ff0125fe..299147c78b4a 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -16,6 +16,14 @@
>  #define PAGE_SIZE      (_AC(1, UL) << PAGE_SHIFT)
>  #define PAGE_MASK      (~(PAGE_SIZE - 1))
>
> +#if __riscv_xlen == 64
> +/* Image load offset(2MB) from start of RAM */
> +#define LOAD_OFFSET    0x200000
> +#else
> +/* Image load offset(4MB) from start of RAM */
> +#define LOAD_OFFSET    0x400000
> +#endif
> +
>  #ifdef CONFIG_64BIT
>  #define HUGE_MAX_HSTATE                2
>  #else
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index f52f01ecbeea..a6ac892d2ccf 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -61,13 +61,7 @@ ENTRY(_start)
>         /* Image load offset (0MB) from start of RAM for M-mode */
>         .dword 0
>  #else
> -#if __riscv_xlen == 64
> -       /* Image load offset(2MB) from start of RAM */
> -       .dword 0x200000
> -#else
> -       /* Image load offset(4MB) from start of RAM */
> -       .dword 0x400000
> -#endif
> +       .dword LOAD_OFFSET
>  #endif
>         /* Effective size of kernel image */
>         .dword _end - _start
> @@ -94,6 +88,8 @@ relocate:
>         la a1, kernel_map
>         XIP_FIXUP_OFFSET a1
>         REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
> +       li a2, LOAD_OFFSET
> +       add a1, a1, a2
>         la a2, _start
>         sub a1, a1, a2
>         add ra, ra, a1
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 5104f3a871e3..75b7c72cd4bd 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -11,10 +11,9 @@
>  #else
>
>  #include <asm/pgtable.h>
> -#define LOAD_OFFSET KERNEL_LINK_ADDR
>
> -#include <asm/vmlinux.lds.h>
>  #include <asm/page.h>
> +#include <asm/vmlinux.lds.h>
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
>  #include <asm/set_memory.h>
> @@ -32,7 +31,7 @@ PECOFF_FILE_ALIGNMENT = 0x200;
>  SECTIONS
>  {
>         /* Beginning of code and text segment */
> -       . = LOAD_OFFSET;
> +       . = LOAD_OFFSET + KERNEL_LINK_ADDR;
>         _start = .;
>         HEAD_TEXT_SECTION
>         . = ALIGN(PAGE_SIZE);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 24b2b8044602..920e78f8c3e4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -221,6 +221,11 @@ static void __init setup_bootmem(void)
>         if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>                 memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>
> +       /*
> +        * Reserve OpenSBI region and depends on PMP to deny accesses.
> +        */
> +       memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
> +
>         early_init_fdt_scan_reserved_mem();
>         dma_contiguous_reserve(dma32_phys_limit);
>         if (IS_ENABLED(CONFIG_64BIT))
> @@ -604,7 +609,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>
>         kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
>  #else
> -       kernel_map.phys_addr = (uintptr_t)(&_start);
> +       kernel_map.phys_addr = (uintptr_t)(&_start) - LOAD_OFFSET;
>         kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
>  #endif
>         kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> @@ -645,8 +650,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
>                            kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
>  #else
> -       create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> -                          kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
> +       create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr + LOAD_OFFSET,
> +                          kernel_map.phys_addr + LOAD_OFFSET, PMD_SIZE, PAGE_KERNEL_EXEC);
>  #endif
>  #else
>         /* Setup trampoline PGD */
> --
> 2.25.1
>
