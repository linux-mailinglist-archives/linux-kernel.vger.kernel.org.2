Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB1361798
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhDPCaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:30:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:32958 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234659AbhDPCaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:30:07 -0400
IronPort-SDR: jgtw9HTEcuV23FzKHqVyhCEOErUXWb3NSy3gOrE+OWunI1ePRHBpr8vtOnKe0rVah8Z9ldpSo/
 dqzr5v6bHhOA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="175085568"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="175085568"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:29:43 -0700
IronPort-SDR: SngLhycm5K800PlphSrnzdMrT0sZYjcs3qa6a62EmAN0URS/tgUqhK/o7RbEFfQvRHlLmA8Huk
 qMrWdxgZwlpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="601326807"
Received: from intel10-debian.sh.intel.com ([10.239.53.15])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2021 19:29:41 -0700
From:   zhengjun.xing@linux.intel.com
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ying.huang@intel.com, tim.c.chen@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
Date:   Fri, 16 Apr 2021 02:35:36 +0000
Message-Id: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

In the system with very few file pages, it is easy to reproduce
"nr_isolated_file > nr_inactive_file",  then too_many_isolated return true,
shrink_inactive_list enter "msleep(100)", the long latency will happen.
The test case to reproduce it is very simple, allocate a lot of huge pages
(near the DRAM size), then do free, repeat the same operation many times.
There is a 3/10 rate to reproduce the issue. In the test, sc-> gfp_mask
is 0x342cca ("_GFP_IO" and "__GFP_FS" is masked),it is more easy to enter
“inactive >>=3”, then “isolated > inactive” will easy to be true.

So I  have a proposal to set a threshold number for the total file pages
to ignore the system with very few file pages, and then bypass the 100ms
sleep. It is hard to set a perfect number for the threshold, so I
just give an example of "256" for it, need more inputs for it.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 mm/vmscan.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..a1926463455c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -168,6 +168,7 @@ struct scan_control {
  * From 0 .. 200.  Higher means more swappy.
  */
 int vm_swappiness = 60;
+int lru_list_threshold = SWAP_CLUSTER_MAX << 3;
 
 static void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
@@ -1785,7 +1786,7 @@ int isolate_lru_page(struct page *page)
 static int too_many_isolated(struct pglist_data *pgdat, int file,
 		struct scan_control *sc)
 {
-	unsigned long inactive, isolated;
+	unsigned long inactive, isolated, active, nr_lru_pages;
 
 	if (current_is_kswapd())
 		return 0;
@@ -1796,11 +1797,13 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	if (file) {
 		inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
 		isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
+		active = node_page_state(pgdat, NR_ACTIVE_FILE);
 	} else {
 		inactive = node_page_state(pgdat, NR_INACTIVE_ANON);
 		isolated = node_page_state(pgdat, NR_ISOLATED_ANON);
+		active = node_page_state(pgdat, NR_ACTIVE_ANON);
 	}
-
+	nr_lru_pages = inactive + active;
 	/*
 	 * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, so they
 	 * won't get blocked by normal direct-reclaimers, forming a circular
@@ -1809,6 +1812,10 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
 		inactive >>= 3;
 
+	if (isolated > inactive)
+		if (nr_lru_pages < lru_list_threshold)
+			return 0;
+
 	return isolated > inactive;
 }
 
-- 
2.17.1

