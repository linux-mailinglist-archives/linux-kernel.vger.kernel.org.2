Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B8400DD9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhIEDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 23:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhIEDV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 23:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC3EF60F9D;
        Sun,  5 Sep 2021 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630812024;
        bh=0pSaxwdnYx37vIi2HaUKmPD/HjxIDlDKMXnoHpjawBU=;
        h=To:Cc:From:Subject:Date:From;
        b=irTviQDZIaNGPeAeP5aNEa/hq63JagmanVTP2dGoznLI4/LB46Vb35dMA2dYdQ/v4
         PfzOYHzw7zq0K2YuiC9Km3/+f5kHZWYznieZurkz6UETQV7mmIzVTFiz/W5vm9yvbm
         uJKECEjCd9mWOAaIgljaiZU9b4ko6Kn+V/Z9mASoLNeKBi1dKE4l89Wodk83/HoZcZ
         g+71pqhJP7y0UQHnyQ1N6x1MXpyk3qu7UIPdxsa7x80bNsdTRrywZbNLO8XLvqpCuJ
         J89QO8XQhNAUMqOz79WHx8qdS185Y4pqISsmasC8R4CnFbdYiFEQhtojgzbAziYsaq
         hE43bCle+E45w==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC changes for 5.15-rc1
Message-ID: <56b00ebf-3c2d-5c2a-0491-14b378e85bb3@kernel.org>
Date:   Sat, 4 Sep 2021 20:20:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Finally a big pile of changes for ARC (atomics/mm). These are from our 
internal arc64 tree, preparing mainline for eventual arc64 support. I'm 
spreading them to avoid tsunami of patches in one release. Please pull.

Thx,
-Vineet
--------------->

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

   Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-5.15-rc1

for you to fetch changes up to 56809a28d45fcad94b28cfd614600568c0d46545:

   ARC: mm: vmalloc sync from kernel to user table to update PMD ... 
(2021-08-26 13:43:19 -0700)

----------------------------------------------------------------
ARC changes for v5.15-rc1

  - MM rework
    + Implementing up to 4 paging levels (needed in MMUv6)
    + Enable STRICT_MM_TYPECHECK
    + switch pgtable_t back to struct page *

  - Atomics rework / implementing relaxed accessors

  - Retiring support for legacy ARC750 cores and MMUv1,v2

  - A few other build errors, typos

----------------------------------------------------------------
Changcheng Deng (1):
       arch/arc/kernel/: fix misspellings using codespell tool

Randy Dunlap (1):
       ARC: export clear_user_page() for modules

Vineet Gupta (31):
       ARC: atomics: disintegrate header
       ARC: atomic: !LLSC: remove hack in atomic_set() for for UP
       ARC: atomic: !LLSC: use int data type consistently
       ARC: atomic64: LLSC: elide unused atomic_{and,or,xor,andnot}_return
       ARC: atomics: implement relaxed variants
       ARC: switch to generic bitops
       ARC: bitops: fls/ffs to take int (vs long) per asm-generic defines
       ARC: xchg: !LLSC: remove UP micro-optimization/hack
       ARC: cmpxchg/xchg: rewrite as macros to make type safe
       ARC: cmpxchg/xchg: implement relaxed variants (LLSC config only)
       ARC: atomic_cmpxchg/atomic_xchg: implement relaxed variants
       ARC: retire ARC750 support
       ARC: retire MMUv1 and MMUv2 support
       ARC: mm: use SCRATCH_DATA0 register for caching pgdir in ARCv2 only
       ARC: mm: remove tlb paranoid code
       ARC: mm: move mmu/cache externs out to setup.h
       ARC: mm: Fixes to allow STRICT_MM_TYPECHECKS
       ARC: mm: Enable STRICT_MM_TYPECHECKS
       ARC: ioremap: use more commonly used PAGE_KERNEL based uncached flag
       ARC: mm: pmd_populate* to use the canonical set_pmd (and drop 
pmd_set)
       ARC: mm: non-functional code movement/cleanup
       ARC: mm: move MMU specific bits out of ASID allocator
       ARC: mm: move MMU specific bits out of entry code ...
       ARC: mm: disintegrate mmu.h (arcv2 bits out)
       ARC: mm: disintegrate pgtable.h into levels and flags
       ARC: mm: hack to allow 2 level build with 4 level code
       ARC: mm: switch pgtable_t back to struct page *
       ARC: mm: switch to asm-generic/pgalloc.h
       ARC: mm: support 3 levels of page tables
       ARC: mm: support 4 levels of page tables
       ARC: mm: vmalloc sync from kernel to user table to update PMD ...

  arch/arc/Kconfig |  41 +--
  arch/arc/include/asm/atomic-llsc.h |  97 +++++++
  arch/arc/include/asm/atomic-spinlock.h | 102 +++++++
  arch/arc/include/asm/atomic.h | 444 ++----------------------------
  arch/arc/include/asm/atomic64-arcv2.h | 250 +++++++++++++++++
  arch/arc/include/asm/bitops.h | 188 +------------
  arch/arc/include/asm/cache.h |   4 -
  arch/arc/include/asm/cmpxchg.h | 233 ++++++++--------
  arch/arc/include/asm/entry-compact.h |   8 -
  arch/arc/include/asm/hugepage.h |   8 -
  arch/arc/include/asm/mmu-arcv2.h | 103 +++++++
  arch/arc/include/asm/mmu.h |  87 +-----
  arch/arc/include/asm/mmu_context.h |  28 +-
  arch/arc/include/asm/page.h |  74 +++--
  arch/arc/include/asm/pgalloc.h |  81 ++----
  arch/arc/include/asm/pgtable-bits-arcv2.h | 149 ++++++++++
  arch/arc/include/asm/pgtable-levels.h | 189 +++++++++++++
  arch/arc/include/asm/pgtable.h | 339 +----------------------
  arch/arc/include/asm/processor.h |   2 +-
  arch/arc/include/asm/setup.h |  12 +-
  arch/arc/include/asm/smp.h |  14 -
  arch/arc/include/asm/tlb-mmu1.h | 101 -------
  arch/arc/kernel/entry-arcv2.S |   1 +
  arch/arc/kernel/entry.S |   7 +-
  arch/arc/kernel/intc-compact.c |   2 +-
  arch/arc/kernel/smp.c |   4 +-
  arch/arc/kernel/stacktrace.c |   2 +-
  arch/arc/mm/cache.c | 112 +-------
  arch/arc/mm/fault.c |  20 +-
  arch/arc/mm/init.c |   5 +
  arch/arc/mm/ioremap.c |   3 +-
  arch/arc/mm/tlb.c | 268 +++---------------
  arch/arc/mm/tlbex.S |  84 ++----
  33 files changed, 1226 insertions(+), 1836 deletions(-)
  create mode 100644 arch/arc/include/asm/atomic-llsc.h
  create mode 100644 arch/arc/include/asm/atomic-spinlock.h
  create mode 100644 arch/arc/include/asm/atomic64-arcv2.h
  create mode 100644 arch/arc/include/asm/mmu-arcv2.h
  create mode 100644 arch/arc/include/asm/pgtable-bits-arcv2.h
  create mode 100644 arch/arc/include/asm/pgtable-levels.h
  delete mode 100644 arch/arc/include/asm/tlb-mmu1.h


