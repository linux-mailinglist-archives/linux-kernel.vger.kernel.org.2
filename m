Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD33D8E50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhG1MxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49733 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236254AbhG1MxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C2E60FC4;
        Wed, 28 Jul 2021 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627476788;
        bh=uVs06J6Sp0nm7rKdLCNuLO/owrULe5dkBXVfD8Ww5vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/faYnN3UaBN3B4xIHIKWqE5hItl6PNO4fcX6B9/fhP2vRecEWniGPj/DGuP74hnz
         NNJBFupVHrEVdCyQ19KJM0OlpQBGpgiROFQ5/6H9uvN+tFmu08+87Icn6uoQNiqjPa
         vC4rrZheFMLK8yy5LDm3HZT5APN5gQrutrVbMLDT4RI0aKxjgiwxx19zGYUtUy4UTj
         oimAgvdikHrUJSR0QIUaouf2fbu3c8vPX3OKZKeQVLWIojcQ5c/qITQReGJgTi94mP
         DEMqs6HRqk3llsf2nKmASpsGOm7Ltgl+Yz/2jVJ00iGzkkwcorRHDi/Vg71IEY/AH+
         g4KcFpr+9BA9A==
Date:   Wed, 28 Jul 2021 15:52:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Kenneth Lee <nek.in.cn@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH] riscv: fix the global name pfn_base confliction error
Message-ID: <YQFTKtNmqorzsv6a@kernel.org>
References: <20210728064318.375747-1-nek.in.cn@gmail.com>
 <0e81c8d2-468a-9afd-bce3-0e8211baa065@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e81c8d2-468a-9afd-bce3-0e8211baa065@ghiti.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 09:19:16AM +0200, Alex Ghiti wrote:
> Hi Kenneth,
> 
> Le 28/07/2021 à 08:43, Kenneth Lee a écrit :
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > RISCV use a global variable pfn_base for page/pfn translation. But this
> > is a common name and will be used elsewhere. In those case,
> > the page-pfn macro which refer this name will refer to the local/input
> > variable of those function (such as in vfio_pin_pages_remote). This make
> > everything wrong.
> > 
> > This patch change the name from pfn_base to riscv_global_pfn_base to fix
> > this problem
> 
> What about removing this variable entirely and using
> PFN_DOWN(kernel_map.phys_addr) directly in ARCH_PFN_OFFSET definition? That
> would remove code from mm/init.c, which is nice :)

That would be nice, but such change would also change the generated code.
Probably nothing important, but someone would have to at least check what
size and bloat-o-meter say.
 
> Thanks,
> 
> Alex
> 
> > 
> > Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> > ---
> >   arch/riscv/include/asm/page.h | 4 ++--
> >   arch/riscv/mm/init.c          | 6 +++---
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index cca8764aed83..8711e415f37c 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
> >   #endif
> >   #ifdef CONFIG_MMU
> > -extern unsigned long pfn_base;
> > -#define ARCH_PFN_OFFSET		(pfn_base)
> > +extern unsigned long riscv_global_pfn_base;
> > +#define ARCH_PFN_OFFSET		(riscv_global_pfn_base)
> >   #else
> >   #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
> >   #endif /* CONFIG_MMU */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index a14bf3910eec..2ce4e9a46ca0 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
> >   #define pt_ops _pt_ops
> >   #endif
> > -unsigned long pfn_base __ro_after_init;
> > -EXPORT_SYMBOL(pfn_base);
> > +unsigned long riscv_global_pfn_base __ro_after_init;
> > +EXPORT_SYMBOL(riscv_global_pfn_base);
> >   pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > @@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >   	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
> >   #endif
> > -	pfn_base = PFN_DOWN(kernel_map.phys_addr);
> > +	riscv_global_pfn_base = PFN_DOWN(kernel_map.phys_addr);
> >   	/*
> >   	 * Enforce boot alignment requirements of RV32 and
> > 

-- 
Sincerely yours,
Mike.
