Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA316400ADC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351140AbhIDKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FC4622676;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9yiSGeVdLsgQPPUAVr85iqaJyt7OhKlgNfMJMkMjBrg=;
        b=bKDYxVP+B4TMemV73gb8pAJqWjHYHMH7PoWx5hflZeWEjA+5PhK8GeIXjr+NMM8UG+lt5k
        qNxAolrXV3Y8P6AHLTWl4LRfm1WiwL469bjR0cF8XoQuCm/H5JCaGpn/GdMUYsHyn5NZrF
        CMyTZJPrf5fCWeSv+w/jTZ0MnWu3haw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9yiSGeVdLsgQPPUAVr85iqaJyt7OhKlgNfMJMkMjBrg=;
        b=XSfpeqtq0VH2WuvLkYHdqJmBZ3iO28JsOtzTezKw1Cm3kT3vnP7oYWowBDb2hYR15LPgl9
        AcbiUMXrPqaIjYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 152141348A;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w7sYBGFPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:09 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 00/33] SLUB: reduce irq disabled scope and make it RT compatible
Date:   Sat,  4 Sep 2021 12:49:30 +0200
Message-Id: <20210904105003.11688-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12881; h=from:subject; bh=wt8HcyQvhbIiXkjePpDdbGH0W+HUEgn1dMJv+TaHQSY=; b=owGbwMvMwMH4QPFU8cfOlQKMp9WSGBKN/X4ZTfROFAx+zjG9wGtmh4T/soO1O9O4pz9wP6X5OKg5 dmNFJ6MxCwMjB4OsmCJLr/dkxpWmjyX2ecSdgRnEygQyhYGLUwAm0tjCwbCg50O/fJiHzeWSzWe5TR e/Nbue6T35oavLl488p/Yd3ev5anJVZnmXu+7Nba6Vx3M51AqfznrHsmxpWNzZxNzaauvqdMkZtwUf pNYfZJ37welzk5KcbUXpkvYbXSGvVLWkDM3fCmZvl8gNNniZYe1yeuFzQ0YbLUOxV386XitM1A1ccz RidvxXd/uI2hN6c18LfJ03b1eiz/ogJ/nzS+sdpYqUls3/acktb7Ptxpcqk9VPi9X73boeBEQdVzbe +X8ff4nGEtUg33kPip5yf5TcncZd+4erpNCivX/LZ+EHEmu25PoeWdzCyOfBHrEttf+T5V5nS52H6b ebF3AbxOfd2zi9qGCLWM/V2O0HAA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Linus and Stephen only To:'d on the cover letter for the git part)

Hi,

this new version addresses feedback from Linus wrt use of conditional locking.
The flush_slab() one is fixed as was discussed, per Mike Galbraith's
suggestion [14]. More instances in the series occuring in cmpxchg_double_slab()
and slab_[un]lock() were removed too. As such, the cleanest way to do this
without churn was to rebase, drop some patches and adjust others (see changelog
below).  As there was rebase anyway, bumped the base tag from v5.14-rc6 to
v5.14 as well. The resulting differences from v5 should be only how the code is
organized, not functional. I will of course continue testing, as I hope Mel and
the RT guys would soon too.

As Linus mentioned the possibility of taking this directly from git [15] I have
created a signed tag for a later (near end of merge window?) pull request
assuming nothing blows up:
git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git tags/mm-slub-5.15-rc1

I assume that would mean dropping the series from mmotm now and instead adding
the tree to linux-next? AFAIK there are no further slub patches pending anywhere
so no conflicts.

Changes since v5 [11]
* Rebased from v5.14-rc6 to v5.14
* Removed conditional locking from flush_slab(), instead the non-locking variant
  is moved to its only caller (patches 27-28)
* In the same vein, removed patches "mm, slub: unify cmpxchg_double_slab() and
  __cmpxchg_double_slab()" [12] and "mm, slub: optionally save/restore irqs in
  slab_[un]lock()" [13] that introduced conditional locking elsewhere. Patch 30
  "mm, slub: make slab_lock() disable irqs with PREEMPT_RT" adjusted
  accordingly

Links to rarlier versions (changelog trimmed):
v4 [10], v3 [8], v2 [5],  RFC v1 [1]:

This series was initially inspired by Mel's pcplist local_lock rewrite, and
also interest to better understand SLUB's locking and the new primitives and RT
variants and implications. It makes SLUB compatible with PREEMPT_RT and
generally more preemption-friendly, apparently without significant regressions,
as the fast paths are not affected.

The main changes to SLUB by this series:

* irq disabling is now only done for minimum amount of time needed to protect
  the strict kmem_cache_cpu fields, and as part of spin lock, local lock and
  bit lock operations to make them irq-safe

* SLUB is fully PREEMPT_RT compatible

Series is based on 5.14 and also available as a git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v6r2

And signed tag:
git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git tags/mm-slub-5.15-rc1

The series should now be sufficiently tested in both RT and !RT configs, mainly
thanks to Mike.

The RFC/v1 version also got basic performance screening by Mel that didn't show
major regressions. Mike's testing with hackbench of v2 on !RT reported
negligible differences [6]:

virgin(ish) tip
5.13.0.g60ab3ed-tip
          7,320.67 msec task-clock                #    7.792 CPUs utilized            ( +-  0.31% )
           221,215      context-switches          #    0.030 M/sec                    ( +-  3.97% )
            16,234      cpu-migrations            #    0.002 M/sec                    ( +-  4.07% )
            13,233      page-faults               #    0.002 M/sec                    ( +-  0.91% )
    27,592,205,252      cycles                    #    3.769 GHz                      ( +-  0.32% )
     8,309,495,040      instructions              #    0.30  insn per cycle           ( +-  0.37% )
     1,555,210,607      branches                  #  212.441 M/sec                    ( +-  0.42% )
         5,484,209      branch-misses             #    0.35% of all branches          ( +-  2.13% )

           0.93949 +- 0.00423 seconds time elapsed  ( +-  0.45% )
           0.94608 +- 0.00384 seconds time elapsed  ( +-  0.41% ) (repeat)
           0.94422 +- 0.00410 seconds time elapsed  ( +-  0.43% )

5.13.0.g60ab3ed-tip +slub-local-lock-v2r3
          7,343.57 msec task-clock                #    7.776 CPUs utilized            ( +-  0.44% )
           223,044      context-switches          #    0.030 M/sec                    ( +-  3.02% )
            16,057      cpu-migrations            #    0.002 M/sec                    ( +-  4.03% )
            13,164      page-faults               #    0.002 M/sec                    ( +-  0.97% )
    27,684,906,017      cycles                    #    3.770 GHz                      ( +-  0.45% )
     8,323,273,871      instructions              #    0.30  insn per cycle           ( +-  0.28% )
     1,556,106,680      branches                  #  211.901 M/sec                    ( +-  0.31% )
         5,463,468      branch-misses             #    0.35% of all branches          ( +-  1.33% )

           0.94440 +- 0.00352 seconds time elapsed  ( +-  0.37% )
           0.94830 +- 0.00228 seconds time elapsed  ( +-  0.24% ) (repeat)
           0.93813 +- 0.00440 seconds time elapsed  ( +-  0.47% ) (repeat)

RT configs showed some throughput regressions, but that's expected tradeoff for
the preemption improvements through the RT mutex. It didn't prevent the v2 to
be incorporated to the 5.13 RT tree [7], leading to testing exposure and
bugfixes.

Before the series, SLUB is lockless in both allocation and free fast paths, but
elsewhere, it's disabling irqs for considerable periods of time - especially in
allocation slowpath and the bulk allocation, where IRQs are re-enabled only
when a new page from the page allocator is needed, and the context allows
blocking. The irq disabled sections can then include deactivate_slab() which
walks a full freelist and frees the slab back to page allocator or
unfreeze_partials() going through a list of percpu partial slabs. The RT tree
currently has some patches mitigating these, but we can do much better in
mainline too.

Patches 1-6 are straightforward improvements or cleanups that could exist
outside of this series too, but are prerequsities.

Patches 7-9 are also preparatory code changes without functional changes, but
not so useful without the rest of the series.

Patch 10 simplifies the fast paths on systems with preemption, based on
(hopefully correct) observation that the current loops to verify tid are
unnecessary.

Patches 11-20 focus on reducing irq disabled scope in the allocation slowpath.

Patch 11 moves disabling of irqs into ___slab_alloc() from its callers, which
are the allocation slowpath, and bulk allocation. Instead these callers only
disable preemption to stabilize the cpu. The following patches then gradually
reduce the scope of disabled irqs in ___slab_alloc() and the functions called
from there. As of patch 14, the re-enabling of irqs based on gfp flags before
calling the page allocator is removed from allocate_slab(). As of patch 17,
it's possible to reach the page allocator (in case of existing slabs depleted)
without disabling and re-enabling irqs a single time.

Pathces 21-26 reduce the scope of disabled irqs in functions related to
unfreezing percpu partial slab.

Patch 27 is preparatory. Patch 28 is adopted from the RT tree and converts the
flushing of percpu slabs on all cpus from using IPI to workqueue, so that the
processing isn't happening with irqs disabled in the IPI handler. The flushing
is not performance critical so it should be acceptable.

Patch 29 also comes from RT tree and makes object_map_lock RT compatible.

Patch 30 make slab_lock irq-safe on RT where we cannot rely on having
irq disabled from the list_lock spin lock usage.

Patch 31 changes kmem_cache_cpu->partial handling in put_cpu_partial() from
cmpxchg loop to a short irq disabled section, which is used by all other code
modifying the field. This addresses a theoretical race scenario pointed out by
Jann, and makes the critical section safe wrt with RT local_lock semantics
after the conversion in patch 35.

Patch 32 changes preempt disable to migrate disable, so that the nested
list_lock spinlock is safe to take on RT. Because migrate_disable() is a
function call even on !RT, a small set of private wrappers is introduced
to keep using the cheaper preempt_disable() on !PREEMPT_RT configurations.
As of this patch, SLUB should be already compatible with RT's lock semantics.

Finally, patch 33 changes irq disabled sections that protect kmem_cache_cpu
fields in the slow paths, with a local lock. However on PREEMPT_RT it means the
lockless fast paths can now preempt slow paths which don't expect that, so the
local lock has to be taken also in the fast paths and they are no longer
lockless. RT folks seem to not mind this tradeoff. The patch also updates the
locking documentation in the file's comment.

[1] https://lore.kernel.org/lkml/20210524233946.20352-1-vbabka@suse.cz/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0001-mm-sl-au-b-Change-list_lock-to-raw_spinlock_t.patch?h=linux-5.12.y-rt-patches
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0004-mm-slub-Move-discard_slab-invocations-out-of-IRQ-off.patch?h=linux-5.12.y-rt-patches
[4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0005-mm-slub-Move-flush_cpu_slab-invocations-__free_slab-.patch?h=linux-5.12.y-rt-patches
[5] https://lore.kernel.org/lkml/20210609113903.1421-1-vbabka@suse.cz/
[6] https://lore.kernel.org/lkml/891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de
[7] https://lore.kernel.org/linux-rt-users/87tul5p2fa.ffs@nanos.tec.linutronix.de/
[8] https://lore.kernel.org/lkml/20210729132132.19691-1-vbabka@suse.cz/
[9] https://lore.kernel.org/lkml/20210804120522.GD6464@techsingularity.net/
[10] https://lore.kernel.org/lkml/20210805152000.12817-1-vbabka@suse.cz/
[11] https://lore.kernel.org/all/20210823145826.3857-1-vbabka@suse.cz/
[12] https://lore.kernel.org/all/20210823145826.3857-7-vbabka@suse.cz/
[13] https://lore.kernel.org/all/20210823145826.3857-32-vbabka@suse.cz/
[14] https://lore.kernel.org/linux-mm/1ae902f7-c500-f9e8-1b4f-077beade0f42@suse.cz/
[15] https://lore.kernel.org/linux-mm/CAHk-=wjRfFtnQ5p42s_5Uv8i0U5YKSBpTH++_ZMKZyyvYicYmQ@mail.gmail.com/
[16] https://lore.kernel.org/all/871r6j526m.ffs@tglx/

Sebastian Andrzej Siewior (2):
  mm: slub: move flush_cpu_slab() invocations __free_slab() invocations
    out of IRQ context
  mm: slub: make object_map_lock a raw_spinlock_t

Vlastimil Babka (31):
  mm, slub: don't call flush_all() from slab_debug_trace_open()
  mm, slub: allocate private object map for debugfs listings
  mm, slub: allocate private object map for validate_slab_cache()
  mm, slub: don't disable irq for debug_check_no_locks_freed()
  mm, slub: remove redundant unfreeze_partials() from put_cpu_partial()
  mm, slub: extract get_partial() from new_slab_objects()
  mm, slub: dissolve new_slab_objects() into ___slab_alloc()
  mm, slub: return slab page from get_partial() and set c->page
    afterwards
  mm, slub: restructure new page checks in ___slab_alloc()
  mm, slub: simplify kmem_cache_cpu and tid setup
  mm, slub: move disabling/enabling irqs to ___slab_alloc()
  mm, slub: do initial checks in ___slab_alloc() with irqs enabled
  mm, slub: move disabling irqs closer to get_partial() in
    ___slab_alloc()
  mm, slub: restore irqs around calling new_slab()
  mm, slub: validate slab from partial list or page allocator before
    making it cpu slab
  mm, slub: check new pages with restored irqs
  mm, slub: stop disabling irqs around get_partial()
  mm, slub: move reset of c->page and freelist out of deactivate_slab()
  mm, slub: make locking in deactivate_slab() irq-safe
  mm, slub: call deactivate_slab() without disabling irqs
  mm, slub: move irq control into unfreeze_partials()
  mm, slub: discard slabs in unfreeze_partials() without irqs disabled
  mm, slub: detach whole partial list at once in unfreeze_partials()
  mm, slub: separate detaching of partial list in unfreeze_partials()
    from unfreezing
  mm, slub: only disable irq with spin_lock in __unfreeze_partials()
  mm, slub: don't disable irqs in slub_cpu_dead()
  mm, slab: split out the cpu offline variant of flush_slab()
  mm, slub: make slab_lock() disable irqs with PREEMPT_RT
  mm, slub: protect put_cpu_partial() with disabled irqs instead of
    cmpxchg
  mm, slub: use migrate_disable() on PREEMPT_RT
  mm, slub: convert kmem_cpu_slab protection to local_lock

 include/linux/page-flags.h |   9 +
 include/linux/slub_def.h   |   6 +
 mm/slab_common.c           |   2 +
 mm/slub.c                  | 797 +++++++++++++++++++++++++------------
 4 files changed, 563 insertions(+), 251 deletions(-)

-- 
2.33.0

