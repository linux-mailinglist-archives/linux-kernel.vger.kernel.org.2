Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9650A38A026
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhETIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:50:53 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:57254 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbhETIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:50:47 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id A19B0CACD9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:49:24 +0100 (IST)
Received: (qmail 6417 invoked from network); 20 May 2021 08:49:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:49:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 06/14] mm/memcontrol.c: Fix kerneldoc comment for mem_cgroup_calculate_protection
Date:   Thu, 20 May 2021 09:48:01 +0100
Message-Id: <20210520084809.8576-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for mem_cgroup_calculate_protection

  mm/memcontrol.c:6468: warning: expecting prototype for mem_cgroup_protected(). Prototype was for mem_cgroup_calculate_protection() instead

Commit 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from
protection checks") changed the function definition but not the associated
kerneldoc comment.

Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..030c1dc131ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6456,7 +6456,7 @@ static unsigned long effective_protection(unsigned long usage,
 }
 
 /**
- * mem_cgroup_protected - check if memory consumption is in the normal range
+ * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
-- 
2.26.2

