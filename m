Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C63C3ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhGKSsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhGKSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 14:48:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E094C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 11:45:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 17so14114340pfz.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5y1tL51+g8bJ9zeGQFl1MfXlU0HHxxQ0UWkz+es+DiE=;
        b=GNCK6j+GAwZx7Z4ROndJ5bUk8gI9KZFMdRMheDSu3LOMbl9Q7juZFhr6P17jjl6yJb
         oFMNPj/68Kw9pioeZKpJDeToyNxo3IjPFOH75HBzK7wUeSNkMtl+mYzfq3p0RfNoGRiD
         m09Z87ByURlSDM48pdNPTZYHmVNB+TIQiVXfRVf8gwJ4TpNycfRTTz5BQDpZR/NX5dls
         NS6V2196U3/RgI5YjgSarokMyd1VDomUHvIsyzvtf9VSNpRR6Vua24ETpq9Nb1nBFjRT
         bs5Xx45muJMscO1qVAAPPZGR/dM2gcVqn3YMwVLSp/dIMJjJCKySWS5H4cdnMSRaga4i
         t4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5y1tL51+g8bJ9zeGQFl1MfXlU0HHxxQ0UWkz+es+DiE=;
        b=k8W1BIVRN5ZXtwftIwQlKwKppurIenZdZTzRO76ugXwKhQ0uWDJd4WKX+V/zx+elwA
         VGZHPNwfYMKF7Ta3KZZ+syQRrsc929U89YHSR+o+OLng3KgV/weQ/rC7ZVRDltZvf7ay
         Ud0C9/w/p3rhn4qrunVxZw4fUx5EA8b8f+eITN5UFcNKlgvce/wqtJNQpF6W3Jp95xnh
         pPQYwE5zcpnuktYK5nQBko6kPbd8fhFecCZJJhWero9AMT5Gtr1iwJSkJJHA9MgVOzKD
         1YILzWIhG4ELlyzqjGl+vyYvft3GcYty5UPOPEWeXWCXsBPmT8Jpr/r/oyegcsd59Uh3
         6j5w==
X-Gm-Message-State: AOAM533qJhQHoNcKK/Elvju/yJStjgB3dkec7VXiN/KyFENaM2Xt8AuR
        prplwWpkGeiuXklqU/dGuNwd7w==
X-Google-Smtp-Source: ABdhPJyhpoOuu7Xwzpb7zWRykfLgqIVpPKjjN2XJU/C6L4pWHHSklmF/06NJwGo89p70BX5gAtSACg==
X-Received: by 2002:a63:4b23:: with SMTP id y35mr49632787pga.179.1626029134576;
        Sun, 11 Jul 2021 11:45:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n6sm6636576pgb.60.2021.07.11.11.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 11:45:33 -0700 (PDT)
Date:   Sun, 11 Jul 2021 11:45:33 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Jul 2021 11:45:31 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.14 Merge Window, Part 1
In-Reply-To: <df700c15-a7b6-5a0d-6ebd-484ecc8c7923@ghiti.fr>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-90f1c895-95b6-4480-937d-ee859a4542c3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jul 2021 12:58:10 PDT (-0700), alex@ghiti.fr wrote:
>
>
> Le 9/07/2021 à 16:53, Palmer Dabbelt a écrit :
>> The following changes since commit 8a4102a0cf07cc76a18f373f6b49485258cc6af4:
>>
>>    riscv: mm: Fix W+X mappings at boot (2021-06-01 21:15:09 -0700)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-mw0
>>
>> for you to fetch changes up to 1958e5aef5098e28b7d6e6a2972649901ebecace:
>>
>>    riscv: xip: Fix duplicate included asm/pgtable.h (2021-07-06 16:17:40 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 5.14 Merge Window, Part 1
>>
>> In addition to We have a handful of new features for 5.14:
>>
>> * Support for transparent huge pages.
>> * Support for generic PCI resources mapping.
>> * Support for the mem= kernel parameter.
>> * Support for KFENCE.
>> * A handful of fixes to avoid W+X mappings in the kernel.
>> * Support for VMAP_STACK based overflow detection.
>> * An optimized copy_{to,from}_user.
>> ----------------------------------------------------------------
>> There are some Kconfig merge conflicts.  They should be pretty
>> straight-forward, but we do have a symbol out of order -- I thought I had a
>> script to check for that, but I guess it doesn't work.  I just sent out a patch
>> to fix it up.
>>
>> diff --cc arch/riscv/Kconfig
>> index 3590eb76000e,469a70bd8da6..d36f3c5029fd
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@@ -60,12 -61,11 +61,12 @@@ config RISC
>>          select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>>          select HANDLE_DOMAIN_IRQ
>>          select HAVE_ARCH_AUDITSYSCALL
>> -       select HAVE_ARCH_JUMP_LABEL
>> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>>          select HAVE_ARCH_KASAN if MMU && 64BIT
>>          select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>>   +      select HAVE_ARCH_KFENCE if MMU && 64BIT
>> -       select HAVE_ARCH_KGDB
>> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
>>          select HAVE_ARCH_KGDB_QXFER_PKT
>>          select HAVE_ARCH_MMAP_RND_BITS if MMU
>>          select HAVE_ARCH_SECCOMP_FILTER
>> @@@ -81,11 -80,9 +82,14 @@@
>>          select HAVE_GCC_PLUGINS
>>          select HAVE_GENERIC_VDSO if MMU && 64BIT
>>          select HAVE_IRQ_TIME_ACCOUNTING
>>   +      select HAVE_KPROBES
>>   +      select HAVE_KPROBES_ON_FTRACE
>>   +      select HAVE_KRETPROBES
>> +       select HAVE_KPROBES if !XIP_KERNEL
>> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>> +       select HAVE_KRETPROBES if !XIP_KERNEL
>>   +      select HAVE_MOVE_PMD
>>   +      select HAVE_MOVE_PUD
>>          select HAVE_PCI
>>          select HAVE_PERF_EVENTS
>>          select HAVE_PERF_REGS
>> @@@ -108,7 -104,7 +112,8 @@@
>>          select SYSCTL_EXCEPTION_TRACE
>>          select THREAD_INFO_IN_TASK
>>          select UACCESS_MEMCPY if !MMU
>>   +      select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
>> +       select ZONE_DMA32 if 64BIT
>>
>>    config ARCH_MMAP_RND_BITS_MIN
>>          default 18 if 64BIT
>> ----------------------------------------------------------------
>> Akira Tsukamoto (1):
>>        riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
>>
>> Alexandre Ghiti (6):
>>        riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
>>        riscv: Simplify xip and !xip kernel address conversion macros
>
> @Palmer: As said in the thread of this patchset multiple times, those 2
> patches should not be merged as it assumes that the base DRAM address is
> always 0x8000_0000 for all rv64 platforms: I don't think it is true, is it?

Sorry, I remember saying something about that but must have missed the 
resposeses.  Do you have a pointer to the discussion?  If this break 
stuff I'm happy to revert it, which can be done post-rc1.  I just need 
to see what's actually broken first, because IIUC this was de-facto how 
things worked already.

>
>>        riscv: Introduce set_kernel_memory helper
>>        riscv: Map the kernel with correct permissions the first time
>>        riscv: Introduce structure that group all variables regarding kernel mapping
>>        riscv: Fix PTDUMP output now BPF region moved back to module region
>>
>> Bixuan Cui (1):
>>        riscv: fix build error when CONFIG_SMP is disabled
>>
>> Christoph Hellwig (1):
>>        riscv: pass the mm_struct to __sbi_tlb_flush_range
>>
>> Guo Ren (3):
>>        riscv: Use global mappings for kernel pages
>>        riscv: Cleanup unused functions
>>        riscv: add ASID-based tlbflushing methods
>>
>> Jeff Xie (1):
>>        riscv: ptrace: add argn syntax
>>
>> Jiapeng Chong (1):
>>        riscv: xip: Fix duplicate included asm/pgtable.h
>>
>> Jisheng Zhang (7):
>>        riscv: mremap speedup - enable HAVE_MOVE_PUD and HAVE_MOVE_PMD
>>        riscv: mm: Remove setup_zero_page()
>>        riscv: Optimize switch_mm by passing "cpu" to flush_icache_deferred()
>>        riscv: Turn has_fpu into a static key if FPU=y
>>        riscv: kprobes: Remove redundant kprobe_step_ctx
>>        riscv: Add __init section marker to some functions again
>>        riscv: mm: init: Consolidate vars, functions
>>
>> Kefeng Wang (5):
>>        riscv: Move setup_bootmem into paging_init
>>        riscv: mm: Drop redundant _sdata and _edata declaration
>>        riscv: mm: Use better bitmap_zalloc()
>>        riscv: Only initialize swiotlb when necessary
>>        riscv: Add mem kernel parameter support
>>
>> Liu Shixin (1):
>>        riscv: Enable KFENCE for riscv64
>>
>> Nanyong Sun (5):
>>        riscv: mm: add _PAGE_LEAF macro
>>        riscv: mm: make pmd_bad() check leaf condition
>>        riscv: mm: add param stride for __sbi_tlb_flush_range
>>        riscv: mm: add THP support on 64-bit
>>        riscv: mm: fix build errors caused by mk_pmd()
>>
>> Palmer Dabbelt (2):
>>        RISC-V: Use asm-generic for {in,out}{bwlq}
>>        Merge branch 'riscv-wx-mappings' into for-next
>>
>> Randy Dunlap (1):
>>        riscv: TRANSPARENT_HUGEPAGE: depends on MMU
>>
>> Stanislaw Kardach (1):
>>        riscv: enable generic PCI resource mapping
>>
>> Tong Tiangen (1):
>>        riscv: add VMAP_STACK overflow detection
>>
>> Vitaly Wool (1):
>>        riscv: fix typo in init.c
>>
>>   arch/riscv/Kconfig                      |  12 +-
>>   arch/riscv/include/asm/asm-prototypes.h |   3 +
>>   arch/riscv/include/asm/io.h             |  13 --
>>   arch/riscv/include/asm/kfence.h         |  63 +++++++
>>   arch/riscv/include/asm/kprobes.h        |   7 -
>>   arch/riscv/include/asm/mmu_context.h    |   2 +
>>   arch/riscv/include/asm/page.h           |  81 +++++----
>>   arch/riscv/include/asm/pci.h            |   2 +
>>   arch/riscv/include/asm/pgtable-64.h     |   5 +-
>>   arch/riscv/include/asm/pgtable-bits.h   |   5 +
>>   arch/riscv/include/asm/pgtable.h        | 171 ++++++++++++++++++-
>>   arch/riscv/include/asm/ptrace.h         |  31 ++++
>>   arch/riscv/include/asm/sections.h       |  17 ++
>>   arch/riscv/include/asm/set_memory.h     |  24 ++-
>>   arch/riscv/include/asm/switch_to.h      |  11 +-
>>   arch/riscv/include/asm/thread_info.h    |  15 ++
>>   arch/riscv/include/asm/tlbflush.h       |   5 +
>>   arch/riscv/kernel/asm-offsets.c         |   2 +
>>   arch/riscv/kernel/cpufeature.c          |   6 +-
>>   arch/riscv/kernel/entry.S               | 108 ++++++++++++
>>   arch/riscv/kernel/head.S                |   4 +-
>>   arch/riscv/kernel/kexec_relocate.S      |   4 +-
>>   arch/riscv/kernel/machine_kexec.c       |   2 +-
>>   arch/riscv/kernel/probes/kprobes.c      |  40 +----
>>   arch/riscv/kernel/process.c             |   2 +-
>>   arch/riscv/kernel/setup.c               |  18 +-
>>   arch/riscv/kernel/signal.c              |   4 +-
>>   arch/riscv/kernel/traps.c               |  35 ++++
>>   arch/riscv/kernel/vmlinux-xip.lds.S     |   1 -
>>   arch/riscv/kernel/vmlinux.lds.S         |   2 +-
>>   arch/riscv/lib/uaccess.S                | 181 ++++++++++++++++----
>>   arch/riscv/mm/context.c                 |  14 +-
>>   arch/riscv/mm/fault.c                   |  11 +-
>>   arch/riscv/mm/init.c                    | 283 +++++++++++++++-----------------
>>   arch/riscv/mm/physaddr.c                |   2 +-
>>   arch/riscv/mm/ptdump.c                  |   6 +-
>>   arch/riscv/mm/tlbflush.c                |  69 ++++++--
>>   37 files changed, 901 insertions(+), 360 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/kfence.h
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
