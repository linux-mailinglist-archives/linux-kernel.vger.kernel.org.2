Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B186E379147
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhEJOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:50:11 -0400
Received: from foss.arm.com ([217.140.110.172]:60044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239628AbhEJOsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:48:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A4B931B;
        Mon, 10 May 2021 07:47:25 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3583F719;
        Mon, 10 May 2021 07:47:23 -0700 (PDT)
Date:   Mon, 10 May 2021 15:43:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Remove [PUD|PMD]_TABLE_BIT from [pud|pmd]_bad()
Message-ID: <20210510144337.GA92897@C02TD0UTHF1T.local>
References: <1620644871-26280-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620644871-26280-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:37:51PM +0530, Anshuman Khandual wrote:
> Semantics wise, [pud|pmd]_bad() have always implied that a given [PUD|PMD]
> entry does not have a pointer to the next level page table. This had been
> made clear in the commit a1c76574f345 ("arm64: mm: use *_sect to check for
> section maps"). Hence explicitly check for a table entry rather than just
> testing a single bit. This basically redefines [pud|pmd]_bad() in terms of
> [pud|pmd]_table() making the semantics clear.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I have no strong feelings either way, so: 

Acked-by: Mark Rutland <mark.rutland@arm.com>

... that said, I think that the "bad" naming is unclear and misleading,
and it'd be really nice if we could clean that up treewide with
something clearer than "bad".

It does seem that would roughly fit p??_leaf() if we had
p??_clear_leaf() and p??_none_or_clear_leaf() helpers.

Thanks,
Mark.

> ---
> This applies on v5.13-rc1.
> 
>  arch/arm64/include/asm/pgtable.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 25f5c04b43ce..69f8183bef29 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -509,13 +509,12 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  
>  #define pmd_none(pmd)		(!pmd_val(pmd))
>  
> -#define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
> -
>  #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>  				 PMD_TYPE_TABLE)
>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>  				 PMD_TYPE_SECT)
>  #define pmd_leaf(pmd)		pmd_sect(pmd)
> +#define pmd_bad(pmd)		(!pmd_table(pmd))
>  
>  #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
>  #define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
> @@ -602,7 +601,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
>  
>  #define pud_none(pud)		(!pud_val(pud))
> -#define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
> +#define pud_bad(pud)		(!pud_table(pud))
>  #define pud_present(pud)	pte_present(pud_pte(pud))
>  #define pud_leaf(pud)		pud_sect(pud)
>  #define pud_valid(pud)		pte_valid(pud_pte(pud))
> -- 
> 2.20.1
> 
