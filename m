Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7037B3A396C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFKB4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:56:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:50523 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhFKB4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:56:43 -0400
IronPort-SDR: gT2hzes16oQeNbZzZJLjrRRvDXSGskYdgdY90a3vWyeD7mJtmSfUx44KKIyyTyou/IF5kTUfMW
 ytR+n5dZ74Jg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="203608384"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="203608384"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 18:54:46 -0700
IronPort-SDR: Z1nMXoA+TKKljdj8QimTkHu5VKn2K5z+rehNWO3TmoKM3+QpS6X+3HuWHWONCLuJ68zGB5V5s3
 o9CJl67Qp6HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483087175"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2021 18:54:43 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Feng Tang <feng.tang@intel.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH] mm: relocate 'write_protect_seq' in struct mm_struct
Date:   Fri, 11 Jun 2021 09:54:42 +0800
Message-Id: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day robot reported a 9.2% regression for will-it-scale mmap1 test
case[1], caused by commit 57efa1fe5957 ("mm/gup: prevent gup_fast
from racing with COW during fork").

Further debug shows the regression is due to that commit changes
the offset of hot fields 'mmap_lock' inside structure 'mm_struct',
thus some cache alignment changes.

From the perf data, the contention for 'mmap_lock' is very severe
and takes around 95% cpu cycles, and it is a rw_semaphore

        struct rw_semaphore {
                atomic_long_t count;	/* 8 bytes */
                atomic_long_t owner;	/* 8 bytes */
                struct optimistic_spin_queue osq; /* spinner MCS lock */
                ...

Before commit 57efa1fe5957 adds the 'write_protect_seq', it
happens to have a very optimal cache alignment layout, as
Linus explained:

 "and before the addition of the 'write_protect_seq' field, the
  mmap_sem was at offset 120 in 'struct mm_struct'.

  Which meant that count and owner were in two different cachelines,
  and then when you have contention and spend time in
  rwsem_down_write_slowpath(), this is probably *exactly* the kind
  of layout you want.

  Because first the rwsem_write_trylock() will do a cmpxchg on the
  first cacheline (for the optimistic fast-path), and then in the
  case of contention, rwsem_down_write_slowpath() will just access
  the second cacheline.

  Which is probably just optimal for a load that spends a lot of
  time contended - new waiters touch that first cacheline, and then
  they queue themselves up on the second cacheline."

After the commit, the rw_semaphore is at offset 128, which means
the 'count' and 'owner' fields are now in the same cacheline,
and causes more cache bouncing.

Currently there are 3 "#ifdef CONFIG_XXX" before 'mmap_lock' which
will affect its offset:

  CONFIG_MMU
  CONFIG_MEMBARRIER
  CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES

The layout above is on 64 bits system with 0day's default kernel
config (similar to RHEL-8.3's config), in which all these 3 options
are 'y'. And the layout can vary with different kernel configs.

Relayouting a structure is usually a double-edged sword, as sometimes
it can helps one case, but hurt other cases. For this case, one
solution is, as the newly added 'write_protect_seq' is a 4 bytes long
seqcount_t (when CONFIG_DEBUG_LOCK_ALLOC=n), placing it into an
existing 4 bytes hole in 'mm_struct' will not change other fields'
alignment, while restoring the regression. 

[1]. https://lore.kernel.org/lkml/20210525031636.GB7744@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c..cba6022 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -445,13 +445,6 @@ struct mm_struct {
 		 */
 		atomic_t has_pinned;
 
-		/**
-		 * @write_protect_seq: Locked when any thread is write
-		 * protecting pages mapped by this mm to enforce a later COW,
-		 * for instance during page table copying for fork().
-		 */
-		seqcount_t write_protect_seq;
-
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
@@ -460,6 +453,18 @@ struct mm_struct {
 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
 					     */
+		/*
+		 * With some kernel config, the current mmap_lock's offset
+		 * inside 'mm_struct' is at 0x120, which is very optimal, as
+		 * its two hot fields 'count' and 'owner' sit in 2 different
+		 * cachelines,  and when mmap_lock is highly contended, both
+		 * of the 2 fields will be accessed frequently, current layout
+		 * will help to reduce cache bouncing.
+		 *
+		 * So please be careful with adding new fields before
+		 * mmap_lock, which can easily push the 2 fields into one
+		 * cacheline.
+		 */
 		struct rw_semaphore mmap_lock;
 
 		struct list_head mmlist; /* List of maybe swapped mm's.	These
@@ -480,7 +485,15 @@ struct mm_struct {
 		unsigned long stack_vm;	   /* VM_STACK */
 		unsigned long def_flags;
 
+		/**
+		 * @write_protect_seq: Locked when any thread is write
+		 * protecting pages mapped by this mm to enforce a later COW,
+		 * for instance during page table copying for fork().
+		 */
+		seqcount_t write_protect_seq;
+
 		spinlock_t arg_lock; /* protect the below fields */
+
 		unsigned long start_code, end_code, start_data, end_data;
 		unsigned long start_brk, brk, start_stack;
 		unsigned long arg_start, arg_end, env_start, env_end;
-- 
2.7.4

