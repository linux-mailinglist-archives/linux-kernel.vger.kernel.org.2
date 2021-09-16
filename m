Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987640DBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbhIPNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbhIPNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE4FC061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c4so3891459pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os6W81L8Jp53y3z498y4ntoeCrrr5kt+lNChMkb1a3E=;
        b=cFoQbgMUuO71GUUl31WSwW9Dbd6Ng9hWx2q8bhXjtr2f6iVWCmSB4vMoHCnSRtKcgL
         w0T97hle6ch5Nk6/EEndFfacy14u+8F/bJCRXxT3WNWbZn4LjKOhnUBqV6YFkwwpYppD
         BwltsgwY0L6sqKNzKVT1mwVq7Ft69f1x1Pw5HxaopGobPq+AVEF4WzSOEF8cA9bYtD34
         KOmMg+k9cvV1uDnKDWLdvHTqVliBAOjPC5XeiNFTYO/tB8SZIsfwQldVc7iX5e1F1RuH
         LxJot3R06na+lEc/QyRd75fmonwEGERx+Jj1AIpHsbWDBDR126XpyfTziZSuAQwSxnXF
         3zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os6W81L8Jp53y3z498y4ntoeCrrr5kt+lNChMkb1a3E=;
        b=w7s+ueX2CFBiWBuCg5jotT8RJfW1oCPN8+ZnCwy1H8mchd6OZ7PiwPSetnQG1ynCIQ
         LqoRgnshgTnFCZtWRJsyeHN8yMF2U8XbSDdWPVZT3nCVBsTxUTHLijALliDP5CfP+ZSy
         3ENr+mNhJJ1NdmAjvFexslI+qpxWHUOZ9TiIIJ0Xq1BOD97gnJTSODMM4q3PtGhxZOzy
         N056jSOcEU7OLYZ7m5kY8F8u+mWTMFJ26hiEXVOEDntzENKZ8KZnjNkyYwaP2Q4cZJ3n
         PYdEYjjIivhGHFTVsY5UzyVXPFYRdNjgaDjH4PdgGKvWF8sXFuYLelZzZ8QXQgEZZJhG
         y20Q==
X-Gm-Message-State: AOAM5338ZK35tKizHd1BR6dekU4ZuDPEletau3eJos2l2vKojObjSmx9
        AVjfUTvPs5kM7GhUUGQM9JpQOQ==
X-Google-Smtp-Source: ABdhPJy9fa7IUXtp12uZvQnAxns54IHKulitYG16Aq9stdgfxKixbhCQfcEEbJ0+OtWXqL8ifok1yQ==
X-Received: by 2002:a17:90a:5513:: with SMTP id b19mr15279213pji.16.1631800346633;
        Thu, 16 Sep 2021 06:52:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 03/13] mm: memcontrol: introduce compact_lock_page_irqsave
Date:   Thu, 16 Sep 2021 21:47:38 +0800
Message-Id: <20210916134748.67712-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we reuse the objcg APIs to charge LRU pages, the page_memcg()
can be changed when the LRU pages reparented. In this case, we need
to acquire the new lruvec lock.

    lruvec = mem_cgroup_page_lruvec(page);

    // The page is reparented.

    compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);

    // Acquired the wrong lruvec lock and need to retry.

But compact_lock_irqsave() only take lruvec lock as the parameter,
we cannot aware this change. If it can take the page as parameter
to acquire the lruvec lock. When the page memcg is changed, we can
use the page_memcg() detect whether we need to reacquire the new
lruvec lock. So compact_lock_irqsave() is not suitable for us.
Similar to lock_page_lruvec_irqsave(), introduce
compact_lock_page_irqsave() to acquire the lruvec lock in
the compaction routine.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/compaction.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index bfc93da1c2c7..bf1a6048b5a3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -509,6 +509,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *compact_lock_page_irqsave(struct page *page,
+						unsigned long *flags,
+						struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	lruvec = mem_cgroup_page_lruvec(page);
+
+	/* Track if the lock is contended in async mode */
+	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
+			goto out;
+
+		cc->contended = true;
+	}
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+out:
+	lruvec_memcg_debug(lruvec, page);
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -1029,11 +1052,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_lock_page_irqsave(page, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page);
-
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
-- 
2.11.0

