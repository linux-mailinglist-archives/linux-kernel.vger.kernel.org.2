Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA134FF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhCaLUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:20:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:27047 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234995AbhCaLUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:20:15 -0400
IronPort-SDR: H4W2hqzacJincwObjBazHBLprga8tOhFGBxh+X0Tvl835bV+BHkhA5BmR/MbOQj3alz7El3ocj
 VmIzV4ryv9Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="192086272"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="192086272"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 04:20:14 -0700
IronPort-SDR: k8VF4N9TTMSeM5+iMweQPOecMGNBNJpms1kKHocVXInsJ9RK76mY5S4ozwMYWlB38OdH2YpQhU
 Ny/eZSerN3MQ==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="418627704"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 04:20:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Peter Xu" <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] NUMA balancing: reduce TLB flush via delaying mapping on
 hint page fault
References: <20210329062651.2487905-1-ying.huang@intel.com>
        <20210330133310.GT15768@suse.de>
Date:   Wed, 31 Mar 2021 19:20:09 +0800
In-Reply-To: <20210330133310.GT15768@suse.de> (Mel Gorman's message of "Tue,
        30 Mar 2021 14:33:10 +0100")
Message-ID: <87a6qj8t92.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Mon, Mar 29, 2021 at 02:26:51PM +0800, Huang Ying wrote:
>> For NUMA balancing, in hint page fault handler, the faulting page will
>> be migrated to the accessing node if necessary.  During the migration,
>> TLB will be shot down on all CPUs that the process has run on
>> recently.  Because in the hint page fault handler, the PTE will be
>> made accessible before the migration is tried.  The overhead of TLB
>> shooting down is high, so it's better to be avoided if possible.  In
>> fact, if we delay mapping the page in PTE until migration, that can be
>> avoided.  This is what this patch doing.
>> 
>
> Why would the overhead be high? It was previously inaccessibly so it's
> only parallel accesses making forward progress that trigger the need
> for a flush.

Sorry, I don't understand this.  Although the page is inaccessible, the
threads may access other pages, so TLB flushing is still necessary.

> As your change notes -- "The benchmark score has no visible
> changes". The patch was neither a win nor a loss for your target workload
> but there are more fundamental issues to consider.
>
>> We have tested the patch with the pmbench memory accessing benchmark
>> on a 2-socket Intel server, and found that the number of the TLB
>> shooting down IPI reduces up to 99% (from ~6.0e6 to ~2.3e4) if NUMA
>> balancing is triggered (~8.8e6 pages migrated).  The benchmark score
>> has no visible changes.
>> 
>> Known issues:
>> 
>> For the multiple threads applications, it's possible that the page is
>> accessed by 2 threads almost at the same time.  In the original
>> implementation, the second thread may go accessing the page directly
>> because the first thread has installed the accessible PTE.  While with
>> this patch, there will be a window that the second thread will find
>> the PTE is still inaccessible.  But the difference between the
>> accessible window is small.  Because the page will be made
>> inaccessible soon for migrating.
>> 
>
> If multiple threads trap the hinting fault, only one potentially attempts
> a migration as the others observe the PTE has changed when the PTL is
> acquired and return to userspace. Such threads then have a short window to
> make progress before the PTE *potentially* becomes a migration PTE and
> during that window, the parallel access may not need the page any more
> and never stall on the migration.

Yes.

> That migration PTE may never be created if migrate_misplaced_page
> chooses to ignore the PTE in which case there is minimal disruption.

Yes.  And in the patched kernel, if numa_migrate_prep() returns
NUMA_NO_NODE or migrate_misplaced_page() returns 0, the PTE will be made
accessible too.

> If migration is attempted, then the time until the migration PTE is
> created is variable. The page has to be isolated from the LRU so there
> could be contention on the LRU lock, a new page has to be allocated and
> that allocation potentially has to enter the page allocator slow path
> etc. During that time, parallel threads make forward progress but with
> the patch, multiple threads potentially attempt the allocation and fail
> instead of doing real work.

If my understanding of the code were correct, only the first thread will
attempt the isolation and allocation.  Because TestClearPageLRU() is
called in

  migrate_misplaced_page()
    numamigrate_isolate_page()
      isolate_lru_page()

And migrate_misplaced_page() will return 0 immediately if
TestClearPageLRU() returns false.  Then the second thread will make the
page accessible and make forward progress.

But there's still some timing difference between the original and
patched kernel.  We have several choices to reduce the difference.

1. Check PageLRU() with PTL held in do_numa_page()

If PageLRU() return false, do_numa_page() can make the page accessible
firstly.  So the second thread will make the page accessible earlier.

2. Try to lock the page with PTL held in do_numa_page()

If the try-locking succeeds, it's the first thread, so it can delay
mapping.  If try-locking fails, it may be the second thread, so it will
make the page accessible firstly.  We need to teach
migrate_misplaced_page() to work with the page locked.  This will
enlarge the duration that the page is locked.  Is it a problem?

3. Check page_count() with PTL held in do_numa_page()

The first thread will call get_page() in numa_migrate_prep().  So if the
second thread can detect that, it can make the page accessible firstly.
The difficulty is that it appears hard to identify the expected
page_count() for the file pages.  For anonymous pages, that is much
easier, so at least if a page passes the following test, we can delay
mapping,

    PageAnon(page) && page_count(page) == page_mapcount(page) + !!PageSwapCache(page)

This will disable the optimization for the file pages.  But it may be
good enough?

Which one do you think is better?  Maybe the first one is good enough?

> You should consider the following question -- is the potential saving
> of an IPI transmission enough to offset the cost of parallel accesses
> not making forward progress while one migration is setup and having
> different migration attempts collide?
>
> I have tests running just in case but I think the answer may be "no".
> So far only one useful test as completed (specjbb2005 with one VM per NUMA
> node) and it showed a mix of small gains and losses but with *higher*
> interrupts contrary to what was expected from the changelog.

That is hard to be understood.  May be caused by the bug you pointed out
(about was_writable)?

> For some
> thread counts, the results showed large differences in variability,
> sometimes lower and sometimes much higher.
>
> It makes me think that a workload should be identified that really
> benefits from the IPI savings are enough to justify stalling parallel
> accesses that could be making forward progress.
>
> One nit below
>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: "Matthew Wilcox" <willy@infradead.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Michel Lespinasse <walken@google.com>
>> Cc: Arjun Roy <arjunroy@google.com>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> ---
>>  mm/memory.c | 54 +++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 32 insertions(+), 22 deletions(-)
>> 
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d3273bd69dbb..a9a8ed1ac06c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4148,29 +4148,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>  		goto out;
>>  	}
>>  
>> -	/*
>> -	 * Make it present again, Depending on how arch implementes non
>> -	 * accessible ptes, some can allow access by kernel mode.
>> -	 */
>> -	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
>> +	/* Get the normal PTE  */
>> +	old_pte = ptep_get(vmf->pte);
>>  	pte = pte_modify(old_pte, vma->vm_page_prot);
>> -	pte = pte_mkyoung(pte);
>> -	if (was_writable)
>> -		pte = pte_mkwrite(pte);
>> -	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
>> -	update_mmu_cache(vma, vmf->address, vmf->pte);
>>  
>>  	page = vm_normal_page(vma, vmf->address, pte);
>> -	if (!page) {
>> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -		return 0;
>> -	}
>> +	if (!page)
>> +		goto out_map;
>>  
>>  	/* TODO: handle PTE-mapped THP */
>> -	if (PageCompound(page)) {
>> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -		return 0;
>> -	}
>> +	if (PageCompound(page))
>> +		goto out_map;
>>  
>>  	/*
>>  	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
>> @@ -4180,7 +4168,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>  	 * pte_dirty has unpredictable behaviour between PTE scan updates,
>>  	 * background writeback, dirty balancing and application behaviour.
>>  	 */
>> -	if (!pte_write(pte))
>> +	if (was_writable)
>>  		flags |= TNF_NO_GROUP;
>>  
>>  	/*
>
> Not clear why this change was made.

Sorry, this is a mistake.  It should be

        if (!was_writable)
  		flags |= TNF_NO_GROUP;

Thanks for pointing this out!  Will change this in the future version.

Best Regards,
Huang, Ying
