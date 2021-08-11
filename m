Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010BA3E899A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhHKFMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233813AbhHKFMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:12:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75B2D60EB2;
        Wed, 11 Aug 2021 05:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628658732;
        bh=Z7LmDfo4zvKNkhohC0InW+SMDP5rAOUz38E0mqDCwHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=If2GrYZCsWAgUZn4dzhz/2LCPJSsKIUbL6y295qindWqzCnB0YyfeR+v2laCFsBzm
         apcx3Y2yNDWkVUFMLBXlJJMbmrS0WMxn4rqNf2uPrLf0XiIa4t8IaS56iSo7REHPZI
         hiDmPVgoxfTwcSUAdHuG/G2yBJU39eeBbsBcXNQpAsjjWWTpafVDyPXg4YVApk9Iz/
         VRaZZ0dcAFvLuDTrYUFXaujZN7Mq9jufIKrodyvysk9DtREFIr6hO2G2Ku3vP7GpPZ
         8/EAcjdYYoq6D5Jlqbn/eUrzaYTWCUc1WR3rbA3fGypWwPA+Y++GbWXLDHlL+7c5id
         CT1YfSwQyzDYQ==
Date:   Wed, 11 Aug 2021 08:12:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 04/18] ARC: mm: remove pgd_offset_fast
Message-ID: <YRNcJpyr76h5EK0k@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-5-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811004258.138075-5-vgupta@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 05:42:44PM -0700, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/arc/include/asm/pgtable.h | 23 -----------------------
>  arch/arc/mm/fault.c            |  2 +-
>  2 files changed, 1 insertion(+), 24 deletions(-)

Shouldn't this be a part of the patch that removed usage of the scratch reg
for pgd?
 
> diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
> index 0c3e220bd2b4..80b57c14b430 100644
> --- a/arch/arc/include/asm/pgtable.h
> +++ b/arch/arc/include/asm/pgtable.h
> @@ -284,29 +284,6 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	set_pte(ptep, pteval);
>  }
>  
> -/*
> - * Macro to quickly access the PGD entry, utlising the fact that some
> - * arch may cache the pointer to Page Directory of "current" task
> - * in a MMU register
> - *
> - * Thus task->mm->pgd (3 pointer dereferences, cache misses etc simply
> - * becomes read a register
> - *
> - * ********CAUTION*******:
> - * Kernel code might be dealing with some mm_struct of NON "current"
> - * Thus use this macro only when you are certain that "current" is current
> - * e.g. when dealing with signal frame setup code etc
> - */
> -#ifdef ARC_USE_SCRATCH_REG
> -#define pgd_offset_fast(mm, addr)	\
> -({					\
> -	pgd_t *pgd_base = (pgd_t *) read_aux_reg(ARC_REG_SCRATCH_DATA0);  \
> -	pgd_base + pgd_index(addr);	\
> -})
> -#else
> -#define pgd_offset_fast(mm, addr)	pgd_offset(mm, addr)
> -#endif
> -
>  extern pgd_t swapper_pg_dir[] __aligned(PAGE_SIZE);
>  void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  		      pte_t *ptep);
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
> index f5657cb68e4f..41f154320964 100644
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@ -33,7 +33,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
>  	pud_t *pud, *pud_k;
>  	pmd_t *pmd, *pmd_k;
>  
> -	pgd = pgd_offset_fast(current->active_mm, address);
> +	pgd = pgd_offset(current->active_mm, address);
>  	pgd_k = pgd_offset_k(address);
>  
>  	if (!pgd_present(*pgd_k))
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
