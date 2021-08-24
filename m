Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE18F3F5F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhHXNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237571AbhHXNhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:37:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9911B6113B;
        Tue, 24 Aug 2021 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629812180;
        bh=WjUMkQNz8BXdmmzGgZfIvQXaLnwVHiI+UpdqeqPwc4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrT0k65qzo5JlmgqGUXvSzZpfqN/HVq6vntPw10xDmDpa1CxSXEFviP/xnYfLHV+f
         mWeJzoVjcsxwlXalrN73X/M75Nh8rqwVGGNLqG+nbVmFK/YKvCrVZZ+F/uu4dog+Mc
         75QIB2Zpd4X013k9FzyhBzyM7AY8HZJTrS/7H76hYQC1cpx3j8cIHV1diaw3yqbhbq
         iiVQ+GqYcYTfPkGXqwL0+EVWyuM+g/LbWbE4lXEjozryNLCtWqjfzySTum1nPi8QEi
         bvqZFzkke44PLYiAYbeqdD0aRW5DRW4MU74pizzsg3O7c+rLP0dJeZOWtGM3TzqTDz
         FNwwb9kdAlOAg==
Date:   Tue, 24 Aug 2021 16:36:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Message-ID: <YST1zQ0FugifJnfi@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <FB6C09CD-9CEA-4FE8-B179-98DB63EBDD68@gmail.com>
 <05242256-4B5F-4AD6-B7DA-46A583335E5C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05242256-4B5F-4AD6-B7DA-46A583335E5C@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:34:42PM -0700, Nadav Amit wrote:
> On Aug 23, 2021, at 10:32 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> > 
> > On Aug 23, 2021, at 6:25 AM, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Allocate page table using __GFP_PTE_MAPPED so that they will have 4K PTEs
> > in the direct map. This allows to switch _PAGE_RW bit each time a page
> > table page needs to be made writable or read-only.
> > 
> > The writability of the page tables is toggled only in the lowest level page
> > table modifiction functions and immediately switched off.
> > 
> > The page tables created early in the boot (including the direct map page
> > table) are not write protected.
> > 
> > 
> 
> [ snip ]
> 
> > +static void pgtable_write_set(void *pg_table, bool set)
> > +{
> > +	int level = 0;
> > +	pte_t *pte;
> > +
> > +	/*
> > +	 * Skip the page tables allocated from pgt_buf break area and from
> > +	 * memblock
> > +	 */
> > +	if (!after_bootmem)
> > +		return;
> > +	if (!PageTable(virt_to_page(pg_table)))
> > +		return;
> > +
> > +	pte = lookup_address((unsigned long)pg_table, &level);
> > +	if (!pte || level != PG_LEVEL_4K)
> > +		return;
> > +
> > +	if (set) {
> > +		if (pte_write(*pte))
> > +			return;
> > +
> > +		WRITE_ONCE(*pte, pte_mkwrite(*pte));
> 
> I think that the pte_write() test (and the following one) might hide
> latent bugs. Either you know whether the PTE is write-protected or you
> need to protect against nested/concurrent calls to pgtable_write_set()
> by disabling preemption/IRQs.
> 
> Otherwise, you risk in having someone else write-protecting the PTE
> after it is write-unprotected and before it is written - causing a crash,
> or write-unprotecting it after it is protected - which circumvents the
> protection.
> 
> Therefore, I would think that instead you should have:
> 
> 	VM_BUG_ON(pte_write(*pte));  // (or WARN_ON_ONCE())
> 
> In addition, if there are assumptions on the preemptability of the code,
> it would be nice to have some assertions. I think that the code assumes
> that all calls to pgtable_write_set() are done while holding the
> page-table lock. If that is the case, perhaps adding some lockdep
> assertion would also help to confirm the correctness.
> 
> [ I put aside the lack of TLB flushes, which make the whole matter of
> delivered protection questionable. I presume that once PKS is used, 
> this is not an issue. ]

As I said in another reply, the actual page table protection is merely to
exercise the allocator. I'll consider to actually use PKS for the next
versions (unless Rick beats me to it).

-- 
Sincerely yours,
Mike.
