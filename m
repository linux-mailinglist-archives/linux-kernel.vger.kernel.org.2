Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3167F3CF9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhGTLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237862AbhGTLwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:52:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C673F61246
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784396;
        bh=KQg2v/CW3pKrFhdKhxhTrULtunXY7ZG5Y+37MBHLN30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u6sJ+ZpAffmKE/Mt50u3yIUwSR3Q/6pk5UjG1UeRy6jbbnOgzIAJ9sKwNB/M10pFD
         tDnVgcrB1X3HI3STfr+iH/5cA4udwqmczFxUD9DnjBgImGy+MXKvidySWHeuT/HUmz
         GNoElzYOtQiBmXQScK4SALqY7yOLy5gQV0Le4yOiqVJsI0XG6lqGO54kyrCrHC1LzB
         KgRvlUMB0Lf/cR0TLUvRtpw+OeS5LMYXYJbtflE79PUAb9mSmu/V+2E5fvPT7yUUVa
         /1OWRI7LBGEupSJcSi9HI0yBaLpMoub8F2QH22zwswUcvIYDHXQCJdxowLhJiqG4jL
         /jNNxd6ui9crw==
Received: by mail-oo1-f41.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso5237682ooc.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 05:33:16 -0700 (PDT)
X-Gm-Message-State: AOAM530Ep3afEKYOveMl2mo3EBJth55bg5v2WCQpowFTgRNhoPFiah8N
        nXtfH6jDFUoiLiQvqtodKNGcMu7csVrKViu9deI=
X-Google-Smtp-Source: ABdhPJyYYhDKVdZ56iWRSbCA9KrycHVWRf4eS6oUeQOLYTjpJZZvjabwaqdSnfgGPMBmxI2QkjM1McCetjGLzh920lE=
X-Received: by 2002:a4a:8241:: with SMTP id t1mr20609277oog.13.1626784395911;
 Tue, 20 Jul 2021 05:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210717160118.9855-1-jonathan@marek.ca>
In-Reply-To: <20210717160118.9855-1-jonathan@marek.ca>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 14:33:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=PgUeU7xMNq5EcW=ivYtXhd7nnFqH=TOFS6mpfu-isg@mail.gmail.com>
Message-ID: <CAMj1kXH=PgUeU7xMNq5EcW=ivYtXhd7nnFqH=TOFS6mpfu-isg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Axtens <dja@axtens.net>,
        Huang Pei <huangpei@loongson.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2021 at 18:06, Jonathan Marek <jonathan@marek.ca> wrote:
>
> c742199a breaks arm64 for some configs because it stubs out functions which
> should not have been stubbed out.
>
> With 4K pages and ARM64_VA_BITS_39=y, the kernel crashes early on unmapped
> 1G pages in the linear map caused by pud_set_huge() in alloc_init_pud()
> being stubbed out. Reverting c742199a fixes the crash.
>
> Fixes: c742199a ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

(replying here because some cc'ees were dropped from Christophe's
reply and the thread that followed it - unfortunately, lore does not
seem to have captured any of that discussion either)

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/mm/mmu.c     | 20 ++++++++------------
>  arch/x86/mm/pgtable.c   | 34 +++++++++++++++-------------------
>  include/linux/pgtable.h | 26 +-------------------------
>  3 files changed, 24 insertions(+), 56 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d745865084488..9ff0de1b2b93c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1339,7 +1339,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>         return dt_virt;
>  }
>
> -#if CONFIG_PGTABLE_LEVELS > 3
>  int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  {
>         pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
> @@ -1354,16 +1353,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>         return 1;
>  }
>
> -int pud_clear_huge(pud_t *pudp)
> -{
> -       if (!pud_sect(READ_ONCE(*pudp)))
> -               return 0;
> -       pud_clear(pudp);
> -       return 1;
> -}
> -#endif
> -
> -#if CONFIG_PGTABLE_LEVELS > 2
>  int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>  {
>         pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), mk_pmd_sect_prot(prot));
> @@ -1378,6 +1367,14 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>         return 1;
>  }
>
> +int pud_clear_huge(pud_t *pudp)
> +{
> +       if (!pud_sect(READ_ONCE(*pudp)))
> +               return 0;
> +       pud_clear(pudp);
> +       return 1;
> +}
> +
>  int pmd_clear_huge(pmd_t *pmdp)
>  {
>         if (!pmd_sect(READ_ONCE(*pmdp)))
> @@ -1385,7 +1382,6 @@ int pmd_clear_huge(pmd_t *pmdp)
>         pmd_clear(pmdp);
>         return 1;
>  }
> -#endif
>
>  int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3364fe62b9037..3481b35cb4ec7 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -682,7 +682,6 @@ int p4d_clear_huge(p4d_t *p4d)
>  }
>  #endif
>
> -#if CONFIG_PGTABLE_LEVELS > 3
>  /**
>   * pud_set_huge - setup kernel PUD mapping
>   *
> @@ -721,23 +720,6 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>         return 1;
>  }
>
> -/**
> - * pud_clear_huge - clear kernel PUD mapping when it is set
> - *
> - * Returns 1 on success and 0 on failure (no PUD map is found).
> - */
> -int pud_clear_huge(pud_t *pud)
> -{
> -       if (pud_large(*pud)) {
> -               pud_clear(pud);
> -               return 1;
> -       }
> -
> -       return 0;
> -}
> -#endif
> -
> -#if CONFIG_PGTABLE_LEVELS > 2
>  /**
>   * pmd_set_huge - setup kernel PMD mapping
>   *
> @@ -768,6 +750,21 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
>         return 1;
>  }
>
> +/**
> + * pud_clear_huge - clear kernel PUD mapping when it is set
> + *
> + * Returns 1 on success and 0 on failure (no PUD map is found).
> + */
> +int pud_clear_huge(pud_t *pud)
> +{
> +       if (pud_large(*pud)) {
> +               pud_clear(pud);
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * pmd_clear_huge - clear kernel PMD mapping when it is set
>   *
> @@ -782,7 +779,6 @@ int pmd_clear_huge(pmd_t *pmd)
>
>         return 0;
>  }
> -#endif
>
>  #ifdef CONFIG_X86_64
>  /**
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index d147480cdefc7..e24d2c992b112 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1397,34 +1397,10 @@ static inline int p4d_clear_huge(p4d_t *p4d)
>  }
>  #endif /* !__PAGETABLE_P4D_FOLDED */
>
> -#ifndef __PAGETABLE_PUD_FOLDED
>  int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
> -int pud_clear_huge(pud_t *pud);
> -#else
> -static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
> -{
> -       return 0;
> -}
> -static inline int pud_clear_huge(pud_t *pud)
> -{
> -       return 0;
> -}
> -#endif /* !__PAGETABLE_PUD_FOLDED */
> -
> -#ifndef __PAGETABLE_PMD_FOLDED
>  int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
> +int pud_clear_huge(pud_t *pud);
>  int pmd_clear_huge(pmd_t *pmd);
> -#else
> -static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
> -{
> -       return 0;
> -}
> -static inline int pmd_clear_huge(pmd_t *pmd)
> -{
> -       return 0;
> -}
> -#endif /* !__PAGETABLE_PMD_FOLDED */
> -
>  int p4d_free_pud_page(p4d_t *p4d, unsigned long addr);
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr);
>  int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
> --
> 2.26.1
>
