Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBD35C5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhDLMJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:09:04 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:59977 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237718AbhDLMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:09:03 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 4CB161C5419
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:08:44 +0100 (IST)
Received: (qmail 2610 invoked from network); 12 Apr 2021 12:08:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2021 12:08:44 -0000
Date:   Mon, 12 Apr 2021 13:08:42 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <20210412120842.GY3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zone_pcp_reset allegedly protects against a race with drain_pages
using local_irq_save but this is bogus. local_irq_save only operates
on the local CPU. If memory hotplug is running on CPU A and drain_pages
is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
offers no protection.

This patch deletes IRQ disable/enable on the grounds that IRQs protect
nothing and assumes the existing hotplug paths guarantees the PCP cannot be
used after zone_pcp_enable(). That should be the case already because all
the pages have been freed and there is no page to put on the PCP lists.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
Resending for email address correction and adding lists

Changelog since v1
o Minimal fix

 mm/page_alloc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e8aedb64b57..9bf0db982f14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8952,12 +8952,9 @@ void zone_pcp_enable(struct zone *zone)
 
 void zone_pcp_reset(struct zone *zone)
 {
-	unsigned long flags;
 	int cpu;
 	struct per_cpu_pageset *pset;
 
-	/* avoid races with drain_pages()  */
-	local_irq_save(flags);
 	if (zone->pageset != &boot_pageset) {
 		for_each_online_cpu(cpu) {
 			pset = per_cpu_ptr(zone->pageset, cpu);
@@ -8966,7 +8963,6 @@ void zone_pcp_reset(struct zone *zone)
 		free_percpu(zone->pageset);
 		zone->pageset = &boot_pageset;
 	}
-	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
