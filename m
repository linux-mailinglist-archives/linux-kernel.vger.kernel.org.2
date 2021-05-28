Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B123E393F04
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhE1I5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:57:24 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:36107 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234366AbhE1I5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:57:22 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id CEA4218E002
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:55:46 +0100 (IST)
Received: (qmail 5451 invoked from network); 28 May 2021 08:55:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 08:55:46 -0000
Date:   Fri, 28 May 2021 09:55:45 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and
 active CPUs
Message-ID: <20210528085545.GJ30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:36:21PM -0700, Dave Hansen wrote:
> Hi Mel,
> 
> Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
> ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
> use" mode and being managed via the buddy just like the normal RAM.
> 
> The PMEM zones are big ones:
> 
>         present  65011712 = 248 G
>         high       134595 = 525 M
> 
> The PMEM nodes, of course, don't have any CPUs in them.
> 
> With your series, the pcp->high value per-cpu is 69584 pages or about
> 270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
> worst-case memory in the pcps per zone, or roughly 10% of the size of
> the zone.
> 
> I did see quite a few pcp->counts above 60,000, so it's definitely
> possible in practice to see the pcps filled up.  This was not observed
> to cause any actual problems in practice.  But, it's still a bit worrisome.
> 

Ok, it does have the potential to trigger early reclaim as pages are
stored on remote PCP lists. The problem would be transient because
vmstat would drain those pages over time but still, how about this patch
on top of the series?

--8<--
mm/page_alloc: Split pcp->high across all online CPUs for cpuless nodes

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
---
 mm/page_alloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d708aa14f4ef..af566e97a0f8 100644
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
