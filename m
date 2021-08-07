Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12683E32B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhHGCWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhHGCWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628302908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q+7cG7xhRyIP8KFqGqqBfTmxfpmvZcxdghzXKqssv0Y=;
        b=ZuFS64Eif3+t4sdatlaVOBHmi4Yxr1kAT22dFuOpjxl6xsP/A6t1EsZ2d73X8da/Lj/4AQ
        E9fsSs1LKSBDB4ucgPv9dqab7i4sDiq8qdt7zfSHXdbGpnbVtCpR1DaH76gt5+t7xLFGXh
        P4/su3cyO40R6pTIN3/4zQyVlmMWsjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-PwD0IpJLOpqWA9RHngli0g-1; Fri, 06 Aug 2021 22:21:47 -0400
X-MC-Unique: PwD0IpJLOpqWA9RHngli0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 587521853025;
        Sat,  7 Aug 2021 02:21:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46CF627C47;
        Sat,  7 Aug 2021 02:21:41 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, npache@redhat.com, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com
Subject: [PATCH v2] vm_swappiness=0 should still try to avoid swapping anon memory
Date:   Fri,  6 Aug 2021 22:21:29 -0400
Message-Id: <20210807022129.8842-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b91ac374346b ("mm: vmscan: enforce inactive:active ratio at the
reclaim root") swappiness can start prematurely swapping anon memory.
This is due to the assumption that refaulting anon should always allow
the shrinker to target anon memory. Add a check for swappiness being
>0 before indiscriminately targeting Anon.

This does not completely disable swapping, but rather tames the
refaulting aspect of the code that allows for the deactivating of anon
memory.

A similar solution may be possible in the get_scan_count() part of the
code, which determines the reclaim pressure for each LRU; however I
believe that kind of solution may be too aggressive, and not allow other
parts of the code (like direct reclaim) from targeting the active_anon
list. This way we stop the problem at the heart of what is causing the
issue, with the least amount of interference in other code paths.

Furthermore, shrink_lruvec can modify the reclaim pressure of each LRU,
which may make the get_scan_count solution even trickier.

Changelog:
 -v2: made this mem_cgroup specific so now it will work with v1, v2, and
   no cgroups. I've also touched up my commit log.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/vmscan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..89d4e84011b7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2909,8 +2909,9 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[0] ||
-			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+		if (mem_cgroup_swappiness(sc->target_mem_cgroup) &&
+			(refaults != target_lruvec->refaults[0] ||
+			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
 			sc->may_deactivate &= ~DEACTIVATE_ANON;
-- 
2.31.1

