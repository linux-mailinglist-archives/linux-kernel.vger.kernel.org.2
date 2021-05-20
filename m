Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE038A02C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhETIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:51:30 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:60167 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhETIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:51:29 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 3CAF2FAB48
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:50:07 +0100 (IST)
Received: (qmail 9226 invoked from network); 20 May 2021 08:50:06 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:50:06 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 10/14] mm/z3fold: Add kerneldoc fields for z3fold_pool
Date:   Thu, 20 May 2021 09:48:05 +0100
Message-Id: <20210520084809.8576-11-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for z3fold_pool

  mm/z3fold.c:171: warning: Function parameter or member 'zpool' not described in 'z3fold_pool'
  mm/z3fold.c:171: warning: Function parameter or member 'zpool_ops' not described in 'z3fold_pool'

Commit 9a001fc19ccc ("z3fold: the 3-fold allocator for compressed
pages") simply did not document the fields at the time. Add rudimentary
documentation.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/z3fold.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7fe7adaaad01..56321bf37d56 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -144,6 +144,8 @@ struct z3fold_header {
  * @c_handle:	cache for z3fold_buddy_slots allocation
  * @ops:	pointer to a structure of user defined operations specified at
  *		pool creation time.
+ * @zpool:	zpool driver
+ * @zpool_ops:	zpool operations structure with an evict callback
  * @compact_wq:	workqueue for page layout background optimization
  * @release_wq:	workqueue for safe page release
  * @work:	work_struct for safe page release
-- 
2.26.2

