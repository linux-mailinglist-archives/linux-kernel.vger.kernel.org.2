Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8642A30F034
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhBDKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:12:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:13159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235044AbhBDKM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:12:26 -0500
IronPort-SDR: oAIi5HS8tvn7NmFpldVEQcpUfHsHWuLvkNirW9W3n7IjNNKAl7tkKkni7oYAHYwdzn2xRyopyL
 n78AWYu/j8Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245283979"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="245283979"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:11:46 -0800
IronPort-SDR: txp9yY4J58LI53q7uHt2PN5KOlXyGRZIVvD3bCiaQvVsgHmZZOUj7PeHJGxy9jCML+EEJYYin+
 MMCBCjvKdh5Q==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="393093391"
Received: from qwang9-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.213.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:11:43 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V5 0/6] autonuma: Optimize memory placement for memory tiering system
Date:   Thu,  4 Feb 2021 18:10:50 +0800
Message-Id: <20210204101056.89336-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of various new memory types, some machines will have
multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
memory subsystem of these machines can be called memory tiering
system, because the performance of the different types of memory are
usually different.

After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
for use like normal RAM"), the PMEM could be used as the
cost-effective volatile memory in separate NUMA nodes.  In a typical
memory tiering system, there are CPUs, DRAM and PMEM in each physical
NUMA node.  The CPUs and the DRAM will be put in one logical node,
while the PMEM will be put in another (faked) logical node.

To optimize the system overall performance, the hot pages should be
placed in DRAM node.  To do that, we need to identify the hot pages in
the PMEM node and migrate them to DRAM node via NUMA migration.

In the original AutoNUMA, there are already a set of existing
mechanisms to identify the pages recently accessed by the CPUs in a
node and migrate the pages to the node.  So we can reuse these
mechanisms to build the mechanisms to optimize the page placement in
the memory tiering system.  This has been implemented in this
patchset.

At the other hand, the cold pages should be placed in PMEM node.  So,
we also need to identify the cold pages in the DRAM node and migrate
them to PMEM node.

In the following patchset,

[RFC][PATCH 00/13] [v5] Migrate Pages in lieu of discard
https://lore.kernel.org/lkml/20210126003411.2AC51464@viggo.jf.intel.com/

A mechanism to demote the cold DRAM pages to PMEM node under memory
pressure is implemented.  Based on that, the cold DRAM pages can be
demoted to PMEM node proactively to free some memory space on DRAM
node.  And this frees the space on DRAM node for the hot PMEM pages to
be promoted to.  This has been implemented in this patchset too.

The patchset is based on the following not-yet-merged patchset,

[RFC][PATCH 00/13] [v5] Migrate Pages in lieu of discard
https://lore.kernel.org/lkml/20210126003411.2AC51464@viggo.jf.intel.com/

This is part of a larger patch set.  If you want to apply these or
play with them, I'd suggest using the tree from below,

https://github.com/hying-caritas/linux/commits/autonuma-r5

We have tested the solution with the pmbench memory accessing
benchmark with the 80:20 read/write ratio and the normal access
address distribution on a 2 socket Intel server with Optane DC
Persistent Memory Model.  The test results of the base kernel and step
by step optimizations are as follows,

                Throughput	Promotion      DRAM bandwidth
		  access/s           MB/s                MB/s
               -----------     ----------      --------------
Base            74238178.0                             4291.7
Patch 1        146050652.3          359.4             11248.6
Patch 2        146300787.1          355.2             11237.2
Patch 3        162536383.0          211.7             11890.4
Patch 4        157187775.0          105.9             10412.3
Patch 5        164028415.2           73.3             10810.6
Patch 6        162666229.4           74.6             10715.1

The whole patchset improves the benchmark score up to 119.1%.  The
basic AutoNUMA based optimization solution (patch 1), the hot page
selection algorithm (patch 3), and the threshold automatic adjustment
algorithms (patch 5) improves the performance or reduce the overhead
(promotion MB/s) mostly.

Changelog:

v5:

- Rebased on the latest page demotion patchset. (which bases on v5.10)

v4:

- Rebased on the latest page demotion patchset. (which bases on v5.9-rc6)

- Add page promotion counter.

v3:

- Move the rate limit control as late as possible per Mel Gorman's
  comments.

- Revise the hot page selection implementation to store page scan time
  in struct page.

- Code cleanup.

- Rebased on the latest page demotion patchset.

v2:

- Addressed comments for V1.

- Rebased on v5.5.

Huang Ying (6):
  NUMA balancing: optimize page placement for memory tiering system
  memory tiering: skip to scan fast memory
  memory tiering: hot page selection with hint page fault latency
  memory tiering: rate limit NUMA migration throughput
  memory tiering: adjust hot threshold automatically
  memory tiering: add page promotion counter

 include/linux/mm.h           |  29 ++++++++
 include/linux/mmzone.h       |  11 ++++
 include/linux/node.h         |   5 ++
 include/linux/sched/sysctl.h |  12 ++++
 kernel/sched/core.c          |   9 +--
 kernel/sched/fair.c          | 124 +++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              |  22 ++++++-
 mm/huge_memory.c             |  41 ++++++++----
 mm/memory.c                  |  11 +++-
 mm/migrate.c                 |  52 +++++++++++++--
 mm/mmzone.c                  |  17 +++++
 mm/mprotect.c                |  19 +++++-
 mm/vmscan.c                  |  15 +++++
 mm/vmstat.c                  |   4 ++
 14 files changed, 345 insertions(+), 26 deletions(-)

Best Regards,
Huang, Ying
