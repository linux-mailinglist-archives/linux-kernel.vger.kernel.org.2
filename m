Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FD426621
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhJHIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:45:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:50073 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhJHIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:45:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="287346425"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="287346425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:43:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="489376744"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:43:24 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -V9 0/6] NUMA balancing: optimize memory placement for
 memory tiering system
References: <20211008083938.1702663-1-ying.huang@intel.com>
Date:   Fri, 08 Oct 2021 16:43:22 +0800
In-Reply-To: <20211008083938.1702663-1-ying.huang@intel.com> (Huang Ying's
        message of "Fri, 8 Oct 2021 16:39:32 +0800")
Message-ID: <87ee8vrjo5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Huang Ying <ying.huang@intel.com> writes:

> The changes since the last post are as follows,
>
> - Rebased on v5.15-rc4
>
> - Make "add promotion counter" the first patch per Yang's comments
>
> --
>
> With the advent of various new memory types, some machines will have
> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
> memory subsystem of these machines can be called memory tiering
> system, because the performance of the different types of memory are
> different.
>
> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
> for use like normal RAM"), the PMEM could be used as the
> cost-effective volatile memory in separate NUMA nodes.  In a typical
> memory tiering system, there are CPUs, DRAM and PMEM in each physical
> NUMA node.  The CPUs and the DRAM will be put in one logical node,
> while the PMEM will be put in another (faked) logical node.
>
> To optimize the system overall performance, the hot pages should be
> placed in DRAM node.  To do that, we need to identify the hot pages in
> the PMEM node and migrate them to DRAM node via NUMA migration.
>
> In the original NUMA balancing, there are already a set of existing
> mechanisms to identify the pages recently accessed by the CPUs in a
> node and migrate the pages to the node.  So we can reuse these
> mechanisms to build the mechanisms to optimize the page placement in
> the memory tiering system.  This is implemented in this patchset.
>
> At the other hand, the cold pages should be placed in PMEM node.  So,
> we also need to identify the cold pages in the DRAM node and migrate
> them to PMEM node.
>
> In commit 26aa2d199d6f ("mm/migrate: demote pages during reclaim"), a
> mechanism to demote the cold DRAM pages to PMEM node under memory
> pressure is implemented.  Based on that, the cold DRAM pages can be
> demoted to PMEM node proactively to free some memory space on DRAM
> node to accommodate the promoted hot PMEM pages.  This is implemented
> in this patchset too.
>
> We have tested the solution with the pmbench memory accessing
> benchmark with the 80:20 read/write ratio and the normal access
> address distribution on a 2 socket Intel server with Optane DC
> Persistent Memory Model.  The test results of the base kernel and step
> by step optimizations are as follows,
>
>                 Throughput	Promotion      DRAM bandwidth
> 		  access/s           MB/s                MB/s
>                -----------     ----------      --------------
> Base		69263986.8			       1830.2
> Patch 2	       135691921.4	    385.6	      11315.9
> Patch 3	       133239016.8	    384.7	      11065.2
> Patch 4	       151310868.9          197.6	      11397.0
> Patch 5	       142311252.8           99.3	       9580.8
> Patch 6	       149044263.9	     65.5	       9922.8
>
> The whole patchset improves the benchmark score up to 115.2%.  The
> basic NUMA balancing based optimization solution (patch 2), the hot
> page selection algorithm (patch 4), and the threshold automatic
> adjustment algorithms (patch 6) improves the performance or reduce the
> overhead (promotion MB/s) greatly.
>
> Changelog:
>
> v9:
>
> - Rebased on v5.15-rc4
>
> - Make "add promotion counter" the first patch per Yang's comments

In this new version, all dependencies have been merged by the latest
upstream kernel.  So it is easier to be reviewed than the previous
version you have reviewed part of them.  Do you have time to take a look
at this new series now?

Best Regards,
Huang, Ying
