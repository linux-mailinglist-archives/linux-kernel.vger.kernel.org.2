Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C832DE27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhCEAAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:00:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:37599 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhCEAAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:00:44 -0500
IronPort-SDR: 1mtsrck22LZ6m/LBe6Dtj06Mf9eSw6uMgnYKXXLWufjVGN/DkCkmPUgO52RsUn4M0nAVNwhPWz
 rRjAaLQdJmJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251569434"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="251569434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 16:00:41 -0800
IronPort-SDR: JCWsUtywXLMo2eI7nfavFq9FiMneXA9gz1RoA/iiV+cJziu8PX6aoWf0jG6UvMcWCfJJtGGMXv
 Q9kTJLS/IszQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="369924207"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 04 Mar 2021 16:00:41 -0800
Subject: [PATCH 00/10] [v6] Migrate Pages in lieu of discard
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 04 Mar 2021 15:59:49 -0800
Message-Id: <20210304235949.7922C1C3@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The full series is also available here:

	https://github.com/hansendc/linux/tree/automigrate-20210304

which also inclues some vm.zone_reclaim_mode sysctl ABI fixup
prerequisites.

The meat of this patch is in:

	[PATCH 05/10] mm/migrate: demote pages during reclaim

Which also has the most changes since the last post.  This version is
mostly to address review comments from Yang Shi and Oscar Salvador.
Review comments are documented in the individual patch changelogs.

This also contains a few prerequisite patches that fix up an issue
with the vm.zone_reclaim_mode sysctl ABI.

Changes since (automigrate-20210122):
 * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE since pages *are*
   movable.
 * Separate out helpers that check for being able to relaim anonymous
   pages versus being able to meaningfully scan the anon LRU.

--

We're starting to see systems with more and more kinds of memory such
as Intel's implementation of persistent memory.

Let's say you have a system with some DRAM and some persistent memory.
Today, once DRAM fills up, reclaim will start and some of the DRAM
contents will be thrown out.  Allocations will, at some point, start
falling over to the slower persistent memory.

That has two nasty properties.  First, the newer allocations can end
up in the slower persistent memory.  Second, reclaimed data in DRAM
are just discarded even if there are gobs of space in persistent
memory that could be used.

This set implements a solution to these problems.  At the end of the
reclaim process in shrink_page_list() just before the last page
refcount is dropped, the page is migrated to persistent memory instead
of being dropped.

While I've talked about a DRAM/PMEM pairing, this approach would
function in any environment where memory tiers exist.

This is not perfect.  It "strands" pages in slower memory and never
brings them back to fast DRAM.  Other things need to be built to
promote hot pages back to DRAM.

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

== Open Issues ==

 * For cpusets and memory policies that restrict allocations
   to PMEM, is it OK to demote to PMEM?  Do we need a cgroup-
   level API to opt-in or opt-out of these migrations?
 * Could be more aggressive about where anon LRU scanning occurs
   since it no longer necessarily involves I/O.  get_scan_count()
   for instance says: "If we have no swap space, do not bother
   scanning anon pages"

--

 Documentation/admin-guide/sysctl/vm.rst |    9
 include/linux/migrate.h                 |   20 +
 include/linux/swap.h                    |    3
 include/linux/vm_event_item.h           |    2
 include/trace/events/migrate.h          |    3
 include/uapi/linux/mempolicy.h          |    1
 mm/compaction.c                         |    3
 mm/gup.c                                |    4
 mm/internal.h                           |    5
 mm/memory-failure.c                     |    4
 mm/memory_hotplug.c                     |    4
 mm/mempolicy.c                          |    8
 mm/migrate.c                            |  369 +++++++++++++++++++++++++++++---
 mm/page_alloc.c                         |   13 -
 mm/vmscan.c                             |  173 +++++++++++++--
 mm/vmstat.c                             |    2
 16 files changed, 560 insertions(+), 63 deletions(-)

--

Changes since (automigrate-20200818):
 * Fall back to normal reclaim when demotion fails
 * Fix some compile issues, when page migration and NUMA are off

Changes since (automigrate-20201007):
 * separate out checks for "can scan anon LRU" from "can actually
   swap anon pages right now".  Previous series conflated them
   and may have been overly aggressive scanning LRU
 * add MR_DEMOTION to tracepoint header
 * remove unnecessary hugetlb page check

Changes since (https://lwn.net/Articles/824830/):
 * Use higher-level migrate_pages() API approach from Yang Shi's
   earlier patches.
 * made sure to actually check node_reclaim_mode's new bit
 * disabled migration entirely before introducing RECLAIM_MIGRATE
 * Replace GFP_NOWAIT with explicit __GFP_KSWAPD_RECLAIM and
   comment why we want that.
 * Comment on effects of that keep multiple source nodes from
   sharing target nodes

Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
Cc: Huang Ying <ying.huang@intel.com>

