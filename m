Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7F30A889
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBANUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBANUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:20:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FAAC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w/fczicmbmO1py4GakJT2Tztq29zaHw4eemdxVZO/3c=; b=g4PopCaGcnb3zTBXhvzk+j7oAd
        zJ8AelvYw1MTMkpBmIjeDx+zuCvzrFeCnDJVpGwz9j1T5xb4smeoznN/3KRhRXjEKKadRofk5wwHm
        AaMT0Nuh4xjcWhF1jyZY1o0/In5o2hyNVyfh2Y4H1UYkkpNup08QvriYvD5ELoO7xPjx4y6zmVJ/+
        wZtTZeVnh7igk0s+2e5dCN6JRBVCRospMcA4qpKId9xhk7jynXS2PKCdN4D0ou7hEsaszWZgCkQXp
        jWBFVX0nNN/sx2tBndNrEcCHyrici0W1wRAMTZlMpasjQP455V7QfPYQI5gz6DlbQ/Prao3jQ77mU
        pR9FmZgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6Z6r-00DoBB-59; Mon, 01 Feb 2021 13:19:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A0ED3011FE;
        Mon,  1 Feb 2021 14:19:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DEBC20C8E333; Mon,  1 Feb 2021 14:19:16 +0100 (CET)
Date:   Mon, 1 Feb 2021 14:19:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [RFC 13/20] mm/tlb: introduce tlb_start_ptes() and tlb_end_ptes()
Message-ID: <YBf/1H/zZ2LNDf3U@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-14-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131001132.3368247-14-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 04:11:25PM -0800, Nadav Amit wrote:
> +#define tlb_start_ptes(tlb)						\
> +	do {								\
> +		struct mmu_gather *_tlb = (tlb);			\
> +									\
> +		flush_tlb_batched_pending(_tlb->mm);			\
> +	} while (0)
> +
> +static inline void tlb_end_ptes(struct mmu_gather *tlb) { }

>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> -	flush_tlb_batched_pending(mm);
> +	tlb_start_ptes(tlb);
>  	arch_enter_lazy_mmu_mode();
>  	for (; addr < end; pte++, addr += PAGE_SIZE) {
>  		ptent = *pte;
> @@ -468,6 +468,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> +	tlb_end_ptes(tlb);
>  	pte_unmap_unlock(orig_pte, ptl);
>  	if (pageout)
>  		reclaim_pages(&page_list);

I don't like how you're dubbling up on arch_*_lazy_mmu_mode(). It seems
to me those should be folded into tlb_{start,end}_ptes().

Alternatively, the even more work approach would be to, add an optional
@tlb argument to pte_offset_map_lock()/pte_unmap_unlock() and friends.
