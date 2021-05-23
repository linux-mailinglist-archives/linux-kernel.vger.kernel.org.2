Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6438D856
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhEWCkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhEWCj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:39:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30288C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:38:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso9228283pji.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9g5UAE2SjxfDrTvNcmsOvc5raZR96mJY6wr+vR+2NDs=;
        b=a5VDk9MlsWkIjemOgii89yKvOX+gqtEqIiUs90uYDUGpB3C/iSuWacKt6AXmeoNCme
         OtNHwwQsFlMtRWAGMxBxBT+s8pUQczemV/iKyAFitCcD67wHk0uafETLXGMpCgfPmhUu
         3YPuJ2FpGE6PbVQCDVZXEmtwB5b5qQzvFU6u82PTRKCL1YDIJFzK0pvsZiL/3fYItKHb
         pIKCvSK8c5zOFQe04C4ymWu51RduMdO0PK2sQeWmlAw6UniNhxAJ8tdDLXrwVOFQU7tF
         SEFl38AS7OjlXmDZaUIFIZpetZ3U3T3jRn+LM2Re8ss/kMU2VqE79DJAi2SypO6f9r0B
         8jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9g5UAE2SjxfDrTvNcmsOvc5raZR96mJY6wr+vR+2NDs=;
        b=cl4BiayV5STbiNlNv9cYbiEeRlvMBfu2thmXkGNsqHj/m+z5FToBrlunjCD9zgRNgF
         dj4lUaYv9vDOC5tdOrSMhO2tyWgaNm+AG2guYglfXou4WDBSScdcMGJb/N+41kXg+l75
         zdzv/R6PZao4xw7qdHQulc4J/2+KMoO1J2sMbGzwE0lAjwJ5yLK6rAwbZQFIw7UqpS5O
         L13mt5rA21SAcoKG3XqOBaoVZD3sCgIfzhI7S5+KRMDbs4A5dMs2UhdbHPLjV4UTGpRB
         NJaOUbl5LxfwhuTl3xnh3pmaUjxQuc1pco42CTZXRZ/3YMk4Gt/Qn2kMSzO55USkJBiK
         5D8g==
X-Gm-Message-State: AOAM533SuDJ8RKlOzmkJ7+2T/9hauwNw6m7XrwZuXzUAPlyZ2WAilVbI
        ob6pC1EJTZWhEk2uBVSZ6z6iQQ==
X-Google-Smtp-Source: ABdhPJzI4sc4+2J9iD2fKq27UKyr7/80Y0uH8UaRjpA66thw0TRtgF1wmNPK7DHP/2AmDq5jN5w4oQ==
X-Received: by 2002:a17:902:dccc:b029:f1:c207:b10b with SMTP id t12-20020a170902dcccb02900f1c207b10bmr19317352pll.41.1621737511695;
        Sat, 22 May 2021 19:38:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v22sm7402355pff.105.2021.05.22.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 19:38:31 -0700 (PDT)
Date:   Sat, 22 May 2021 19:38:31 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 19:38:28 PDT (-0700)
Subject:     Re: [PATCH RFC v2] riscv: Enable KFENCE for riscv64
In-Reply-To: <CANpmjNMN2xQ28nsqUzE+XJ_muHUT+EGdCTCDhvLH2hMMxuTidQ@mail.gmail.com>
CC:     liushixin2@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     elver@google.com
Message-ID: <mhng-f2825fd1-15e0-403d-b972-d327494525e6@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 08:20:10 PDT (-0700), elver@google.com wrote:
> On Fri, 14 May 2021 at 05:11, Liu Shixin <liushixin2@huawei.com> wrote:
>> Add architecture specific implementation details for KFENCE and enable
>> KFENCE for the riscv64 architecture. In particular, this implements the
>> required interface in <asm/kfence.h>.
>>
>> KFENCE requires that attributes for pages from its memory pool can
>> individually be set. Therefore, force the kfence pool to be mapped at
>> page granularity.
>>
>> I tested this patch using the testcases in kfence_test.c and all passed.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>
> Acked-by: Marco Elver <elver@google.com>
>
>
>> ---
>> v1->v2: Change kmalloc() to pte_alloc_one_kernel() for allocating pte.
>>
>>  arch/riscv/Kconfig              |  1 +
>>  arch/riscv/include/asm/kfence.h | 51 +++++++++++++++++++++++++++++++++
>>  arch/riscv/mm/fault.c           | 11 ++++++-
>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/include/asm/kfence.h
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index c426e7d20907..000d8aba1030 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -64,6 +64,7 @@ config RISCV
>>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>         select HAVE_ARCH_KASAN if MMU && 64BIT
>>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>> +       select HAVE_ARCH_KFENCE if MMU && 64BIT
>>         select HAVE_ARCH_KGDB
>>         select HAVE_ARCH_KGDB_QXFER_PKT
>>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
>> new file mode 100644
>> index 000000000000..c25d67e0b8ba
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/kfence.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _ASM_RISCV_KFENCE_H
>> +#define _ASM_RISCV_KFENCE_H
>> +
>> +#include <linux/kfence.h>
>> +#include <linux/pfn.h>
>> +#include <asm-generic/pgalloc.h>
>> +#include <asm/pgtable.h>
>> +
>> +static inline bool arch_kfence_init_pool(void)
>> +{
>> +       int i;
>> +       unsigned long addr;
>> +       pte_t *pte;
>> +       pmd_t *pmd;
>> +
>> +       for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
>> +            addr += PAGE_SIZE) {
>> +               pte = virt_to_kpte(addr);
>> +               pmd = pmd_off_k(addr);
>> +
>> +               if (!pmd_leaf(*pmd) && pte_present(*pte))
>> +                       continue;
>> +
>> +               pte = pte_alloc_one_kernel(&init_mm);
>> +               for (i = 0; i < PTRS_PER_PTE; i++)
>> +                       set_pte(pte + i, pfn_pte(PFN_DOWN(__pa((addr & PMD_MASK) + i * PAGE_SIZE)), PAGE_KERNEL));
>> +
>> +               set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE));
>> +               flush_tlb_kernel_range(addr, addr + PMD_SIZE);
>> +       }
>> +
>> +       return true;
>> +}

I'm not fundamentally opposed to this, but the arm64 approach where 
pages are split at runtime when they have mis-matched permissions seems 
cleaner to me.  I'm not sure why x86 is doing it during init, though, as 
IIUC set_memory_4k() will work for both.

Upgrading our __set_memory() with the ability to split pages (like arm64 
has) seems generally useful, and would let us trivially implement the 
dynamic version of this.  We'll probably end up with the ability to 
split pages anyway, so that would be the least code in the long run.

If there's some reason to prefer statically allocating the pages I'm 
fine with this, though.

>> +
>> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
>> +{
>> +       pte_t *pte = virt_to_kpte(addr);
>> +
>> +       if (protect)
>> +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
>> +       else
>> +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>> +
>> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +
>> +       return true;
>> +}
>> +
>> +#endif /* _ASM_RISCV_KFENCE_H */
>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> index 096463cc6fff..aa08dd2f8fae 100644
>> --- a/arch/riscv/mm/fault.c
>> +++ b/arch/riscv/mm/fault.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/signal.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/kprobes.h>
>> +#include <linux/kfence.h>
>>
>>  #include <asm/ptrace.h>
>>  #include <asm/tlbflush.h>
>> @@ -45,7 +46,15 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
>>          * Oops. The kernel tried to access some bad page. We'll have to
>>          * terminate things with extreme prejudice.
>>          */
>> -       msg = (addr < PAGE_SIZE) ? "NULL pointer dereference" : "paging request";
>> +       if (addr < PAGE_SIZE)
>> +               msg = "NULL pointer dereference";
>> +       else {
>> +               if (kfence_handle_page_fault(addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
>> +                       return;
>> +
>> +               msg = "paging request";
>> +       }
>> +
>>         die_kernel_fault(msg, addr, regs);
>>  }
>>
>> --
>> 2.18.0.huawei.25
>>

