Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E337E38A019
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhETIuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:50:18 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:57905 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231268AbhETIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:50:16 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 97FBABAC24
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:48:52 +0100 (IST)
Received: (qmail 4549 invoked from network); 20 May 2021 08:48:52 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:48:52 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 03/14] mm/page_alloc: Make should_fail_alloc_page a static function should_fail_alloc_page static
Date:   Thu, 20 May 2021 09:47:58 +0100
Message-Id: <20210520084809.8576-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for mm/page_alloc.c

  mm/page_alloc.c:3651:15: warning: no previous prototype for ‘should_fail_alloc_page’ [-Wmissing-prototypes]
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
                 ^~~~~~~~~~~~~~~~~~~~~~

This function is deliberately split out for BPF to allow errors to be
injected. The function is not used anywhere else so it is local to
the file. Make it static which should still allow error injection
to be used similar to how block/blk-core.c:should_fail_bio() works.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aaa1655cf682..26cc1a4e639b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3648,7 +3648,7 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
-noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
 }
-- 
2.26.2

