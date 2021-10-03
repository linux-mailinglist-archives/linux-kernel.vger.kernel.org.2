Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6831B42016C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhJCMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJCMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:13:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D2C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/yJMhw3wPQSlyKaEi+lnBPfgzZ18ON2DTC2x75zIHa0=; b=Z/3qakIcDJeLpgvVAHld4Swu0L
        2ZRyHoY1CSgsQSiX2/o9b3Dhr37N2z0Fg+Bf6cIjz2JY/wy9rMpUNfgLs+XESSEyZeklyiqmnmfQ8
        yVNXsce+LInTB002JXsZk8AtSl9l/VEYBYOcX6VxnPsHSlMOvr2Pknu00fnsPJqJxGezk9qIugd1G
        6ZP5z2SnHBNTiKLn3ogL9BL3zq2ZL89aRqruXT06YPExcvdkutVzYJl8t7inCuQ1FF+HMzps69JYW
        lVwvJlMl0JwGxuoIMBWIsTOEe5wtGInNwYObBmkEtsXuoBi6hDR7fK+SvFCBAF/cI1ewgiWEETLFh
        36LknG7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mX0Jw-00Ftb6-KR; Sun, 03 Oct 2021 12:10:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CC12981431; Sun,  3 Oct 2021 14:10:19 +0200 (CEST)
Date:   Sun, 3 Oct 2021 14:10:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
Message-ID: <20211003121019.GF4323@worktop.programming.kicks-ass.net>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925205423.168858-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:

> @@ -338,25 +344,25 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  	pgd_t *pgd;
>  	unsigned long next;
> -	unsigned long start = addr;
>  	unsigned long pages = 0;
> +	struct mmu_gather tlb;
>  
>  	BUG_ON(addr >= end);
>  	pgd = pgd_offset(mm, addr);
>  	flush_cache_range(vma, addr, end);
>  	inc_tlb_flush_pending(mm);

That seems unbalanced...

> +	tlb_gather_mmu(&tlb, mm);
> +	tlb_start_vma(&tlb, vma);
>  	do {
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none_or_clear_bad(pgd))
>  			continue;
> -		pages += change_p4d_range(vma, pgd, addr, next, newprot,
> +		pages += change_p4d_range(&tlb, vma, pgd, addr, next, newprot,
>  					  cp_flags);
>  	} while (pgd++, addr = next, addr != end);
>  
> -	/* Only flush the TLB if we actually modified any entries: */
> -	if (pages)
> -		flush_tlb_range(vma, start, end);
> -	dec_tlb_flush_pending(mm);

... seeing you do remove the extra decrement.

> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb);
>  
>  	return pages;
>  }
> -- 
> 2.25.1
> 
