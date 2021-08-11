Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD93E97AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhHKSaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:30:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C11C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:29:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e19so3777565pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5u5xWf8fH3lSDD8C8CeQ89dIv41ElE5n6uIfcU9ZCf0=;
        b=SPHtAE3CUi+rHIK5iZyiYptiSl8gQKF9kMsJgVM24KkKJCa1JQizODARByJfyUMKjI
         m/fCdSV9wzSR0AxmIEhpuMNsDoTbA72TEsStL5DEn9xantDelFldkGcEaJrdGn9NqrWn
         wlqPZh9/BT2mBRlISvu7t9Nv6RQeN82cJnmr0VGlRbnzczZRN5XlaKyTznWRUqKZFPlT
         InPUM1ejaR748oXOLc0Q12dp4XSvhnBMln4o69ugeNZ/6uZwHKhJzOCt+x0J6VVgRIO3
         6yt4e51bwgsjuv8y8XMKLO5OtHOZxZkve+abSgmKAWDVsdzdgpo++40P/ldzur6EOXLu
         HQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5u5xWf8fH3lSDD8C8CeQ89dIv41ElE5n6uIfcU9ZCf0=;
        b=KUSHH14k1qELVEIrJ95zxnlqQB3xCT56W6+J0S9DZc7BcGJLEt29qfOaHg+sRqRI9t
         n5azgDeEo9mLfRDArs/BWw4XOyOpnN12x6oxVI331WIaz+duRgwTnEabRC4sZk1NCiAy
         OdhmwPLWiZfv6ciXrQu6TUxkYsr37FkNZ/jeaqfHdRjvvXBOHLJIOxySn7kVAQa1JVWt
         YgPKYbCcVcCGak5JRSMm+fUY4HK++Y7HGbQQsH2sqMwUD9Hyi6JjsWTkA3NHWan1xjbv
         Vytr5l2i1gLOueENmaU9+h34nyJxP3RT+vHJ8kL/iwftrFSZTbSG9B23pzwj2kQIx6Zj
         pBSA==
X-Gm-Message-State: AOAM5305cFdHLpK+tsEMIxn2c1l0y7/FdcdN2V6Ji6DjU4ejKniLenTO
        5kAt8ZYdDEheMkxxVePK2tRropt4+NY=
X-Google-Smtp-Source: ABdhPJxxIHRrDtXqLi/qTsWb+Zgdqd50Jz8EuJWohWLL0TeLkI52sgnhvnQkkcgJvqwc6oJz04yK2Q==
X-Received: by 2002:a17:903:3091:b029:12d:6927:9ff4 with SMTP id u17-20020a1709033091b029012d69279ff4mr218791plc.1.1628706580923;
        Wed, 11 Aug 2021 11:29:40 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j128sm241653pfd.38.2021.08.11.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:29:40 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH] mm/page_alloc: don't corrupt pcppage_migratetype
Date:   Wed, 11 Aug 2021 11:29:17 -0700
Message-Id: <20210811182917.2607994-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When placing pages on a pcp list, migratetype values over
MIGRATE_PCPTYPES get added to the MIGRATE_MOVABLE pcp list.

However, the actual migratetype is preserved in the page and
should not be changed to MIGRATE_MOVABLE or the page may end
up on the wrong free_list.

Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 73704e836649..8addb4919f75 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3436,19 +3436,10 @@ void free_unref_page_list(struct list_head *list)
 		 * comment in free_unref_page.
 		 */
 		migratetype = get_pcppage_migratetype(page);
-		if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
-			if (unlikely(is_migrate_isolate(migratetype))) {
-				list_del(&page->lru);
-				free_one_page(page_zone(page), page, pfn, 0,
-							migratetype, FPI_NONE);
-				continue;
-			}
-
-			/*
-			 * Non-isolated types over MIGRATE_PCPTYPES get added
-			 * to the MIGRATE_MOVABLE pcp list.
-			 */
-			set_pcppage_migratetype(page, MIGRATE_MOVABLE);
+		if (unlikely(is_migrate_isolate(migratetype))) {
+			list_del(&page->lru);
+			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
+			continue;
 		}
 
 		set_page_private(page, pfn);
@@ -3458,7 +3449,15 @@ void free_unref_page_list(struct list_head *list)
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_private(page);
 		set_page_private(page, 0);
+
+		/*
+		 * Non-isolated types over MIGRATE_PCPTYPES get added
+		 * to the MIGRATE_MOVABLE pcp list.
+		 */
 		migratetype = get_pcppage_migratetype(page);
+		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
+			migratetype = MIGRATE_MOVABLE;
+
 		trace_mm_page_free_batched(page);
 		free_unref_page_commit(page, pfn, migratetype, 0);
 
-- 
2.25.1

