Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018AC3A12EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhFILlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbhFILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70E2B219B7;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dyU2uA8gaMj+8WnIcYc+CD0Lb8B5Mc1oXS2ZWu8+WYE=;
        b=XiY1pT774bUbPDyWvVGB41zxxSPRJzrpTee0IAPyQvNPwEK2RsYSP5VRgL6cjiaeIdM0yI
        ivoQGI7tp6CQMy/IEq4xfW/xcRaGEvXykoKpqXYgdemhaxHJHQBuPhytXC1jSHaiyV7zzd
        CY/46sgytXp3GMzTZ+Ypqb2Ed3rmzMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dyU2uA8gaMj+8WnIcYc+CD0Lb8B5Mc1oXS2ZWu8+WYE=;
        b=cxzoOfW5O1kHHz9m7xcKMf6Uz1WD0BUCZKoGi5LzigVDHYoN+BnUXgewmR//QlTYzEkFMi
        F9+IAPQVC2qe7WBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 46EA6118DD;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dyU2uA8gaMj+8WnIcYc+CD0Lb8B5Mc1oXS2ZWu8+WYE=;
        b=XiY1pT774bUbPDyWvVGB41zxxSPRJzrpTee0IAPyQvNPwEK2RsYSP5VRgL6cjiaeIdM0yI
        ivoQGI7tp6CQMy/IEq4xfW/xcRaGEvXykoKpqXYgdemhaxHJHQBuPhytXC1jSHaiyV7zzd
        CY/46sgytXp3GMzTZ+Ypqb2Ed3rmzMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dyU2uA8gaMj+8WnIcYc+CD0Lb8B5Mc1oXS2ZWu8+WYE=;
        b=cxzoOfW5O1kHHz9m7xcKMf6Uz1WD0BUCZKoGi5LzigVDHYoN+BnUXgewmR//QlTYzEkFMi
        F9+IAPQVC2qe7WBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id xVXHEHOowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:31 +0000
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
Subject: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT compatible
Date:   Wed,  9 Jun 2021 13:38:29 +0200
Message-Id: <20210609113903.1421-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC v1 [1]:
* Addressed feedback from Christoph and Mel, added their acks.
* Finished RT conversion, including adopting 2 patches from the RT tree.
* The optional local_lock conversion has to sacrifice lockless fathpaths on RT
* Added some more cleanup patches to the front.

This series was initially inspired by Mel's pcplist local_lock rewrite, and
also by interest to better understand SLUB's locking and the new locking
primitives and their RT variants and implications. It should make SLUB more
preemption-friendly and fully RT compatible, hopefully without noticeable
regressions on !RT kernels, as the fast paths are not affected there.

Series is based on 5.13-rc5 and also available as a git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v2r1

It received some light stability testing on !RT and no testing within RT
kernel. The previous version also got basic performance screening (thanks Mel)
that didn't show major regressions. This version shouldn't be introducing
further regressions. But I'm still interested in e.g. Jesper's tests whether
the bulk allocator or high speed networking in general didn't regress.

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

Patches 12-21 focus on reducing irq disabled scope in the allocation slowpath:

Patch 12 moves disabling of irqs into ___slab_alloc() from its callers, which
are the allocation slowpath, and bulk allocation. Instead these callers only
disable preemption to stabilize the cpu. The following patches then gradually
reduce the scope of disabled irqs in ___slab_alloc() and the functions called
from there. As of patch 15, the re-enabling of irqs based on gfp flags before
calling the page allocator is removed from allocate_slab(). As of patch 18,
it's possible to reach the page allocator (when existing slabs are depleted of
free objects) without disabling and re-enabling irqs a single time on the way.

Pathces 22-27 similarly reduce the scope of disabled irqs in functions related
to unfreezing percpu partial slab.

Patch 28 is preparatory. Patch 29 is adopted from the RT tree and converts the
flushing of percpu slabs on all cpus from using IPIs to workqueue, so that the
processing isn't happening with irqs disabled in the IPI handler. The flushing
is not called from performance critical contexts, so it should be acceptable.

Patch 30 also comes from RT tree and makes object_map_lock RT compatible.

Patches 31-32 make slab_lock irq-safe on RT where we cannot rely on having
irq already disabled in the context of spin_lock_irqsave().

Patch 33 changes preempt disable to migrate disable, so that the nested
list_lock spinlock is safe to take on RT. Because migrate_disable() is a
function call even on !RT, a small set of private wrappers is introduced
to keep using the cheaper preempt_disable() on !PREEMPT_RT configurations.

As of this patch, SLUB should be compatible with RT's lock semantics, to the
best of my knowledge.

Finally, patch 34 changes irq disabled sections that protect kmem_cache_cpu
fields in the slow paths, with a local lock. However on PREEMPT_RT it means the
lockless fast paths can now preempt slow paths which don't expect that, so the
local lock has to be taken also in the fast paths and they are no longer
lockless. It's up to RT folks to decide if this is a good tradeoff.
The patch also updates the locking documentation in the file's comment.

The main results of this series:

* irq disabling is only done for minimum amount of time needed to protect the
  kmem_cache_cpu data or as part of spin lock, local lock and bit spinlock
  operations to make them irq-safe

* SLUB should be fully PREEMPT_RT compatible

This should have obvious implications for better preemptibility, especially on RT.

Some details are different than how the current SLUB RT tree patches are
implemented:

  mm: sl[au]b: Change list_lock to raw_spinlock_t [2] - the SLAB part can be
  dropped as a different patch restricts RT to SLUB anyway. And after this series
  the list_lock in SLUB is never taken with irqs or preemption already disabled
  so it doesn't have to be converted to raw_spinlock_t.

  mm: slub: Move discard_slab() invocations out of IRQ-off sections [3] should be
  unnecessary as this series does move these invocations outside irq disabled
  sections in a different way.

The remaining patches to upstream from the RT tree are small ones related to
KConfig. The patch that restricts PREEMPT_RT to SLUB (not SLAB or SLOB) makes
sense. The patch that disables CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT could
perhaps be re-evaluated as the series also addresses some latency issues with
percpu partial slabs.

[1] [RFC 00/26] SLUB: use local_lock for kmem_cache_cpu protection and reduce disabling irqs
    https://lore.kernel.org/lkml/20210524233946.20352-1-vbabka@suse.cz/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0001-mm-sl-au-b-Change-list_lock-to-raw_spinlock_t.patch?h=linux-5.12.y-rt-patches
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0004-mm-slub-Move-discard_slab-invocations-out-of-IRQ-off.patch?h=linux-5.12.y-rt-patches
[4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0005-mm-slub-Move-flush_cpu_slab-invocations-__free_slab-.patch?h=linux-5.12.y-rt-patches

Sebastian Andrzej Siewior (2):
  mm: slub: Move flush_cpu_slab() invocations __free_slab() invocations
    out of IRQ context
  mm: slub: Make object_map_lock a raw_spinlock_t

Vlastimil Babka (32):
  mm, slub: don't call flush_all() from list_locations()
  mm, slub: allocate private object map for sysfs listings
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
  mm, slub: do initial checks in  ___slab_alloc() with irqs enabled
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
  mm, slub: detach percpu partial list in unfreeze_partials() using
    this_cpu_cmpxchg()
  mm, slub: only disable irq with spin_lock in __unfreeze_partials()
  mm, slub: don't disable irqs in slub_cpu_dead()
  mm, slab: make flush_slab() possible to call with irqs enabled
  mm, slub: optionally save/restore irqs in slab_[un]lock()/
  mm, slub: make slab_lock() disable irqs with PREEMPT_RT
  mm, slub: use migrate_disable() on PREEMPT_RT
  mm, slub: convert kmem_cpu_slab protection to local_lock

 include/linux/slub_def.h |   2 +
 mm/slub.c                | 750 ++++++++++++++++++++++++++-------------
 2 files changed, 499 insertions(+), 253 deletions(-)

-- 
2.31.1

