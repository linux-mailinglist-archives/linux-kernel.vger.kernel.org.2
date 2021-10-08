Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1C42660C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhJHIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:41:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:38268 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJHIlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:41:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="249823544"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="249823544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:39:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="439860303"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:39:52 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
Subject: [PATCH -V9 0/6] NUMA balancing: optimize memory placement for memory tiering system
Date:   Fri,  8 Oct 2021 16:39:32 +0800
Message-Id: <20211008083938.1702663-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes since the last post are as follows,

- Rebased on v5.15-rc4

- Make "add promotion counter" the first patch per Yang's comments

--

With the advent of various new memory types, some machines will have
multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
memory subsystem of these machines can be called memory tiering
system, because the performance of the different types of memory are
different.

After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
for use like normal RAM"), the PMEM could be used as the
cost-effective volatile memory in separate NUMA nodes.  In a typical
memory tiering system, there are CPUs, DRAM and PMEM in each physical
NUMA node.  The CPUs and the DRAM will be put in one logical node,
while the PMEM will be put in another (faked) logical node.

To optimize the system overall performance, the hot pages should be
placed in DRAM node.  To do that, we need to identify the hot pages in
the PMEM node and migrate them to DRAM node via NUMA migration.

In the original NUMA balancing, there are already a set of existing
mechanisms to identify the pages recently accessed by the CPUs in a
node and migrate the pages to the node.  So we can reuse these
mechanisms to build the mechanisms to optimize the page placement in
the memory tiering system.  This is implemented in this patchset.

At the other hand, the cold pages should be placed in PMEM node.  So,
we also need to identify the cold pages in the DRAM node and migrate
them to PMEM node.

In commit 26aa2d199d6f ("mm/migrate: demote pages during reclaim"), a
mechanism to demote the cold DRAM pages to PMEM node under memory
pressure is implemented.  Based on that, the cold DRAM pages can be
demoted to PMEM node proactively to free some memory space on DRAM
node to accommodate the promoted hot PMEM pages.  This is implemented
in this patchset too.

We have tested the solution with the pmbench memory accessing
benchmark with the 80:20 read/write ratio and the normal access
address distribution on a 2 socket Intel server with Optane DC
Persistent Memory Model.  The test results of the base kernel and step
by step optimizations are as follows,

                Throughput	Promotion      DRAM bandwidth
		  access/s           MB/s                MB/s
               -----------     ----------      --------------
Base		69263986.8			       1830.2
Patch 2	       135691921.4	    385.6	      11315.9
Patch 3	       133239016.8	    384.7	      11065.2
Patch 4	       151310868.9          197.6	      11397.0
Patch 5	       142311252.8           99.3	       9580.8
Patch 6	       149044263.9	     65.5	       9922.8

The whole patchset improves the benchmark score up to 115.2%.  The
basic NUMA balancing based optimization solution (patch 2), the hot
page selection algorithm (patch 4), and the threshold automatic
adjustment algorithms (patch 6) improves the performance or reduce the
overhead (promotion MB/s) greatly.

Changelog:

v9:

- Rebased on v5.15-rc4

- Make "add promotion counter" the first patch per Yang's comments

v8:

- Rebased on v5.15-rc1

- Make user-specified threshold take effect sooner

v7:

- Rebased on the mmots tree of 2021-07-15.

- Some minor fixes.

v6:

- Rebased on the latest page demotion patchset. (which bases on v5.11)

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

Best Regards,
Huang, Ying
