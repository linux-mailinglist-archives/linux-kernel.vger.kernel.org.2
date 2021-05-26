Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA3390FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEZFDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:03:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:29575 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhEZFDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:03:32 -0400
IronPort-SDR: UAFVu22d7VQTeTvh4TAUGMfUz4+pEIAG+56VJD/HBdAKvebqQqzzEmrnZiuAmwxtuYV5KwFiYb
 CbwQi7k/zAFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202395910"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="202395910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 22:01:59 -0700
IronPort-SDR: zQkz1Y67YopzocW+inNWA3lREcKog8YlC7QCgQlRPgw8zTcoWfhNGL5ORVnUkuzQgO7nLoXXt1
 qTfB7hcztefw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="479700258"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 22:01:50 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v1 2/4] mm/mempolicy: unify the preprocessing for mbind and set_mempolicy
Date:   Wed, 26 May 2021 13:01:40 +0800
Message-Id: <1622005302-23027-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel_mbind() and kernel_set_mempolicy() do almost
the same operation for parameter sanity check and preprocessing.

Add a helper function to unify the code to reduce the redundancy,
and make it easier for changing the pre-processing code in future.

[thanks to David Rientjes for suggesting using helper function
instead of macro]

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1964cca..2830bb8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1460,6 +1460,20 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
+static inline int mpol_pre_process(int *mode, const unsigned long __user *nmask, unsigned long maxnode, nodemask_t *nodes, unsigned short *flags)
+{
+	int ret;
+
+	*flags = *mode & MPOL_MODE_FLAGS;
+	*mode &= ~MPOL_MODE_FLAGS;
+	if ((unsigned int)(*mode) >= MPOL_MAX)
+		return -EINVAL;
+	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
+		return -EINVAL;
+	ret = get_nodes(nodes, nmask, maxnode);
+	return ret;
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
@@ -1467,19 +1481,14 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	nodemask_t nodes;
 	int err;
 	unsigned short mode_flags;
+	int lmode = mode;
 
-	start = untagged_addr(start);
-	mode_flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if (mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((mode_flags & MPOL_F_STATIC_NODES) &&
-	    (mode_flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
-	err = get_nodes(&nodes, nmask, maxnode);
+	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
 	if (err)
 		return err;
-	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
+
+	start = untagged_addr(start);
+	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
@@ -1495,18 +1504,14 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 {
 	int err;
 	nodemask_t nodes;
-	unsigned short flags;
+	unsigned short mode_flags;
+	int lmode = mode;
 
-	flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if ((unsigned int)mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
-	err = get_nodes(&nodes, nmask, maxnode);
+	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
 	if (err)
 		return err;
-	return do_set_mempolicy(mode, flags, &nodes);
+
+	return do_set_mempolicy(lmode, mode_flags, &nodes);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
-- 
2.7.4

