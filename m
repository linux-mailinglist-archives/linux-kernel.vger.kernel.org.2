Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0F30A7A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBAM3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBAM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:29:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDAC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DH1LPO33/0czZh+7CrFmp0uq6mDgTJMK8cCrtZOax5g=; b=iglQvYKCNbZo+ptxfnjYBkQG6K
        CAQXM+4UdQl4Qnq6Y3ERlHNy+jcKFR9UMD8z5QyElM37REHrDl3QkDUUzgVTjLsjfXCcQqheZ2Xd/
        BXA3WyDewu1JYUEKXTeNF+0T4fNOVztnTzXN4fY03x8YvWu18EnjOdtRRzr1/bhd7+1ql0gMYPW7y
        s5nhHmd4McV0fEojawcFN1W32735Ip3btUSK4f0xNnLLxHOE4T1O+cJDHknIsBQgwqfZxJaEa3bjQ
        /lF6jjyVMnEwTY0aaGs67A365N3F3V/nARuvO/UmsKbikNEeoyQgFO2gENsyPaqvVKrfs+pnTMxdy
        kJw12mCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6YJo-00Dl5K-2w; Mon, 01 Feb 2021 12:28:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 722BE3011FE;
        Mon,  1 Feb 2021 13:28:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59BE320C8E312; Mon,  1 Feb 2021 13:28:32 +0100 (CET)
Date:   Mon, 1 Feb 2021 13:28:32 +0100
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
Subject: Re: [RFC 12/20] mm/tlb: save the VMA that is flushed during
 tlb_start_vma()
Message-ID: <YBfz8MMQ25xkjO7e@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-13-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131001132.3368247-13-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 04:11:24PM -0800, Nadav Amit wrote:

> @@ -283,12 +290,6 @@ struct mmu_gather {
>  	unsigned int		cleared_puds : 1;
>  	unsigned int		cleared_p4ds : 1;
>  
> -	/*
> -	 * tracks VM_EXEC | VM_HUGETLB in tlb_start_vma
> -	 */
> -	unsigned int		vma_exec : 1;
> -	unsigned int		vma_huge : 1;
> -
>  	unsigned int		batch_count;
>  
>  #ifndef CONFIG_MMU_GATHER_NO_GATHER

> @@ -372,38 +369,20 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>  	if (tlb->fullmm || tlb->need_flush_all) {
>  		flush_tlb_mm(tlb->mm);
>  	} else if (tlb->end) {
> -		struct vm_area_struct vma = {
> -			.vm_mm = tlb->mm,
> -			.vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
> -				    (tlb->vma_huge ? VM_HUGETLB : 0),
> -		};
> -
> -		flush_tlb_range(&vma, tlb->start, tlb->end);
> +		VM_BUG_ON(!tlb->vma);
> +		flush_tlb_range(tlb->vma, tlb->start, tlb->end);
>  	}
>  }

I don't much like this, and I think this is a step in the wrong
direction.

The idea is to extend the tlb_{remove,flush}_*() API to provide the
needed information to do TLB flushing. In fact, I think
tlb_remove_huge*() is already sufficient to set the VM_EXEC 'hint'. We
just don't have anything that covers the EXEC thing.

(also, I suspect the page_size crud we have also covers that)

Constructing a fake vma very much ensures arch tlb routines don't go
about and look at anything else either.

> +tlb_update_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
> -	/*
> -	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
> -	 * mips-4k) flush only large pages.
> -	 *
> -	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
> -	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
> -	 * range.
> -	 *
> -	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
> -	 * these values the batch is empty.
> -	 */
> -	tlb->vma_huge = is_vm_hugetlb_page(vma);
> -	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> +	tlb->vma = vma;
>  }

And you're also removing the useful information about arch tlb flush
functions.
