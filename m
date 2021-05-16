Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138A6381F35
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhEPOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 10:08:26 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:54351 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229888AbhEPOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 10:08:23 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id A6A75CAD11
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 15:07:07 +0100 (IST)
Received: (qmail 21356 invoked from network); 16 May 2021 14:07:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 May 2021 14:07:07 -0000
Date:   Sun, 16 May 2021 15:07:05 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_alloc: Split per cpu page lists and zone stats -fix
 -fix
Message-ID: <20210516140705.GB3735@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/ is not W=1 clean for make allnoconfig but this patch accidentally
made it worse for i386 with the warning

  mm/vmstat.c: In function ‘refresh_cpu_vm_stats’:
  mm/vmstat.c:785:34: warning: unused variable ‘pcp’ [-Wunused-variable]
     struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
                                    ^~~

This is a second fix to the mmotm patch
mm-page_alloc-split-per-cpu-page-lists-and-zone-stats.patch.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index a2c3f58253be..f1400ba46beb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -782,7 +782,9 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+#ifdef CONFIG_NUMA
 		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
+#endif
 
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			int v;
