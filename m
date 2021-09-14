Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD140A296
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhINBig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:38:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:19808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhINBif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:38:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307395477"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="307395477"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:37:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="543575247"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:37:14 -0700
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
Subject: [PATCH -V8 0/6] NUMA balancing: optimize memory placement for memory tiering system
Date:   Tue, 14 Sep 2021 09:36:55 +0800
Message-Id: <20210914013701.344956-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes since the last post are as follows,

- Rebased on latest upstream kernel (v5.15-rc1)

- Make user-specified threshold take effect sooner

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
Base            74238178.0                             4291.7
Patch 2        146050652.3          359.4             11248.6
Patch 3        146300787.1          355.2             11237.2
Patch 4        162536383.0          211.7             11890.4
Patch 5        157187775.0          105.9             10412.3
Patch 6        164028415.2           73.3             10810.6

The whole patchset improves the benchmark score up to 119.1%.  The
basic NUMA balancing based optimization solution (patch 1), the hot
page selection algorithm (patch 4), and the threshold automatic
adjustment algorithms (patch 6) improves the performance or reduce the
overhead (promotion MB/s) greatly.

Changelog:

v8:

- Rebased on latest upstream kernel (v5.15-rc1)

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
