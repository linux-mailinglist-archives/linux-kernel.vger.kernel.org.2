Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF26B38A027
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhETIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:50:59 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:42482 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbhETIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:50:58 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 430FDC0C2E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:49:35 +0100 (IST)
Received: (qmail 7090 invoked from network); 20 May 2021 08:49:35 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:49:34 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 07/14] mm/memory_hotplug: Fix kerneldoc comment for __try_online_node
Date:   Thu, 20 May 2021 09:48:02 +0100
Message-Id: <20210520084809.8576-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for try_online_node

mm/memory_hotplug.c:1087: warning: expecting prototype for try_online_node(). Prototype was for __try_online_node() instead

Commit b9ff036082cd ("mm/memory_hotplug.c: make add_memory_resource use
__try_online_node") renamed the function but did not update the associated
kerneldoc. The function is static and somewhat specialised in nature
so it's not clear it warrants being a kerneldoc by moving the comment
to try_online_node. Hence, leave the comment of the internal helper in
place but leave it out of kerneldoc and correct the function name in
the comment.

Fixes: Commit b9ff036082cd ("mm/memory_hotplug.c: make add_memory_resource use __try_online_node")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..e3266be1d020 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1072,8 +1072,8 @@ static void rollback_node_hotadd(int nid)
 }
 
 
-/**
- * try_online_node - online a node if offlined
+/*
+ * __try_online_node - online a node if offlined
  * @nid: the node ID
  * @set_node_online: Whether we want to online the node
  * called by cpu_up() to online a node without onlined memory.
-- 
2.26.2

