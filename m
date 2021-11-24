Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5C45CC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350453AbhKXTCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhKXTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:01:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:42 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 8so3703601qtx.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YmsUoDW9eMA7OqlC1Sev9mWdQTdgWApJJN3mxqyS7s=;
        b=aACX/0Ls+nHwU3OjIx7swS7Uq6pRXAbW457gf9xFUpvu9q340k1gWUys8bJmIySnk6
         Afp/UVuoYz0eCK9b7JhDCG3k0YYQQJhW2fb8iA0nCgvP2o+TF1vj500LZDopHotsote1
         5XrWcqjlgPHJ9mlnRZ0tov7Hxn7htnc/dTv/IP3Asmh/E6A44hASe0s8l/wJi6IVPa1w
         0lbywEBPv98TQA/2XkchKCd3NwtevY3W2a9nDfwRnyXQkmgvvDarzxpgNUmsGhRp29R5
         cgfU3BerKo+LiUrwLcDtqZrsoZ6AUXkgOqi4poxBnsTMAQNK5HmLU2vpwH5v5PXuCpWV
         FaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YmsUoDW9eMA7OqlC1Sev9mWdQTdgWApJJN3mxqyS7s=;
        b=Xjx3tceabqRwrCC12L1QscUg+oU7HEyf8nIXi9vPF4VayGCqLfpEBEOiwHKL9HG0Mn
         vjzTQSXeviWKGboIX0NldG7eIqizMLjElaT90jjchFI2AdK+SJBawB53m7JI7kXZfZKo
         Xdr4B5SnK1ai2v0fL3OvokzRm1+FagS7igQ8gPtHp10SPfq3meNUk6/ZUwnA0bmyzZ3X
         YX6KZj57dfv3CSiz5cspBzmp6I6jDcHGYJmvb/JAmfMTV1SDZGa7TYHjFK3GejgMxdFx
         LmUKgHH3713xyO09Pz3GbKeCIhzo/zY0X4WLm3+az45E/4DX5lg1LBpptm4SYOX4THs8
         RBRw==
X-Gm-Message-State: AOAM532tgQ+a20OWTAGRRDMYmLvGPmR3ZhK6Pjt3wKrCYeOJbk4f2qjS
        foUSNs/7xReNQISvoiKr+lo=
X-Google-Smtp-Source: ABdhPJz9YQrN+sAh/Q7X19JbLZJVr7MvV4sU7b/DT2reZGw5fFTq9k22ixjnmBV/nKNZh38RtMVjNQ==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr9922754qty.378.1637780321136;
        Wed, 24 Nov 2021 10:58:41 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:a1b0])
        by smtp.gmail.com with ESMTPSA id r16sm315775qkp.42.2021.11.24.10.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:58:40 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     dave.hansen@linux.intel.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Reclaim to satisfy WMARK_DEMOTE on toptier nodes
Date:   Wed, 24 Nov 2021 13:58:29 -0500
Message-Id: <cd42adda728e211be3f1d8719221dd02088b76bf.1637778851.git.hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1637778851.git.hasanalmaruf@fb.com>
References: <cover.1637778851.git.hasanalmaruf@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kswapd is wakenup on a toptier node in a tiered-memory NUMA
balancing mode, it reclaims pages until the toptier node is balanced
and the number of free pages on toptier node satisfies WMARK_DEMOTE.

When THP (Transparent Huge Page) is enabled, sometimes demotion/promotion
between the memory nodes may pause for several hundreds of seconds as
the pages in the toptier node may sometimes become so hot, that kswapd
fails to reclaim any page.  Finally, the kswapd failure count
(pgdat->kswapd_failures) reaches its max value and kswapd will not be
waken up until a successful direct reclaiming. For general use case,
this isn't a big problem as the memory users will do direct reclaim
finally and trigger successful direct reclaiming or OOM to fix the
issue. But in memory tiering system, the demotion and promotion will
avoid to create too much memory pressure on the fast memory node, so
direct reclaiming will not be triggered to resolve the issue. To
resolve this, when promotion enabled, kswapd will be waken up every
10 seconds to try to free some pages to recover kswapd failures.

Signed-off-by: Hasan Al Maruf <hasanalmaruf@fb.com>
---
 mm/vmscan.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c39b217effa9..1e87221f2b58 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2386,8 +2386,14 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	unsigned long ap, fp;
 	enum lru_list lru;
 
-	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
+	/*
+	 * If we have no swap space, do not bother scanning anon pages.
+	 * However, anon pages on toptier node can be demoted via reclaim
+	 * when numa promotion is enabled. Disable the check to prevent
+	 * demotion for no swap space when numa promotion is enabled.
+	 */
+	if (!numa_promotion_tiered_enabled &&
+		(!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc))) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2916,7 +2922,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			if (!managed_zone(zone))
 				continue;
 
-			total_high_wmark += high_wmark_pages(zone);
+			if (numa_promotion_tiered_enabled && node_is_toptier(pgdat->node_id))
+				total_high_wmark += demote_wmark_pages(zone);
+			else
+				total_high_wmark += high_wmark_pages(zone);
 		}
 
 		/*
@@ -3574,6 +3583,9 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	unsigned long mark = -1;
 	struct zone *zone;
 
+	if (numa_promotion_tiered_enabled && node_is_toptier(pgdat->node_id) &&
+			highest_zoneidx >= ZONE_NORMAL)
+		return pgdat_toptier_balanced(pgdat, 0, highest_zoneidx);
 	/*
 	 * Check watermarks bottom-up as lower zones are more likely to
 	 * meet watermarks.
@@ -3692,7 +3704,10 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 		if (!managed_zone(zone))
 			continue;
 
-		sc->nr_to_reclaim += max(high_wmark_pages(zone), SWAP_CLUSTER_MAX);
+		if (numa_promotion_tiered_enabled && node_is_toptier(pgdat->node_id))
+			sc->nr_to_reclaim += max(demote_wmark_pages(zone), SWAP_CLUSTER_MAX);
+		else
+			sc->nr_to_reclaim += max(high_wmark_pages(zone), SWAP_CLUSTER_MAX);
 	}
 
 	/*
@@ -4021,8 +4036,23 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 */
 		set_pgdat_percpu_threshold(pgdat, calculate_normal_threshold);
 
-		if (!kthread_should_stop())
-			schedule();
+		if (!kthread_should_stop()) {
+			/*
+			 * In numa promotion modes, try harder to recover from
+			 * kswapd failures, because direct reclaiming may be
+			 * not triggered.
+			 */
+			if (numa_promotion_tiered_enabled &&
+						node_is_toptier(pgdat->node_id) &&
+					pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES) {
+				remaining = schedule_timeout(10 * HZ);
+				if (!remaining) {
+					pgdat->kswapd_highest_zoneidx = ZONE_MOVABLE;
+					pgdat->kswapd_order = 0;
+				}
+			} else
+				schedule();
+		}
 
 		set_pgdat_percpu_threshold(pgdat, calculate_pressure_threshold);
 	} else {
-- 
2.30.2

