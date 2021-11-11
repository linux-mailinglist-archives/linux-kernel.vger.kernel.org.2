Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B130544D0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhKKESX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhKKESJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:18:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD1C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g190-20020a25dbc7000000b005c21574c704so7400545ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kkYXutnF3tqIDgP/+md0LwFCRHQYe48hIbECc2/BN/g=;
        b=LjoYxRZJYGByr+juxNeKldPgxBmLVsfVRXHrmp+7FV3oJhOJ8obUU4xaVWVIDbQ3uk
         SjX0YFAuTOrg6sQNKDPmivE/csYeEyFQkhjz2AvEjOvDbennQj+TxGtBV5KsnSMemAwW
         7ni5j0xum/RctjppDOQRr+XxLwEaGg8QT7ZDO+wahZCfX1Z56MQc5VWklkSw6vCh0qwx
         mTatUMaAKsq/hAKH32rwujCvNY3b3IyiZPFBaxraFFHFjd6tSZVGTFgfM6RjW4bI6bc9
         VW3xjO/bvg1eUKFFwhmVwTr0RmHc0eqDTRjxvotdl5fRrEVvVjtibZ5dbUqcQcBwC0WY
         egZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kkYXutnF3tqIDgP/+md0LwFCRHQYe48hIbECc2/BN/g=;
        b=XBwoPuuhLgdgX4PqWCKxg83KOCBPJHljRUFrf+6hUPvj9iWgzQESJsV+0h7tcNGZs8
         dYEoS7tZAPACscXyDiJrYr80335RXtp6meXhzurM5Q22zBc/re85xgmUEGl1Aag8Vbu5
         19E9LWUlpXAPNgK3eGFy6o1AYdxlRbzVzTnu6Djiim1sfQxomm4AnImSNPMJIg6DaBU3
         Z2odXq90XRDbklgZCSrgiPVUTT1OB2ywDH3YkMQ/4j2Tvguh83uUFtansxIz/0obGbHq
         Aqauye8jUUjFETOWGvexkMjXqOl2X/smvhQg73z7IzQcJI48ObYIhcJfQaQjgfL8TWCA
         FK3Q==
X-Gm-Message-State: AOAM531wrIiEz7Di6ZXEG6088651vQpz3DM0Jb9n72Nljx16+S+9Em3v
        6jdMWN+bmm5eWwlPN/cSVlUHuTh6+eg=
X-Google-Smtp-Source: ABdhPJwUYfVo4AnRC14nO9b/ERoW/rwISJSmlGaWjVjwgv+GeM62fJuFNr4x956f5zWuu+0six7mwizy2uc=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:346b:bb72:659e:f91c])
 (user=yuzhao job=sendgmr) by 2002:a25:f20e:: with SMTP id i14mr5134085ybe.366.1636604119885;
 Wed, 10 Nov 2021 20:15:19 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:15:03 -0700
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
Message-Id: <20211111041510.402534-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20211111041510.402534-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 03/10] mm/vmscan.c: refactor shrink_node()
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, page-reclaim@google.com,
        holger@applied-asynchrony.com, iam@valdikss.org.ru,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors shrink_node(). This will make the upcoming
changes to mm/vmscan.c more readable.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 mm/vmscan.c | 186 +++++++++++++++++++++++++++-------------------------
 1 file changed, 98 insertions(+), 88 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74296c2d1fed..802b6c7ce5b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2562,6 +2562,103 @@ enum scan_balance {
 	SCAN_FILE,
 };
 
+static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
+{
+	unsigned long file;
+	struct lruvec *target_lruvec;
+
+	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+
+	/*
+	 * Determine the scan balance between anon and file LRUs.
+	 */
+	spin_lock_irq(&target_lruvec->lru_lock);
+	sc->anon_cost = target_lruvec->anon_cost;
+	sc->file_cost = target_lruvec->file_cost;
+	spin_unlock_irq(&target_lruvec->lru_lock);
+
+	/*
+	 * Target desirable inactive:active list ratios for the anon
+	 * and file LRU lists.
+	 */
+	if (!sc->force_deactivate) {
+		unsigned long refaults;
+
+		refaults = lruvec_page_state(target_lruvec,
+				WORKINGSET_ACTIVATE_ANON);
+		if (refaults != target_lruvec->refaults[0] ||
+			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+			sc->may_deactivate |= DEACTIVATE_ANON;
+		else
+			sc->may_deactivate &= ~DEACTIVATE_ANON;
+
+		/*
+		 * When refaults are being observed, it means a new
+		 * workingset is being established. Deactivate to get
+		 * rid of any stale active pages quickly.
+		 */
+		refaults = lruvec_page_state(target_lruvec,
+				WORKINGSET_ACTIVATE_FILE);
+		if (refaults != target_lruvec->refaults[1] ||
+		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
+			sc->may_deactivate |= DEACTIVATE_FILE;
+		else
+			sc->may_deactivate &= ~DEACTIVATE_FILE;
+	} else
+		sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
+
+	/*
+	 * If we have plenty of inactive file pages that aren't
+	 * thrashing, try to reclaim those first before touching
+	 * anonymous pages.
+	 */
+	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
+	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+		sc->cache_trim_mode = 1;
+	else
+		sc->cache_trim_mode = 0;
+
+	/*
+	 * Prevent the reclaimer from falling into the cache trap: as
+	 * cache pages start out inactive, every cache fault will tip
+	 * the scan balance towards the file LRU.  And as the file LRU
+	 * shrinks, so does the window for rotation from references.
+	 * This means we have a runaway feedback loop where a tiny
+	 * thrashing file LRU becomes infinitely more attractive than
+	 * anon pages.  Try to detect this based on file LRU size.
+	 */
+	if (!cgroup_reclaim(sc)) {
+		unsigned long total_high_wmark = 0;
+		unsigned long free, anon;
+		int z;
+
+		free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
+		file = node_page_state(pgdat, NR_ACTIVE_FILE) +
+			   node_page_state(pgdat, NR_INACTIVE_FILE);
+
+		for (z = 0; z < MAX_NR_ZONES; z++) {
+			struct zone *zone = &pgdat->node_zones[z];
+
+			if (!managed_zone(zone))
+				continue;
+
+			total_high_wmark += high_wmark_pages(zone);
+		}
+
+		/*
+		 * Consider anon: if that's low too, this isn't a
+		 * runaway file reclaim problem, but rather just
+		 * extreme pressure. Reclaim as per usual then.
+		 */
+		anon = node_page_state(pgdat, NR_INACTIVE_ANON);
+
+		sc->file_is_tiny =
+			file + free <= total_high_wmark &&
+			!(sc->may_deactivate & DEACTIVATE_ANON) &&
+			anon >> sc->priority;
+	}
+}
+
 /*
  * Determine how aggressively the anon and file LRU lists should be
  * scanned.  The relative value of each set of LRU lists is determined
@@ -3032,7 +3129,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	unsigned long nr_reclaimed, nr_scanned;
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
-	unsigned long file;
 
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
 
@@ -3048,93 +3144,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	nr_reclaimed = sc->nr_reclaimed;
 	nr_scanned = sc->nr_scanned;
 
-	/*
-	 * Determine the scan balance between anon and file LRUs.
-	 */
-	spin_lock_irq(&target_lruvec->lru_lock);
-	sc->anon_cost = target_lruvec->anon_cost;
-	sc->file_cost = target_lruvec->file_cost;
-	spin_unlock_irq(&target_lruvec->lru_lock);
-
-	/*
-	 * Target desirable inactive:active list ratios for the anon
-	 * and file LRU lists.
-	 */
-	if (!sc->force_deactivate) {
-		unsigned long refaults;
-
-		refaults = lruvec_page_state(target_lruvec,
-				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[0] ||
-			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
-			sc->may_deactivate |= DEACTIVATE_ANON;
-		else
-			sc->may_deactivate &= ~DEACTIVATE_ANON;
-
-		/*
-		 * When refaults are being observed, it means a new
-		 * workingset is being established. Deactivate to get
-		 * rid of any stale active pages quickly.
-		 */
-		refaults = lruvec_page_state(target_lruvec,
-				WORKINGSET_ACTIVATE_FILE);
-		if (refaults != target_lruvec->refaults[1] ||
-		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
-			sc->may_deactivate |= DEACTIVATE_FILE;
-		else
-			sc->may_deactivate &= ~DEACTIVATE_FILE;
-	} else
-		sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
-
-	/*
-	 * If we have plenty of inactive file pages that aren't
-	 * thrashing, try to reclaim those first before touching
-	 * anonymous pages.
-	 */
-	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
-		sc->cache_trim_mode = 1;
-	else
-		sc->cache_trim_mode = 0;
-
-	/*
-	 * Prevent the reclaimer from falling into the cache trap: as
-	 * cache pages start out inactive, every cache fault will tip
-	 * the scan balance towards the file LRU.  And as the file LRU
-	 * shrinks, so does the window for rotation from references.
-	 * This means we have a runaway feedback loop where a tiny
-	 * thrashing file LRU becomes infinitely more attractive than
-	 * anon pages.  Try to detect this based on file LRU size.
-	 */
-	if (!cgroup_reclaim(sc)) {
-		unsigned long total_high_wmark = 0;
-		unsigned long free, anon;
-		int z;
-
-		free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
-		file = node_page_state(pgdat, NR_ACTIVE_FILE) +
-			   node_page_state(pgdat, NR_INACTIVE_FILE);
-
-		for (z = 0; z < MAX_NR_ZONES; z++) {
-			struct zone *zone = &pgdat->node_zones[z];
-			if (!managed_zone(zone))
-				continue;
-
-			total_high_wmark += high_wmark_pages(zone);
-		}
-
-		/*
-		 * Consider anon: if that's low too, this isn't a
-		 * runaway file reclaim problem, but rather just
-		 * extreme pressure. Reclaim as per usual then.
-		 */
-		anon = node_page_state(pgdat, NR_INACTIVE_ANON);
-
-		sc->file_is_tiny =
-			file + free <= total_high_wmark &&
-			!(sc->may_deactivate & DEACTIVATE_ANON) &&
-			anon >> sc->priority;
-	}
+	prepare_scan_count(pgdat, sc);
 
 	shrink_node_memcgs(pgdat, sc);
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

