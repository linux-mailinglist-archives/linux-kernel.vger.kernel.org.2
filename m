Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE6389FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhETIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:32:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:61362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhETIb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:31:58 -0400
IronPort-SDR: x7omwfNs6jVVXQranMsTPm+ZMFmO9Owf3CVkd024MWa9zknPM2pVfoRlrgbUkp1P5GTW/6My/B
 HIehGl6OCCjw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="198088177"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198088177"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 01:30:19 -0700
IronPort-SDR: d/xtzwRVWrQjMJ24low5iOQu84fAtGYY0Mt7lk4Nz5Gyq5OK7ikeHhBhVMP0UNo1SSNsxw/lph
 koUNTsCRD74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="473899333"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2021 01:30:15 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC Patch v2 2/4] mm/mempolicy: unify the preprocessing for mbind and set_mempolicy
Date:   Thu, 20 May 2021 16:30:02 +0800
Message-Id: <1621499404-67756-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel_mbind() and kernel_set_mempolicy() do almost
the same operation for parameter sanity check and preprocessing.

Add a macro to unify the code to reduce the redundancy, and make
it easier for changing the pre-processing code in future.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1964cca..0f5bf60 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1460,25 +1460,29 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
+#define MPOL_PRE_PROCESS() \
+	 \
+	nodemask_t nodes; \
+	int err; \
+	unsigned short mode_flags; \
+	mode_flags = mode & MPOL_MODE_FLAGS; \
+	mode &= ~MPOL_MODE_FLAGS; \
+	if (mode >= MPOL_MAX) \
+		return -EINVAL; \
+	if ((mode_flags & MPOL_F_STATIC_NODES) && \
+		(mode_flags & MPOL_F_RELATIVE_NODES)) \
+		return -EINVAL; \
+	err = get_nodes(&nodes, nmask, maxnode); \
+	if (err) \
+		return err;
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
-	nodemask_t nodes;
-	int err;
-	unsigned short mode_flags;
+	MPOL_PRE_PROCESS();
 
 	start = untagged_addr(start);
-	mode_flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if (mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((mode_flags & MPOL_F_STATIC_NODES) &&
-	    (mode_flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
-	err = get_nodes(&nodes, nmask, maxnode);
-	if (err)
-		return err;
 	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
 }
 
@@ -1493,20 +1497,8 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
 {
-	int err;
-	nodemask_t nodes;
-	unsigned short flags;
-
-	flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if ((unsigned int)mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
-	err = get_nodes(&nodes, nmask, maxnode);
-	if (err)
-		return err;
-	return do_set_mempolicy(mode, flags, &nodes);
+	MPOL_PRE_PROCESS();
+	return do_set_mempolicy(mode, mode_flags, &nodes);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
-- 
2.7.4

