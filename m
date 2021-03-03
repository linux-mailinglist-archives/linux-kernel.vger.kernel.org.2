Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1277E32BD3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384155AbhCCPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:36:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:57503 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356890AbhCCKsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:48:41 -0500
IronPort-SDR: aKg9U8/hLPl8qryPXO6IXVPjeqgW0Pr46gYVx6W5tjd/G6qYajex9b4BvjvmHD/IKLDaHxhZLG
 1Qnp4QJpOUqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802584"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802584"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:03 -0800
IronPort-SDR: 9QrR37MV3t4bXLQ8tV7FZSTHd2QlJ8vHvNyTE3xwKUG0zj764VUZFE5gsB5CyewUnrtYAndMzX
 LiHJrh+17DOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445199913"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:20:59 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi leen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 00/14] Introduced multi-preference mempolicy
Date:   Wed,  3 Mar 2021 18:20:44 +0800
Message-Id: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces the concept of the MPOL_PREFERRED_MANY mempolicy.
This mempolicy mode can be used with either the set_mempolicy(2) or mbind(2)
interfaces. Like the MPOL_PREFERRED interface, it allows an application to set a
preference for nodes which will fulfil memory allocation requests. Unlike the
MPOL_PREFERRED mode, it takes a set of nodes. Like the MPOL_BIND interface, it
works over a set of nodes. Unlike MPOL_BIND, it will not cause a SIGSEGV or
invoke the OOM killer if those preferred nodes are not available.

Along with these patches are patches for libnuma, numactl, numademo, and memhog.
They still need some polish, but can be found here:
https://gitlab.com/bwidawsk/numactl/-/tree/prefer-many
It allows new usage: `numactl -P 0,3,4`

The goal of the new mode is to enable some use-cases when using tiered memory
usage models which I've lovingly named.
1a. The Hare - The interconnect is fast enough to meet bandwidth and latency
requirements allowing preference to be given to all nodes with "fast" memory.
1b. The Indiscriminate Hare - An application knows it wants fast memory (or
perhaps slow memory), but doesn't care which node it runs on. The application
can prefer a set of nodes and then xpu bind to the local node (cpu, accelerator,
etc). This reverses the nodes are chosen today where the kernel attempts to use
local memory to the CPU whenever possible. This will attempt to use the local
accelerator to the memory.
2. The Tortoise - The administrator (or the application itself) is aware it only
needs slow memory, and so can prefer that.

Much of this is almost achievable with the bind interface, but the bind
interface suffers from an inability to fallback to another set of nodes if
binding fails to all nodes in the nodemask.

Like MPOL_BIND a nodemask is given. Inherently this removes ordering from the
preference.

> /* Set first two nodes as preferred in an 8 node system. */
> const unsigned long nodes = 0x3
> set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);

> /* Mimic interleave policy, but have fallback *.
> const unsigned long nodes = 0xaa
> set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);

Some internal discussion took place around the interface. There are two
alternatives which we have discussed, plus one I stuck in:
1. Ordered list of nodes. Currently it's believed that the added complexity is
   nod needed for expected usecases.
2. A flag for bind to allow falling back to other nodes. This confuses the
   notion of binding and is less flexible than the current solution.
3. Create flags or new modes that helps with some ordering. This offers both a
   friendlier API as well as a solution for more customized usage. It's unknown
   if it's worth the complexity to support this. Here is sample code for how
   this might work:

> // Prefer specific nodes for some something wacky
> set_mempolicy(MPOL_PREFER_MANY, 0x17c, 1024);
>
> // Default
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_SOCKET, NULL, 0);
> // which is the same as
> set_mempolicy(MPOL_DEFAULT, NULL, 0);
>
> // The Hare
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, NULL, 0);
>
> // The Tortoise
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_REV, NULL, 0);
>
> // Prefer the fast memory of the first two sockets
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, -1, 2);
>

In v1, Andi Kleen brought up reusing MPOL_PREFERRED as the mode for the API.
There wasn't consensus around this, so I've left the existing API as it was. I'm
open to more feedback here, but my slight preference is to use a new API as it
ensures if people are using it, they are entirely aware of what they're doing
and not accidentally misusing the old interface. (In a similar way to how
MPOL_LOCAL was introduced).

In v1, Michal also brought up renaming this MPOL_PREFERRED_MASK. I'm equally
fine with that change, but I hadn't heard much emphatic support for one way or
another, so I've left that too.

Changelog: 

  Since v2:
  * Rebased against v5.11
  * Fix a stack overflow related panic, and a kernel warning (Feng)
  * Some code clearup (Feng)
  * One RFC patch to speedup mem alloc in some case (Feng)

  Since v1:
  * Dropped patch to replace numa_node_id in some places (mhocko)
  * Dropped all the page allocation patches in favor of new mechanism to
    use fallbacks. (mhocko)
  * Dropped the special snowflake preferred node algorithm (bwidawsk)
  * If the preferred node fails, ALL nodes are rechecked instead of just
    the non-preferred nodes.

v3 Summary:
1: Random fix I found along the way
2-5: Represent node preference as a mask internally
6-7: Tread many preferred like bind
8-11: Handle page allocation for the new policy
12: Enable the uapi
13: unifiy 2 functions
14: RFC optimization patch

Thanks,
Ben/Dave/Feng

Ben Widawsky (8):
  mm/mempolicy: Add comment for missing LOCAL
  mm/mempolicy: kill v.preferred_nodes
  mm/mempolicy: handle MPOL_PREFERRED_MANY like BIND
  mm/mempolicy: Create a page allocator for policy
  mm/mempolicy: Thread allocation for many preferred
  mm/mempolicy: VMA allocation for many preferred
  mm/mempolicy: huge-page allocation for many preferred
  mm/mempolicy: Advertise new MPOL_PREFERRED_MANY

Dave Hansen (4):
  mm/mempolicy: convert single preferred_node to full nodemask
  mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
  mm/mempolicy: allow preferred code to take a nodemask
  mm/mempolicy: refactor rebind code for PREFERRED_MANY

Feng Tang (2):
  mem/mempolicy: unify mpol_new_preferred() and
    mpol_new_preferred_many()
  mm: speedup page alloc for MPOL_PREFERRED_MANY by adding a NO_SLOWPATH
    gfp bit

 .../admin-guide/mm/numa_memory_policy.rst          |  22 +-
 include/linux/gfp.h                                |   9 +-
 include/linux/mempolicy.h                          |   6 +-
 include/uapi/linux/mempolicy.h                     |   6 +-
 mm/hugetlb.c                                       |  22 +-
 mm/mempolicy.c                                     | 266 ++++++++++++++-------
 mm/page_alloc.c                                    |   2 +-
 7 files changed, 224 insertions(+), 109 deletions(-)

-- 
2.7.4

