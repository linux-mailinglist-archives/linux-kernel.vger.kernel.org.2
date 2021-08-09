Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE03E4F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhHIWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236769AbhHIWi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628548686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3phZ5xNWaqsuNurqRPYHiavKgHhNvHzLSi+t2Ovfg4k=;
        b=Aq7zhhuj313tmH09xWoHEDbtS7uQuE/olvGuQSQK64/Jgwt1BkVDZruVwM0VpziTb/pFnM
        N0fULw3I53+HOdFFScwedm/lrVpSamZ3hA/ZGntThV7+HR5FPOb9JCa98F77/GItzK80qh
        3HpgufyVxYcLVThAfX5amb+aEXWv1EI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-33a9sAwKPkKr6nNp4yEzkQ-1; Mon, 09 Aug 2021 18:38:04 -0400
X-MC-Unique: 33a9sAwKPkKr6nNp4yEzkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 639A1760C9;
        Mon,  9 Aug 2021 22:38:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1142660BF1;
        Mon,  9 Aug 2021 22:37:56 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, npache@redhat.com, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
Subject: [PATCH v3] vm_swappiness=0 should still try to avoid swapping anon memory
Date:   Mon,  9 Aug 2021 18:37:40 -0400
Message-Id: <20210809223740.59009-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 170b04b7ae49 ("mm/workingset: prepare the workingset detection
infrastructure for anon LRU") and commit b91ac374346b ("mm: vmscan: enforce
inactive:active ratio at the reclaim root") swappiness can start prematurely
swapping anon memory. This is due to the assumption that refaulting anon should
always allow the shrinker to target anon memory. Add a check for swappiness
being >0 before indiscriminately targeting Anon. Before these commits
when a user had swappiness=0 anon memory would rarely get swapped; this
behavior has remained constant sense RHEL5. This commit keeps that behavior
intact and prevents the new workingset refaulting from challenging the anon
memory when swappiness=0.

Anon can still be swapped to prevent OOM. This does not completely disable
swapping, but rather tames the refaulting aspect of the code that allows for
the deactivating of anon memory.

We have two customer workloads that discovered this issue:
1) A VM claiming 95% of the hosts memory followed by file reads (never dirty)
   which begins to challenge the anon. Refaulting the anon working set will then
   cause the indiscriminant swapping of the anon.

2) A VM running a in-memory DB is being populated from file reads.
   Swappiness is set to 0 or 1 to defer write I/O as much as possible. Once
   the customer experienced low memory, swapping anon starts, with
   little-to-no PageCache being swapped.

Previously the file cache would account for almost all of the memory
reclaimed and reads would throttle. Although the two LRU changes mentioned
allow for less thrashing of file cache, customers would like to be able to keep
the swappiness=0 behavior that has been present in the kernel for a long
time.

A similar solution may be possible in get_scan_count(), which determines the
reclaim pressure for each LRU; however I believe that kind of solution may be
too aggressive, and will not allow other parts of the code (like direct reclaim)
from targeting the active_anon list. This way we stop the problem at the heart
of what is causing the issue, with the least amount of interference in other
code paths. Furthermore, shrink_lruvec can modify the reclaim pressure of each
LRU, which may make the get_scan_count solution even trickier.

Changelog:
 -V3:
    * Blame the right commit and be more descriptive in my log message.
    * inactive_is_low should remain independent from the new swappiness check.
    * Change how we get the swappiness value. Shrink_node can be called with a
      null target_mem_cgroup so we should depend on the target_lruvec to do the
      null check on memcg.

 -V2:
     * made this mem_cgroup specific so now it will work with v1, v2, and
       no cgroups.
     * I've also touched up my commit log.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/vmscan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..9f2420da4037 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2883,8 +2883,12 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 	unsigned long file;
+	struct mem_cgroup *memcg;
+	int swappiness;
 
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+	memcg = lruvec_memcg(target_lruvec);
+	swappiness = mem_cgroup_swappiness(memcg);
 
 again:
 	memset(&sc->nr, 0, sizeof(sc->nr));
@@ -2909,7 +2913,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[0] ||
+		if ((swappiness && refaults != target_lruvec->refaults[0]) ||
 			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
-- 
2.31.1

