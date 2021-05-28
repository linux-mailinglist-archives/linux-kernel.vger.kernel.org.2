Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591723943CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhE1OJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:09:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:63313 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhE1OIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:08:54 -0400
IronPort-SDR: shwJZ05gy54oPPa/RDC+Umxu8U3ur0lZ1AGORlDJlBkSqg2pWV2WSHesW3/qW8YKq1DNnXX27y
 qhah0S9HWrGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="202734940"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="202734940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 07:07:20 -0700
IronPort-SDR: vm5T4xDc3MzHgbFCEy2u4eU43/8v1tEBAL4XacOhxXfEqwFu3kg3Ig4zHLzH3udFUUwl5kX69x
 0DSvH+JCuC7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="481059699"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2021 07:07:16 -0700
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
Subject: [v2 PATCH 3/3] mm/mempolicy: unify the parameter sanity check for mbind and set_mempolicy
Date:   Fri, 28 May 2021 22:07:03 +0800
Message-Id: <1622210823-61911-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
References: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel_mbind() and kernel_set_mempolicy() do almost
the same operation for parameter sanity check.

Add a helper function to unify the code to reduce the redundancy,
and make it easier for changing the pre-processing code in future.

[thanks to David Rientjes for suggesting using helper function
instead of macro]

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f9ab05b..e5a3e5e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1467,26 +1467,37 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
+static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
+{
+	*flags = *mode & MPOL_MODE_FLAGS;
+	*mode &= ~MPOL_MODE_FLAGS;
+	if ((unsigned int)(*mode) >= MPOL_MAX)
+		return -EINVAL;
+	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
+		return -EINVAL;
+
+	return 0;
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
+	unsigned short mode_flags;
 	nodemask_t nodes;
+	int lmode = mode;
 	int err;
-	unsigned short mode_flags;
 
 	start = untagged_addr(start);
-	mode_flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if (mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((mode_flags & MPOL_F_STATIC_NODES) &&
-	    (mode_flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
+	err = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (err)
+		return err;
+
 	err = get_nodes(&nodes, nmask, maxnode);
 	if (err)
 		return err;
-	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
+
+	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
@@ -1500,20 +1511,20 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
 {
-	int err;
+	unsigned short mode_flags;
 	nodemask_t nodes;
-	unsigned short flags;
+	int lmode = mode;
+	int err;
+
+	err = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (err)
+		return err;
 
-	flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if ((unsigned int)mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
 	err = get_nodes(&nodes, nmask, maxnode);
 	if (err)
 		return err;
-	return do_set_mempolicy(mode, flags, &nodes);
+
+	return do_set_mempolicy(lmode, mode_flags, &nodes);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
-- 
2.7.4

