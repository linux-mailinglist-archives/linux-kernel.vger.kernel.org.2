Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0E389FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhETIb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:31:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:61362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhETIb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:31:56 -0400
IronPort-SDR: voHcOnXo/2B6P5fKbS2wb2NwNDn3Qpp5VVoy9xF76S4diDkyDFI0x/jowOSLqAspITTdGc8Q1K
 1+KSAwS+rtRA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="198088155"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198088155"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 01:30:10 -0700
IronPort-SDR: OrraMT7xKCAhV7vX4z8WmEXKmxrk+p6QfFCb5R6GlHLSFMErOh7bl2yD9287jDqXiD22IWV/hn
 Edn43VdvTXJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="473899304"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2021 01:30:05 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC Patch v2 0/4] mm/mempolicy: some fix and semantics cleanup 
Date:   Thu, 20 May 2021 16:30:00 +0800
Message-Id: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
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

- Feng


Feng Tang (4):
  mm/mempolicy: skip nodemask intersect check for 'interleave' when oom
  mm/mempolicy: unify the preprocessing for mbind and set_mempolicy
  mm/mempolicy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED
    policy
  mm/mempolicy: kill MPOL_F_LOCAL bit

 include/uapi/linux/mempolicy.h |   1 +
 mm/mempolicy.c                 | 205 +++++++++++++++++++----------------------
 2 files changed, 98 insertions(+), 108 deletions(-)

-- 
2.7.4

