Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98896360237
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhDOGQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhDOGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:16:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBEDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 23:16:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u7so9664332plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8aPMWJgLeOMSHDPtfmh56WRL1jMhYN833mNKhQBp9lg=;
        b=S2hDQvA6UfYIH0obB5OOp9EyLCYxAEyAd3zUh7VQB70I3FE4ZQVlnB7pDBCv+EYFQR
         iFQFmiIaWxlgH15kJyqdoNWAXVIuM4M2ymSet5SjMCXRhlept12z7lOne2sKKM/Qahl7
         SR7pLqx9Vp7A+RTWtW8cb1WdsLFiMjf9rLjh125BDNZllXhK6EEvfBeKPL8z4bLGqKGk
         eFuDCXxvbc2teHQ6SsD24i8HjukX3iaINCwJ2VtvMJAWwhBc4Ndv9ROtmGrWt1xbQIm5
         DmNE3nxJvy2+8U5npx6FG2l55e7/FJb/AM0pRO39N+0wA1HUB8S4qbjmV/RhscpnPZUn
         ii2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8aPMWJgLeOMSHDPtfmh56WRL1jMhYN833mNKhQBp9lg=;
        b=ErcwO865ll5jCqP/kB92wfwb+bkcYiyfu3WZyjIoQBosiCZMaxBxMYo7etqm8veqaC
         XGplJF17uoqR1j4YsJj8FegwhIAFx6/beoecnK4SnbSBIfrJNeQ4D4en/+mehluQl4RE
         XK8Zoa4RbkXWgI/eutv5CdWEz3worOL5niBchnSgWmgdVS9NjP98fiFvo1F/cX9Xcp8W
         BWBRnjdoS1JOpEf+Ki4fwpMkaiUbdcuaf7BYUIVNuN4PMuefXrLQhpAcPeAMd4yRBWJ8
         ZwQcLJpmENh+pipyUuWBjVyZ+5Z+kBtJrDrLXaaks43FyYQ7Th78X9p12AI9bgqaFmZS
         rMkA==
X-Gm-Message-State: AOAM533+pSfzbfWvpZe86RG31ClMwHI3f4Ugc3E00VSpGLUDRztSyhD+
        VOqMuMX1213JconcIux6Tl7vKg==
X-Google-Smtp-Source: ABdhPJwQ8tlbhjRyFTql28i8d3dPzxk+82TQ7fucsms/w1A1eM/vcb693iFMmHVxxBPuNRepSBkMdQ==
X-Received: by 2002:a17:90a:670a:: with SMTP id n10mr2087887pjj.176.1618467385372;
        Wed, 14 Apr 2021 23:16:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m9sm1242059pgt.65.2021.04.14.23.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 23:16:24 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:16:24 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Apr 2021 23:16:23 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] riscv: Cleanup KASAN_VMALLOC support
In-Reply-To: <CAMuHMdXdhTUKuvJkJGUm=ESpwA6R06eKV5q6wFOJftJ1p3R7nw@mail.gmail.com>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, nylon7@andestech.com, nickhu@andestech.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-93309746-0fd6-42ec-b574-bf1ce486f34a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 02:47:30 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Palmer,
>
> On Tue, Mar 30, 2021 at 7:08 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> On Sat, 13 Mar 2021 00:45:05 PST (-0800), alex@ghiti.fr wrote:
>> > When KASAN vmalloc region is populated, there is no userspace process and
>> > the page table in use is swapper_pg_dir, so there is no need to read
>> > SATP. Then we can use the same scheme used by kasan_populate_p*d
>> > functions to go through the page table, which harmonizes the code.
>> >
>> > In addition, make use of set_pgd that goes through all unused page table
>> > levels, contrary to p*d_populate functions, which makes this function work
>> > whatever the number of page table levels.
>> >
>> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> > ---
>> >  arch/riscv/mm/kasan_init.c | 59 ++++++++++++--------------------------
>> >  1 file changed, 18 insertions(+), 41 deletions(-)
>> >
>> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>> > index 57bf4ae09361..c16178918239 100644
>> > --- a/arch/riscv/mm/kasan_init.c
>> > +++ b/arch/riscv/mm/kasan_init.c
>> > @@ -11,18 +11,6 @@
>> >  #include <asm/fixmap.h>
>> >  #include <asm/pgalloc.h>
>> >
>> > -static __init void *early_alloc(size_t size, int node)
>> > -{
>> > -     void *ptr = memblock_alloc_try_nid(size, size,
>> > -             __pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
>> > -
>> > -     if (!ptr)
>> > -             panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
>> > -                     __func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
>> > -
>> > -     return ptr;
>> > -}
>> > -
>> >  extern pgd_t early_pg_dir[PTRS_PER_PGD];
>> >  asmlinkage void __init kasan_early_init(void)
>> >  {
>> > @@ -155,38 +143,27 @@ static void __init kasan_populate(void *start, void *end)
>> >       memset(start, KASAN_SHADOW_INIT, end - start);
>> >  }
>> >
>> > -void __init kasan_shallow_populate(void *start, void *end)
>> > +static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
>> >  {
>> > -     unsigned long vaddr = (unsigned long)start & PAGE_MASK;
>> > -     unsigned long vend = PAGE_ALIGN((unsigned long)end);
>> > -     unsigned long pfn;
>> > -     int index;
>> > +     unsigned long next;
>> >       void *p;
>> > -     pud_t *pud_dir, *pud_k;
>> > -     pgd_t *pgd_dir, *pgd_k;
>> > -     p4d_t *p4d_dir, *p4d_k;
>> > -
>> > -     while (vaddr < vend) {
>> > -             index = pgd_index(vaddr);
>> > -             pfn = csr_read(CSR_SATP) & SATP_PPN;
>> > -             pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
>> > -             pgd_k = init_mm.pgd + index;
>> > -             pgd_dir = pgd_offset_k(vaddr);
>> > -             set_pgd(pgd_dir, *pgd_k);
>> > -
>> > -             p4d_dir = p4d_offset(pgd_dir, vaddr);
>> > -             p4d_k  = p4d_offset(pgd_k, vaddr);
>> > -
>> > -             vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
>> > -             pud_dir = pud_offset(p4d_dir, vaddr);
>> > -             pud_k = pud_offset(p4d_k, vaddr);
>> > -
>> > -             if (pud_present(*pud_dir)) {
>> > -                     p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>> > -                     pud_populate(&init_mm, pud_dir, p);
>> > +     pgd_t *pgd_k = pgd_offset_k(vaddr);
>> > +
>> > +     do {
>> > +             next = pgd_addr_end(vaddr, end);
>> > +             if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
>> > +                     p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> > +                     set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
>> >               }
>> > -             vaddr += PAGE_SIZE;
>> > -     }
>> > +     } while (pgd_k++, vaddr = next, vaddr != end);
>> > +}
>> > +
>> > +static void __init kasan_shallow_populate(void *start, void *end)
>> > +{
>> > +     unsigned long vaddr = (unsigned long)start & PAGE_MASK;
>> > +     unsigned long vend = PAGE_ALIGN((unsigned long)end);
>> > +
>> > +     kasan_shallow_populate_pgd(vaddr, vend);
>> >
>> >       local_flush_tlb_all();
>> >  }
>>
>> Thanks, this is on for-next.
>
> Your for-next does not include your fixes branch, hence they now conflict,
> and for-next lacks the local_flush_tlb_all().

This came up before and I don't think we ever sorted out what the right 
thing to do is.  Right now I'm keeping for-next pinned an at early RC, 
but fast-forwarding fixes to the latest RC every time I sent a PR.  I 
don't have fixes merged back into for-next because I don't want those 
merges to show up when I send my merge window PRs.

For this one I purposefully left out the local_flush_tlb_all() whene I 
pulled in this patch, and was planning on fixing it up along with any 
other merge conflicts when I send along the PR.  It does all seem like a 
bit of a song and dance here, though, so I'm open to suggestions as to 
how to run this better -- though last time I went through that exercise 
it seemed like everyone had their own way of doing it, they all had a 
different set of issues, and I was at least familiar with this flavor of 
craziness.

I was kind of tempted to convert for-next over into a branch that only 
contains merges, though, which would make it a bit easier to merge fixes 
in.

>
> Gr{oetje,eeting}s,
>
>                         Geert
