Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D973EBE28
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhHMWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 18:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhHMWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 18:08:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DEFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 15:08:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so17376622pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IFfhJzI1+Hp4pz+0fTeAGmJnJc4r5sQBUjmelaHgx6o=;
        b=dP30dr45wxLfDU1V9bPdy2fQNqhX1GebOSyWBYpPFJzwdB99FkQrVjM5FaJwWwgEPV
         7ppjAEYy1/vYnI6ablevUbx1GtlxkSv8BBCfMKv7SKFnMqStHBTz7rMONo5qbDdXWVtp
         RbqbKGQyXR3wd/pP2C0ZLqRHxormARR+bNn/wSCd01QyLkM2v9WJLaspc5zjkuQbxuuv
         xbKyeR+SDlIv5ctKL8xVAOFBV9nVi3ZS5ihGi1UED1Ro2bpLPWxmCmEWT6WkMJ9Ntx6j
         x7XYfDRdrOf45CWVjxBaBsXotzzIPwzf54XObBycJOuCVWirHxm84hTTBKxrGpzk6vvb
         V8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IFfhJzI1+Hp4pz+0fTeAGmJnJc4r5sQBUjmelaHgx6o=;
        b=FziXqErU+A0n+muixOJxwxGbCNBfSehS773+hFj/hTmkAsdt9zcKMNzho1DQZTpuy/
         PPBypuuOeqZrSpW3O6YgHeuQcjDhJS6AEDP1S5hg85KBw51To74PleCeMSaUOVeh7nmU
         7nQptUnO1b6oPxeFTGQNbIZPYuYhCb8IXdNGhJ8Ym6J7WWL+snKwkqH/5NkFldS8cddC
         DkAhrYC1kgaYwKbuJIAqAwMy3c7AupgIS/rrf2pEmqEUFdg0/reeD2SYZ+ZnU5PJa0gw
         VDEMwh0wojVdh3dF+zXlMgzby/gkQfNHdTprq9Ss6DpEoMEIer8LpmMesmxdsPdXzN/2
         12qg==
X-Gm-Message-State: AOAM533JSyReXJr6DkWRqN6KLcNg7acMgdWO+wrxoOpq9jAcZ8B0ZYOl
        U3PmN+Qyp9vlZmEgp/ZkAcEUAw==
X-Google-Smtp-Source: ABdhPJyXkyfvKAYV9Nhd906NRWMFvTxm6LHMcxFIUbnDbck716z9ty+xBBO0bWZZ0N66CoMfBVfp/w==
X-Received: by 2002:a17:90a:bd06:: with SMTP id y6mr4636521pjr.6.1628892498259;
        Fri, 13 Aug 2021 15:08:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g2sm3378290pfi.211.2021.08.13.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:08:17 -0700 (PDT)
Date:   Fri, 13 Aug 2021 15:08:17 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Aug 2021 15:08:14 PDT (-0700)
Subject:     Re: [PATCH v2 -next] riscv: mm: remove redundant trampoline PGD for 64bit
In-Reply-To: <6198036e-353c-dac5-5399-8b823a89f926@ghiti.fr>
CC:     sunnanyong@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        tiantao6@hisilicon.com, qiuwenbo@phytium.com.cn, rppt@kernel.org,
        jszhang@kernel.org, mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-ea598bd7-cae0-4b60-83c5-b862a664116d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 05:43:02 PDT (-0700), alex@ghiti.fr wrote:
> Hi Nanyong,
>
> Le 28/07/2021 à 13:55, Alex Ghiti a écrit :
>>
>>
>> Le 28/07/2021 à 04:49, Nanyong Sun a écrit :
>>> Remove redundant trampoline PGD for 64bit and add more comment
>>> for why 32bit systems need trampoline PGD.
>>>
>>> There was a patch and discussion similar to this,refer to
>>> the link [1][2].
>>>
>>> The trampoline PGD is redundant for 64bit systems because:
>>> 1. The early PGD covers the entire kernel mapping. Directly
>>> loading early PGD can achieve the result in boot stage.
>>> A more trampoline PGD makes code hard to understand.
>>> 2. Directly loading early PGD is safe in 64bit systems since
>>> the kernel virtual address starts as 0xFFFFxxxxxxxxxxxx,
>>> which has a very big gap with RAM address.It won't fall into
>>> the corner case that 32bit system worrys.
>>> 3. Remove redundant trampoline PGD can benefit to code maintaince,
>>> because 64bit systems have more page table levels.For example:
>>> If we want to support SV48 which has 4 page table levels, we have
>>> to add a trampoline_pud and insert it before trampoline_pmd.
>>>
>>> Reference link:
>>> [1]https://lore.kernel.org/linux-riscv/20190325092234.5451-4-anup.patel@wdc.com/
>>>
>>> [2]https://lkml.org/lkml/2019/3/28/147
>>>
>>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>>
>> I have not reviewed this patch yet! :)
>>
>>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Reviewed-by: weiyongjun <weiyongjun1@huawei.com>
>>> ---
>>> v2 changes:
>>>    Adjust codes based on the review suggestions from Alex Ghiti,
>>>    make codes more readable.
>>> ---
>>>   arch/riscv/kernel/head.S | 46 ++++++++++++++++++++++++++--------------
>>>   arch/riscv/mm/init.c     | 16 ++++----------
>>>   2 files changed, 34 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>> index fce5184b22c3..3816aa5edc69 100644
>>> --- a/arch/riscv/kernel/head.S
>>> +++ b/arch/riscv/kernel/head.S
>>> @@ -89,29 +89,52 @@ relocate:
>>>       add ra, ra, a1
>>>       /* Point stvec to virtual address of intruction after satp write */
>>> -    la a2, 1f
>>> +#ifdef CONFIG_64BIT
>>> +    la a2, load_done
>>> +#else
>>> +    la a2, load_kernel_pgd
>>> +#endif
>>>       add a2, a2, a1
>>>       csrw CSR_TVEC, a2
>>> -    /* Compute satp for kernel page tables, but don't load it yet */
>>> +    /* Compute satp for kernel page tables.
>>> +     * For 64bit systems, load it and trap to stvec.
>>> +     * For 32bit systems, don't load it yet.
>>> +     */
>>>       srl a2, a0, PAGE_SHIFT
>>>       li a1, SATP_MODE
>>>       or a2, a2, a1
>>>       /*
>>> +     * Before writing satp, we need a full fence here because
>>> setup_vm() just
>>> +     * wrote these PTEs and we need to ensure the new translations
>>> are in use.
>>> +     */
>>> +    sfence.vma
>>> +#ifndef CONFIG_64BIT
>>> +    /*
>>> +     * 32bit systems need firstly loading a trampoline to handle a
>>> corner
>>> +     * case where load address range overlaps kernel virtual address
>>> range.
>>>        * Load trampoline page directory, which will cause us to trap to
>>> -     * stvec if VA != PA, or simply fall through if VA == PA.  We need a
>>> -     * full fence here because setup_vm() just wrote these PTEs and
>>> we need
>>> -     * to ensure the new translations are in use.
>>> +     * stvec if VA != PA, or simply fall through if VA == PA.
>>>        */
>>>       la a0, trampoline_pg_dir
>>>       XIP_FIXUP_OFFSET a0
>>>       srl a0, a0, PAGE_SHIFT
>>>       or a0, a0, a1
>>> -    sfence.vma
>>>       csrw CSR_SATP, a0
>>> +#endif
>>>   .align 2
>>> -1:
>>> +load_kernel_pgd:
>>> +        /*
>>> +         * Switch to kernel page tables.  A full fence is necessary
>>> in order to
>>> +         * avoid using the trampoline translations, which are only
>>> correct for
>>> +         * the first superpage.  Fetching the fence is guarnteed to work
>>> +         * because that first superpage is translated the same way.
>>> +         */
>>> +        csrw CSR_SATP, a2
>>> +        sfence.vma
>>> +
>>> +load_done:
>>>       /* Set trap vector to spin forever to help debug */
>>>       la a0, .Lsecondary_park
>>>       csrw CSR_TVEC, a0
>
>
> I suppose stvec was set this way to catch any problem with early_pg_dir,
> you moved that and then this defeats this original purpose.

Essentially.

The specific issue is that the JTAG debug spec is defined (or at least 
was when I was using it, it's been years since I've needed to do that) 
in terms of committed instructions.  Thus if you end up in a position 
where the processer is unable to commit an instruction you also lose the 
ability to do anything meaningful with the debugger, thus essentially 
locking up the system.

The most common way to end up in a situation where the processor is 
unable to commit an instruction is to have a fault with an invalid trap 
vector: maybe dangling from M-mode, the last boot, reset, whatever.  
Then as soon as you take a trap the system locks up.  Any trap before we 
have a working trap handler is a bug, but it's way harder to debug 
things when the debugger doesn't function.

There is of course no way to fundamentally prevent these sort of 
no-commitable-instruction situations, but I got into the habbit of just 
setting up a trivial trap entry point ASAP -- it probably took a dozen 
rounds of trying to debug the debugger only to realize it was per spec 
to hang, but that idiom eventually crept into pretty much everything.

Not sure if the debug spec is still written this way (or if debuggers 
respect it), as I haven't had to use one in a while.

>
>
>>> @@ -122,15 +145,6 @@ relocate:
>>>       la gp, __global_pointer$
>>>   .option pop
>>> -    /*
>>> -     * Switch to kernel page tables.  A full fence is necessary in
>>> order to
>>> -     * avoid using the trampoline translations, which are only
>>> correct for
>>> -     * the first superpage.  Fetching the fence is guarnteed to work
>>> -     * because that first superpage is translated the same way.
>>> -     */
>>> -    csrw CSR_SATP, a2
>>> -    sfence.vma
>>> -
>>>       ret
>>>   #endif /* CONFIG_MMU */
>>>   #ifdef CONFIG_SMP
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index ac48742fa6fc..306fcb2334fa 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -219,13 +219,17 @@ unsigned long pfn_base __ro_after_init;
>>>   EXPORT_SYMBOL(pfn_base);
>>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>> +#ifndef CONFIG_64BIT
>>>   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>> +#endif /* CONFIG_64BIT */
>
>
> As stated in Documentation/process/coding-style.rst, it is better to use
> __maybe_unused rather than #ifdefs.
>
>
>>>   static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>>>   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>>>   #ifdef CONFIG_XIP_KERNEL
>>> +#ifndef CONFIG_64BIT
>>>   #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
>>> +#endif /* CONFIG_64BIT */
>
>
> Using __maybe_unused allows to remove those too.
>
>
>>>   #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
>>>   #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
>>>   #endif /* CONFIG_XIP_KERNEL */
>>> @@ -300,13 +304,11 @@ static void __init create_pte_mapping(pte_t *ptep,
>>>   #ifndef __PAGETABLE_PMD_FOLDED
>>> -static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>>>   static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>>>   static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>>>   static pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata
>>> __aligned(PAGE_SIZE);
>>>   #ifdef CONFIG_XIP_KERNEL
>>> -#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
>>>   #define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
>>>   #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
>>>   #endif /* CONFIG_XIP_KERNEL */
>>> @@ -585,16 +587,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>>       /* Setup fixmap PMD */
>>>       create_pmd_mapping(fixmap_pmd, FIXADDR_START,
>>>                  (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
>>> -    /* Setup trampoline PGD and PMD */
>>> -    create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
>>> -               (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
>>> -#ifdef CONFIG_XIP_KERNEL
>>> -    create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
>>> -               kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
>>> -#else
>>> -    create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
>>> -               kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
>>> -#endif
>>>   #else
>>>       /* Setup trampoline PGD */
>>>       create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
>>>
>>
>
> Overall this version adds more complexity to assembly code than I
> thought, but I don't see any way to improve that (which does not mean
> there isn't!).
>
> Thanks,
>
> Alex
>
>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
