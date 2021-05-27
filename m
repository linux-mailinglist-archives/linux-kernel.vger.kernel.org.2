Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611CD392ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhE0Jfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhE0Jfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:35:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 6so3266391pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0YhrymrmSUcJ+T+JtK0OJA6wg0f0ZwEXSDhmmxyIN4=;
        b=FyIy/JTLAy/uShk1TncAyQKrw8G/f5Ojqc5RG7p6MZ8FM2+BnLHKRWiHC3Se1mckDY
         kfP8joLFacRWyM9yy/djdd5EtN2bPH6kFUlNBs7iBN+rdkGxryYDobs0zs82yE1fz5ls
         s/olT1vG+Y8b8XGFPWejsZIYp92Wfc3XeVVAcxWsSqlfaNoZpv0d46b7YgQMErFYkggF
         DRuX1YtSotV0yzKhsZr4gStcfYJ0VwnEObHJe4cuRAWadjjWllRc2m11JmLWcq4l/0lQ
         MP5iQsLy2fClryCvNtJmY2/06BWnSl9+egyt9/I3z6hPYkLuCeVAbo/d0ZqBJ+9S4w5Y
         t/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0YhrymrmSUcJ+T+JtK0OJA6wg0f0ZwEXSDhmmxyIN4=;
        b=e4KLX04bvMWGTuuZauKmwfNasvr4i1QgNx4OYgcv5dQC91u2wXADZ2ER7ba/PJArmy
         Lt15RLTL0MJ66nGpy93Amg3RklGkVikudoXFrkr4X7RET96hXf8APda+OJqTsc+XGeWa
         7G/zqLUCCkCU8krxw/aLodhH8GyjGPbeJV1Y42S1DKuuqpgO2Lk5cP9MUEcU2nhKUHoe
         bfklS3CaUFwUBFgoilalCkpcTS5LQJSwBdgf5mglNGEhgE7eLju2i3fFrYUCSJPE5T5V
         xvuBEf4sbhu5fJeECyFyrPfoTCVlU0gk6iI2X7LQzf4Q6lmCwWqX5mkuPNKakLJ8C9/j
         qd1Q==
X-Gm-Message-State: AOAM533Xn5TvApRCFL5WBMXrzbfQLel44scWM+SAmd3G+jNjMwIb8+JM
        J531oTVEmH5sl4j8Jjy1zk5b2A==
X-Google-Smtp-Source: ABdhPJxWkKaforjSgY5McTXQGVxZMMc2zHnli+MFqpGqnaszhkiedFoYqoejpPl4F1STf6pgjEREow==
X-Received: by 2002:aa7:8159:0:b029:2c5:dfd8:3ac4 with SMTP id d25-20020aa781590000b02902c5dfd83ac4mr2508426pfn.16.1622108041980;
        Thu, 27 May 2021 02:34:01 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 02/12] mm: memcontrol: introduce compact_lock_page_irqsave
Date:   Thu, 27 May 2021 17:33:26 +0800
Message-Id: <20210527093336.14895-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
index 7d41b58fb17c..851fd8f62695 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -511,6 +511,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
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
@@ -1035,11 +1058,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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

