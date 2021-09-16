Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3B40DB39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhIPNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240008AbhIPNcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6146E60555;
        Thu, 16 Sep 2021 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631799040;
        bh=SnqLVt+EJ1bHNkv2hdNN4FVTS5b7LZ1LwuXCb4PcRGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIOB7bFP2CbmttTqr5DCx0WbVlqgMeI5Unl5ebLD/NwtWpAAvAZCD4lNSBa8enCAA
         GGJGzhkht2XLNC5F8H+0nGLiL2KTRe82wH6DV2zB4eT7pBYk6ap13OCekWLn51jagT
         oyhQRe2po1TKuA9Xv5Dg+oOpbb8M2++GbRJHaZadMBjxJlv3BHy8TrdZd3p45qfbNU
         cFtkTpj7owzNRYVhC2mQdNeyWyAYte9VD1CBQW3g1uiquy0pdh+cVKpOnTLSV84fE/
         zW0WKA1sKZSWVenXuqzidhm/MsqfyPib+UV0iznhsUM24EcNDbG8PHtpf3AHBLxwK7
         oNMrectuEEsdA==
Date:   Thu, 16 Sep 2021 14:30:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, andreyknvl@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, keescook@chromium.org
Subject: Re: [PATCH] mm/vmalloc: Don't allow VM_NO_GUARD on vmap()
Message-ID: <20210916133035.GA8888@willie-the-truck>
References: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:41:56PM +0200, Peter Zijlstra wrote:
> 
> The vmalloc guard pages are added on top of each allocation, thereby
> isolating any two allocations from one another. The top guard of the
> lower allocation is the bottom guard guard of the higher allocation
> etc.
> 
> Therefore VM_NO_GUARD is dangerous; it breaks the basic premise of
> isolating separate allocations.
> 
> There are only two in-tree users of this flag, neither of which use it
> through the exported interface. Ensure it stays this way.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/vmalloc.h | 2 +-
>  mm/vmalloc.c            | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 671d402c3778..10e9571ff0b2 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -22,7 +22,7 @@ struct notifier_block;		/* in notifier.h */
>  #define VM_USERMAP		0x00000008	/* suitable for remap_vmalloc_range */
>  #define VM_DMA_COHERENT		0x00000010	/* dma_alloc_coherent */
>  #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
> -#define VM_NO_GUARD		0x00000040      /* don't add guard page */
> +#define VM_NO_GUARD		0x00000040      /* ***DANGEROUS*** don't add guard page */
>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
>  #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
>  #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..01927ebea267 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2743,6 +2743,13 @@ void *vmap(struct page **pages, unsigned int count,
>  
>  	might_sleep();
>  
> +	/*
> +	 * Your top guard is someone else's bottom guard. Not having a top
> +	 * guard compromises someone else's mappings too.
> +	 */
> +	if (WARN_ON_ONCE(flags & VM_NO_GUARD))
> +		flags &= ~VM_NO_GUARD;
> +
>  	if (count > totalram_pages())
>  		return NULL;

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will
