Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D043BE6F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhGGLQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhGGLQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:16:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D76CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:13:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w15so1835629pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdzfnR4j5eQS/lxbgzCM8QfZTWzUyhCC6sdEedhtEac=;
        b=l5qvT9pK4sLGvXuFFcV6Xw0M5gy0owqlmoKq5yUKAd6+LmwxFt8cfQYuxsKzbXGTdf
         f836Fm5gfNv1ml0LuQ1yH3ewcDtCD2w2tqm1QNX1iUGsjXm7KC5dK/wHq0c1mX4AmXXM
         TldtoS2fNCFNgY+rVrVTB3Z74ZZUnKHAb2q2465brs3iENz8716C5cBrNYN7VJUQNirK
         aBJdEcaTydHg5fqSeVLCfQSLy1hEztU2idlcRwzTfieccA/qk/Lqr3ZGLJgfdsc9L7zQ
         d63pu8Ae5moDd04el4WrVyrMa8v70EdVKsLR26jLvOFSCJ2lRuGeO8iyMNkj2QxJinz7
         yIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdzfnR4j5eQS/lxbgzCM8QfZTWzUyhCC6sdEedhtEac=;
        b=ELyRGFzSw6YavDWliSJcvDgadoic4iztgLDih0T96YPpDSS3DnCDkO1b5u4YqpaXLq
         V9DHcXqKEVf5JKECZ3gM/cleNKMcUSrRnKsYvQY8bqpF6oXnuT7KkSKpoQQGcAXOZbiP
         6YK+JkgWhnzYFBELh4hazWKvHO21S2Jf+xq9sPBgQrtaO3qwQBxdTVsot4R7Ak5NXJ7I
         T7woAKahwXXGpzjVTaL4y1i5RjwfRCmS8j/wDXfQk4mPiGoxxloKz2uSqlEG+M/veo9l
         LmZEkrHdFXYfrZCO9HhW9YrRlsu8R4/Zok7D5sd4jr0myaNXFrytmTfG/U30iP8rccCX
         WSlA==
X-Gm-Message-State: AOAM533d5KlHWks1DF8q08IyM+M52dk9+5xQV4zmXkUgi7e263vDJzzb
        Bg5P8+DAWmEM/AsuJxnkJh13LUutsET/w97J094=
X-Google-Smtp-Source: ABdhPJxBfBQ8Wo2ahM2ctn4u10fcGSESS6ZBw/A8VV8R4TJQJBRDdFLtmUkeJFchBFHaUWGBBSd6Gg==
X-Received: by 2002:a63:4201:: with SMTP id p1mr25888381pga.386.1625656415995;
        Wed, 07 Jul 2021 04:13:35 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id k189sm18896577pgk.14.2021.07.07.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:13:35 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
Subject: [PATCH] mm/page_alloc: avoid deadlocks for &pagesets.lock
Date:   Wed,  7 Jul 2021 19:12:45 +0800
Message-Id: <20210707111245.625374-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports a number of potential deadlocks for &pagesets.lock. It
seems that this new lock is being used as both an inner and outer
lock, which makes it prone to creating circular dependencies.

For example, one such call trace goes as follows:
  __alloc_pages_bulk()
    local_lock_irqsave(&pagesets.lock, flags) <---- outer lock here
    prep_new_page():
      post_alloc_hook():
        set_page_owner():
          __set_page_owner():
            save_stack():
              stack_depot_save():
                alloc_pages():
                  alloc_page_interleave():
                    __alloc_pages():
                      get_page_from_freelist():
                        rm_queue():
                          rm_queue_pcplist():
                            local_lock_irqsave(&pagesets.lock, flags);
                            *** DEADLOCK ***

The common culprit for the lockdep splats seems to be the call to
local_lock_irqsave(&pagesets.lock, flags) inside
__alloc_pages_bulk(). &pagesets.lock becomes an outer lock if it's
held during the call to prep_new_page().

As the local lock is used to protect the PCP structure, we adjust the
locking in __alloc_pages_bulk so that only the necessary structures
are protected.

Fixes: dbbee9d5cd83 ("mm/page_alloc: convert per-cpu list protection to local_lock")
Reported-and-tested-by: syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 mm/page_alloc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0817d88383d5..0e005b1a60e3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5288,10 +5288,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
-
 	while (nr_populated < nr_pages) {
 
 		/* Skip existing pages */
@@ -5300,12 +5296,16 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
+		local_lock_irqsave(&pagesets.lock, flags);
+		pcp = this_cpu_ptr(zone->per_cpu_pageset);
+		pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
 								pcp, pcp_list);
+		local_unlock_irqrestore(&pagesets.lock, flags);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
 			if (!nr_populated)
-				goto failed_irq;
+				goto failed;
 			break;
 		}
 		nr_account++;
@@ -5318,16 +5318,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
-
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
 	return nr_populated;
 
-failed_irq:
-	local_unlock_irqrestore(&pagesets.lock, flags);
-
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
 	if (page) {
-- 
2.25.1

