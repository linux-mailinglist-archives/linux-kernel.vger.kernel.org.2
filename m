Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF63943C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhE1OIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:08:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:63291 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236424AbhE1OIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:08:44 -0400
IronPort-SDR: PMzWQKYkEAnFKau1YJ7R5Mt+OJ5djf++in4S7vBHHqTjVX8YmX1Sp5bmJ2rwwA9xUL/8oaNDF6
 2qYO3WPSKPXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="202734894"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="202734894"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 07:07:08 -0700
IronPort-SDR: c9J/f0NDmZkintRVHYY5bIkCibKTYZYFkS1eLa9jExvqFlvB4BhlxuuV/vSn1GTt6X0C6GUEqP
 j/nZyT+YERRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="481059632"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2021 07:07:04 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [v2 PATCH 0/3] mm/mempolicy: some fix and semantics cleanup 
Date:   Fri, 28 May 2021 22:07:00 +0800
Message-Id: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We've posted v4 patchset introducing a new "perfer-many" memory policy
https://lore.kernel.org/lkml/1615952410-36895-1-git-send-email-feng.tang@intel.com/ ,
for which Michal Hocko gave many comments while pointing out some
problems, and we also found some semantics confusion about 'prefer'
and 'local' policy, as well as some duplicated code. This patchset
tries to address them. Please help to review, thanks!

The patchset has been run with some sanity test like 'stress-ng'
and 'ltp', and no problem found.

Thanks,
Feng

Changelogs:
    v2:
      * rename mempolicy_nodemask_intersects() to
        mempolicy_in_oom_domain() and correct commit log (Michal Hocko)
      * change the mpol syscall param sanity check (Michal Hocko) 
      * combine the 3/4 and 4/4 in v1 into one patch,
        and further clean the logic (Michal Hocko)

    v1:
      * use helper func instead of macro for patch 2/4 (David Rientjes)
      * fix a possible null pointer case in patch 3/4 		
      * update commit log for 1/4
      
    RFC v2:
      * add for oom check fix patch 1/4
      * add the unification patch for mpol preprocess 2/4

Feng Tang (3):
  mm/mempolicy: cleanup nodemask intersection check for oom
  mm/mempolicy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED
    policy
  mm/mempolicy: unify the parameter sanity check for mbind and
    set_mempolicy

 include/linux/mempolicy.h      |   2 +-
 include/uapi/linux/mempolicy.h |   1 -
 mm/mempolicy.c                 | 205 ++++++++++++++++++++---------------------
 mm/oom_kill.c                  |   2 +-
 4 files changed, 103 insertions(+), 107 deletions(-)

-- 
2.7.4

