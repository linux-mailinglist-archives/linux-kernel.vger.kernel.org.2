Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B430CA62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbhBBSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbhBBSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:44:27 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A27CC061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:43:45 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r77so20803407qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/EUDZtKaiSyDKXvfLIwZ1X17LExjz/BTXp+Qswz/80=;
        b=Iz+nS5wB18XhzRHXXjLAFP2+rBMbj2fQKW9W5Q44tL57OvvIC6Cojk6ZN4/AsU+AGv
         9qsWNiQ29WnyFcNAolBh8/jA2621OTXLX0rFhktZrQ/TpGJNwbimKjZuuRBB7zEJTTsa
         B7JRNSsSRwHpSz/vifIONK8yfhvdlKSe8oem48/EzZe8h40a0fY1+00QhhyXUB2wprJ5
         ftVQpVLH1QOCvywbBVPj9jOh2qaXRUXeplvi/c0IyMx0jpxRAoqadgz/TXyF1MwsnXdD
         DN91xV/99jLXys7egtWY9i/OcXJk5Fc/bn3c+QT1GPWEGd3EiENaTWXhaUUF3/3NYt94
         jlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/EUDZtKaiSyDKXvfLIwZ1X17LExjz/BTXp+Qswz/80=;
        b=P0NEXfI+JjnZ5ZqOy281QOVIKGCE0zwsQvMuOt+1cQOiPXG7EFe8aGybqJUxaP5vZG
         u/tOO15jsGCvmARmvcBWx2KQwEFLhosF++2WDZoyeTFqmilADlIDXY5eRPLD4On9gLr5
         Tz0P97Y/8cA7LvxnpWeLpDdZFzeGoXyBgdYEh+Yh3GbzxSw8hTeN7pjJ6UTyb76dh8Yp
         TBRyWIfVcpEi1T7rwXX3MGeFaXRdcEFcny//MRWVjbHp0uBhI5vXYs2ehJlrcgPhKC5b
         M1YjFRO8TFP/Yhhxmp/gwbo+sQY2hyyc4QHWT2nJPr8ZA8f/Fid9dKFn8SW5WnEOd0Ms
         fXLg==
X-Gm-Message-State: AOAM530ni++2oPfuWbr6PrvwvqH/BvQQShFDo+sHHYMHODss4ViiZ8IF
        v8GwtrRo0G9NFfZyo5x5OmtcvTAqghFHOA==
X-Google-Smtp-Source: ABdhPJwit/eqC47k4f+5oaw7MilN7SBc0rePovCbW+aVM/dLH44ek4q1m6tXMzBR4h7juI2aL+zwUQ==
X-Received: by 2002:a05:620a:ce8:: with SMTP id c8mr22564722qkj.282.1612291424480;
        Tue, 02 Feb 2021 10:43:44 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t71sm17028805qka.86.2021.02.02.10.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:43:43 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: vmstat: fix NOHZ wakeups for node stat changes
Date:   Tue,  2 Feb 2021 13:43:42 -0500
Message-Id: <20210202184342.118513-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NOHZ, the periodic vmstat flushers on each CPU can go to sleep and
won't wake up until stat changes are detected in the per-cpu deltas of
the zone vmstat counters.

In commit 75ef71840539 ("mm, vmstat: add infrastructure for per-node
vmstats") per-node counters were introduced, and subsequently most
stats were moved from the zone to the node level. However, the node
counters weren't added to the NOHZ wakeup detection.

In theory this can cause per-cpu errors to remain in the user-reported
stats indefinitely. In practice this only affects a handful of sub
counters (file_mapped, dirty and writeback e.g.) because other page
state changes at the node level likely involve a change at the zone
level as well (alloc and free, lru ops). Also, nobody has complained.

Fix it up for completeness: wake up vmstat refreshing on node
changes. Also remove the BUILD_BUG_ONs that assert counter size; we
haven't relied on it since we added sizeof() to the range calculation
in commit 13c9aaf7fa01 ("mm/vmstat.c: fix NUMA statistics updates").

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmstat.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 97fc32a53320..1cf549dd703e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1904,16 +1904,12 @@ static void vmstat_update(struct work_struct *w)
  */
 static bool need_update(int cpu)
 {
+	pg_data_t *last_pgdat = NULL;
 	struct zone *zone;
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_pageset *p = per_cpu_ptr(zone->pageset, cpu);
-
-		BUILD_BUG_ON(sizeof(p->vm_stat_diff[0]) != 1);
-#ifdef CONFIG_NUMA
-		BUILD_BUG_ON(sizeof(p->vm_numa_stat_diff[0]) != 2);
-#endif
-
+		struct per_cpu_nodestat *n;
 		/*
 		 * The fast way of checking if there are any vmstat diffs.
 		 */
@@ -1925,6 +1921,13 @@ static bool need_update(int cpu)
 			       sizeof(p->vm_numa_stat_diff[0])))
 			return true;
 #endif
+		if (last_pgdat == zone->zone_pgdat)
+			continue;
+		last_pgdat = zone->zone_pgdat;
+		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
+		if (memchr_inv(n->vm_node_stat_diff, 0, NR_VM_NODE_STAT_ITEMS *
+			       sizeof(n->vm_node_stat_diff[0])))
+		    return true;
 	}
 	return false;
 }
-- 
2.30.0

