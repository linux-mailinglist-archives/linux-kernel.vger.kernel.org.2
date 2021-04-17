Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D4362DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhDQEiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhDQEiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4EC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso15678975pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EITONQXFUiMqxrQ5NUsYlzJaHXQ6TTbcz+uz38aCyj8=;
        b=whLRw2HCvXl3pHg6mNAV15FULhOHrpn62y8Z8WKJKFY20H6AULTb5aEwzcp8eDCYtw
         ov1aiOKypF9MkXKicm+fYwhabKgE5rafxXQlyV9ykdSYtSO9QncIl8RWuZvTwd+VEo5P
         1e6TQQiIb5rY1dJ1PYZO+hG8aEMtvl/AB2yOQk1Cx6qUDh6IlxGWze4ZnTI8QgNhj4GR
         ciF8lmElZj/GpCJl/KHuLRQl0Q6MaQTcUU8CEq9pFgu95wxqjljkBG+PSSPR3L4nBW7R
         foBQUryfXNvNEwh5/yhgtbz2Vl+2kmuLu/9YjSzZ/YNRfoVDpTbWib7DnSFO5t/suN/m
         65xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EITONQXFUiMqxrQ5NUsYlzJaHXQ6TTbcz+uz38aCyj8=;
        b=Ye5IN6JozJwMi7Wh8Bi2APv7QacFdDUXrksSqIaTlGRxXI3ec95Fu+h7Y7EC0/ZrFP
         fNrp7sRakpJMcmvZKAZVTpERkrXWxKMMDhvHW0oR8RIt66VCerUnUXM7Zeu1ac18axRS
         S24YBC16rsLucCxTnaK9FVez1/VHiuNCNXS/cGiHxS6UH0w2nnf4B+RKkPY9jzJ3Lkwo
         JdU8rOSNeYnHoXg/bbvOzjhnqbJ9+z4Glu4Q4GDbKsMUl0pcO9OLzIHi6zknngrrCGir
         xBsVXKkerUt3lxEsCdLne7UOGd48X2fWK4al9vC1xEXYl1HSXq2UUegSCMebI4xe0gHY
         +6vQ==
X-Gm-Message-State: AOAM530GQjUaA6YHRJuAcWAsbmX/Wfhdi5q3578rmd0I3xmBNYUDisTn
        efCGbfr4H9KFAWko7XGSKagF+g==
X-Google-Smtp-Source: ABdhPJx3/kW197VAi+ZCYN+jYpLWGU93A/ZF7SmxrsBMkISTuQDrOIqPceWxOybJqEEuIfDvhrq82A==
X-Received: by 2002:a17:90a:854b:: with SMTP id a11mr13378213pjw.17.1618634300159;
        Fri, 16 Apr 2021 21:38:20 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 4/8] mm: memcontrol: simplify lruvec_holds_page_lru_lock
Date:   Sat, 17 Apr 2021 12:35:34 +0800
Message-Id: <20210417043538.9793-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have a helper lruvec_memcg() to get the memcg from lruvec, we
do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
to simplify the code. We can have a single definition for this function
that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
CONFIG_MEMCG.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f2a5aaba3577..2fc728492c9b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -755,22 +755,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return mem_cgroup_lruvec(memcg, pgdat);
 }
 
-static inline bool lruvec_holds_page_lru_lock(struct page *page,
-					      struct lruvec *lruvec)
-{
-	pg_data_t *pgdat = page_pgdat(page);
-	const struct mem_cgroup *memcg;
-	struct mem_cgroup_per_node *mz;
-
-	if (mem_cgroup_disabled())
-		return lruvec == &pgdat->__lruvec;
-
-	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = page_memcg(page) ? : root_mem_cgroup;
-
-	return lruvec->pgdat == pgdat && mz->memcg == memcg;
-}
-
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
@@ -1227,14 +1211,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return &pgdat->__lruvec;
 }
 
-static inline bool lruvec_holds_page_lru_lock(struct page *page,
-					      struct lruvec *lruvec)
-{
-	pg_data_t *pgdat = page_pgdat(page);
-
-	return lruvec == &pgdat->__lruvec;
-}
-
 static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 {
 }
@@ -1516,6 +1492,13 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 }
 
+static inline bool lruvec_holds_page_lru_lock(struct page *page,
+					      struct lruvec *lruvec)
+{
+	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
+	       lruvec_memcg(lruvec) == page_memcg(page);
+}
+
 /* Don't lock again iff page's lruvec locked */
 static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		struct lruvec *locked_lruvec)
-- 
2.11.0

