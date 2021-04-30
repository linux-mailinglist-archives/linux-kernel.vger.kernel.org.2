Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443B8370179
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhD3TxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:24 -0400
Received: from server.lespinasse.org ([63.205.204.226]:36221 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhD3TxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:22 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 mime-version : content-transfer-encoding : from;
 bh=Docz4GsclSOYnAtcUPpooJiiUyd92UO1SY1X6kPKA5k=;
 b=ZcZnCIICkKrKgtWV/D10WMxk76DSRs9bYoGKetpTB/RM42XMYnoel50JwbAqhOHzkPtVc
 jF4v3o1K4TQcRGrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=Docz4GsclSOYnAtcUPpooJiiUyd92UO1SY1X6kPKA5k=;
 b=Rla4/bnyR9pv95AHFeHJqtwhIURSnYkPq4hzkCV4PLXmty0pg50VwtHu6p6npsJk78KoY
 zvQlc0z5sgfdB/bTq3FP1tZOVHsQ5vQgkHVGkOknqgo23TzIqdrgpnv9hi6vj/HiSOIV4Gv
 8Rf7mtvpq0UkUTfKwa6ZLfssqPzccSFyRVAuOd5sDAXa/M6en0Nu4sCEIYzT7Paqp3abJkJ
 fE4GdndmmkqwPMfdRRJr0EBiKNldb+TvrHjkeu1nZAM3Z7mAMA+UdqDt5VBcmgCdW79URjN
 ItAuChWCm8/2on5kao5gVfvGXPavPQzjyujyrkjdPcgolq4pyoMuQUYq7mlg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 151171600A2;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id EFF7619F521; Fri, 30 Apr 2021 12:52:32 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 00/29] Speculative page faults (anon vmas only)
Date:   Fri, 30 Apr 2021 12:52:01 -0700
Message-Id: <20210430195232.30491-1-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is my take on speculative page faults (spf).
It builds on ideas that have been previously proposed by Laurent Dufour,
Peter Zijlstra and others before. While Laurent's previous proposal
was rejected around the time of LSF/MM 2019, I am hoping we can revisit
this now based on what I think is a simpler and more bisectable approach,
much improved scaling numbers in the anonymous vma case, and the Android
use case that has since emerged. I will expand on these points towards
the end of this message.

The patch series applies on top of linux v5.12;
a git tree is also available:
git fetch https://github.com/lespinasse/linux.git v5.12-spf-anon

I believe these patches should be considered for merging.
My github also has a v5.12-spf branch which extends this mechanism
for handling file mapped vmas too; however I believe these are less
mature and I am not submitting them for inclusion at this point.


Compared to the previous (RFC) proposal, I have split out / left out
the file VMA handling parts, fixed some config specific build issues,
added a few more comments and modified the speculative fault handling
to use rcu_read_lock() rather than local_irq_disable() in the
MMU_GATHER_RCU_TABLE_FREE case.


Classical page fault processing takes the mmap read lock in order to
prevent races with mmap writers. In contrast, speculative fault
processing does not take the mmap read lock, and instead verifies,
when the results of the page fault are about to get committed and
become visible to other threads, that no mmap writers have been
running concurrently with the page fault. If the check fails,
speculative updates do not get committed and the fault is retried
in the usual, non-speculative way (with the mmap read lock held).

The concurrency check is implemented using a per-mm mmap sequence count.
The counter is incremented at the beginning and end of each mmap write
operation. If the counter is initially observed to have an even value,
and has the same value later on, the observer can deduce that no mmap
writers have been running concurrently with it between those two times.
This is similar to a seqlock, except that readers never spin on the
counter value (they would instead revert to taking the mmap read lock),
and writers are allowed to sleep. One benefit of this approach is that
it requires no writer side changes, just some hooks in the mmap write
lock APIs that writers already use.

The first step of a speculative page fault is to look up the vma and
read its contents (currently by making a copy of the vma, though in
principle it would be sufficient to only read the vma attributes that
are used in page faults). The mmap sequence count is used to verify
that there were no mmap writers concurrent to the lookup and copy steps.
Note that walking rbtrees while there may potentially be concurrent
writers is not an entirely new idea in linux, as latched rbtrees
are already doing this. This is safe as long as the lookup is
followed by a sequence check to verify that concurrency did not
actually occur (and abort the speculative fault if it did).

The next step is to walk down the existing page table tree to find the
current pte entry. This is done with interrupts disabled to avoid
races with munmap(). Again, not an entirely new idea, as this repeats
a pattern already present in fast GUP. Similar precautions are also
taken when taking the page table lock.


Commits 1 to 5 are preparatory cleanups
(which I would like to push regardless of what happens to the rest)

Commits 6 and 7 introduce CONFIG_SPECULATIVE_PAGE_FAULT and lets us
enable it on x86 so we can test the new code as it gets introduced.

Commits 8 and 9 extend handle_mm_fault() so it can be used for
speculative faults; initially these always abort with VM_FAULT_RETRY.

Commits 10 to 16 introduce all the basic building blocks for speculative
page faults:
- Commit 10 adds the mmap sequence count that will be used for detecting
  when writers have been running concurrently with an spf attempt
  (in which case the attempt will be aborted);
- Commit 11 adds RCU safe vma freeing;
- Commit 12 does a lockless VMA lookup and starts the spf handling attempt;
- Commit 13 introduces an API for preventing page table reclamation
  (using RCU or disabling interrupts depending on build config options);
- (Commit 14 is a small refactor preparing for the next commit);
- Commit 15 walks down the existing page tables, carefully avoiding
  races with potential writers (munmap in particular)
- Commit 16 introduces pte_map_lock() and pte_spinlock(), which attempt
  to (optionally map and) lock an existing page table when it's time to
  commit page fault results to it.

Commits 17 to 24 progressively implement spf for most anon vma cases.
This mostly comes down to using the pte_map_lock() and pte_spinlock()
APIs where needed, and making sure to abort speculation in unsupported
cases (mostly anon_vma allocation and userfaultfd). The work is split
in small steps so that changes can be tested soon after they are added.

Commits 25 and 26 disable speculative handling for single threaded
userspace. This is for (minor) performance tuning and is pushed
towards the end of the series to make it easier to exercise the spf
paths as they are introduced.

Commit 27 adds some extra statistics.

Commits 28 and 29 add spf support on the arm64 architecture. It should
be easy to add other architectures too, given access to test machines.


As Laurent's previous proposal before LSF/MM 2019 was rejected for
complexity reasons, I think that some of the changes I made will
help address these concerns:

- First, the patchset is structured to be bisectable (at least on x86).
  Every few commits the new code gets enabled, which makes for easier
  testing and also should make it easier for reviewers to understand how
  the various commits relate to each other.

- This patchset requires no changes to mmap writers other than instrumenting
  the mmap write lock APIs.

- The fault handler operates on a stable copy of the vma, so it does not
  require any special care to avoid the possibility of vma fields being
  modified concurrently with it.


mmtest results (from my previous RFC submission) on HP Z840 workstation
(2 socket Xeon E5-2690 v3 @ 2.60GHz, 24 cores / 48 threads total):
See https://www.lespinasse.org/kernel/v5.12-rc5-spf/mmtests/

Highlights from the above:

- pft results show some pretty damn good scalability. Throughput using
  all 48 threads (24 cores) is 24x that of single-threaded tests, and
  3.7x higher than when using the baseline kernel. This is the result
  of avoiding writing into any shared cache lines, be it for mmap lock
  or vma refcounting, during speculative page faults.
  (Experiments show that adding a single atomic variable per vma,
  which would be incremented and decremented before and after spf
  copies the vma, would decrease the 48-threads throughput by 62%).

- wis-pf page_fault1 (anon THP) shows some moderate improvement.

- wis-mmap likes the change, even though it doesn't do much page faults.
  This seems to be a side effect of rcu safe vma freeing reducing vma
  reuse between threads running on separate CPUs.

- wis-malloc benefits from a mix of the anon vma and rcu effects.

- macro benchmarks are mostly performance neutral, with some small
  benefit in limited cases.


Another motivation for this is the Android use case. Several Android
vendors have picked up the previous SPF proposal and included it on
their devices because it reduces application start-up times,
which is an important performance metric for them.


Michel Lespinasse (29):
  mm: export dump_mm
  mmap locking API: mmap_lock_is_contended returns a bool
  mmap locking API: name the return values
  do_anonymous_page: use update_mmu_tlb()
  do_anonymous_page: reduce code duplication
  mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
  x86/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
  mm: add FAULT_FLAG_SPECULATIVE flag
  mm: add do_handle_mm_fault()
  mm: add per-mm mmap sequence counter for speculative page fault handling.
  mm: rcu safe vma freeing
  x86/mm: attempt speculative mm faults first
  mm: add speculative_page_walk_begin() and speculative_page_walk_end()
  mm: refactor __handle_mm_fault() / handle_pte_fault()
  mm: implement speculative handling in __handle_mm_fault().
  mm: add pte_map_lock() and pte_spinlock()
  mm: implement speculative handling in do_anonymous_page()
  mm: enable speculative fault handling through do_anonymous_page()
  mm: implement speculative handling in do_numa_page()
  mm: enable speculative fault handling in do_numa_page()
  mm: implement speculative handling in wp_page_copy()
  mm: implement and enable speculative fault handling in handle_pte_fault()
  mm: implement speculative handling in do_swap_page()
  mm: enable speculative fault handling through do_swap_page()
  mm: disable speculative faults for single threaded user space
  mm: disable rcu safe vma freeing for single threaded user space
  mm: anon spf statistics
  arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
  arm64/mm: attempt speculative mm faults first

 arch/arm64/Kconfig            |   1 +
 arch/arm64/mm/fault.c         |  63 ++++
 arch/x86/Kconfig              |   1 +
 arch/x86/mm/fault.c           |  62 ++++
 include/linux/mm.h            |  57 +++-
 include/linux/mm_types.h      |  25 +-
 include/linux/mmap_lock.h     | 109 +++++--
 include/linux/vm_event_item.h |  27 ++
 include/linux/vmstat.h        |   6 +
 kernel/fork.c                 |  15 +
 mm/Kconfig                    |  22 ++
 mm/Kconfig.debug              |   7 +
 mm/debug.c                    |   1 +
 mm/memory.c                   | 520 ++++++++++++++++++++++++----------
 mm/vmstat.c                   |  27 ++
 15 files changed, 770 insertions(+), 173 deletions(-)

-- 
2.20.1

