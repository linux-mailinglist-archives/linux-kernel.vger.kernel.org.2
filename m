Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9843A38F2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhEXSGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhEXSGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C01D361403
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621879505;
        bh=KGRCoMcUCffmNqNMyYCNwM4ghBH4MssFfRhQ/aKFadw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BcdB6cNQvxd4u6LUFIOZOlNu8JlNiEjvUpUmxR71JMGIB8xYsyqiutXKAIZHgafcA
         589dFAs9mMxTQFFFcbCIw6tA5SoQ+MIJSepIJSrA3o12WPR3rQYbFhhbkCiK8GW+s9
         SXWgPB/U/sq5CrKW4He40cPP2SyHLL9fyBpTTQfnqfavjucq+DEaQUdZ+uq16c9lLm
         XTiSIAxs3VXos8NJcMkrJJxLDh4m50xlp7OXaRgGUZV23/sbhKxlBXc2CxjwUFJivp
         zBljbCjyTR4a1dquB+MqHFckUeVk+UJvWH7T00qMRIMHHX8JQmMAdBMyRxI+VqJ8Jy
         KTb8+vdFHwtSg==
Received: by mail-ot1-f51.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so26049162otc.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:05:05 -0700 (PDT)
X-Gm-Message-State: AOAM533EVDHzUtlO7TDqLY5tsUUsGm8ULs2CuQW+8sXHl1vP1jCgflNJ
        YVykEeHpW9NP1zi9lLaLVboc+hkNqpWIYsAeU1E=
X-Google-Smtp-Source: ABdhPJzwa+eGro5LfpsUg8LpjxTeuWPx0fycPTgtYU+cKxtT4ii8rv0+oT0G8vyH2SBT1iB3LZJFWVcv8tiG7iSQL/c=
X-Received: by 2002:a9d:7cd8:: with SMTP id r24mr19941356otn.90.1621879505060;
 Mon, 24 May 2021 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210524172433.015b3b6b@xhacker.debian> <20210524172606.08dac28d@xhacker.debian>
 <CANpmjNNuaYneLb3ScSwF=o0DnECBt4NRkBZJuwRqBrOKnTGPbA@mail.gmail.com>
In-Reply-To: <CANpmjNNuaYneLb3ScSwF=o0DnECBt4NRkBZJuwRqBrOKnTGPbA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 May 2021 20:04:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtguQ=rG4wM2=xXaDLBvN3+w7DRFeCGCeVabTGLinPuQ@mail.gmail.com>
Message-ID: <CAMj1kXGtguQ=rG4wM2=xXaDLBvN3+w7DRFeCGCeVabTGLinPuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: remove page granularity limitation from KFENCE
To:     Marco Elver <elver@google.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 19:31, Marco Elver <elver@google.com> wrote:
>
> +Cc Mark
>
> On Mon, 24 May 2021 at 11:26, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >
> > KFENCE requires linear map to be mapped at page granularity, so that
> > it is possible to protect/unprotect single pages in the KFENCE pool.
> > Currently if KFENCE is enabled, arm64 maps all pages at page
> > granularity, it seems overkilled. In fact, we only need to map the
> > pages in KFENCE pool itself at page granularity. We acchieve this goal
> > by allocating KFENCE pool before paging_init() so we know the KFENCE
> > pool address, then we take care to map the pool at page granularity
> > during map_mem().
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Could you please share some performance numbers that result from this
optimization?

(There are other reasons why we may need to map the linear region down
to pages unconditionally in the future, so it would be good to have
some solid numbers about the potential impact of doing so)


> > ---
> >  arch/arm64/kernel/setup.c |  3 +++
> >  arch/arm64/mm/mmu.c       | 27 +++++++++++++++++++--------
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 61845c0821d9..51c0d6e8b67b 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/screen_info.h>
> >  #include <linux/init.h>
> >  #include <linux/kexec.h>
> > +#include <linux/kfence.h>
> >  #include <linux/root_dev.h>
> >  #include <linux/cpu.h>
> >  #include <linux/interrupt.h>
> > @@ -345,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >
> >         arm64_memblock_init();
> >
> > +       kfence_alloc_pool();
> > +
> >         paging_init();
> >
> >         acpi_table_upgrade();
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 89b66ef43a0f..12712d31a054 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> >  #include <linux/kexec.h>
> > +#include <linux/kfence.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/mman.h>
> >  #include <linux/nodemask.h>
> > @@ -515,10 +516,16 @@ static void __init map_mem(pgd_t *pgdp)
> >          */
> >         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> >
> > -       if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
> > -           IS_ENABLED(CONFIG_KFENCE))
> > +       if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
> >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> > +       /*
> > +        * KFENCE requires linear map to be mapped at page granularity, so
> > +        * temporarily skip mapping for __kfence_pool in the following
> > +        * for-loop
> > +        */
> > +       memblock_mark_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> > +
>
> Did you build this with CONFIG_KFENCE unset? I don't think it builds.
>
> >         /*
> >          * Take care not to create a writable alias for the
> >          * read-only text and rodata sections of the kernel image.
> > @@ -553,6 +560,15 @@ static void __init map_mem(pgd_t *pgdp)
> >         __map_memblock(pgdp, kernel_start, kernel_end,
> >                        PAGE_KERNEL, NO_CONT_MAPPINGS);
> >         memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> > +
> > +       /*
> > +        * Map the __kfence_pool at page granularity now.
> > +        */
> > +       __map_memblock(pgdp, __pa(__kfence_pool),
> > +                      __pa(__kfence_pool + KFENCE_POOL_SIZE),
> > +                      pgprot_tagged(PAGE_KERNEL),
> > +                      NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > +       memblock_clear_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> >  }
> >
> >  void mark_rodata_ro(void)
> > @@ -1480,12 +1496,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >
> >         VM_BUG_ON(!mhp_range_allowed(start, size, true));
> >
> > -       /*
> > -        * KFENCE requires linear map to be mapped at page granularity, so that
> > -        * it is possible to protect/unprotect single pages in the KFENCE pool.
> > -        */
> > -       if (rodata_full || debug_pagealloc_enabled() ||
> > -           IS_ENABLED(CONFIG_KFENCE))
> > +       if (rodata_full || debug_pagealloc_enabled())
> >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> >         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > --
> > 2.31.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210524172606.08dac28d%40xhacker.debian.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
