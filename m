Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76963CFD30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhGTOd3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jul 2021 10:33:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5375 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhGTOXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GThms4brpzB9SY;
        Tue, 20 Jul 2021 17:03:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xY-Ufv6zed-4; Tue, 20 Jul 2021 17:03:41 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GThms3bRYzB9SV;
        Tue, 20 Jul 2021 17:03:41 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 818D9C01; Tue, 20 Jul 2021 17:08:54 +0200 (CEST)
Received: from 37.170.147.235 ([37.170.147.235]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Tue, 20 Jul 2021 17:08:54 +0200
Date:   Tue, 20 Jul 2021 17:08:54 +0200
Message-ID: <20210720170854.Horde.zUpZp_h7ZiNgRJJV7AKL7g1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "powerpc/8xx: add support for huge pages on
 VMAP and VMALLOC"
References: <20210720123512.8740-1-will@kernel.org>
 <20210720123512.8740-2-will@kernel.org>
In-Reply-To: <20210720123512.8740-2-will@kernel.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> a écrit :

> This reverts commit a6a8f7c4aa7eb50304b5c4e68eccd24313f3a785.
>
> Commit c742199a014d ("mm/pgtable: add stubs for
> {pmd/pub}_{set/clear}_huge") breaks the boot for arm64 when block
> mappings are used to create the linear map, as this relies on a working
> implementation of pXd_set_huge() even if the corresponding page-table
> levels have been folded.
>
> Although the problematic patch reverts cleanly, doing so breaks the
> build for 32-bit PowerPC 8xx machines, which rely on the default
> function definitions when the corresponding page-table levels are
> folded:
>
>  | powerpc64-linux-ld: mm/vmalloc.o: in function `vunmap_pud_range':
>  | linux/mm/vmalloc.c:362: undefined reference to `pud_clear_huge'
>  | powerpc64-linux-ld: mm/vmalloc.o: in function `vunmap_pmd_range':
>  | linux/mm/vmalloc.c:337: undefined reference to `pmd_clear_huge'
>  | powerpc64-linux-ld: mm/vmalloc.o: in function `vunmap_pud_range':
>  | linux/mm/vmalloc.c:362: undefined reference to `pud_clear_huge'
>  | powerpc64-linux-ld: mm/vmalloc.o: in function `vunmap_pmd_range':
>  | linux/mm/vmalloc.c:337: undefined reference to `pmd_clear_huge'
>  | make: *** [Makefile:1177: vmlinux] Error 1
>
> Although Christophe has kindly offered to look into the arm64 breakage,
> he's on holiday for another 10 days and there isn't an obvious fix on
> the arm64 side which allows us to continue using huge-vmap for affected
> configurations.
>
> In the interest of quickly getting things back to a working state as
> they were in 5.13, revert the huge-vmap changes for PowerPC 8xx prior to
> reverting the change which breaks arm64. We can then work on this
> together for 5.15 once Christophe is back.

Instead of reverting this awaited functionnality,  could you please  
just add the two following functions in arch/powerpc/mm/nohash/8xx.c :

int pud_clear_huge(pud_t *pud)
{
	return 0;
}

int pmd_clear_huge(pmd_t *pmd)
{
	return 0;
}

Thank you
Christophe

>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicholas Piggin <npiggin@gmail.com
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Link:  
> https://lore.kernel.org/r/20210719170615.Horde.Qio1wp3k5ebLo-d9xXHdOg1@messagerie.c-s.fr
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/powerpc/Kconfig                         |  2 +-
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 43 --------------------
>  2 files changed, 1 insertion(+), 44 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d01e3401581d..5fc19ac62cb9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -189,7 +189,7 @@ config PPC
>  	select GENERIC_VDSO_TIME_NS
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
> -	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
> +	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h  
> b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> index 997cec973406..6e4faa0a9b35 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> @@ -178,7 +178,6 @@
>  #ifndef __ASSEMBLY__
>
>  #include <linux/mmdebug.h>
> -#include <linux/sizes.h>
>
>  void mmu_pin_tlb(unsigned long top, bool readonly);
>
> @@ -226,48 +225,6 @@ static inline unsigned int  
> mmu_psize_to_shift(unsigned int mmu_psize)
>  	BUG();
>  }
>
> -static inline bool arch_vmap_try_size(unsigned long addr, unsigned  
> long end, u64 pfn,
> -				      unsigned int max_page_shift, unsigned long size)
> -{
> -	if (end - addr < size)
> -		return false;
> -
> -	if ((1UL << max_page_shift) < size)
> -		return false;
> -
> -	if (!IS_ALIGNED(addr, size))
> -		return false;
> -
> -	if (!IS_ALIGNED(PFN_PHYS(pfn), size))
> -		return false;
> -
> -	return true;
> -}
> -
> -static inline unsigned long arch_vmap_pte_range_map_size(unsigned  
> long addr, unsigned long end,
> -							 u64 pfn, unsigned int max_page_shift)
> -{
> -	if (arch_vmap_try_size(addr, end, pfn, max_page_shift, SZ_512K))
> -		return SZ_512K;
> -	if (PAGE_SIZE == SZ_16K)
> -		return SZ_16K;
> -	if (arch_vmap_try_size(addr, end, pfn, max_page_shift, SZ_16K))
> -		return SZ_16K;
> -	return PAGE_SIZE;
> -}
> -#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
> -
> -static inline int arch_vmap_pte_supported_shift(unsigned long size)
> -{
> -	if (size >= SZ_512K)
> -		return 19;
> -	else if (size >= SZ_16K)
> -		return 14;
> -	else
> -		return PAGE_SHIFT;
> -}
> -#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
> -
>  /* patch sites */
>  extern s32 patch__itlbmiss_exit_1, patch__dtlbmiss_exit_1;
>  extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
> --
> 2.32.0.402.g57bb445576-goog


