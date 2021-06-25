Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B23B3D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFYHfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:35:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:29591 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhFYHfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:35:12 -0400
IronPort-SDR: sBxSL6YiXLtB6CNxhldcXCn+GAYU5IU3Um+P4Vap4E8lwuiCDf6jlobPq32x0WwdxRKnNTP2KW
 oKbAp0M15W5w==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207562646"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="207562646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:32:51 -0700
IronPort-SDR: qGS64tHnwuYbvVOOx/54ZukzYe1TvsMOw0VBQy6DpmSvGu0AheD6muo1i9N4JIZ3wG5n2zm0Xo
 5/JV9g1Co5Gw==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488085674"
Received: from msun2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:32:44 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH -V9 0/9] Migrate Pages in lieu of discard
Date:   Fri, 25 Jun 2021 15:31:55 +0800
Message-Id: <20210625073204.1005986-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full series is also available here:

	https://github.com/hying-caritas/linux/tree/automigrate-20210625

The changes since the last post are as follows,

 * Squash the original 01/10 and 02/10 and move the RCU protection
   from the original 03/10 to the squashed 1/9.
 * Make the newly added migrate_pages() parameter optional per Oscar's
   comments.
 * Restore the original behavior of MADV_PAGEOUT per Zi's comments.
 * Guard next_demotion_node() with numa_demotion_enabled per Wei's
   comments.

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

We have tested the patchset with the postgresql and pgbench.  On a
2-socket server machine with DRAM and PMEM, the kernel with the
patchset can improve the score of pgbench up to 22.1% compared with
that of the DRAM only + disk case.  This comes from the reduced disk
read throughput (which reduces up to 70.8%).

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

Changes since (automigrate-20210618):
 * Squash the original 01/10 and 02/10 and move the RCU protection
   from the original 03/10 to the squashed 1/9.
 * Make the newly added migrate_pages() parameter optional per Oscar's
   comments.
 * Restore the original behavior of MADV_PAGEOUT per Zi's comments.
 * Guard next_demotion_node() with numa_demotion_enabled per Wei's
   comments.

Changes since (automigrate-20210331):
 * Change the page allocation flags per Michal's comments.
 * Change the user interface to enable the feature.

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

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
Cc: Wei Xu <weixugc@google.com>
Cc: Zi Yan <ziy@nvidia.com>
