Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0785E3E9005
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhHKMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232160AbhHKMEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:04:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6127D60F55;
        Wed, 11 Aug 2021 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628683466;
        bh=1/ul8lTpnB4T++xzDF3kRFrA2xyEls7zKujxDteqWws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVoRi/drbZA10GqMWQqMmCoGAgW4Royyy0CA+6YNMUfjh0ivQaLCh9tX9suVJWJhQ
         DHwrdzBb+C3sDOcDa7hs/wGTbPlX7jTnhKThl1cLojTXdv/nywsx5dinAFS8ml7Qpe
         6M548VZLJmoJwx1UJlLzoKqbPE0VldIiADMotoUf986q2t8pTy8S6ntOBUqtTWyPHQ
         4TfSQ2U4+U9Bevg+AIfxFDiOW3awR2RdFk65K/GAoYfjcDynTwnD9x+mjr5wb3uKdx
         rmWZZ+roqwqo8cE+AlXBnZ1jNmJwsqt5XH6EaPIFkg1uGUBH6QAfRro3yE0VetTfKT
         v/W01nfpUVP8A==
Date:   Wed, 11 Aug 2021 15:04:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 06/18] ARC: mm: Enable STRICT_MM_TYPECHECKS
Message-ID: <YRO8xUlAtMeJnDbe@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-7-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811004258.138075-7-vgupta@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 05:42:46PM -0700, Vineet Gupta wrote:
> In the past I've refrained from doing this (atleast 2 times) due to the

                                            ^ at least

> slight code bloat due to ABI implications of pte_t etc becoming sttuct

                                                                 ^ struct
> 
> Per ARC ABI, functions return struct via memory and not through register
> r0, even if the struct would fits in register(s)

                              ^ fit
> 
>  - caller allocates space on stack and passes the address as first arg
>    (r0), shifting rest of args by one
> 
>  - callee creates return struct in memory (referenced via r0)
> 
> This time around the code actually shrunk slightly (due to subtle
> inlining heuristic effects), but still slightly inefficient due to
> return values passed through memory. That however seems like a small

Out of curiosity, is this actually measurable on real world applications?

> cost compared to maintenance burden given the impending new mmu support
> for page walk etc
> 
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/arc/include/asm/page.h | 26 --------------------------
>  arch/arc/mm/ioremap.c       |  2 +-
>  2 files changed, 1 insertion(+), 27 deletions(-)
> 
> diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
> index 4a9d33372fe2..c4ac827379cd 100644
> --- a/arch/arc/include/asm/page.h
> +++ b/arch/arc/include/asm/page.h
> @@ -34,12 +34,6 @@ void copy_user_highpage(struct page *to, struct page *from,
>  			unsigned long u_vaddr, struct vm_area_struct *vma);
>  void clear_user_page(void *to, unsigned long u_vaddr, struct page *page);
>  
> -#undef STRICT_MM_TYPECHECKS
> -
> -#ifdef STRICT_MM_TYPECHECKS
> -/*
> - * These are used to make use of C type-checking..
> - */
>  typedef struct {
>  #ifdef CONFIG_ARC_HAS_PAE40
>  	unsigned long long pte;
> @@ -64,26 +58,6 @@ typedef struct {
>  
>  #define pte_pgprot(x) __pgprot(pte_val(x))
>  
> -#else /* !STRICT_MM_TYPECHECKS */
> -
> -#ifdef CONFIG_ARC_HAS_PAE40
> -typedef unsigned long long pte_t;
> -#else
> -typedef unsigned long pte_t;
> -#endif
> -typedef unsigned long pgd_t;
> -typedef unsigned long pgprot_t;
> -
> -#define pte_val(x)	(x)
> -#define pgd_val(x)	(x)
> -#define pgprot_val(x)	(x)
> -#define __pte(x)	(x)
> -#define __pgd(x)	(x)
> -#define __pgprot(x)	(x)
> -#define pte_pgprot(x)	(x)
> -
> -#endif
> -
>  typedef pte_t * pgtable_t;
>  
>  /*
> diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
> index 95c649fbc95a..052bbd8b1e5f 100644
> --- a/arch/arc/mm/ioremap.c
> +++ b/arch/arc/mm/ioremap.c
> @@ -39,7 +39,7 @@ void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
>  	if (arc_uncached_addr_space(paddr))
>  		return (void __iomem *)(u32)paddr;
>  
> -	return ioremap_prot(paddr, size, PAGE_KERNEL_NO_CACHE);
> +	return ioremap_prot(paddr, size, pgprot_val(PAGE_KERNEL_NO_CACHE));
>  }
>  EXPORT_SYMBOL(ioremap);
>  
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
