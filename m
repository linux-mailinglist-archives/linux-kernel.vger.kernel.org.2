Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FD43948F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhJYLPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhJYLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:14:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0450AC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fWNxGT5LtHzA26MweR5leugLZdnvfvBUGjVtTUT0oqA=; b=JmO3/plrRLhiuyjpPJ1R/qg2up
        RAavhob5okv+8vNs79EfBR0iAkR8EvUaNfaeRXPMKijRHV2/FxTL4HhIInWqsYv61GD6Bw3lb4t5o
        1NAbqU6iwRLcFREv//JAZPYsZ3CisfvORjZ2ryKk/kCPvnhyrFE54mnh+yPdGun7UkKYyWcsF/F+R
        5Z1Q4FXp50qyVsCnAHovDJYi0l4/bN2BKnfHk20kMbSlAf3N5VtSJ23/X0xLGohQeG+EqQ+41R5Xn
        g9xKhO3H1PaxXVkEb8CnROrnKODaxo8EkfC9ELXZkRwvQcOE4Q/pronaCVZoFx5nztcloXylWZxmU
        kSVT7ZfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mexu1-00C8IH-A3; Mon, 25 Oct 2021 11:12:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC66D300230;
        Mon, 25 Oct 2021 13:12:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE47320C6C147; Mon, 25 Oct 2021 13:12:28 +0200 (CEST)
Date:   Mon, 25 Oct 2021 13:12:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 5/5] mm/mprotect: do not flush on permission promotion
Message-ID: <YXaRHE0IrJD2lXeg@hirez.programming.kicks-ass.net>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-6-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021122112.592634-6-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 05:21:12AM -0700, Nadav Amit wrote:
> +/*
> + * pte_may_need_flush() checks whether permissions were demoted and require a
> + * flush. It should only be used for userspace PTEs.
> + */
> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
> +{
> +	/* new is non-present: need only if old is present */
> +	if (!pte_present(newpte))
> +		return pte_present(oldpte);
> +
> +	/* old is not present: no need for flush */
> +	if (!pte_present(oldpte))
> +		return false;

Would it not be clearer to write the above like:

	/* !PRESENT -> * ; no need for flush */
	if (!pte_present(oldpte))
		return false;

	/* PRESENT -> !PRESENT ; needs flush */
	if (!pte_present(newpte))
		return true;

?


> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0f5c87af5c60..6179c82ea72d 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -141,7 +141,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  				ptent = pte_mkwrite(ptent);
>  			}
>  			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
> -			tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
> +			if (pte_may_need_flush(oldpte, ptent))
> +				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>  			pages++;
>  		} else if (is_swap_pte(oldpte)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);

One question on naming, "may_need" sounds a bit washy to me, either it
does or it does not. I suppose you're trying to convey the fact that we
ought to err towards too many TLBi rather than too few, but that's
always true.

That is, would "needs" not be a better name?
