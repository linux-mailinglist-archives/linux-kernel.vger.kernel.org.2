Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200D837F339
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEMGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:50:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:19897 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhEMGuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:50:10 -0400
IronPort-SDR: yVbPDotRl8Jn5mCePHQVzD/+CwhYLw6zueSyA1Y9w2j8q6Wv2X0DIllRMzJOmZXbXG9suZeyyo
 tCB5LOWSTRyg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="220869987"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="220869987"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 23:49:00 -0700
IronPort-SDR: U9vE5e7D+uHcEkdlJ/9H2KC6Qxjc69tiJh3o7GqE9EzEZkUc7GIRHQNZ9GKnHijKme+lwIbi0/
 WGEta5zyBZQg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625872650"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 23:48:56 -0700
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
Subject: [PATCH] mm, swap: Remove unnecessary smp_rmb() in swap_type_to_swap_info()
Date:   Thu, 13 May 2021 14:48:37 +0800
Message-Id: <20210513064837.3949064-1-ying.huang@intel.com>
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

Because the ordering isn't guaranteed, it's possible that "p" is read
before checking "type".  And that may result in NULL pointer
dereference.

So in commit c10d38cc8d3e, the code becomes,

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
  /* access fields of *p */

Because "p" is checked to be non-zero before dereference, smp_rmb()
isn't needed anymore.

We still need to guarantee swap_info[type] is read before dereference.
That can be satisfied via the data dependency ordering of
READ_ONCE(swap_info[type]).  The corresponding smp_wmb() is adjusted
in alloc_swap_info() too.

And, we don't need to read "nr_swapfiles" too.  Because if
"type >= nr_swapfiles", swap_info[type] will be NULL.  We just need
to make sure we will not access out of the boundary of the array.
With that change, nr_swapfiles will only be accessed with swap_lock
held, except in swapcache_free_entries().  Where the absolute
correctness of the value isn't needed, as described in the comments.

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
---
 mm/swapfile.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2aad85751991..4c1fb28bbe0e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -100,10 +100,14 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
-	if (type >= READ_ONCE(nr_swapfiles))
+	if (type >= MAX_SWAPFILES)
 		return NULL;
 
-	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
+	/*
+	 * The data dependency ordering from the READ_ONCE() pairs
+	 * with smp_wmb() in alloc_swap_info() to guarantee the
+	 * swap_info_struct fields are read after swap_info[type].
+	 */
 	return READ_ONCE(swap_info[type]);
 }
 
@@ -2884,14 +2888,10 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	if (type >= nr_swapfiles) {
 		p->type = type;
-		WRITE_ONCE(swap_info[type], p);
-		/*
-		 * Write swap_info[type] before nr_swapfiles, in case a
-		 * racing procfs swap_start() or swap_next() is reading them.
-		 * (We never shrink nr_swapfiles, we never free this entry.)
-		 */
+		/* Paired with READ_ONCE() in swap_type_to_swap_info() */
 		smp_wmb();
-		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
+		WRITE_ONCE(swap_info[type], p);
+		nr_swapfiles++;
 	} else {
 		defer = p;
 		p = swap_info[type];
-- 
2.30.2

