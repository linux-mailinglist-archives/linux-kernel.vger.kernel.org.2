Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADCB31DD79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhBQQgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhBQQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:36:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F22C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:36:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o38so8798075pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXIcl6OjwHYOdUvY1AbzlPKs0gf3kbJZZdxqTT5jVpM=;
        b=G8IMiTzquvhqASKS3eBBR2Tqy32NX8vLtGtNGB7t8MEsE32dUThk9wltx7hM3S0gue
         Vs0SKBMmVSJxLwHdWLW2pddn7LV8NsV+kknrwuL65T2TTGOXlEoXM4wN2U/xQEdyGilT
         YkqbBI/WDTPy5JrhI8u9Q5eVzSuKygRGE9dxEcG4iO8o7l9xwnjkwiZi0gybWwrHODrO
         OHoT1yA3JyDAkdZFvTmUPnEBv2nt8lj7GZ7i8ZzhbIjn1V3wDt28gNTT1R9S0tgDsdlI
         lfGY3awFwpT25EDAE/VaLIJwJh4f7HCHqJgi7OG2ULnTcPbqRx6W5Z5/SbBgJYL6ZvZO
         iucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WXIcl6OjwHYOdUvY1AbzlPKs0gf3kbJZZdxqTT5jVpM=;
        b=DUZhG/JssHa/2BnyHf5SLf33kujnHb4CCc8+OP/GsT4bsgagatMY3WGl+HI36Z3gwA
         VHfxZ9WRHfsxGkgdBn9oy21jSG/TeyVPR4Im2dKgHTK7hBOk1LHsZ3zFZamBitUrQyG8
         BVnLyGYpa9Z4a3dUwQYbYNuRqUZ29T60AkT6NDZ8kr1eYL6bTIHQrFpjQvwj+qGMTG7U
         XVMM8dI+82Chnz9dGZEFmQWP2Cf+hll6U3Q1uYfRfg/s4B1nP5GDruy6ZVj0WXsElof6
         aAGwFHChAF3pY/cdnBR/67Be5EhcA5jDW1xagYLywmIFM7CRhABzEygg3sarROi+ceYq
         Wskw==
X-Gm-Message-State: AOAM532SsVllsHIIzC7f4+XtTN+R8B3zsc2ZCym2+l+IteYMARDtkIGf
        uT1RIewtWQ9iqT9m2lB2zd8=
X-Google-Smtp-Source: ABdhPJwdeylB2BJC0jCIrsR5u5T4D3uPaBfWaqrtrdYp26DWyQLPvSA0yegpTKMuiqeY7AIC/ctHYA==
X-Received: by 2002:a63:1343:: with SMTP id 3mr209669pgt.166.1613579768128;
        Wed, 17 Feb 2021 08:36:08 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:cdf7:1c5d:c444:e341])
        by smtp.gmail.com with ESMTPSA id a136sm2939364pfa.66.2021.02.17.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:36:07 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        mhocko@suse.com, david@redhat.com, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: be more verbose for alloc_contig_range faliures
Date:   Wed, 17 Feb 2021 08:36:03 -0800
Message-Id: <20210217163603.429062-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range is usually used on cma area or movable zone.
It's critical if the page migration fails on those areas so
dump more debugging message like memory_hotplug unless user
specifiy __GFP_NOWARN.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/page_alloc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b55c9c95364..67f3ee3a1528 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8486,6 +8486,15 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
+		if (!(cc->gfp_mask & __GFP_NOWARN)) {
+			struct page *page;
+
+			list_for_each_entry(page, &cc->migratepages, lru) {
+				pr_warn("migrating pfn %lx failed ret:%d ",
+						page_to_pfn(page), ret);
+				dump_page(page, "migration failure");
+			}
+		}
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
@@ -8728,6 +8737,8 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
 			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
+				unsigned long gfp_flags;
+
 				/*
 				 * We release the zone lock here because
 				 * alloc_contig_range() will also lock the zone
@@ -8736,8 +8747,11 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 				 * and cause alloc_contig_range() to fail...
 				 */
 				spin_unlock_irqrestore(&zone->lock, flags);
+
+				if (zone_idx(zone) != ZONE_MOVABLE)
+					gfp_flags = gfp_mask | __GFP_NOWARN;
 				ret = __alloc_contig_pages(pfn, nr_pages,
-							gfp_mask);
+							gfp_flags);
 				if (!ret)
 					return pfn_to_page(pfn);
 				spin_lock_irqsave(&zone->lock, flags);
-- 
2.30.0.478.g8a0d178c01-goog

