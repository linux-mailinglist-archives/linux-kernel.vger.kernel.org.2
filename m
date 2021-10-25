Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABCD439412
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhJYKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhJYKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:55:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DCDC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=37pEA9KAU9KSHTfwbmN3OIgu/ct9YJ/MS91p5yc7dvY=; b=cb20feDN+uNCfAtXD2CJVv0CzV
        ARZqjBAlXKlAWjRhdf1WilByn8mkbHBnYYIkJj/D5wmUfF69WIVPNVZ0syA5T1YcouXLPJiHjq5v4
        bziNSKXDW2/d+1OpsN4MoZNAp6vmZ2wASFUpXH57Yn5lJQh68BG28vrltepXipF1FNKyOjrWXgZw1
        lYCTqSh0tIK4/GjYPYTXJCIFgJN8FJr13szXlsq4DSOqs9URx7T42cS9fa6uo4rRmBbUbrd3TO5a/
        b6eZD07pwSm7dLeEbLUnta1bman38CfzMbOSMUgJS7iEXhS9SMz+9HLvXTeEENX1mF5bMWICeQqxi
        iehKFzWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mexac-00C86Z-BQ; Mon, 25 Oct 2021 10:52:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F27D23003A9;
        Mon, 25 Oct 2021 12:52:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC17220C6C147; Mon, 25 Oct 2021 12:52:25 +0200 (CEST)
Date:   Mon, 25 Oct 2021 12:52:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
Message-ID: <YXaMaUbdDOxMTstc@hirez.programming.kicks-ass.net>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021122112.592634-3-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 05:21:09AM -0700, Nadav Amit wrote:
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 448cd01eb3ec..18c3366f8f4d 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1146,6 +1146,14 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  	}
>  }
>  #endif
> +
> +#define __HAVE_ARCH_PMDP_INVALIDATE_AD
> +static inline pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
> +				       unsigned long address, pmd_t *pmdp)
> +{
> +	return pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));

Did this want to be something like:

	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
	if (cpu_feature_enabled(X86_BUG_PTE_LEAK))
		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
	return old;

instead?

> +}
> +
>  /*
>   * Page table pages are page-aligned.  The lower half of the top
>   * level is used for userspace and the top half for the kernel.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5ea5f775d5c..435da011b1a2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1795,10 +1795,11 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * The race makes MADV_DONTNEED miss the huge pmd and don't clear it
>  	 * which may break userspace.
>  	 *
> -	 * pmdp_invalidate() is required to make sure we don't miss
> -	 * dirty/young flags set by hardware.
> +	 * pmdp_invalidate_ad() is required to make sure we don't miss
> +	 * dirty/young flags (which are also known as access/dirty) cannot be
> +	 * further modifeid by the hardware.

"modified", I think is the more common spelling.

>  	 */
> -	entry = pmdp_invalidate(vma, addr, pmd);
> +	entry = pmdp_invalidate_ad(vma, addr, pmd);
>  
>  	entry = pmd_modify(entry, newprot);
>  	if (preserve_write)
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 4e640baf9794..b0ce6c7391bf 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -200,6 +200,14 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD

/*
 * Does this deserve a comment to explain the intended difference vs
 * pmdp_invalidate() ?
 */

> +pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
> +			 pmd_t *pmdp)
> +{
> +	return pmdp_invalidate(vma, address, pmdp);
> +}
> +#endif
> +
>  #ifndef pmdp_collapse_flush
>  pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
>  			  pmd_t *pmdp)
> -- 
> 2.25.1
> 
