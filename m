Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB53CB0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhGPCZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhGPCZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:25:36 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E3CC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:22:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a16so12368046ybt.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcGnhbgGNOyTIUDh5SucoyI65bVLgGCSLNQx1HGY7GY=;
        b=otqrJJIZByY9gd3geezqoyVsJMv/IvEZq8Js39EoGePHL4zZ2cHE9ToRjHVGUp2gWm
         tqiSpB8972dgJzF7QarpCka/+6FD5zesTleAYoRAA29Y2QFhoP34DSoV4phccxSMc/yS
         ft9iGcScr8JDLaWJ9IRN2Jas2jYL9zeTfNe4U9g1oiu5Zbrfam4POkGrBmg9Yn1tBPqZ
         E2pZcl6yP9vUX+ePV2kZDYXe0FBja8b/0Fs9ft42CanAjWLdvlI74TqkEFjeBLMZsPjn
         hh8k/ydAil66c/7sS0SV8kWBAtS7XPYCfo1OZPRToxqjHJfIJdAci5KdsngjzkpZOghZ
         wugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcGnhbgGNOyTIUDh5SucoyI65bVLgGCSLNQx1HGY7GY=;
        b=K96osVPe6uE9zqQl2Q8MFcLMvny/xdLY0hAxK4cPlBRkoQPcV4smtMDhhu+YYOcTLD
         JWZulIxRjIj3Jyzcs0yaC7COSSbRcXsGDgmOeKScOIhaikvhEWIAHkqK4H33yZUhlX6N
         pzGhdO/55j69o+QDfezVzZr386IQmwX4M/6eCkpcW7I9Sag7C1HOBTGLs78TFPKs+L2J
         ZbPcUMXQ/o85hNZL1dX60jBud69+JmXe6w8igDpcCb62GzdAqC1A1goQcnX7i4qy14Ke
         4+cz0h0ZQjwDs5ibtSHZSPTz5mTZSmCTR5QNOjXecy8K77rhDUeKUsXzUEFMu9D42g5w
         5r9g==
X-Gm-Message-State: AOAM532s+l46m1NlxIPtzqdVXDAhTxIo2HXpf65i3OFhU+8C1ijtaHa4
        sfN1U38WLiQrGF9f19QBqs2rAaYrU94m6M2JrjU=
X-Google-Smtp-Source: ABdhPJzsAioQ40CSJOi/XmSMDlA7Q5z9hpj1SgegYHELGXmn9X9rYg94iYbey9lKIOAoc5PngRWhjVNRR7dujx8REwg=
X-Received: by 2002:a25:b701:: with SMTP id t1mr9236770ybj.517.1626402160698;
 Thu, 15 Jul 2021 19:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-423e8bdb-977e-4b99-a1bb-b8c530664a51@palmerdabbelt-glaptop>
In-Reply-To: <mhng-423e8bdb-977e-4b99-a1bb-b8c530664a51@palmerdabbelt-glaptop>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 16 Jul 2021 10:22:28 +0800
Message-ID: <CAEUhbmX6QD+ncgUS8g5yQMm0A5aPAAHcmsfBty6eWupeut+SSA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.14 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Fri, Jul 9, 2021 at 10:54 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> The following changes since commit 8a4102a0cf07cc76a18f373f6b49485258cc6af4:
>
>   riscv: mm: Fix W+X mappings at boot (2021-06-01 21:15:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-mw0
>
> for you to fetch changes up to 1958e5aef5098e28b7d6e6a2972649901ebecace:
>
>   riscv: xip: Fix duplicate included asm/pgtable.h (2021-07-06 16:17:40 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.14 Merge Window, Part 1
>
> In addition to We have a handful of new features for 5.14:
>
> * Support for transparent huge pages.
> * Support for generic PCI resources mapping.
> * Support for the mem= kernel parameter.
> * Support for KFENCE.
> * A handful of fixes to avoid W+X mappings in the kernel.
> * Support for VMAP_STACK based overflow detection.
> * An optimized copy_{to,from}_user.
> ----------------------------------------------------------------
> There are some Kconfig merge conflicts.  They should be pretty
> straight-forward, but we do have a symbol out of order -- I thought I had a
> script to check for that, but I guess it doesn't work.  I just sent out a patch
> to fix it up.
>
> diff --cc arch/riscv/Kconfig
> index 3590eb76000e,469a70bd8da6..d36f3c5029fd
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@@ -60,12 -61,11 +61,12 @@@ config RISC
>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>         select HANDLE_DOMAIN_IRQ
>         select HAVE_ARCH_AUDITSYSCALL
> -       select HAVE_ARCH_JUMP_LABEL
> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>         select HAVE_ARCH_KASAN if MMU && 64BIT
>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>  +      select HAVE_ARCH_KFENCE if MMU && 64BIT
> -       select HAVE_ARCH_KGDB
> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
>         select HAVE_ARCH_KGDB_QXFER_PKT
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>         select HAVE_ARCH_SECCOMP_FILTER
> @@@ -81,11 -80,9 +82,14 @@@
>         select HAVE_GCC_PLUGINS
>         select HAVE_GENERIC_VDSO if MMU && 64BIT
>         select HAVE_IRQ_TIME_ACCOUNTING
>  +      select HAVE_KPROBES
>  +      select HAVE_KPROBES_ON_FTRACE
>  +      select HAVE_KRETPROBES
> +       select HAVE_KPROBES if !XIP_KERNEL
> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> +       select HAVE_KRETPROBES if !XIP_KERNEL
>  +      select HAVE_MOVE_PMD
>  +      select HAVE_MOVE_PUD
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
> @@@ -108,7 -104,7 +112,8 @@@
>         select SYSCTL_EXCEPTION_TRACE
>         select THREAD_INFO_IN_TASK
>         select UACCESS_MEMCPY if !MMU
>  +      select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> +       select ZONE_DMA32 if 64BIT
>
>   config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> ----------------------------------------------------------------
> Akira Tsukamoto (1):
>       riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
>
> Alexandre Ghiti (6):
>       riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
>       riscv: Simplify xip and !xip kernel address conversion macros
>       riscv: Introduce set_kernel_memory helper
>       riscv: Map the kernel with correct permissions the first time
>       riscv: Introduce structure that group all variables regarding kernel mapping
>       riscv: Fix PTDUMP output now BPF region moved back to module region
>
> Bixuan Cui (1):
>       riscv: fix build error when CONFIG_SMP is disabled
>
> Christoph Hellwig (1):
>       riscv: pass the mm_struct to __sbi_tlb_flush_range
>
> Guo Ren (3):
>       riscv: Use global mappings for kernel pages
>       riscv: Cleanup unused functions
>       riscv: add ASID-based tlbflushing methods
>
> Jeff Xie (1):
>       riscv: ptrace: add argn syntax
>
> Jiapeng Chong (1):
>       riscv: xip: Fix duplicate included asm/pgtable.h
>
> Jisheng Zhang (7):
>       riscv: mremap speedup - enable HAVE_MOVE_PUD and HAVE_MOVE_PMD
>       riscv: mm: Remove setup_zero_page()
>       riscv: Optimize switch_mm by passing "cpu" to flush_icache_deferred()
>       riscv: Turn has_fpu into a static key if FPU=y
>       riscv: kprobes: Remove redundant kprobe_step_ctx
>       riscv: Add __init section marker to some functions again
>       riscv: mm: init: Consolidate vars, functions
>
> Kefeng Wang (5):
>       riscv: Move setup_bootmem into paging_init
>       riscv: mm: Drop redundant _sdata and _edata declaration
>       riscv: mm: Use better bitmap_zalloc()
>       riscv: Only initialize swiotlb when necessary
>       riscv: Add mem kernel parameter support

This patch should not be merged as it mixed two things into one patch,
as discussed here:
http://lists.infradead.org/pipermail/linux-riscv/2021-July/007486.html

You remained silent on my "ping", sigh ...

>
> Liu Shixin (1):
>       riscv: Enable KFENCE for riscv64
>
> Nanyong Sun (5):
>       riscv: mm: add _PAGE_LEAF macro
>       riscv: mm: make pmd_bad() check leaf condition
>       riscv: mm: add param stride for __sbi_tlb_flush_range
>       riscv: mm: add THP support on 64-bit
>       riscv: mm: fix build errors caused by mk_pmd()
>
> Palmer Dabbelt (2):
>       RISC-V: Use asm-generic for {in,out}{bwlq}
>       Merge branch 'riscv-wx-mappings' into for-next
>
> Randy Dunlap (1):
>       riscv: TRANSPARENT_HUGEPAGE: depends on MMU
>
> Stanislaw Kardach (1):
>       riscv: enable generic PCI resource mapping
>
> Tong Tiangen (1):
>       riscv: add VMAP_STACK overflow detection
>
> Vitaly Wool (1):
>       riscv: fix typo in init.c

Regards,
Bin
