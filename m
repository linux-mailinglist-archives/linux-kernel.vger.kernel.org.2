Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AF43A98C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFPLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:09:57 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:52977 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhFPLJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:09:53 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 2A3EBFAFD2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:07:45 +0100 (IST)
Received: (qmail 31185 invoked from network); 16 Jun 2021 11:07:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jun 2021 11:07:44 -0000
Date:   Wed, 16 Jun 2021 12:07:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: [PATCH] mm/page_alloc: Split pcp->high across all online CPUs for
 cpuless nodes
Message-ID: <20210616110743.GK30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen reported the following about Feng Tang's tests on a machine
with persistent memory onlined as a DRAM-like device.

  Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
  ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
  use" mode and being managed via the buddy just like the normal RAM.

  The PMEM zones are big ones:

        present  65011712 = 248 G
        high       134595 = 525 M

  The PMEM nodes, of course, don't have any CPUs in them.

  With your series, the pcp->high value per-cpu is 69584 pages or about
  270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
  worst-case memory in the pcps per zone, or roughly 10% of the size of
  the zone.

This should not cause a problem as such although it could trigger reclaim
due to pages being stored on per-cpu lists for CPUs remote to a node. It
is not possible to treat cpuless nodes exactly the same as normal nodes
but the worst-case scenario can be mitigated by splitting pcp->high across
all online CPUs for cpuless memory nodes.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 mm/page_alloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3ab6aac2f1a3..21c67a587e36 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6687,7 +6687,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 {
 #ifdef CONFIG_MMU
 	int high;
-	int nr_local_cpus;
+	int nr_split_cpus;
 	unsigned long total_pages;
 
 	if (!percpu_pagelist_high_fraction) {
@@ -6710,10 +6710,14 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 	 * Split the high value across all online CPUs local to the zone. Note
 	 * that early in boot that CPUs may not be online yet and that during
 	 * CPU hotplug that the cpumask is not yet updated when a CPU is being
-	 * onlined.
-	 */
-	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone)))) + cpu_online;
-	high = total_pages / nr_local_cpus;
+	 * onlined. For memory nodes that have no CPUs, split pcp->high across
+	 * all online CPUs to mitigate the risk that reclaim is triggered
+	 * prematurely due to pages stored on pcp lists.
+	 */
+	nr_split_cpus = cpumask_weight(cpumask_of_node(zone_to_nid(zone))) + cpu_online;
+	if (!nr_split_cpus)
+		nr_split_cpus = num_online_cpus();
+	high = total_pages / nr_split_cpus;
 
 	/*
 	 * Ensure high is at least batch*4. The multiple is based on the
