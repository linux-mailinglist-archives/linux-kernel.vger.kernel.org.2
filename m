Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E103BAF04
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGDUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhGDUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:34:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0328611F2;
        Sun,  4 Jul 2021 20:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625430721;
        bh=zyCebPnazQjntRzeTuZ2gfvhK3mUPhkSUxENlXWUFZM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tb8FkdwAex3h/bfWaGy8bngp01K6n88DBGvtMYv+eaftY/pnL64GTzKaNzD0xYMDD
         WTAO+LBcR9ELNEaEhyr72zewK1No8oKbCRVBMwlh/yil9VKEMP+Hl+zB6iD2LkazVf
         n1HEfqSC/czcEuRn4Y1nwcglFKxsnEtOPb/4XfjiAqPtYfS0EXi5i+De1s3BQdMZEM
         vGpkBuhCWAMhf6ektAvCGnnHGClU4hXmVOMwSi+e6vgZScZQ0BKLY8rwAr2PyQ++sc
         TP+245E90gAZw3J9JgpzqIzmz5Gp/RJdABYtaEcGnnWoM+ljJ5B9Day6djb9Krproy
         zip7KjNaO1kRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 862FE5C0138; Sun,  4 Jul 2021 13:32:01 -0700 (PDT)
Date:   Sun, 4 Jul 2021 13:32:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] RCU changes for v5.14
Message-ID: <20210704203201.GT4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=whSGHOiuv1yARox+P3k2uTLtJ=F51aKoJYVi5UPgjitCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSGHOiuv1yARox+P3k2uTLtJ=F51aKoJYVi5UPgjitCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 01:01:33PM -0700, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 10:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > An example merge resolution may be found here:
> >
> >         4e2b64e124c7 ("Merge remote-tracking branch 'linus/master' into HEAD")
> 
> There sommit ID's are completely useless, because I have no idea where
> they come from. They aren't in the linux-next tree as far as I can
> tell, for example.
> 
> So they are just random noise.
> 
> Now, none of the conflicts looked in the least complicated, so it's
> not like I _need_ the examples, but this "send random shortened SHA1s
> to Linus" is simply not useful.
> 
> At a guess, it's actually from your merge-example branch in your own tree.
> 
> The point being, that a SHA1 may be globally unique, but without
> telling me where that SHA1 can be _found_, it is entirely useless.
> 
> If you have example merges - which I do like seeing, and I will
> compare against just to double-check even when I have no reason to
> doubt my own merge - you need to point to it the same way you point to
> the actual real branch.
> 
> IOW, say something like
> 
>   "I've done an example merge, and you can find it in
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> rcu-example-merge"
> 
> or similar.
> 
> Because actual SHA1 names are only useful WHEN THEY ARE IN MY TREE. So
> you can point to history that I have (or that was in your actual pull
> request), and I can see _those_ just fine.
> 
> So when you say
> 
>   "The second is a trivial whitespace conflict between these two commits:
> 
>         76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu
> from a pointer")
>         b9964ce74544 ("rcu: Create an unrcu_pointer() to remove __rcu
> from a pointer")"
> 
> then that makes sense, because those are two commits that I actually
> have as part of the merge conflict).
> 
> But that example merge? I don't have it, unless you actually tell me
> where it is.
> 
> Then I can just do
> 
>       git fetch <paul-told-me-where-to-fetch>
> 
> and can do
> 
>     git show FETCH_HEAD
> 
> or (more commonly) just compare my merge result with yours:
> 
>     git diff FETCH_HEAD kernel/rcu/tree_stall.h
> 
> and it's all golden. But if you send me a random SHA1 of somethign
> that only exists in your trees, I just go "oh, ok, not useful".

Once again, please accept my apologies, and thank you for the explanation.
I should have sent something like the following, correct?  Or is there
still something I am missing?

							Thanx, Paul

------------------------------------------------------------------------

Hello, Linus,

In a deviation from long-standing -tip tradition, please pull the latest
RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu-2021.07.04
  # HEAD: 641faf1b9064c270a476a424e60063bb05df3ee9: Merge branches 'bitmaprange.2021.05.10c', 'doc.2021.05.10c', 'fixes.2021.05.13a', 'kvfree_rcu.2021.05.10c', 'mmdumpobj.2021.05.10c', 'nocb.2021.05.12a', 'srcu.2021.05.12a', 'tasks.2021.05.18a' and 'torture.2021.05.10c' into HEAD (2021-05-18 10:56:19 -0700)

RCU changes for this cycle were:

o	Bitmap support for "all" as an alias for all bits.

o	Documentation updates.

o	Miscellaneous fixes, including some that overlap into mm and lockdep.

o	kvfree_rcu() updates.

o	mem_dump_obj() updates, with acks from one of the slab-allocator
	maintainers.

o	RCU NOCB CPU updates, including limited deoffloading.

o	SRCU updates.

o	Tasks-RCU updates.

o	Torture-test updates.

These changes have two merge conflicts with mainline.  The first is
a semantic conflict detected by -next between these two commits:

	2f064a59a11f ("sched: Change task_struct::state")
	e44111ed20d8 ("rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output")

I have done an example merge here:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git merge-example-rcu

The second is a trivial whitespace conflict between these two commits:

	76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu from a pointer")
	b9964ce74544 ("rcu: Create an unrcu_pointer() to remove __rcu from a pointer")

I have done an example merge on top of the merge commit for the first
conflict:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git merge-example-rcu2

And yes, this second conflict did in fact happen because I handed out
a patch containing this whitespace error, and failed to follow up with
the corrected patch.  :-/

							Thanx, Paul

----------------------------------------------------------------
Frederic Weisbecker (17):
      doc: Fix diagram references in memory-ordering document
      rcu/nocb: Use the rcuog CPU's ->nocb_timer
      timer: Revert "timer: Add timer_curr_running()"
      srcu: Remove superfluous sdp->srcu_lock_count zero filling
      srcu: Remove superfluous ssp initialization for early callbacks
      srcu: Unconditionally embed struct lockdep_map
      srcu: Initialize SRCU after timers
      srcu: Fix broken node geometry after early ssp init
      torture: Correctly fetch number of CPUs for non-English languages
      rcu/nocb: Directly call __wake_nocb_gp() from bypass timer
      rcu/nocb: Allow de-offloading rdp leader
      rcu/nocb: Cancel nocb_timer upon nocb_gp wakeup
      rcu/nocb: Delete bypass_timer upon nocb_gp wakeup
      rcu/nocb: Only cancel nocb timer if not polling
      rcu/nocb: Prepare for fine-grained deferred wakeup
      rcu/nocb: Unify timers
      srcu: Early test SRCU polling start

Ingo Molnar (1):
      rcu: Fix various typos in comments

Jules Irenge (1):
      rcu: Add missing __releases() annotation

Maninder Singh (2):
      mm/slub: Fix backtrace of objects to handle redzone adjustment
      mm/slub: Add Support for free path information of an object

Paul E. McKenney (47):
      doc: Fix statement of RCU's memory-ordering requirements
      tools/rcu: Add drgn script to dump number of RCU callbacks
      rcu-tasks: Add block comment laying out RCU Tasks design
      rcu-tasks: Add block comment laying out RCU Rude design
      torture: Fix remaining erroneous torture.sh instance of $*
      torture: Add "scenarios" option to kvm.sh --dryrun parameter
      torture: Make kvm-again.sh use "scenarios" rather than "batches" file
      refscale: Allow CPU hotplug to be enabled
      rcuscale: Allow CPU hotplug to be enabled
      torture: Add kvm-remote.sh script for distributed rcutorture test runs
      refscale: Add acqrel, lock, and lock-irq
      rcutorture: Abstract read-lock-held checks
      torture: Fix grace-period rate output
      torture: Abstract end-of-run summary
      torture: Make kvm.sh use abstracted kvm-end-run-stats.sh
      torture:  Make the build machine control N in "make -jN"
      torture: Make kvm-find-errors.sh account for kvm-remote.sh
      rcutorture: Judge RCU priority boosting on grace periods, not callbacks
      torture:  Set kvm.sh language to English
      rcutorture: Delay-based false positives for RCU priority boosting tests
      rcutorture: Consolidate rcu_torture_boost() timing and statistics
      rcutorture: Make rcu_torture_boost_failed() check for GP end
      rcutorture: Add BUSTED-BOOST to test RCU priority boosting tests
      rcutorture: Forgive RCU boost failures when CPUs don't pass through QS
      rcutorture: Don't count CPU-stalled time against priority boosting
      torture: Make kvm-remote.sh account for network failure in pathname checks
      torture: Don't cap remote runs by build-system number of CPUs
      rcutorture: Move mem_dump_obj() tests into separate function
      rcu: Remove the unused rcu_irq_exit_preempt() function
      rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()
      rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output
      rcu: Add ->gp_max to show_rcu_gp_kthreads() output
      lockdep: Explicitly flag likely false-positive report
      rcu: Reject RCU_LOCKDEP_WARN() false positives
      rcu: Add quiescent states and boost states to show_rcu_gp_kthreads() output
      rcu: Make RCU priority boosting work on single-CPU rcu_node structures
      rcu: Make show_rcu_gp_kthreads() dump rcu_node structures blocking GP
      rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs
      rcu: Make rcu_gp_cleanup() be noinline for tracing
      rcu: Point to documentation of ordering guarantees
      rcu: Don't penalize priority boosting when there is nothing to boost
      rcu: Create an unrcu_pointer() to remove __rcu from a pointer
      rcu: Improve comments describing RCU read-side critical sections
      rcu: Remove obsolete rcu_read_unlock() deadlock commentary
      rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states
      tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
      Merge branches 'bitmaprange.2021.05.10c', 'doc.2021.05.10c', 'fixes.2021.05.13a', 'kvfree_rcu.2021.05.10c', 'mmdumpobj.2021.05.10c', 'nocb.2021.05.12a', 'srcu.2021.05.12a', 'tasks.2021.05.18a' and 'torture.2021.05.10c' into HEAD

Rolf Eike Beer (1):
      rcu: Fix typo in comment: kthead -> kthread

Uladzislau Rezki (Sony) (6):
      kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
      kvfree_rcu: Add a bulk-list check when a scheduler is run
      kvfree_rcu: Update "monitor_todo" once a batch is started
      kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
      kvfree_rcu: Fix comments according to current code
      kvfree_rcu: Refactor kfree_rcu_monitor()

Yury Norov (2):
      bitmap_parse: Support 'all' semantics
      rcu/tree_plugin: Don't handle the case of 'all' CPU range

Zhang Qiang (1):
      kvfree_rcu: Release a page cache under memory pressure

Zhouyi Zhou (1):
      rcu: Improve tree.c comments and add code cleanups

 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   6 +-
 Documentation/admin-guide/kernel-parameters.rst    |   5 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 include/linux/rcupdate.h                           |  84 +++---
 include/linux/rcutiny.h                            |   1 -
 include/linux/rcutree.h                            |   1 -
 include/linux/srcu.h                               |   6 +
 include/linux/srcutree.h                           |   2 -
 include/linux/timer.h                              |   2 -
 include/trace/events/rcu.h                         |   1 +
 init/main.c                                        |   2 +
 kernel/locking/lockdep.c                           |   6 +-
 kernel/rcu/Kconfig.debug                           |   2 +-
 kernel/rcu/rcu.h                                   |  14 +-
 kernel/rcu/rcutorture.c                            | 315 +++++++++++----------
 kernel/rcu/refscale.c                              | 109 ++++++-
 kernel/rcu/srcutree.c                              |  28 +-
 kernel/rcu/sync.c                                  |   4 +-
 kernel/rcu/tasks.h                                 |  58 +++-
 kernel/rcu/tiny.c                                  |   1 -
 kernel/rcu/tree.c                                  | 313 +++++++++++---------
 kernel/rcu/tree.h                                  |  14 +-
 kernel/rcu/tree_plugin.h                           | 239 ++++++++--------
 kernel/rcu/tree_stall.h                            |  84 +++++-
 kernel/rcu/update.c                                |   8 +-
 kernel/time/timer.c                                |  14 -
 lib/bitmap.c                                       |   9 +
 lib/test_bitmap.c                                  |   7 +
 mm/oom_kill.c                                      |   2 +-
 mm/slab.h                                          |   1 +
 mm/slab_common.c                                   |  12 +-
 mm/slub.c                                          |   8 +
 mm/util.c                                          |   2 +-
 tools/rcu/rcu-cbs.py                               |  46 +++
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |  33 +--
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   6 +-
 .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |  40 +++
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   2 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh | 249 ++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  61 ++--
 tools/testing/selftests/rcutorture/bin/torture.sh  |   2 +-
 .../selftests/rcutorture/configs/rcu/BUSTED-BOOST  |  17 ++
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   8 +
 .../selftests/rcutorture/configs/rcuscale/TREE     |   2 +-
 .../selftests/rcutorture/configs/rcuscale/TREE54   |   2 +-
 .../rcutorture/configs/refscale/NOPREEMPT          |   2 +-
 .../selftests/rcutorture/configs/refscale/PREEMPT  |   2 +-
 .../rcutorture/formal/srcu-cbmc/src/locks.h        |   2 +-
 49 files changed, 1265 insertions(+), 576 deletions(-)
 create mode 100644 tools/rcu/rcu-cbs.py
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot

