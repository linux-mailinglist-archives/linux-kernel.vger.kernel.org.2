Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57B37A488
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEKK0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhEKK01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:26:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB9FA61936
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620728720;
        bh=JV3oIYlPRhAEEPVctWNPV/cOycFyYs1Lq6DGChiCd+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DmYACPuIeG6DUf3e9aSCRKD4sAXZdKw4RqF6Pp00JLxdMo2YhXtCrwAXNpr/NHMqZ
         oDldT6x/cS0KPsVlOjNNNacP62Pn/6s4/9Dtr/nMv6QNvTDIfo+1DuXY+Owpv0Oomq
         t7cH1Ux8nSmob7o/jDbNynCu6GQt5eC2SLSqk9y8EnyptvliHdxwbANdSfFReShuuf
         ZnW/vrbHs+PASPY+A4JKR+qnEyxPSI/lla+nFpB8wzyuiuCWGgY2lIR1VXMBLaYTJt
         pT/DL2qD7qzYkzrAvR/290AS6znOUJ3Fs68ZhEpe90J4d0bracvkNvC4Vmj4OI7WXT
         BWZYO6ccSYXqA==
Received: by mail-ot1-f42.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso17021804otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:25:20 -0700 (PDT)
X-Gm-Message-State: AOAM533BX5eOPEvAxWyVDxeYfoWBYJpoDYkxTPpRCU3ZtH0mkKFmP7vD
        Z1Heq7Nyy+RpEG30GzmnTuFw28IpGA/UIBe7HBQ=
X-Google-Smtp-Source: ABdhPJytWz1IVkHqKkcpbQyOgm8jLChtkDskRM+4A0ChV/Q2KAjwVVeEAON+ryI7vhB7a9AgJZb69e4AhTOmXsHGZbY=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr25288213otd.77.1620728719935;
 Tue, 11 May 2021 03:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210511100550.28178-1-rppt@kernel.org> <20210511100550.28178-4-rppt@kernel.org>
In-Reply-To: <20210511100550.28178-4-rppt@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 May 2021 12:25:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGE=mu4P3sL-2zuGMrV1QwkXJc+-Y4Pj4RV7YEvdTDPzw@mail.gmail.com>
Message-ID: <CAMj1kXGE=mu4P3sL-2zuGMrV1QwkXJc+-Y4Pj4RV7YEvdTDPzw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: decouple check whether pfn is in linear map
 from pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 12:06, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The intended semantics of pfn_valid() is to verify whether there is a
> struct page for the pfn in question and nothing else.
>
> Yet, on arm64 it is used to distinguish memory areas that are mapped in the
> linear map vs those that require ioremap() to access them.
>
> Introduce a dedicated pfn_is_map_memory() wrapper for
> memblock_is_map_memory() to perform such check and use it where
> appropriate.
>
> Using a wrapper allows to avoid cyclic include dependencies.
>
> While here also update style of pfn_valid() so that both pfn_valid() and
> pfn_is_map_memory() declarations will be consistent.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/include/asm/memory.h |  2 +-
>  arch/arm64/include/asm/page.h   |  3 ++-
>  arch/arm64/kvm/mmu.c            |  2 +-
>  arch/arm64/mm/init.c            | 12 ++++++++++++
>  arch/arm64/mm/ioremap.c         |  4 ++--
>  arch/arm64/mm/mmu.c             |  2 +-
>  6 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 87b90dc27a43..9027b7e16c4c 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -369,7 +369,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>
>  #define virt_addr_valid(addr)  ({                                      \
>         __typeof__(addr) __addr = __tag_reset(addr);                    \
> -       __is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));      \
> +       __is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));      \
>  })
>
>  void dump_mem_limit(void);
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 012cffc574e8..75ddfe671393 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -37,7 +37,8 @@ void copy_highpage(struct page *to, struct page *from);
>
>  typedef struct page *pgtable_t;
>
> -extern int pfn_valid(unsigned long);
> +int pfn_valid(unsigned long pfn);
> +int pfn_is_map_memory(unsigned long pfn);
>
>  #include <asm/memory.h>
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index c5d1f3c87dbd..470070073085 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>
>  static bool kvm_is_device_pfn(unsigned long pfn)
>  {
> -       return !pfn_valid(pfn);
> +       return !pfn_is_map_memory(pfn);
>  }
>
>  static void *stage2_memcache_zalloc_page(void *arg)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 16a2b2b1c54d..798f74f501d5 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -255,6 +255,18 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>
> +int pfn_is_map_memory(unsigned long pfn)
> +{
> +       phys_addr_t addr = PFN_PHYS(pfn);
> +
> +       /* avoid false positives for bogus PFNs, see comment in pfn_valid() */
> +       if (PHYS_PFN(addr) != pfn)
> +               return 0;
> +
> +       return memblock_is_map_memory(addr);
> +}
> +EXPORT_SYMBOL(pfn_is_map_memory);
> +
>  static phys_addr_t memory_limit = PHYS_ADDR_MAX;
>
>  /*
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index b5e83c46b23e..b7c81dacabf0 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -43,7 +43,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
>         /*
>          * Don't allow RAM to be mapped.
>          */
> -       if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> +       if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
>                 return NULL;
>
>         area = get_vm_area_caller(size, VM_IOREMAP, caller);
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL(iounmap);
>  void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
>  {
>         /* For normal memory we already have a cacheable mapping. */
> -       if (pfn_valid(__phys_to_pfn(phys_addr)))
> +       if (pfn_is_map_memory(__phys_to_pfn(phys_addr)))
>                 return (void __iomem *)__phys_to_virt(phys_addr);
>
>         return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6dd9369e3ea0..ab5914cebd3c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -82,7 +82,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>                               unsigned long size, pgprot_t vma_prot)
>  {
> -       if (!pfn_valid(pfn))
> +       if (!pfn_is_map_memory(pfn))
>                 return pgprot_noncached(vma_prot);
>         else if (file->f_flags & O_SYNC)
>                 return pgprot_writecombine(vma_prot);
> --
> 2.28.0
>
