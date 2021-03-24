Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358BE3473CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhCXIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:39:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:3069 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhCXIjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:39:44 -0400
IronPort-SDR: jeaM+3zWT8xi38PFtiK+WrU4eohA+s6k8mkmllQ9+D8arEp30ra3Zeb84EoyKAr5ZNyb24OsJf
 qpx5F/QIQdqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="254654470"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="254654470"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 01:39:43 -0700
IronPort-SDR: /1Hn1Gw25ZH8DZ0wrqQYR8IE94GRz/aOqMJX7UflhUHsaH0rukH/1JnjNa40VhuvDsunlnrZ19
 bn837bul6Wvw==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="415386079"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 01:39:39 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Yu Zhao <yuzhao@google.com>, Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [RFC] mm: activate access-more-than-once page via NUMA balancing
Date:   Wed, 24 Mar 2021 16:32:09 +0800
Message-Id: <20210324083209.527427-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One idea behind the LRU page reclaiming algorithm is to put the
access-once pages in the inactive list and access-more-than-once pages
in the active list.  This is true for the file pages that are accessed
via syscall (read()/write(), etc.), but not for the pages accessed via
the page tables.  We can only activate them via page reclaim scanning
now.  This may cause some problems.  For example, even if there are
only hot file pages accessed via the page tables in the inactive list,
we will enable the cache trim mode incorrectly to scan only the hot
file pages instead of cold anon pages.

This can be improved via NUMA balancing.  Where, the page tables of
all processes will be scanned gradually to trap the page accesses.
With that, we can identify whether a page in the inactive list has
been accessed at least twice.  If so, we can activate the page to
leave only the access-once pages in the inactive list.  This patch
implements this.

It may sound overkill to enable NUMA balancing only to activate some
pages.  But firstly, if you have used NUMA balancing already, the
added overhead is negligible.  Secondly, this patch is only the first
step to take advantage of the NUMA balancing to optimize the page
reclaiming.  We may improve the page reclaim further with the help of
the NUMA balancing.  For example, we have implemented a way to measure
the page hot/cold via NUMA balancing in

https://lore.kernel.org/linux-mm/20210311081821.138467-5-ying.huang@intel.com/

That may help to improve the LRU algorithm.  For example, instead of
migrating from PMEM to DRAM, the hot pages can be put at the head of
the active list (or a separate hot page list) to make it easier to
reclaim the cold pages at the tail of the LRU.

This patch is inspired by the work done by Yu Zhao in the
Multigenerational LRU patchset as follows,

https://lore.kernel.org/linux-mm/20210313075747.3781593-1-yuzhao@google.com/

It may be possible to combine some ideas from the multi-generational
LRU patchset with the NUMA balancing page table scanning to improve
the LRU page reclaiming algorithm.  Compared with the page table
scanning method used in the multi-generational LRU patchset, the page
tables can be scanned much slower via NUMA balancing, because the page
faults instead of the Accessed bit is used to trap the page accesses.
This can reduce the peak overhead of scanning.

To show the effect of the patch, we designed a test as follows,

On a system with 128 GB DRAM and 2 NVMe disks as swap,

  * Run the workload A with about 60 GB hot anon pages.

  * After 100 seconds, run the workload B with about 58 GB cold anon
    pages (accessed-once).

  * After another 200 second, run the workload C with about 57 GB hot
    anon pages.

It’s desirable that the 58 GB cold pages of the workload B will be
swapped out to accommodate the 57 GB memory of the workload C.

The test results are as follows,

			         base	      patched
Pages swapped in (GB)		  2.3		  0.0
Pages swapped out (GB)		 59.0		 55.9
Pages scanned (GB)		296.7		172.5
Avg length of active
list (GB)			 18.1		 58.4
Avg length of inactive
list (GB)			 89.1		 48.4

Because the size of the cold workload B (58 GB) is larger than the
size of the workload C, it’s desirable that the accessed-once pages of
workload B will be reclaimed to accommodate the workload C, so that
there should be no pages to be swapped in.  But in the base kernel,
because the pages of the workload A are scanned before that of the
workload B, some hot pages (~2.3 GB) from the workload A will be
swapped out wrongly.  While in the patched kernel, the pages of
workload A will be activated to the active list beforehand, so the
pages swapped in reduces greatly (~14.2 MB).  Because the size of
inactive list is much shorter in the patched kernel, to reclaim pages
for the workload C, the pages scanned is much less too (172.5 GB
vs. 296.7 GB).

As always, the VM subsystem is complex, any change may cause some
regressions.  We have observed some for this patch too.  The
fundamental effect of the patch is to reduce the size of inactive list
to reduce the scanning overhead and improve scanning correctness.  But
in some situations, the long inactive list in the base kernel (not
patched) can help performance.  Because it will take longer to scan
a (not so) hot page twice, to make it easier to distinguish the hot
and cold pages.  But generally, I don't think it is a good idea to
improve the performance via increasing the system overhead purely.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Inspired-by: Yu Zhao <yuzhao@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5efa07fb6cdc..b44b6fd577a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4165,6 +4165,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 			&flags);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	if (target_nid == NUMA_NO_NODE) {
+		if (!PageActive(page) && page_evictable(page) &&
+		    (!PageSwapBacked(page) || total_swap_pages)) {
+			if (pte_young(old_pte) && !PageReferenced(page))
+				SetPageReferenced(page);
+			if (PageReferenced(page))
+				mark_page_accessed(page);
+		}
 		put_page(page);
 		goto out;
 	}
-- 
2.30.2

