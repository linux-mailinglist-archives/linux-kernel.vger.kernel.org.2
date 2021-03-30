Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D734E930
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhC3Nd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhC3NdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:33:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD404B2FB;
        Tue, 30 Mar 2021 13:33:12 +0000 (UTC)
Date:   Tue, 30 Mar 2021 14:33:10 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] NUMA balancing: reduce TLB flush via delaying mapping on
 hint page fault
Message-ID: <20210330133310.GT15768@suse.de>
References: <20210329062651.2487905-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210329062651.2487905-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 02:26:51PM +0800, Huang Ying wrote:
> For NUMA balancing, in hint page fault handler, the faulting page will
> be migrated to the accessing node if necessary.  During the migration,
> TLB will be shot down on all CPUs that the process has run on
> recently.  Because in the hint page fault handler, the PTE will be
> made accessible before the migration is tried.  The overhead of TLB
> shooting down is high, so it's better to be avoided if possible.  In
> fact, if we delay mapping the page in PTE until migration, that can be
> avoided.  This is what this patch doing.
> 

Why would the overhead be high? It was previously inaccessibly so it's
only parallel accesses making forward progress that trigger the need
for a flush. As your change notes -- "The benchmark score has no visible
changes". The patch was neither a win nor a loss for your target workload
but there are more fundamental issues to consider.

> We have tested the patch with the pmbench memory accessing benchmark
> on a 2-socket Intel server, and found that the number of the TLB
> shooting down IPI reduces up to 99% (from ~6.0e6 to ~2.3e4) if NUMA
> balancing is triggered (~8.8e6 pages migrated).  The benchmark score
> has no visible changes.
> 
> Known issues:
> 
> For the multiple threads applications, it's possible that the page is
> accessed by 2 threads almost at the same time.  In the original
> implementation, the second thread may go accessing the page directly
> because the first thread has installed the accessible PTE.  While with
> this patch, there will be a window that the second thread will find
> the PTE is still inaccessible.  But the difference between the
> accessible window is small.  Because the page will be made
> inaccessible soon for migrating.
> 

If multiple threads trap the hinting fault, only one potentially attempts
a migration as the others observe the PTE has changed when the PTL is
acquired and return to userspace. Such threads then have a short window to
make progress before the PTE *potentially* becomes a migration PTE and
during that window, the parallel access may not need the page any more
and never stall on the migration.

That migration PTE may never be created if migrate_misplaced_page
chooses to ignore the PTE in which case there is minimal disruption.

If migration is attempted, then the time until the migration PTE is
created is variable. The page has to be isolated from the LRU so there
could be contention on the LRU lock, a new page has to be allocated and
that allocation potentially has to enter the page allocator slow path
etc. During that time, parallel threads make forward progress but with
the patch, multiple threads potentially attempt the allocation and fail
instead of doing real work.

You should consider the following question -- is the potential saving
of an IPI transmission enough to offset the cost of parallel accesses
not making forward progress while one migration is setup and having
different migration attempts collide?

I have tests running just in case but I think the answer may be "no".
So far only one useful test as completed (specjbb2005 with one VM per NUMA
node) and it showed a mix of small gains and losses but with *higher*
interrupts contrary to what was expected from the changelog. For some
thread counts, the results showed large differences in variability,
sometimes lower and sometimes much higher.

It makes me think that a workload should be identified that really
benefits from the IPI savings are enough to justify stalling parallel
accesses that could be making forward progress.

One nit below

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Matthew Wilcox" <willy@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Arjun Roy <arjunroy@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> ---
>  mm/memory.c | 54 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d3273bd69dbb..a9a8ed1ac06c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4148,29 +4148,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  		goto out;
>  	}
>  
> -	/*
> -	 * Make it present again, Depending on how arch implementes non
> -	 * accessible ptes, some can allow access by kernel mode.
> -	 */
> -	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
> +	/* Get the normal PTE  */
> +	old_pte = ptep_get(vmf->pte);
>  	pte = pte_modify(old_pte, vma->vm_page_prot);
> -	pte = pte_mkyoung(pte);
> -	if (was_writable)
> -		pte = pte_mkwrite(pte);
> -	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
> -	update_mmu_cache(vma, vmf->address, vmf->pte);
>  
>  	page = vm_normal_page(vma, vmf->address, pte);
> -	if (!page) {
> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
> -		return 0;
> -	}
> +	if (!page)
> +		goto out_map;
>  
>  	/* TODO: handle PTE-mapped THP */
> -	if (PageCompound(page)) {
> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
> -		return 0;
> -	}
> +	if (PageCompound(page))
> +		goto out_map;
>  
>  	/*
>  	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
> @@ -4180,7 +4168,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	 * pte_dirty has unpredictable behaviour between PTE scan updates,
>  	 * background writeback, dirty balancing and application behaviour.
>  	 */
> -	if (!pte_write(pte))
> +	if (was_writable)
>  		flags |= TNF_NO_GROUP;
>  
>  	/*

Not clear why this change was made.

> @@ -4194,23 +4182,45 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	page_nid = page_to_nid(page);
>  	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
>  			&flags);
> -	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	if (target_nid == NUMA_NO_NODE) {
>  		put_page(page);
> -		goto out;
> +		goto out_map;
>  	}
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  
>  	/* Migrate to the requested node */
>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>  		page_nid = target_nid;
>  		flags |= TNF_MIGRATED;
> -	} else
> +	} else {
>  		flags |= TNF_MIGRATE_FAIL;
> +		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> +		spin_lock(vmf->ptl);
> +		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> +			pte_unmap_unlock(vmf->pte, vmf->ptl);
> +			goto out;
> +		}
> +		goto out_map;
> +	}
>  
>  out:
>  	if (page_nid != NUMA_NO_NODE)
>  		task_numa_fault(last_cpupid, page_nid, 1, flags);
>  	return 0;
> +out_map:
> +	/*
> +	 * Make it present again, Depending on how arch implementes non
> +	 * accessible ptes, some can allow access by kernel mode.
> +	 */
> +	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
> +	pte = pte_modify(old_pte, vma->vm_page_prot);
> +	pte = pte_mkyoung(pte);
> +	if (was_writable)
> +		pte = pte_mkwrite(pte);
> +	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
> +	update_mmu_cache(vma, vmf->address, vmf->pte);
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	goto out;
>  }
>  
>  static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
> -- 
> 2.30.2
> 

-- 
Mel Gorman
SUSE Labs
