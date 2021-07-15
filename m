Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856603C9892
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhGOFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 01:55:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:22887 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240092AbhGOFzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:55:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197661970"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197661970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="505591649"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:36 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V10 8/9] mm/vmscan: never demote for memcg reclaim
Date:   Thu, 15 Jul 2021 13:51:44 +0800
Message-Id: <20210715055145.195411-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715055145.195411-1-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Global reclaim aims to reduce the amount of memory used on
a given node or set of nodes.  Migrating pages to another
node serves this purpose.

memcg reclaim is different.  Its goal is to reduce the
total memory consumption of the entire memcg, across all
nodes.  Migration does not assist memcg reclaim because
it just moves page contents between nodes rather than
actually reducing memory consumption.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>

--
changes from 20210618:
 * Avoid to scan anon lists for demotion for cgroup reclaim.
---
 mm/vmscan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0f9be998230f..b697f1a6108c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -521,8 +521,13 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 
 static bool can_demote_anon_pages(int nid, struct scan_control *sc)
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

