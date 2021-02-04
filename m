Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2681E30F03D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhBDKNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:13:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:13170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235364AbhBDKNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:13:07 -0500
IronPort-SDR: r/IG2V1WDwmcauwHvpBtwNMdEkM0n0vc0ujJ+nb8r10jZ3TzedAL1enK43mD4lHyaRmXtahhFO
 W6P36/Gn+Eig==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245284005"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="245284005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:12:07 -0800
IronPort-SDR: iXKFfAUODQbiP17TynK/66aRPZZEhUX2EB1LJa4fxDX6XWUcK6ZZB5LMG36Dg2HBfK7Gl6HMON
 kOAczPLv4sIg==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="393093528"
Received: from qwang9-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.213.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:12:04 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V5 6/6] memory tiering: add page promotion counter
Date:   Thu,  4 Feb 2021 18:10:56 +0800
Message-Id: <20210204101056.89336-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204101056.89336-1-ying.huang@intel.com>
References: <20210204101056.89336-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To distinguish the number of the memory tiering promoted pages from
that of the originally inter-socket NUMA balancing migrated pages.
The counter is per-node (count in the target node).  So this can be
used to identify promotion imbalance among the NUMA nodes.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  1 +
 mm/migrate.c           | 10 +++++++++-
 mm/vmstat.c            |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 897331d5e57c..52c68f59f378 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -209,6 +209,7 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+	PGPROMOTE_SUCCESS,	/* promote successfully */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
diff --git a/mm/migrate.c b/mm/migrate.c
index 0982919f6798..eb2130b4ecb5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2175,8 +2175,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			putback_lru_page(page);
 		}
 		isolated = 0;
-	} else
+	} else {
 		count_vm_numa_event(NUMA_PAGE_MIGRATE);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+			mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+					    nr_succeeded);
+	}
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
@@ -2301,6 +2306,9 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	mod_node_page_state(page_pgdat(page),
 			NR_ISOLATED_ANON + page_lru,
 			-HPAGE_PMD_NR);
+	if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+		mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+				    HPAGE_PMD_NR);
 	return isolated;
 
 out_fail:
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 0678da1db47a..3786d8773404 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1217,6 +1217,7 @@ const char * const vmstat_text[] = {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_candidate",
+	"pgpromote_success",
 #endif
 
 	/* enum writeback_stat_item counters */
-- 
2.29.2

