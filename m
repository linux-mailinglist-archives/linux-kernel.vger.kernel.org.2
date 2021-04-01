Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E0351F37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhDAS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:56:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:64255 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239226AbhDASy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:54:28 -0400
IronPort-SDR: FuP25OydwmxOHt5ft04yNJY8h19VCZz8PTpeNfPDIrhA6LSVNCjdPAbmnb6ekjJ7Tapyl2bhQX
 E84hPznSdtPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277494267"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277494267"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:34:57 -0700
IronPort-SDR: KwSwaWBSIhCOyuwnE9NGHX67rxb1NL7OZFkpD94w6Ry8dIAVGJ5AiUXtNZe+AEmNc4VbdxfORX
 Ys646TBphLDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="446192246"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2021 11:34:57 -0700
Subject: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:16 -0700
Message-Id: <20210401183216.443C4443@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending this because I forgot to cc the mailing lists on the
post yesterday.  Sorry for the noise.  Please reply to this series.

The full series is also available here:

	https://github.com/hansendc/linux/tree/automigrate-20210331

which also inclues some vm.zone_reclaim_mode sysctl ABI fixup
prerequisites:

	https://github.com/hansendc/linux/commit/18daad8f0181a2da57cb43e595303c2ef5bd7b6e
	https://github.com/hansendc/linux/commit/a873f3b6f250581072ab36f2735a3aa341e36705

There are no major changes since the last post.

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
brings them back to fast DRAM.  Huang Ying has follow-on work which
repurposes autonuma to promote hot pages back to DRAM.

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

== Open Issues ==

 * Memory policies and cpusets that, for instance, restrict allocations
   to DRAM can be demoted to PMEM whenever they opt in to this
   new mechanism.  A cgroup-level API to opt-in or opt-out of
   these migrations will likely be required as a follow-on.
 * Could be more aggressive about where anon LRU scanning occurs
   since it no longer necessarily involves I/O.  get_scan_count()
   for instance says: "If we have no swap space, do not bother
   scanning anon pages"

--

 Documentation/admin-guide/sysctl/vm.rst |  12 +
 include/linux/migrate.h                 |  14 +-
 include/linux/swap.h                    |   3 +-
 include/linux/vm_event_item.h           |   2 +
 include/trace/events/migrate.h          |   3 +-
 include/uapi/linux/mempolicy.h          |   1 +
 mm/compaction.c                         |   3 +-
 mm/gup.c                                |   3 +-
 mm/internal.h                           |   5 +
 mm/memory-failure.c                     |   4 +-
 mm/memory_hotplug.c                     |   4 +-
 mm/mempolicy.c                          |   8 +-
 mm/migrate.c                            | 315 +++++++++++++++++++++++-
 mm/page_alloc.c                         |  11 +-
 mm/vmscan.c                             | 158 +++++++++++-
 mm/vmstat.c                             |   2 +
 16 files changed, 520 insertions(+), 28 deletions(-)

--

Changes since (automigrate-20210304):
 * Add ack/review tags
 * Remove duplicate synchronize_rcu() call

Changes since (automigrate-20210122):
 * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE since pages *are*
   movable.
 * Separate out helpers that check for being able to relaim anonymous
   pages versus being able to meaningfully scan the anon LRU.

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
Cc: Wei Xu <weixugc@google.com>

