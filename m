Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E947331BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCIAcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:32:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:7664 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhCIAbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:31:41 -0500
IronPort-SDR: s2PwdowNM8i6VMO1UysIDlFb0bwA8bgNCp8aNJhFXZeLSRZG09n1YwwVDsAIwMu84lK8pMCVEZ
 GJWIUC5npOpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207899666"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="207899666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 16:31:41 -0800
IronPort-SDR: NBWbpV3r055cG6hH7Nh/HKGbLcmBRU+bu0Pw7kjoVTbY9BlE4m2c0W7hwe93VlyxkGq94cTq96
 +3bdLT1OBWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="437679955"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2021 16:31:38 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJQHi-0001FB-8z; Tue, 09 Mar 2021 00:31:38 +0000
Date:   Tue, 9 Mar 2021 08:30:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC PATCH] mm: page_alloc: alloc_contig_ratelimit() can be static
Message-ID: <20210309003046.GA34778@7449abb4ec10>
References: <20210308202047.1903802-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308202047.1903802-1-minchan@kernel.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 page_alloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 43d3e1e4ab487..149a2b0e2b098 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8345,12 +8345,12 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
 		DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
-int alloc_contig_ratelimit(void)
+static int alloc_contig_ratelimit(void)
 {
 	return __ratelimit(&alloc_contig_ratelimit_state);
 }
 
-void dump_migrate_failure_pages(struct list_head *page_list)
+static void dump_migrate_failure_pages(struct list_head *page_list)
 {
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
 			"migrate failure");
