Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2635010C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhCaNRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235728AbhCaNRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:17:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67388B21D;
        Wed, 31 Mar 2021 13:17:00 +0000 (UTC)
Date:   Wed, 31 Mar 2021 14:16:58 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Message-ID: <20210331131658.GV15768@suse.de>
References: <20210329062651.2487905-1-ying.huang@intel.com>
 <20210330133310.GT15768@suse.de>
 <87a6qj8t92.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87a6qj8t92.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:20:09PM +0800, Huang, Ying wrote:
> Mel Gorman <mgorman@suse.de> writes:
> 
> > On Mon, Mar 29, 2021 at 02:26:51PM +0800, Huang Ying wrote:
> >> For NUMA balancing, in hint page fault handler, the faulting page will
> >> be migrated to the accessing node if necessary.  During the migration,
> >> TLB will be shot down on all CPUs that the process has run on
> >> recently.  Because in the hint page fault handler, the PTE will be
> >> made accessible before the migration is tried.  The overhead of TLB
> >> shooting down is high, so it's better to be avoided if possible.  In
> >> fact, if we delay mapping the page in PTE until migration, that can be
> >> avoided.  This is what this patch doing.
> >> 
> >
> > Why would the overhead be high? It was previously inaccessibly so it's
> > only parallel accesses making forward progress that trigger the need
> > for a flush.
> 
> Sorry, I don't understand this.  Although the page is inaccessible, the
> threads may access other pages, so TLB flushing is still necessary.
> 

You assert the overhead of TLB shootdown is high and yes, it can be
very high but you also said "the benchmark score has no visible changes"
indicating the TLB shootdown cost is not a major problem for the workload.
It does not mean we should ignore it though.

> > <SNIP the parts that are not problematic>
> >
> > If migration is attempted, then the time until the migration PTE is
> > created is variable. The page has to be isolated from the LRU so there
> > could be contention on the LRU lock, a new page has to be allocated and
> > that allocation potentially has to enter the page allocator slow path
> > etc. During that time, parallel threads make forward progress but with
> > the patch, multiple threads potentially attempt the allocation and fail
> > instead of doing real work.
> 
> If my understanding of the code were correct, only the first thread will
> attempt the isolation and allocation.  Because TestClearPageLRU() is
> called in
> 
>   migrate_misplaced_page()
>     numamigrate_isolate_page()
>       isolate_lru_page()
> 
> And migrate_misplaced_page() will return 0 immediately if
> TestClearPageLRU() returns false.  Then the second thread will make the
> page accessible and make forward progress.
> 

Ok, that's true. While additional work is done, the cost is reasonably
low -- lower than I initially imagined and with fewer side-effects.

> But there's still some timing difference between the original and
> patched kernel.  We have several choices to reduce the difference.
> 
> 1. Check PageLRU() with PTL held in do_numa_page()
> 
> If PageLRU() return false, do_numa_page() can make the page accessible
> firstly.  So the second thread will make the page accessible earlier.
> 
> 2. Try to lock the page with PTL held in do_numa_page()
> 
> If the try-locking succeeds, it's the first thread, so it can delay
> mapping.  If try-locking fails, it may be the second thread, so it will
> make the page accessible firstly.  We need to teach
> migrate_misplaced_page() to work with the page locked.  This will
> enlarge the duration that the page is locked.  Is it a problem?
> 
> 3. Check page_count() with PTL held in do_numa_page()
> 
> The first thread will call get_page() in numa_migrate_prep().  So if the
> second thread can detect that, it can make the page accessible firstly.
> The difficulty is that it appears hard to identify the expected
> page_count() for the file pages.  For anonymous pages, that is much
> easier, so at least if a page passes the following test, we can delay
> mapping,
> 
>     PageAnon(page) && page_count(page) == page_mapcount(page) + !!PageSwapCache(page)
> 
> This will disable the optimization for the file pages.  But it may be
> good enough?
> 
> Which one do you think is better?  Maybe the first one is good enough?
> 

The first one is probably the most straight-forward but it's more
important to figure out why interrupts were higher with at least one
workload when the exact opposite is expected. Investigating which of
options 1-3 are best and whether it's worth the duplicated check could
be done as a separate patch.

> > You should consider the following question -- is the potential saving
> > of an IPI transmission enough to offset the cost of parallel accesses
> > not making forward progress while one migration is setup and having
> > different migration attempts collide?
> >
> > I have tests running just in case but I think the answer may be "no".
> > So far only one useful test as completed (specjbb2005 with one VM per NUMA
> > node) and it showed a mix of small gains and losses but with *higher*
> > interrupts contrary to what was expected from the changelog.
> 
> That is hard to be understood.  May be caused by the bug you pointed out
> (about was_writable)?
> 

It's possible and I could not figure out what the rationale behind the
change was :/

Fix it and run it through your tests to make sure it works as you
expect. Assuming it passes your tests and it's posted, I'll read it again
and run it through a battery of tests. If it shows that interrupts are
lower and is either netural or improves performance in enough cases then
I think it'll be ok. Even if it's only neutral in terms of performance
but interrupts are lower, it'll be acceptable.

Thanks!

-- 
Mel Gorman
SUSE Labs
