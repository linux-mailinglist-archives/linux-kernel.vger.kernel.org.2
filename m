Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9821232BD46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448932AbhCCPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:43:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:57101 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357484AbhCCKt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:57 -0500
IronPort-SDR: 1Hn0yGLcMiEwXuwJxaKFLsjcdwiQh3j5scdFpjXdu51RgSZS0w54e+XzneD5DcG6pIX9hu6t8R
 X5xpeAIYDAaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802594"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802594"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:06 -0800
IronPort-SDR: MRHzt/NdJJ8FWdsuRTptLifMQQnxpngh+dv2T5zzI55Qqxm9YUPoy+Wa2b3YLM0wgVbHYqkJcz
 42YRkVq0arFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445199976"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:03 -0800
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
Subject: [PATCH v3 01/14] mm/mempolicy: Add comment for missing LOCAL
Date:   Wed,  3 Mar 2021 18:20:45 +0800
Message-Id: <1614766858-90344-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

MPOL_LOCAL is a bit weird because it is simply a different name for an
existing behavior (preferred policy with no node mask). It has been this
way since it was added here:
commit 479e2802d09f ("mm: mempolicy: Make MPOL_LOCAL a real policy")

It is so similar to MPOL_PREFERRED in fact that when the policy is
created in mpol_new, the mode is set as PREFERRED, and an internal state
representing LOCAL doesn't exist.

To prevent future explorers from scratching their head as to why
MPOL_LOCAL isn't defined in the mpol_ops table, add a small comment
explaining the situations.

v2:
Change comment to refer to mpol_new (Michal)

Link: https://lore.kernel.org/r/20200630212517.308045-2-ben.widawsky@intel.com
#Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2c3a865..5730fc1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -427,6 +427,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	/* [MPOL_LOCAL] - see mpol_new() */
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
-- 
2.7.4

