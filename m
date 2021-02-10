Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC824316AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhBJQFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBJQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:05:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20626C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:04:59 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so1496503pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjnrEMtmAnoIwqw6c8TBD65sHh6j23Tk4gaVZSM437g=;
        b=n4U/qPzbSSCPTQ4CmXv6LZSc4TY/fDrYJDcE3Oi5T6Kgs2+8J1y4Lc2beG0iGi06Rk
         /9C689SzBecgZmRICTYOn4/MHlo68ZgTqilrkI5q/aRSh8G5tP6o2b+rjP6y1IID+b5q
         Q1MIO9iaNVvgL1fs+nInBrMHOKlbjS1kuwfzhIyM8t6oSVBT8LmzDohALY1W1w7b+v6u
         ubDMo5YyFKM3EbUhbb2qCimglXxSg/yjQ4F5VFD7h5dOyCjWHSxsX3bVGH+37sttbBQK
         p6i1byPY+4U438rKbVgmDW1ColSXsDnMg/vVZCvQofsi7GVLy+C4f4GKjpv8XiFKz6I2
         6YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JjnrEMtmAnoIwqw6c8TBD65sHh6j23Tk4gaVZSM437g=;
        b=lWlanWKUVOud6pctEZ2rBOt6t3ktevgKWURPGxfRPoNNSoLSHnqpCV7SlRR4M3z8lU
         LYyzyeIbkre8ZKp3p2mQvL1xi8I652OOytuZdyfCBZopaThvgWSL453xX4gpYrgMKQI4
         mhn/1d4fYs7rbaSx4MtFq18+SM+YPSHockEocN/a7HtjN/FHV+29k5Di0ao/fp5SfZPN
         G7fKhNAok5X6nZUoTZAboHZcv8LeyO0OdhnQxgtFO/FHvUlnjubfvIFI41pMvFX/P5fJ
         UF5yxTi1aElWZize95T7pYxq2JfVGS25IZ0x4qu7ipA+8K08jcZdnbz4kKGS2xjhdeqn
         dJWg==
X-Gm-Message-State: AOAM531o4nw4SZmJsY5vC8C2q5kf6A+W386XUItiErPIK+mgBg/aHUEB
        1Bc4t/zApit4DKxAE5l4P/0=
X-Google-Smtp-Source: ABdhPJzYyBsDIL+IHmLsoiZZEOKi+Mg+mjz5fDQSUqli6T4zljFiWUCtgaU07Vjx1S472MbDmt+Vow==
X-Received: by 2002:a63:1965:: with SMTP id 37mr3704325pgz.49.1612973098600;
        Wed, 10 Feb 2021 08:04:58 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id p17sm2866380pgn.38.2021.02.10.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:04:57 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        vbabka@suse.cz, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: remove lru_add_drain_all in alloc_contig_range
Date:   Wed, 10 Feb 2021 08:04:51 -0800
Message-Id: <20210210160451.3888849-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__alloc_contig_migrate_range already has lru_add_drain_all call
via migrate_prep. It's necessary to move LRU taget pages into
LRU list to be able to isolated. However, lru_add_drain_all call
after __alloc_contig_migrate_range is pointless since it has changed
source page freeing from putback_lru_pages to put_page[1].

This patch removes it.

[1] c6c919eb90e0, ("mm: use put_page() to free page instead of putback_lru_page()"

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* From v1 - https://lore.kernel.org/linux-mm/20210209175048.361638-1-minchan@kernel.org/
  * add [Acked|Reviewed]-by - vbabka, mhocko, osalvador
  * add history to the description - vbabka

 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6446778cbc6b..f8fbee73dd6d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8603,8 +8603,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 
-	lru_add_drain_all();
-
 	order = 0;
 	outer_start = start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
-- 
2.30.0.478.g8a0d178c01-goog

