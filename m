Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1BC356112
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348011AbhDGBxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:13 -0400
Received: from server.lespinasse.org ([63.205.204.226]:53125 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347837AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 mime-version : content-transfer-encoding : from;
 bh=1Gm09qrGS0vm5EI74EwXKuGq+s1fXgeSXb23fQLnCZI=;
 b=jIoCr/PgNXFyknpm1BL/ffLrCKNz02jb37x5rZlM0ZnQel1d/h0ghAyJ16JKJkqKCUnC1
 tUWsBLeGtc15+CbDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=1Gm09qrGS0vm5EI74EwXKuGq+s1fXgeSXb23fQLnCZI=;
 b=ZAB+YHn7Asi/YlkOBBphEa7oZ/Ka/SmP+oEGRJ8KNRBkWnvTHzSBeQyik+jBk5SynHWJV
 1iTcuPhkV2plWIrzusVLvGbbhOPwH/lYzaa3vR5+E2mMfi2KNWSmFLXHizayyxId6bc5/dr
 NfOq/8EkzMye9+wneFUuXsvktPp89rWMj92zjWjhfVHZm5/zyvWc/UXa2NFyBn2ip9KQMGG
 9M8LuUTBxM7jgG7VaNlOQDQ73hCSbrAZJC1k8BIwxSkeeit/z+v+AvXohFaX5BBTxxVHPrI
 3uWVI8iDzsPi7rXX/IXgPN7DOZcTI3tmYBcQrE+HqI+tBEupljeOrkge6w9w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 69B64160021;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 5752919F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 00/37] Speculative page faults
Date:   Tue,  6 Apr 2021 18:44:25 -0700
Message-Id: <20210407014502.24091-1-michel@lespinasse.org>
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

In the case of mapped files, additional precautions must be taken when
dereferencing vma->vm_file. The vma copy that is taken at the start of
the speculative page fault includes a pointer to the file, but does not
take a reference to it. The reference is held by the original vma.
In order to guarantee the validity of the file through the vm_ops->fault()
and/or vm_ops->map_pages() calls, these are run within an rcu read locked
code section, with the mmap sequence count being verified at the start of
the section and the vma file fput() is rcu-deferred when vmas are freed.


The patch series applies on top of linux v5.12-rc5;
a git tree is also available:
git fetch https://github.com/lespinasse/linux.git v5.12-rc5-spf


Commits 1 to 4 are preparatory cleanups
(which I would like to push regardless of what happens to the rest)

Commits 5 and 6 introduce CONFIG_SPECULATIVE_PAGE_FAULT and lets us
enable it on x86 so we can test the new code as it gets introduced.

Commits 7 and 8 extend handle_mm_fault() so it can be used for
speculative faults; initially these always abort with VM_FAULT_RETRY.

Commits 9 to 14 introduce all the basic building blocks for speculative
page faults:
- Commit 9 adds the mmap sequence count that will be used for detecting
  when writers have been running concurrently with an spf attempt
  (in which case the attempt will be aborted);
- Commit 10 adds RCU safe vma freeing;
- Commit 11 does a lockless VMA lookup and starts the spf handling attempt;
- (Commit 12 is a small refactor preparing for the next commit);
- Commit 13 walks down the existing page tables, carefully avoiding
  races with potential writers (munmap in particular)
- Commit 14 introduces pte_map_lock() and pte_spinlock(), which attempt
  to (optionally map and) lock an existing page table when it's time to
  commit page fault results to it.

Commits 15 to 22 progressively implement spf for most anon vma cases.
This mostly comes down to using the pte_map_lock() and pte_spinlock()
APIs where needed, and making sure to abort speculation in unsupported
cases (mostly anon_vma allocation and userfaultfd). The work is split
in small steps so that changes can be tested soon after they are added.

Commits 23 to 26 introduce the main ideas for extending spf to file
mapped vmas:
- Commit 23 adds RCU safe vma->vm_file freeing;
- Commit 24 uses RCU to ensure vma->vm_file stays valid through the
  vm_ops->fault() method call;
- Commit 25 implements the speculative case for filemap_fault().
  This only handles the common case where the desired page is already
  cached, is not locked and where we don't need to trigger readahead.
- Commit 26 ensures we use pte_map_lock() to commit the faulted page to the
  mm address space, verifying that no mmap writers ran during the fault.

Commits 27 and 28 use the same ideas to implement speculative fault-around.

Commits 29 to 32 complete spf support for most mapped file types.
A list of supported file types is introduced, and we allow speculative
execution through the new speculative file faulting paths for those files.
Note that the speculative support does not extend to shared file
mapping writes in this patchset, as this would require some support
for vm_ops->page_mkwrite() which isn't handled yet.

Commits 33 and 34 disable speculative handling for single-threaded
userspace. This is for (minor) performance tuning and is pushed
towards the end of the series to make it easier to exercise the spf
paths as they are introduced.

Commit 35 adds some extra statistics. Not pushing for inclusion on
these but I thought it might come handy when discussing spf performance.

Commits 36 and 37 add spf support on the arm64 architecture. It should
be easy to add other architectures too, given access to test machines.


As Laurent's previous proposal before LSF/MM 2019 was rejected for
complexity reasons, I am hoping that some of the changes I made will
help address these concerns:

- First, the patchset is structured to be bisectable. Every few commits
  the new code gets enabled, which makes for easier testing and also,
  I think, should make it easier for reviewers to understand how the
  various commits relate to each other.

- This patchset requires no changes to mmap writers other than instrumenting
  the mmap write lock APIs.

- The fault handler operates on a stable copy of the vma, so it does not
  require any special care to avoid the possibility of vma fields being
  modified concurrently with it.


mmtest results on HP Z840 workstation
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

- wis-pf page_fault2 (private file mapping write) shows some
  improvement, though much less than in the pft (anon) case.
  The performance is limited by LRU contention here.

- wis-pf page_fault3 (shared file mapping write) gets a bit slower.
  This patchset does not implement speculative handling for this case.

- wis-mmap likes the change, even though it doesn't do much page faults.
  This seems to be a side effect of rcu safe vma freeing reducing vma
  reuse between threads running on separate CPUs.

- wis-malloc benefits from a mix of the anon vma and rcu effects.

- macro benchmarks are mostly performance neutral, with some small
  benefit in limited cases.


Another potential motivation for this is the Android use case.
Several Android vendors have picked up the previous SPF proposal and
included it on their devices because it reduces application start-up
times, which is an important performance metric for them.

Early Android test results with this patchset (actually a backport of
it to the Android 5.10 kernel) show that it is also effective in
reducing application start times, similar to what the prior SPF
proposal did. I do not have a direct comparison available though,
as our port of Laurent's prior SPF series to the 5.10 android kernel
is showing some instabilities. SPF abort rates are in the low single
digit percentage range, and few of these aborts are caused by the fact
that we only use a global counter to detect fault vs writer concurrency.
We are seeing launch time improvements for a variety of Android packages
that use a large number of threads during startup:
Meituan: 15%
Iqiyi: 8%
Tiktok: 4%
YouTube: 3%
I expect Suren may have more Android numbers from partners in a few days.

ChromeOS measurements with the previous SPF patchset also showed
significant reduction in page fault, mmap and munmap times. We do not
have data on this new SPF proposal yet, though.


I would like any feedback on the patchset, and most particularly about:
- Has the complexity issue in previous SPF proposals been sufficiently
  addressed ?
- Are the performance benefits compelling enough ? I think the answer is
  yes for the anon case, but maybe not as clear for the file cases.
- Is the Android use case compelling enough to merge the entire patchset ?
- Can we use this as a foundation for other mmap scalability work ?
  I hear several proposals involving the idea of RCU based fault handling,
  and hope this proposal might serve as a building block for these ?


Michel Lespinasse (37):
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
  mm: rcu safe vma->vm_file freeing
  mm: implement speculative handling in __do_fault()
  mm: implement speculative handling in filemap_fault()
  mm: implement speculative fault handling in finish_fault()
  mm: implement speculative handling in do_fault_around()
  mm: implement speculative handling in filemap_map_pages()
  fs: list file types that support speculative faults.
  mm: enable speculative fault handling for supported file types.
  ext4: implement speculative fault handling
  f2fs: implement speculative fault handling
  mm: enable speculative fault handling only for multithreaded user space
  mm: rcu safe vma freeing only for multithreaded user space
  mm: spf statistics
  arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
  arm64/mm: attempt speculative mm faults first

 arch/arm64/Kconfig            |   1 +
 arch/arm64/mm/fault.c         |  52 +++
 arch/x86/Kconfig              |   1 +
 arch/x86/mm/fault.c           |  51 +++
 fs/btrfs/file.c               |   1 +
 fs/cifs/file.c                |   1 +
 fs/exec.c                     |   1 +
 fs/ext4/file.c                |   1 +
 fs/ext4/inode.c               |   7 +-
 fs/f2fs/file.c                |   8 +-
 fs/fuse/file.c                |   1 +
 fs/nfs/file.c                 |   1 +
 fs/ubifs/file.c               |   1 +
 fs/vboxsf/file.c              |   1 +
 fs/xfs/xfs_file.c             |   3 +
 include/linux/mm.h            |  76 +++-
 include/linux/mm_types.h      |  20 +-
 include/linux/mmap_lock.h     | 109 ++++--
 include/linux/vm_event_item.h |  28 ++
 include/linux/vmstat.h        |   6 +
 kernel/fork.c                 |  26 +-
 mm/Kconfig                    |  22 ++
 mm/Kconfig.debug              |   7 +
 mm/filemap.c                  |  73 +++-
 mm/memory.c                   | 634 ++++++++++++++++++++++++----------
 mm/mmap.c                     |  11 +-
 mm/nommu.c                    |   6 +-
 mm/vmstat.c                   |  28 ++
 28 files changed, 942 insertions(+), 235 deletions(-)

-- 
2.20.1

