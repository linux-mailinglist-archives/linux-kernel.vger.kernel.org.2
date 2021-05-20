Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D6389EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhETHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:34:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:17034 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETHes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:34:48 -0400
IronPort-SDR: mHdxQ6z3QJTxA9FAS7yz/Fan8avejP/oaMsHU8ECaXll94aO2ao/LVbTkvd4bkW1eAlpKRJFLn
 aQrVq5iVAWyw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="265079984"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265079984"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:33:27 -0700
IronPort-SDR: A2G2dULyX5u+hXjc1IsDi3pnqyRWa4YlPM1CfvPxBQNBuvpEpvJ+sDA7tnu/EP8a5WwR89GNw+
 cZ3sgBD7Kr0A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="473880275"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:33:20 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH -V2] mm, swap: Remove unnecessary smp_rmb() in swap_type_to_swap_info()
Date:   Thu, 20 May 2021 15:33:01 +0800
Message-Id: <20210520073301.1676294-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit c10d38cc8d3e ("mm, swap: bounds check swap_info array
accesses to avoid NULL derefs"), the typical code to reference the
swap_info[] is as follows,

  type = swp_type(swp_entry);
  if (type >= nr_swapfiles)
          /* handle invalid swp_entry */;
  p = swap_info[type];
  /* access fields of *p.  OOPS! p may be NULL! */

Because the ordering isn't guaranteed, it's possible that
swap_info[type] is read before "nr_swapfiles".  And that may result
in NULL pointer dereference.

So after commit c10d38cc8d3e, the code becomes,

  struct swap_info_struct *swap_type_to_swap_info(int type)
  {
	  if (type >= READ_ONCE(nr_swapfiles))
		  return NULL;
	  smp_rmb();
	  return READ_ONCE(swap_info[type]);
  }

  /* users */
  type = swp_type(swp_entry);
  p = swap_type_to_swap_info(type);
  if (!p)
	  /* handle invalid swp_entry */;
  /* dereference p */

Where the value of swap_info[type] (that is, "p") is checked to be
non-zero before being dereferenced.  So, the NULL deferencing
becomes impossible even if "nr_swapfiles" is read after
swap_info[type].  Therefore, the "smp_rmb()" becomes unnecessary.

And, we don't even need to read "nr_swapfiles" here.  Because the
non-zero checking for "p" is sufficient.  We just need to make sure we
will not access out of the boundary of the array.  With the change,
nr_swapfiles will only be accessed with swap_lock held, except in
swapcache_free_entries().  Where the absolute correctness of the value
isn't needed, as described in the comments.

We still need to guarantee swap_info[type] is read before being
dereferenced.  That can be satisfied via the data dependency ordering
enforced by READ_ONCE(swap_info[type]).  This needs to be paired with
proper write barriers.  So smp_store_release() is used in
alloc_swap_info() to guarantee the fields of *swap_info[type] is
initialized before swap_info[type] itself being written.  Note that
the fields of *swap_info[type] is initialized to be 0 via kvzalloc()
firstly.  The assignment and deferencing of swap_info[type] is like
rcu_assign_pointer() and rcu_dereference().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>

v2:

- Revise the patch description and comments per Peter's comments.

---
 mm/swapfile.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2aad85751991..65dd979a0f94 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -100,11 +100,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
-	if (type >= READ_ONCE(nr_swapfiles))
+	if (type >= MAX_SWAPFILES)
 		return NULL;
 
-	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
-	return READ_ONCE(swap_info[type]);
+	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
 static inline unsigned char swap_count(unsigned char ent)
@@ -2884,14 +2883,12 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	if (type >= nr_swapfiles) {
 		p->type = type;
-		WRITE_ONCE(swap_info[type], p);
 		/*
-		 * Write swap_info[type] before nr_swapfiles, in case a
-		 * racing procfs swap_start() or swap_next() is reading them.
-		 * (We never shrink nr_swapfiles, we never free this entry.)
+		 * Publish the swap_info_struct after initializing it.
+		 * Note that kvzalloc() above zeroes all its fields.
 		 */
-		smp_wmb();
-		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
+		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
+		nr_swapfiles++;
 	} else {
 		defer = p;
 		p = swap_info[type];
-- 
2.30.2

