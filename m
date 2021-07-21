Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6653D091D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhGUGDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:03:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:44388 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhGUF70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:59:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272496401"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="272496401"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:40:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="511390055"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:39:57 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH -V11 8/9] mm/vmscan: never demote for memcg reclaim
Date:   Wed, 21 Jul 2021 14:39:25 +0800
Message-Id: <20210721063926.3024591-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721063926.3024591-1-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Global reclaim aims to reduce the amount of memory used on a given node or
set of nodes.  Migrating pages to another node serves this purpose.

memcg reclaim is different.  Its goal is to reduce the total memory
consumption of the entire memcg, across all nodes.  Migration does not
assist memcg reclaim because it just moves page contents between nodes
rather than actually reducing memory consumption.

Link: https://lkml.kernel.org/r/20210715055145.195411-9-ying.huang@intel.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 67a320c6571d..60179903ed9e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -521,8 +521,13 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 
 static bool can_demote(int nid, struct scan_control *sc)
 {
-	if (sc && sc->no_demotion)
-		return false;
+	if (sc) {
+		if (sc->no_demotion)
+			return false;
+		/* It is pointless to do demotion in memcg reclaim */
+		if (cgroup_reclaim(sc))
+			return false;
+	}
 	if (next_demotion_node(nid) == NUMA_NO_NODE)
 		return false;
 
-- 
2.30.2

