Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C3421F26
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJEG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhJEG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:56:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99637C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Qr22602shIdzzG2+Obu3zaMUVwn4jZ1NQIj+6vzc1lo=; b=P4J3v3j7xLp7hyJWqzhO0yGpj8
        Xjzn5UPhR+dBYwUCMfMEpEY6kBEZfZIf7h9GQU6M5KlPR4T3E9t4zWarsuxneRlYJ2WAnE9934EZa
        4AME/jedTwabAuyHP8YltPfLh7l6Qjb/cLFH1TNgqIgP7p31I4jnYJVNs50AQXgRkyaasqpWcb/oq
        493+ts8zxHuPj3/qjhZRsjUqrKKiupnBEv5Zw6IeKIcTNEMksRcmpYAEpuiqJw7zSueaE0dI4AGge
        UihAu33VdZ47vO4EhFDIY7i7rGi2o7FhFz13HZSdQ6nXlrpdS1nMWGTOFQeECFxmNE5BuxKWtBV6r
        i6QUTB4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXeKW-0004jQ-1X; Tue, 05 Oct 2021 06:53:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE3739811EE; Tue,  5 Oct 2021 08:53:35 +0200 (CEST)
Date:   Tue, 5 Oct 2021 08:53:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
Message-ID: <20211005065335.GG4323@worktop.programming.kicks-ass.net>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
 <20211003121019.GF4323@worktop.programming.kicks-ass.net>
 <620B1A38-1457-4F77-8666-E73A318392B6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <620B1A38-1457-4F77-8666-E73A318392B6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 12:24:14PM -0700, Nadav Amit wrote:
> 
> 
> > On Oct 3, 2021, at 5:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
> > 
> >> @@ -338,25 +344,25 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
> >> 	struct mm_struct *mm = vma->vm_mm;
> >> 	pgd_t *pgd;
> >> 	unsigned long next;
> >> -	unsigned long start = addr;
> >> 	unsigned long pages = 0;
> >> +	struct mmu_gather tlb;
> >> 
> >> 	BUG_ON(addr >= end);
> >> 	pgd = pgd_offset(mm, addr);
> >> 	flush_cache_range(vma, addr, end);
> >> 	inc_tlb_flush_pending(mm);
> > 
> > That seems unbalanced...
> 
> Bad rebase. Thanks for catching it!
> 
> > 
> >> +	tlb_gather_mmu(&tlb, mm);
> >> +	tlb_start_vma(&tlb, vma);
> >> 	do {
> >> 		next = pgd_addr_end(addr, end);
> >> 		if (pgd_none_or_clear_bad(pgd))
> >> 			continue;
> >> -		pages += change_p4d_range(vma, pgd, addr, next, newprot,
> >> +		pages += change_p4d_range(&tlb, vma, pgd, addr, next, newprot,
> >> 					  cp_flags);
> >> 	} while (pgd++, addr = next, addr != end);
> >> 
> >> -	/* Only flush the TLB if we actually modified any entries: */
> >> -	if (pages)
> >> -		flush_tlb_range(vma, start, end);
> >> -	dec_tlb_flush_pending(mm);
> > 
> > ... seeing you do remove the extra decrement.
> 
> Is it really needed? We do not put this comment elsewhere for
> tlb_finish_mmu(). But no problem, I’ll keep it.

-ENOPARSE, did you read decrement as comment? In any case, I don't
particularly care about the comment, and tlb_*_mmu() imply the inc/dec
thingies.

All I tried to do is point out that removing the dec but leaving the inc
is somewhat inconsistent :-)
