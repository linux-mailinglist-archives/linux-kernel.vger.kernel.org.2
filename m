Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671123E89A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhHKFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhHKFS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:18:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEDD660560;
        Wed, 11 Aug 2021 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628659085;
        bh=KaZ5HktjKJgg/abvCF/afCgcYiL4DoXNFGs6S6USjuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaUw+W5tJLNTIO8XlWFxDhu1sfkl05slqvSv8mec9a6kDYbqIxMRtBZwvk7/a/grn
         MlBkLZBLE1WPjD7gbuz3cvbM0txRFgMvcygTxYNL2OOYxqR27yTL7oW2bJiQ9EIxWp
         Pqpw0krpzymCUfgEA5aPioD/ZznEIMVfNSQ5W/N8t5yHArPjTNP3WMKz7IMUDzlEvW
         42towC/cT4ZDZFZGkeagFNla2KHp5DBcTN7941p1rDtPy/jnI42nkS7IfJ6XYFWJKh
         f3y2RSp3mQYoS1lXUko2AG7CKkHkSHsC2Rkjq8z0+nn7qS4fe70GVez80HzAwxytQc
         vGWMxstpln/lA==
Date:   Wed, 11 Aug 2021 08:18:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 07/18] ARC: ioremap: use more commonly used PAGE_KERNEL
 based uncached flag
Message-ID: <YRNdiDnMjQ2hKzIV@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-8-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811004258.138075-8-vgupta@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 05:42:47PM -0700, Vineet Gupta wrote:
> and remove the one off uncached definition for ARC
> 
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/arc/include/asm/pgtable.h | 3 ---
>  arch/arc/mm/ioremap.c          | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
> index 80b57c14b430..b054c14f8bf6 100644
> --- a/arch/arc/include/asm/pgtable.h
> +++ b/arch/arc/include/asm/pgtable.h
> @@ -103,9 +103,6 @@
>   */
>  #define PAGE_KERNEL          __pgprot(_K_PAGE_PERMS | _PAGE_CACHEABLE)
>  
> -/* ioremap */
> -#define PAGE_KERNEL_NO_CACHE __pgprot(_K_PAGE_PERMS)
> -
>  /* Masks for actual TLB "PD"s */
>  #define PTE_BITS_IN_PD0		(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_HW_SZ)
>  #define PTE_BITS_RWX		(_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ)
> diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
> index 052bbd8b1e5f..0ee75aca6e10 100644
> --- a/arch/arc/mm/ioremap.c
> +++ b/arch/arc/mm/ioremap.c
> @@ -39,7 +39,8 @@ void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
>  	if (arc_uncached_addr_space(paddr))
>  		return (void __iomem *)(u32)paddr;
>  
> -	return ioremap_prot(paddr, size, pgprot_val(PAGE_KERNEL_NO_CACHE));
> +	return ioremap_prot(paddr, size,
> +			    pgprot_val(pgprot_noncached(PAGE_KERNEL)));

But this becomes _PAGE_CACHEABLE now. What did I miss?

>  }
>  EXPORT_SYMBOL(ioremap);
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
