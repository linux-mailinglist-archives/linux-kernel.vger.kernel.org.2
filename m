Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740C73F4CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhHWO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:59:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60266 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC35D20004;
        Mon, 23 Aug 2021 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uz/SOMUXcZ1WHskbw8dIls9Znrzm0eHT/WUI3qh2ff8=;
        b=f7LIj7NuNL2r6wPmfq0/rm6UGhfpui6Geyt5rEpiwPmOzLMGFTkF/sAwjFYtnzqr42bNOp
        SF/CKVR3vWNQr8G8Fp2Y2/rTMRdk3BRUu380dablyFeuuPub75IxihDMF83Bn4+Nekxxr+
        gMjPEMStljWTd1hv3hi/8Xuqsks8x9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730717;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uz/SOMUXcZ1WHskbw8dIls9Znrzm0eHT/WUI3qh2ff8=;
        b=doIL2me1Uw3nGn1RqGCnua4dVz50bFt2Nj/7eLirZmhd5ZeyN9hTcHRRIFffyDcP9zxztH
        ANy5gqCL81BNNxCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EB2F13BE0;
        Mon, 23 Aug 2021 14:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 249UHp23I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v5 00/35] SLUB: reduce irq disabled scope and make it RT compatible
Date:   Mon, 23 Aug 2021 16:57:51 +0200
Message-Id: <20210823145826.3857-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v5 is just accumulated fixes since posting v4 to allow checking that mmotm
is identical. I've checked my tree against next-20210823 and diff of mm/slub.c
was empty, git range-diff against fixups-squashed range of commits made from
mmotm also showed no difference in patch contents.
The HEAD of git branch slub-local-lock-v5r0 is the same as slub-local-lock-v4r4.

Changes since v4 [10]:
* Rebased on v5.14-rc6
* Integrated fixes accumulated after posting v4:
  * VM_BUG_ON in PageSlabPfmemalloc (patch 13)
  * Lock ordering in memory offline and cache destroy contexts (patch 29)
  * Size of local_lock_t in kmem_cache_cpu incompatible with double cmpxchg
    on freelist + tid when LOCK_STAT enabled (patch 35)
  * Unified lockdep_assert_held(local_lock_t) syntax on RT and !RT (patch 35)

Changes since v3 [8]:
* Rebase to 5.14-rc4
* Fix unbounded percpu partial list growth reported by Sebastian Andrzej Siewior
* Prevent spurious uninitialized local variable warning reported by Mel Gorman

Changes since v2 [5]:
* Rebase to 5.14-rc3
* A number of fixes to the RT parts, big thanks to Mike Galbraith for testing
  and debugging!
  * The largest fix is to protect kmem_cache_cpu->partial by local_lock instead
    of cmpxchg tricks, which are insufficient on RT. To avoid divergence
    between RT and !RT, just do it everywhere. Affected mainly patch 25 and a
    new patch 33. This also addresses a theoretical race raised earlier by Jann
    Horn.
* Smaller fixes reported by Sebastian Andrzej Siewior and Cyrill Gorcunov

Changes since RFC v1 [1]:
* Addressed feedback from Christoph and Mel, added their acks.
* Finished RT conversion, adopting 2 patches from the RT tree.
* The local_lock conversion has to sacrifice lockless fathpaths on PREEMPT_RT
* Added some more cleanup patches to the front.

This series was initially inspired by Mel's pcplist local_lock rewrite, and
also interest to better understand SLUB's locking and the new primitives and RT
variants and implications. It should make SLUB more preemption-friendly,
especially for RT, hopefully without noticeable regressions, as the fast paths
are not affected.

Series is based on 5.14-rc6 and also available as a git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v5r0

The series should now be sufficiently tested in both RT and !RT configs, mainly
thanks to Mike. The RFC/v1 version also got basic performance screening by
Mel that didn't show major regressions. Mike's testing with hackbench of v2 on
!RT reported negligible differences [6]:

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

Patches 7-10 are also preparatory code changes without functional changes, but
not so useful without the rest of the series.

Patch 11 simplifies the fast paths on systems with preemption, based on
(hopefully correct) observation that the current loops to verify tid are
unnecessary.

Patches 12-21 focus on reducing irq disabled scope in the allocation slowpath.

Patch 12 moves disabling of irqs into ___slab_alloc() from its callers, which
are the allocation slowpath, and bulk allocation. Instead these callers only
disable preemption to stabilize the cpu. The following patches then gradually
reduce the scope of disabled irqs in ___slab_alloc() and the functions called
from there. As of patch 15, the re-enabling of irqs based on gfp flags before
calling the page allocator is removed from allocate_slab(). As of patch 18,
it's possible to reach the page allocator (in case of existing slabs depleted)
without disabling and re-enabling irqs a single time.

Pathces 22-27 reduce the scope of disabled irqs in functions related to
unfreezing percpu partial slab.

Patch 28 is preparatory. Patch 29 is adopted from the RT tree and converts the
flushing of percpu slabs on all cpus from using IPI to workqueue, so that the
processing isn't happening with irqs disabled in the IPI handler. The flushing
is not performance critical so it should be acceptable.

Patch 30 also comes from RT tree and makes object_map_lock RT compatible.

Patches 31-32 make slab_lock irq-safe on RT where we cannot rely on having
irq disabled from the list_lock spin lock usage.

Patch 33 changes kmem_cache_cpu->partial handling in put_cpu_partial() from
cmpxchg loop to a short irq disabled section, which is used by all other code
modifying the field. This addresses a theoretical race scenario pointed out by
Jann, and makes the critical section safe wrt with RT local_lock semantics
after the conversion in patch 35.

Patch 34 changes preempt disable to migrate disable, so that the nested
list_lock spinlock is safe to take on RT. Because migrate_disable() is a
function call even on !RT, a small set of private wrappers is introduced
to keep using the cheaper preempt_disable() on !PREEMPT_RT configurations.

As of this patch, SLUB should be compatible with RT's lock semantics, to the
best of my knowledge.

Finally, patch 35 changes irq disabled sections that protect kmem_cache_cpu
fields in the slow paths, with a local lock. However on PREEMPT_RT it means the
lockless fast paths can now preempt slow paths which don't expect that, so the
local lock has to be taken also in the fast paths and they are no longer
lockless. It's up to RT folks to decide if this is a good tradeoff.
The patch also updates the locking documentation in the file's comment.

The main results of this series:

* irq disabling is only done for minimum amount of time needed to protect the
  kmem_cache_cpu data and as part of spin lock, local lock and bit lock
  operations to make them irq-safe

* SLUB should be fully PREEMPT_RT compatible

This should have obvious implications for better preemptibility, especially on RT.

Some details are different than how the previous SLUB RT tree patches were
implemented:

  mm: sl[au]b: Change list_lock to raw_spinlock_t [2] - the SLAB part can be
  dropped as a different patch restricts RT to SLUB anyway. And after this series
  the list_lock in SLUB is never used with irqs disabled before taking the lock
  so it doesn't have to be converted to raw_spinlock_t.

  mm: slub: Move discard_slab() invocations out of IRQ-off sections [3] should be
  unnecessary as this series does move these invocations outside irq disabled
  sections in a different way.

The remaining patches to upstream from the RT tree are small ones related to
KConfig. The patch that restricts PREEMPT_RT to SLUB (not SLAB or SLOB) makes
sense. The patch that disables CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT could
perhaps be re-evaluated as the series addresses some latency issues with it.

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

Sebastian Andrzej Siewior (2):
  mm: slub: Move flush_cpu_slab() invocations __free_slab() invocations
    out of IRQ context
  mm: slub: Make object_map_lock a raw_spinlock_t

Vlastimil Babka (33):
  mm, slub: don't call flush_all() from slab_debug_trace_open()
  mm, slub: allocate private object map for debugfs listings
  mm, slub: allocate private object map for validate_slab_cache()
  mm, slub: don't disable irq for debug_check_no_locks_freed()
  mm, slub: remove redundant unfreeze_partials() from put_cpu_partial()
  mm, slub: unify cmpxchg_double_slab() and __cmpxchg_double_slab()
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
  mm, slab: make flush_slab() possible to call with irqs enabled
  mm, slub: optionally save/restore irqs in slab_[un]lock()/
  mm, slub: make slab_lock() disable irqs with PREEMPT_RT
  mm, slub: protect put_cpu_partial() with disabled irqs instead of
    cmpxchg
  mm, slub: use migrate_disable() on PREEMPT_RT
  mm, slub: convert kmem_cpu_slab protection to local_lock

 include/linux/page-flags.h |   9 +
 include/linux/slub_def.h   |   6 +
 mm/slab_common.c           |   2 +
 mm/slub.c                  | 837 ++++++++++++++++++++++++-------------
 4 files changed, 571 insertions(+), 283 deletions(-)

-- 
2.32.0

