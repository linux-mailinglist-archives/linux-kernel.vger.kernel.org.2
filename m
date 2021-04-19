Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29FB3645B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhDSOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:14:26 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:48137 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233706AbhDSOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:14:23 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 7A9831C37B1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:13:52 +0100 (IST)
Received: (qmail 8808 invoked from network); 19 Apr 2021 14:13:52 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Apr 2021 14:13:52 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 00/10 v4] Use local_lock for pcp protection and reduce stat overhead
Date:   Mon, 19 Apr 2021 15:13:31 +0100
Message-Id: <20210419141341.26047-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Acks from RT people are still missing that I'd like to have before
trying to merge this via Andrew's tree and there is an open question is
whether the last path in this series is worthwhile. It embeds local_lock
within the per_cpu_pages structure to clarify the scope but it increases
complexity and storage costs that may not be worthwhile. I don't think
it is but it was asked whether the lock could be safely embedded or not.

Changelog since v3
o Preserve NUMA_* counters after CPU hotplug
o Drop "mm/page_alloc: Remove duplicate checks if migratetype should be isolated"
o Add micro-optimisation tracking PFN during free_unref_page_list
o Add Acks

Changelog since v2
o Fix zonestats initialisation
o Merged memory hotplug fix separately
o Embed local_lock within per_cpu_pages

This series requires patches in Andrew's tree so for convenience, it's
also available at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v4r4

The PCP (per-cpu page allocator in page_alloc.c) shares locking
requirements with vmstat and the zone lock which is inconvenient and
causes some issues. For example, the PCP list and vmstat share the
same per-cpu space meaning that it's possible that vmstat updates dirty
cache lines holding per-cpu lists across CPUs unless padding is used.
Second, PREEMPT_RT does not want to disable IRQs for too long in the
page allocator.

This series splits the locking requirements and uses locks types more
suitable for PREEMPT_RT, reduces the time when special locking is required
for stats and reduces the time when IRQs need to be disabled on !PREEMPT_RT
kernels.

Why local_lock? PREEMPT_RT considers the following sequence to be unsafe
as documented in Documentation/locking/locktypes.rst

   local_irq_disable();
   spin_lock(&lock);

The pcp allocator has this sequence for rmqueue_pcplist (local_irq_save)
-> __rmqueue_pcplist -> rmqueue_bulk (spin_lock). While it's possible to
separate this out, it generally means there are points where we enable
IRQs and reenable them again immediately. To prevent a migration and the
per-cpu pointer going stale, migrate_disable is also needed. That is a
custom lock that is similar, but worse, than local_lock. Furthermore,
on PREEMPT_RT, it's undesirable to leave IRQs disabled for too long.
By converting to local_lock which disables migration on PREEMPT_RT, the
locking requirements can be separated and start moving the protections
for PCP, stats and the zone lock to PREEMPT_RT-safe equivalent locking. As
a bonus, local_lock also means that PROVE_LOCKING does something useful.

After that, it's obvious that zone_statistics incurs too much overhead
and leaves IRQs disabled for longer than necessary on !PREEMPT_RT
kernels. zone_statistics uses perfectly accurate counters requiring IRQs
be disabled for parallel RMW sequences when inaccurate ones like vm_events
would do. The series makes the NUMA statistics (NUMA_HIT and friends)
inaccurate counters that then require no special protection on !PREEMPT_RT.

The bulk page allocator can then do stat updates in bulk with IRQs enabled
which should improve the efficiency.  Technically, this could have been
done without the local_lock and vmstat conversion work and the order
simply reflects the timing of when different series were implemented.

Finally, there are places where we conflate IRQs being disabled for the
PCP with the IRQ-safe zone spinlock. The remainder of the series reduces
the scope of what is protected by disabled IRQs on !PREEMPT_RT kernels.
By the end of the series, page_alloc.c does not call local_irq_save so
the locking scope is a bit clearer. The one exception is that modifying
NR_FREE_PAGES still happens in places where it's known the IRQs are
disabled as it's harmless for PREEMPT_RT and would be expensive to split
the locking there.

No performance data is included because despite the overhead of the stats,
it's within the noise for most workloads on !PREEMPT_RT. However, Jesper
Dangaard Brouer ran a page allocation microbenchmark on a E5-1650 v4 @
3.60GHz CPU on the first version of this series. Focusing on the array
variant of the bulk page allocator reveals the following.

(CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz)
ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size

         Baseline        Patched
 1       56.383          54.225 (+3.83%)
 2       40.047          35.492 (+11.38%)
 3       37.339          32.643 (+12.58%)
 4       35.578          30.992 (+12.89%)
 8       33.592          29.606 (+11.87%)
 16      32.362          28.532 (+11.85%)
 32      31.476          27.728 (+11.91%)
 64      30.633          27.252 (+11.04%)
 128     30.596          27.090 (+11.46%)

While this is a positive outcome, the series is more likely to be
interesting to the RT people in terms of getting parts of the PREEMPT_RT
tree into mainline.

 drivers/base/node.c    |  18 +--
 include/linux/mmzone.h |  60 +++++++--
 include/linux/vmstat.h |  65 ++++++----
 mm/mempolicy.c         |   2 +-
 mm/page_alloc.c        | 274 +++++++++++++++++++++++++----------------
 mm/vmstat.c            | 255 +++++++++++++++-----------------------
 6 files changed, 369 insertions(+), 305 deletions(-)

-- 
2.26.2

