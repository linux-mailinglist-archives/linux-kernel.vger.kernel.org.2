Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0180320B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBUPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhBUPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:39:14 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7662C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:38:31 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e15so7559214qte.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GKaoGR/KXVQs4D+Moaoy5AaMPodEWc16wY0BNQoFag=;
        b=ROTfgQfNz1rCye1xd3kcex7CsikFHCq4FPx79+ONWYSEfTzCkNOU2o8lq0KDTeZWk+
         gv1dPsHH+lqqIA8x7Yr8pZ/oi6ARknsk+JJqjC3gCnOVOmQTWFbJ09in+qD3kjlF7uLm
         b39WcYsFfEWOlP0du7C/FAedCr9kTRHv89MNL4qRL5jdVxKPbzaFSczjxFCK52G+GjWc
         jERgNJZS5+hLyqizpVgjdWl+6DJMedkoS4m7HU5XRnWIP8xMkJowdu66KrFHqmj7/IQ5
         Wt7hXWOg+IsOGLPPaogd2LLeaq0BG9juGh1A2rz1Ku4mQBCo7o4HU3EVja2yYb+i+LkV
         T54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GKaoGR/KXVQs4D+Moaoy5AaMPodEWc16wY0BNQoFag=;
        b=jAeT7wl4w9K1Bdc5h3CXoWzExxAqchbw/Ip1GHF3rLBlyDX4bH5krK9meXpktupAeJ
         ncmVsWnC7RIyUtIhnrYSoR971FkN3rgVFY0Q3+DHrUF/E9UOt1EqlrhaVR4G64G+BSE3
         9MTJ0jfDNGN1bKvffx7Fv3lmqqg3Bq8PZZbPDKUORBcFM66HfK48zIV0WRkUAFSl2fjx
         SNWumbvlrTFMunFOzSi0WTOvSzkO1PbVYuu0UegGDDYr3llvhMvS5p3amiG0BL8Cqm8h
         74Yb3HRZzj1aYmCshgwPM0X0jHFCEvrJ7I0MQAppWQg3qSkkOdB5PWqZA8+znXuztijU
         n4cg==
X-Gm-Message-State: AOAM532sPOr05HjC7RXUO3B3ALhv2OfMkVuPhy6QjROkxlFd07yfWkUh
        OqLSKzKT6Hja1j2WoTBmSzrwqxe5pQiScDYyjamDYKVGJ7JuDw==
X-Google-Smtp-Source: ABdhPJw/NiOpFR5jg8h1f+PTLGcbyf+j0YjorHfz4N81OkCwtHyksWxjcW/X3GeWitKoQXpZ62xBLmCkvgS6/EWpVZ0=
X-Received: by 2002:ac8:7512:: with SMTP id u18mr16425751qtq.290.1613921910580;
 Sun, 21 Feb 2021 07:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20210221142233.3661-1-alex@ghiti.fr>
In-Reply-To: <20210221142233.3661-1-alex@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 21 Feb 2021 16:38:19 +0100
Message-ID: <CACT4Y+Y9Ax=3XnE1NaN1+Qz7oh209nncz7xULQ2Tf8BmUqmVAw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Get rid of MAX_EARLY_MAPPING_SIZE
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 3:22 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> At early boot stage, we have a whole PGDIR to map the kernel, so there
> is no need to restrict the early mapping size to 128MB. Removing this
> define also allows us to simplify some compile time logic.
>
> This fixes large kernel mappings with a size greater than 128MB, as it
> is the case for syzbot kernels whose size was just ~130MB.
>
> Note that on rv64, for now, we are then limited to PGDIR size for early
> mapping as we can't use PGD mappings (see [1]). That should be enough
> given the relative small size of syzbot kernels compared to PGDIR_SIZE
> which is 1GB.
>
> [1] https://lore.kernel.org/lkml/20200603153608.30056-1-alex@ghiti.fr/

I've applied this patch to (as it contains the HEAD fix):

commit f49815047c1a3e3644a0ba38f3825c5cde8a0922 (HEAD, riscv/for-next)
Author: Tobias Klauser <tklauser@distanz.ch>
Date:   Tue Feb 16 18:33:05 2021 +0100
    riscv: Disable KSAN_SANITIZE for vDSO

and the kernel started booting with my large config.
It quickly crashed (see below), but at least it started booting, so
it's an improvement.

Tested-by: Dmitry Vyukov <dvyukov@google.com>

Linux version 5.11.0-rc2-00069-gf49815047c1a-dirty
(dvyukov@dvyukov-desk.muc.corp.google.com) (riscv64-linux-gnu-gcc
(Debian 10.2.1-6+build1) 10.2.1 20210110, GNU ld (GNU Binutils for
Debian) 2.35.1) #34 SMP PREEMPT Sun Feb 21 15:51:40 CET 2021
OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
Machine model: riscv-virtio,qemu
earlycon: ns16550a0 at MMIO 0x0000000010000000 (options '')
printk: bootconsole [ns16550a0] enabled
efi: UEFI not found.
cma: Reserved 16 MiB at 0x00000000fec00000
Zone ranges:
  DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080200000-0x00000000ffffffff]
Zeroed struct page in unavailable ranges: 512 pages
Initmem setup node 0 [mem 0x0000000080200000-0x00000000ffffffff]
SBI specification v0.2 detected
SBI implementation ID=0x1 Version=0x8
SBI v0.2 TIME extension detected
SBI v0.2 IPI extension detected
SBI v0.2 RFENCE extension detected
software IO TLB: mapped [mem 0x00000000f7c00000-0x00000000fbc00000] (64MB)
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4085
lockdep_hardirqs_on_prepare+0x384/0x388 kernel/locking/lockdep.c:4085
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-rc2-00069-gf49815047c1a-dirty #34
Hardware name: riscv-virtio,qemu (DT)
epc : lockdep_hardirqs_on_prepare+0x384/0x388 kernel/locking/lockdep.c:4085
 ra : lockdep_hardirqs_on_prepare+0x384/0x388 kernel/locking/lockdep.c:4085
epc : ffffffe0000c125a ra : ffffffe0000c125a sp : ffffffe006603ce0
 gp : ffffffe006c338f0 tp : ffffffe006689e00 t0 : ffffffe00669a9a8
 t1 : ffffffc400cc0738 t2 : 0000000000000000 s0 : ffffffe006603d20
 s1 : ffffffe006689e00 a0 : 000000000000002d a1 : 00000000000f0000
 a2 : 0000000000000002 a3 : ffffffe0000d2718 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe0066039c7
 s2 : ffffffe004a337c0 s3 : ffffffe0076fa1b8 s4 : 0000000000000000
 s5 : ffffffe006689e00 s6 : 0000000000000001 s7 : ffffffe07fcfc000
 s8 : ffffffe07fcfd000 s9 : ffffffe006c3c0d0 s10: fffffffffffff000
 s11: ffffffe004a1fbb8 t3 : 000000002d2d2d2d t4 : ffffffc400cc0737
 t5 : ffffffc400cc0739 t6 : ffffffe0066039c8
status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
Call Trace:
[<ffffffe0000c125a>] lockdep_hardirqs_on_prepare+0x384/0x388
kernel/locking/lockdep.c:4085
[<ffffffe0001b7dc0>] trace_hardirqs_on+0x116/0x174
kernel/trace/trace_preemptirq.c:49
[<ffffffe00000550a>] _save_context+0xa2/0xe2
[<ffffffe004807908>] local_flush_tlb_all
arch/riscv/include/asm/tlbflush.h:16 [inline]
[<ffffffe004807908>] populate arch/riscv/mm/kasan_init.c:95 [inline]
[<ffffffe004807908>] kasan_init+0x23e/0x31a arch/riscv/mm/kasan_init.c:157
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<0000000000000000>] 0x0
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
random: get_random_bytes called from init_oops_id kernel/panic.c:546
[inline] with crng_init=0
random: get_random_bytes called from init_oops_id kernel/panic.c:543
[inline] with crng_init=0
random: get_random_bytes called from print_oops_end_marker
kernel/panic.c:556 [inline] with crng_init=0
random: get_random_bytes called from __warn+0x1be/0x20a
kernel/panic.c:613 with crng_init=0
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfffffc810040000
Oops [#1]
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W
5.11.0-rc2-00069-gf49815047c1a-dirty #34
Hardware name: riscv-virtio,qemu (DT)
epc : __memset+0x60/0xfc arch/riscv/lib/memset.S:67
 ra : populate arch/riscv/mm/kasan_init.c:96 [inline]
 ra : kasan_init+0x256/0x31a arch/riscv/mm/kasan_init.c:157
epc : ffffffe001791cf0 ra : ffffffe004807920 sp : ffffffe006603e80
 gp : ffffffe006c338f0 tp : ffffffe006689e00 t0 : dfffffc810040000
 t1 : ffffffe004a1fc80 t2 : 0000000000000000 s0 : ffffffe006603f30
 s1 : 0000000000000001 a0 : dfffffc810040000 a1 : 0000000000000000
 a2 : 000000000ffc0000 a3 : dfffffc820000000 a4 : 0000000000000000
 a5 : dfffffc820000000 a6 : 0000000000f00000 a7 : ffffffe004a1fcaf
 s2 : dfffffc810040000 s3 : 000000000000ffc0 s4 : dfffffc800000000
 s5 : ffffffe006c46908 s6 : 0000000000000001 s7 : ffffffe07fcfc000
 s8 : ffffffe07fcfd000 s9 : ffffffe006c3c0d0 s10: fffffffffffff000
 s11: ffffffe004a1fbb8 t3 : 0000000000000000 t4 : 0000000000000001
 t5 : ffffffc400943f96 t6 : ffffffe006603b98
status: 0000000000000100 badaddr: dfffffc810040000 cause: 000000000000000f
Call Trace:
[<ffffffe001791cf0>] __memset+0x60/0xfc arch/riscv/lib/memset.S:65
[<ffffffe004805e7a>] setup_arch+0x6c4/0x6f2 arch/riscv/kernel/setup.c:271
[<ffffffe0048010ea>] start_kernel+0xca/0x5d6 init/main.c:871
---[ end trace f68728a0d3053b52 ]---





> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f9f9568d689e..f81f813b9603 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -226,8 +226,6 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>
> -#define MAX_EARLY_MAPPING_SIZE SZ_128M
> -
>  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
> @@ -302,13 +300,7 @@ static void __init create_pte_mapping(pte_t *ptep,
>
>  pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -
> -#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
> -#define NUM_EARLY_PMDS         1UL
> -#else
> -#define NUM_EARLY_PMDS         (1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
> -#endif
> -pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>  pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> @@ -330,11 +322,9 @@ static pmd_t *get_pmd_virt_late(phys_addr_t pa)
>
>  static phys_addr_t __init alloc_pmd_early(uintptr_t va)
>  {
> -       uintptr_t pmd_num;
> +       BUG_ON((va - PAGE_OFFSET) >> PGDIR_SHIFT);
>
> -       pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> -       BUG_ON(pmd_num >= NUM_EARLY_PMDS);
> -       return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
> +       return (uintptr_t)early_pmd;
>  }
>
>  static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
> @@ -452,7 +442,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         uintptr_t va, pa, end_va;
>         uintptr_t load_pa = (uintptr_t)(&_start);
>         uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
> -       uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
> +       uintptr_t map_size;
>  #ifndef __PAGETABLE_PMD_FOLDED
>         pmd_t fix_bmap_spmd, fix_bmap_epmd;
>  #endif
> @@ -464,12 +454,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>          * Enforce boot alignment requirements of RV32 and
>          * RV64 by only allowing PMD or PGD mappings.
>          */
> -       BUG_ON(map_size == PAGE_SIZE);
> +       map_size = PMD_SIZE;
>
>         /* Sanity check alignment and size */
>         BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>         BUG_ON((load_pa % map_size) != 0);
> -       BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
>
>         pt_ops.alloc_pte = alloc_pte_early;
>         pt_ops.get_pte_virt = get_pte_virt_early;
> --
> 2.20.1
>
