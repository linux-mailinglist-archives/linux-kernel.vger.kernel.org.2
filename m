Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A172238AE22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhETMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhETMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:25:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A99C0AF785
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sCwMcwa2kg+AkPZlCazcoWrH/8f3pwrtAWEJ7S1Wl2E=; b=Khd3SqXf04hdLqifmK3uHZXml7
        ucZy4r+VIk1NG7qnnD7BFbEJXFNDJ/VsBeXs3GQ/xZM40wHNkkwTOz1nnpTq17B5cwoilo/LE8WiB
        LCyBf5JWa9+KzyLiKFJTyFr/63bMSzB3o2G4RekJAbQyLrQVqt0jB3pyKEfFSsez+hkZpdS2HvkWK
        m2dWbtBC7Z+d42YNM9kYHzjL2/8LFQy8NKDn9RwEIerk18sV/rzmCNhc6VfGYJBfKNwnr5w50uV91
        fC2qTC7m+gYvPoeK05JXn+7JhJP5jVgCiy1U+ZZmFDN8fqzyP4UJykCeCCGSHPnGppP54qcEM/hWD
        ef5ROLFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljgg8-00FtvO-JY; Thu, 20 May 2021 11:18:07 +0000
Date:   Thu, 20 May 2021 12:17:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on
 USE_SPLIT_PTE_PTLOCKS
Message-ID: <YKZFRPqg4wKjOdVg@casper.infradead.org>
References: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:03:06PM +0530, Anshuman Khandual wrote:
> Split ptlocks need not be defined and allocated unless they are being used.
> ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
> just makes it explicit and clear. While here drop the spinlock_t element
> from the struct page when USE_SPLIT_PTE_PTLOCKS is not enabled.

I didn't spot this email yesterday.  I'm not a fan.  Isn't struct page
already complicated enough without adding another ifdef to it?  Surely
there's a better way than this.

> +++ b/include/linux/mm_types.h
> @@ -152,10 +152,12 @@ struct page {
>  				struct mm_struct *pt_mm; /* x86 pgds only */
>  				atomic_t pt_frag_refcount; /* powerpc */
>  			};
> +#if USE_SPLIT_PTE_PTLOCKS
>  #if ALLOC_SPLIT_PTLOCKS
>  			spinlock_t *ptl;
>  #else
>  			spinlock_t ptl;
> +#endif
>  #endif
>  		};
>  		struct {	/* ZONE_DEVICE pages */
