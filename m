Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947E390FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhEZFDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:03:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:50413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhEZFDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:03:20 -0400
IronPort-SDR: E06Il60auSPuP6VLwrQhlrOx3zADT7eG8H/yK1CKeHBxL1FUnWIVhsxYo9NoVi79KaOsFFp7OJ
 +WjnW+uEybkw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189500097"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="189500097"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 22:01:47 -0700
IronPort-SDR: 0h27wMAYK3v55YBqQB+At3rVQvoPuBvze1wykHFLgBrab2cy7/gIcvsk4hFZAx8xClj+aeRIK+
 y/CTWwHoGDqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="479700204"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 22:01:43 -0700
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
Subject: [PATCH v1 0/4] mm/mempolicy: some fix and semantics cleanup
Date:   Wed, 26 May 2021 13:01:38 +0800
Message-Id: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
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

- Feng

Changelogs:

    v1:
      * use helper func instead of macro for patch 2/4 (David Rientjes)
      * fix a possible null pointer case in patch 3/4 		
      * update commit log for 1/4
      
    RFC v2:
      * add for oom check fix patch 1/4
      * add the unification patch for mpol preprocess 2/4

Feng Tang (4):
  mm/mempolicy: skip nodemask intersect check for 'interleave' when oom
  mm/mempolicy: unify the preprocessing for mbind and set_mempolicy
  mm/mempolicy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED
    policy
  mm/mempolicy: kill MPOL_F_LOCAL bit

 include/uapi/linux/mempolicy.h |   1 +
 mm/mempolicy.c                 | 208 +++++++++++++++++++++--------------------
 2 files changed, 109 insertions(+), 100 deletions(-)

-- 
2.7.4

