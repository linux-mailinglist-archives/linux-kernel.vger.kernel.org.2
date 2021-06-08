Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2C39EB04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFHAxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:53:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:4251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhFHAx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:53:29 -0400
IronPort-SDR: IM+GdIuUmiP5UzzfFC/lTm1bG0NsJvblpZiZmKb8IjshWpKIjm8ixKp0NcFG2/blpGvcXVYNgz
 lV96i7EtTahA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185119919"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="185119919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 17:51:37 -0700
IronPort-SDR: q/wCTAnYL3WnH3KJ+Ba5oWsrAwn24eYI+tw3G+eSL6UfDKmrh4r0KqVT5225wkYVs28GIXcHNY
 DdBrIvXRwL9Q==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="447695110"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 17:51:33 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] swap: Check mapping_empty() for swap cache before being freed
Date:   Tue,  8 Jun 2021 08:51:21 +0800
Message-Id: <20210608005121.511140-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To check whether all pages and shadow entries in swap cache has been
removed before swap cache is freed.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>
---

BTW: The patch reverts the following patch in -mm tree in effect.

mm/swap: remove unused global variable nr_swapper_spaces

---
 mm/swap_state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 95e391f46468..c56aa9ac050d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -37,6 +37,7 @@ static const struct address_space_operations swap_aops = {
 };
 
 struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
+static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
@@ -684,6 +685,7 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		/* swap cache doesn't use writeback related tags */
 		mapping_set_no_writeback_tags(space);
 	}
+	nr_swapper_spaces[type] = nr;
 	swapper_spaces[type] = spaces;
 
 	return 0;
@@ -691,7 +693,13 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 
 void exit_swap_address_space(unsigned int type)
 {
-	kvfree(swapper_spaces[type]);
+	int i;
+	struct address_space *spaces = swapper_spaces[type];
+
+	for (i = 0; i < nr_swapper_spaces[type]; i++)
+		VM_WARN_ON_ONCE(!mapping_empty(&spaces[i]));
+	kvfree(spaces);
+	nr_swapper_spaces[type] = 0;
 	swapper_spaces[type] = NULL;
 }
 
-- 
2.30.2

