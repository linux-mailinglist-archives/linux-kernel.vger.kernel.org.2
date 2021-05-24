Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34CE38F64E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEXXmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:42:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhEXXmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v5sc2D8hG26MRRg4jt1tvt4JkNt4+5RwYIbu9VY2H9c=;
        b=dUURhfxkILZ7vsr0jaislxF6W4I7LiABdz67kPUR9fI6AAum5R8kYl+BRbblsd/oC5R7my
        C96sUFHdvn7Bv93AuTGJTqhq2P5hGUBUIU/X1ugNUxT26ZmO4pyZwXSb3mhGBHlh5UqASl
        mYicJWM4lak9vJuSuvW1kzZqhjb/kas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v5sc2D8hG26MRRg4jt1tvt4JkNt4+5RwYIbu9VY2H9c=;
        b=ipEWoN65xCH8yXk6TMPM8Gyl9ve4YOisL4HbycF0BYiv9A2L7Fh6zFx+joflr4fnt8Ec/W
        9Y2VTf3VB9LdViAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEF02ACC5;
        Mon, 24 May 2021 23:40:47 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 00/26] SLUB: use local_lock for kmem_cache_cpu protection and reduce disabling irqs
Date:   Tue, 25 May 2021 01:39:20 +0200
Message-Id: <20210524233946.20352-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was inspired by Mel's pcplist local_lock rewrite, and also interest
to better understand SLUB's locking and the new primitives and RT variants and
implications. It should make SLUB more preemption-friendly, especially for RT,
hopefully without noticeable regressions, as the fast paths are not affected.

Series is based on 5.13-rc3 and also available as a git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v1r9
It received some light stability testing and also basic performance screening
(thanks Mel) that didn't show major regressions. But I'm interested in e.g.
Jesper's tests whether the bulk allocator didn't regress.

Before the series, SLUB is lockless in both allocation and free fast paths, but
elsewhere, it's disabling irqs for considerable periods of time - especially in
allocation slowpath and the bulk allocation, where IRQs are re-enabled only
when a new page from the page allocator is needed, and the context allows
blocking. The irq disabled sections can then include deactivate_slab() which
walks a full freelist and frees the slab back to page allocator or
unfreeze_partials() going through a list of percpu partial slabs. The RT tree
currently has some patches mitigating these, but we can do much better in
mainline too.

Patches 1-2 are straightforward optimizations removing unnecessary usages of
object_map_lock.

Patch 3 is a cleanup of an obviously unnecessary local_irq_save/restore
instance.

Patch 4 simplifies the fast paths on systems with preemption, based on
(hopefully correct) observation that the current loops to verify tid are
unnecessary.

Patches 5-18 focus on allocation slowpath. Patches 5-8 are preparatory code
refactoring.

Patch 9 moves disabling of irqs into ___slab_alloc() from its callers, which
are the allocation slowpath, and bulk allocation. Instead these callers only
disable migration to stabilize the cpu. The following patches then gradually
reduce the scope of disabled irqs in ___slab_alloc() and the functions called
from there. As of patch 12, the re-enabling of irqs based on gfp flags before
calling the page allocator is removed from allocate_slab(). As of patch 15,
it's possible to reach the page allocator (in case of existing slabs depleted)
without disabling and re-enabling irqs a single time.

Patches 19-24 reduce the scope of disabled irqs in remaining functions. Patch
25 replaces a preempt_disable with migrate_disable in put_cpu_partial().

Patch 26 replaces the remaining explicitly irq disabled sections that protect
percpu variables with a local_lock, and updates the locking documentation in
the file's comment.

The result is that irq disabling is only done for minimum amount of time needed
and as part of spin lock or local lock operations to make them irq-safe, except
one case around slab_lock which is a bit spinlock.

This should have obvious implications for better preemption, especially on RT.
Also some RT patches should now be unnecessary, IIUC:

  mm: slub: Enable irqs for __GFP_WAIT [1] becomes unnecessary as of patch 12.

The following two once the IPI flush_slab() handler is dealt with, as discussed
later:

  mm: sl[au]b: Change list_lock to raw_spinlock_t [2] - the SLAB part can be
  dropped as a different patch restricts RT to SLUB anyway. And after this series
  the list_lock in SLUB is never used with irqs disabled before taking the lock.

  mm: slub: Move discard_slab() invocations out of IRQ-off sections [3] should be
  unnecessary as this series does move these invocations outside irq disabled
  sections

Some caveats that will probably have to be solved on PREEMPT_RT - I'm just not
sure enough from reading Documentation/locking/locktypes.rst how some things
work. Advice welcome.

* There are paths such as:
  get_partial_node() - does spin_lock_irqsave(&n->list_lock);
    acquire_slab()
      __cmpxchg_double_slab()
        slab_lock() - a bit spinlock without explicit irqsave

On !PREEMPT_RT this is fine as spin_lock_irqsave() disables irq so slab_lock()
doesn't need to and it's still irq-safe. I assume there are no such guarantees on
PREEMPT_RT where spin_lock_irqsave() is just a mutex with disabled migration?
So RT will have to make sure all paths to slab_lock go through explicit irqsave?

* There is this path involving IPI:
  flush_all()
    on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
      IPI with interrupts disabled (is it still true also on RT?)
        flush_cpu_slab()
          flush_slab()
            manipulate kmem_cache_cpu variables
	    deactivate_slab();

The problems here are that in flush_slab() we manipulate variables normally
protected by the local_lock. On !PREEMPT_RT we don't need the local_lock here
because local_lock_irqsave() just disables irqs and we already got them
disabled from the IPI. On PREEMPT_RT we IIUC actually even can't take the
local_lock due to the irqs already disabled. So that's a problem.

Another issue is that deactivate_slab() above will take the node_lock spinlock,
so with irqs disabled it would still have to be a raw spinlock as patch [2]
does. And it will also call discard_slab() which should be also called without
irqs disabled. So for these reasons, the RT patch "mm: slub: Move
flush_cpu_slab() invocations __free_slab() invocations out of IRQ context" [4]
converting IPIs to workqueues will still be needed. Then the work handler
can use local_lock normally and that should solve the issues with flush_all()
and hopefully allow ditching patch [2].

Or is there perhaps a simpler way to make this flush IPI not disable IRQ on
PREEMPT_RT?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0003-mm-slub-Enable-irqs-for-__GFP_WAIT.patch?h=linux-5.12.y-rt-patches
[2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0001-mm-sl-au-b-Change-list_lock-to-raw_spinlock_t.patch?h=linux-5.12.y-rt-patches
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0004-mm-slub-Move-discard_slab-invocations-out-of-IRQ-off.patch?h=linux-5.12.y-rt-patches
[4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0005-mm-slub-Move-flush_cpu_slab-invocations-__free_slab-.patch?h=linux-5.12.y-rt-patches

Vlastimil Babka (26):
  mm, slub: allocate private object map for sysfs listings
  mm, slub: allocate private object map for validate_slab_cache()
  mm, slub: don't disable irq for debug_check_no_locks_freed()
  mm, slub: simplify kmem_cache_cpu and tid setup
  mm, slub: extract get_partial() from new_slab_objects()
  mm, slub: dissolve new_slab_objects() into ___slab_alloc()
  mm, slub: return slab page from get_partial() and set c->page
    afterwards
  mm, slub: restructure new page checks in ___slab_alloc()
  mm, slub: move disabling/enabling irqs to ___slab_alloc()
  mm, slub: do initial checks in  ___slab_alloc() with irqs enabled
  mm, slub: move disabling irqs closer to get_partial() in
    ___slab_alloc()
  mm, slub: restore irqs around calling new_slab()
  mm, slub: validate partial and newly allocated slabs before loading
    them
  mm, slub: check new pages with restored irqs
  mm, slub: stop disabling irqs around get_partial()
  mm, slub: move reset of c->page and freelist out of deactivate_slab()
  mm, slub: make locking in deactivate_slab() irq-safe
  mm, slub: call deactivate_slab() without disabling irqs
  mm, slub: move irq control into unfreeze_partials()
  mm, slub: discard slabs in unfreeze_partials() without irqs disabled
  mm, slub: detach whole partial list at once in unfreeze_partials()
  mm, slub: detach percpu partial list in unfreeze_partials() using
    this_cpu_cmpxchg()
  mm, slub: only disable irq with spin_lock in __unfreeze_partials()
  mm, slub: don't disable irqs in slub_cpu_dead()
  mm, slub: use migrate_disable() in put_cpu_partial()
  mm, slub: convert kmem_cpu_slab protection to local_lock

 include/linux/slub_def.h |   2 +
 mm/slub.c                | 496 ++++++++++++++++++++++++---------------
 2 files changed, 314 insertions(+), 184 deletions(-)

-- 
2.31.1

