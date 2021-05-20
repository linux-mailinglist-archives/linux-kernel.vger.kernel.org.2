Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4738A029
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhETIvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:51:08 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:40129 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhETIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:51:07 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id DD7FA1C3C01
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:49:45 +0100 (IST)
Received: (qmail 7830 invoked from network); 20 May 2021 08:49:45 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:49:45 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 08/14] mm/memory_hotplug: Fix kerneldoc comment for __remove_memory
Date:   Thu, 20 May 2021 09:48:03 +0100
Message-Id: <20210520084809.8576-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for __remove_memory

  mm/memory_hotplug.c:2044: warning: expecting prototype for remove_memory(). Prototype was for __remove_memory() instead

Commit eca499ab3749 ("mm/hotplug: make remove_memory() interface usable")
introduced the kerneldoc comment and function but the kerneldoc name and
function name did not match.

Fixes: eca499ab3749 ("mm/hotplug: make remove_memory() interface usable")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e3266be1d020..4ea1b19e8c7a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2031,7 +2031,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 }
 
 /**
- * remove_memory
+ * __remove_memory - Remove memory if every memory block is offline
  * @nid: the node ID
  * @start: physical address of the region to remove
  * @size: size of the region to remove
-- 
2.26.2

