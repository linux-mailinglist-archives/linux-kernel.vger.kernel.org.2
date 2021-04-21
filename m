Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234CE3665FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhDUHCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbhDUHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0512C061342
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u15so12548618plf.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwWuYiWQGSbc8ycMu6DseDSOCB8T/8g49Sen6QaPJMk=;
        b=m2EZPGDxxaBT2seoPtdlskpRShBLXOsRTclW3ZU5paVEBHQb/Gx7RYe69DBH5Z7CFn
         6a6RM4gMZavG6XPfeqE8GV4ZRzpVSq78WRq+FkH/uFRhbnmpuTvm3YI8iaJo5BZdyt+D
         /PsRsFhf/cw3sZ5HC558yDI61EniO5tUMActASgND0z5vHJ5ZUe08a+mDYZ831AciJbi
         Ox86jT2ezW8iZZ6VOnXdQJfTiRMI8wZLjoblvZ6aa4F/hCYrJ+GSmv6aDQbWceVIpOxz
         s2cKYTj1KQ1K/PX9nbTtE0NbVLZ1EnKfzgdjhjPO0ERu1ibOKYkdpcpMjyF1ewe0RFml
         Shlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwWuYiWQGSbc8ycMu6DseDSOCB8T/8g49Sen6QaPJMk=;
        b=LcjQ33RpaeQn/5Y7QwKUxhg3x6X6C4+JithWqZEDgLLoBIRKGd3jWlh2lWlqhiyvAM
         csEYiAppvRqD83glzOXUxfap/hx4/BX02terXm1HSMdRTKuU2QrFo9GcJShlXuJmgYSE
         rjUO49AcwR2r8+fW+SBNWvG60y2afDneMfmIOj3SBy53xNFgPUgOi3W7b7q2CNYUJxV7
         AONSIEkPtGekQhhSbkFZ7BgqWuwVlZXs8Do9FnEWFzK5MB2oL0Ac9QiyFd2Pe4TaPleH
         Gs7bowSdpu2ZvBslgqz54e9pznW2XNw42+rRzMdVt469TwgiKgxyoJoxMvmtM3yqgHjl
         BIyg==
X-Gm-Message-State: AOAM530dBMHgsMFpBxbV4o2AO2XM+RJ0xA5iRCNXLsPHQtcA8tBkh8UL
        zLsQSZfXkVXSE3WM3O9dfuGEFQ==
X-Google-Smtp-Source: ABdhPJxegXTguuiACBJsla3VyxWjtQa2UzPwLhHrGXGiGwKuPa6HjTCl4K05aAx9E/CQ2SNSgxOsWg==
X-Received: by 2002:a17:902:4c:b029:ec:a39a:41ad with SMTP id 70-20020a170902004cb02900eca39a41admr15082872pla.52.1618988492393;
        Wed, 21 Apr 2021 00:01:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 03/12] mm: memcontrol: make lruvec lock safe when the LRU pages reparented
Date:   Wed, 21 Apr 2021 15:00:50 +0800
Message-Id: <20210421070059.69361-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diagram below shows how to make the page lruvec lock safe when the
LRU pages reparented.

lock_page_lruvec(page)
    retry:
        lruvec = mem_cgroup_page_lruvec(page);

        // The page is reparented at this time.
        spin_lock(&lruvec->lru_lock);

        if (unlikely(lruvec_memcg(lruvec) != page_memcg(page)))
            // Acquired the wrong lruvec lock and need to retry.
            // Because this page is on the parent memcg lruvec list.
            goto retry;

        // If we reach here, it means that page_memcg(page) is stable.

memcg_reparent_objcgs(memcg)
    // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
    spin_lock(&lruvec->lru_lock);
    spin_lock(&lruvec_parent->lru_lock);

    // Move all the pages from the lruvec list to the parent lruvec list.

    spin_unlock(&lruvec_parent->lru_lock);
    spin_unlock(&lruvec->lru_lock);

After we acquire the lruvec lock, we need to check whether the page is
reparented. If so, we need to reacquire the new lruvec lock. On the
routine of the LRU pages reparenting, we will also acquire the lruvec
lock (Will be implemented in the later patch). So page_memcg() cannot
be changed when we hold the lruvec lock.

Since lruvec_memcg(lruvec) is always equal to page_memcg(page) after
we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
remove it.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 16 +++------------
 mm/compaction.c            | 10 +++++++++-
 mm/memcontrol.c            | 50 +++++++++++++++++++++++++++-------------------
 mm/swap.c                  |  5 +++++
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53a19db9f8eb..cb0d99583f77 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -746,7 +746,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
  * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
  * @page: the page
  *
- * This function relies on page->mem_cgroup being stable.
+ * The lruvec can be changed to its parent lruvec when the page reparented.
+ * The caller need to recheck if it cares about this change (just like
+ * lock_page_lruvec() does).
  */
 static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 {
@@ -766,14 +768,6 @@ struct lruvec *lock_page_lruvec_irq(struct page *page);
 struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 						unsigned long *flags);
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
-#else
-static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
-{
-}
-#endif
-
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -1213,10 +1207,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return &pgdat->__lruvec;
 }
 
-static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
-{
-}
-
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
 	return NULL;
diff --git a/mm/compaction.c b/mm/compaction.c
index 082293587cc6..f88e2731d27c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -517,6 +517,8 @@ compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 
 	/* Track if the lock is contended in async mode */
@@ -529,7 +531,13 @@ compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
 
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 out:
-	lruvec_memcg_debug(lruvec, page);
+	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in lock_page_lruvec(). */
+	rcu_read_unlock();
 
 	return lruvec;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dae7ab2b1406..fd8e2c242726 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1160,23 +1160,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
-#ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
-{
-	struct mem_cgroup *memcg;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	memcg = page_memcg(page);
-
-	if (!memcg)
-		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
-	else
-		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != memcg, page);
-}
-#endif
-
 /**
  * lock_page_lruvec - lock and return lruvec for a given page.
  * @page: the page
@@ -1191,10 +1174,21 @@ struct lruvec *lock_page_lruvec(struct page *page)
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
 
-	lruvec_memcg_debug(lruvec, page);
+	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
+		spin_unlock(&lruvec->lru_lock);
+		goto retry;
+	}
+
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1203,10 +1197,18 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
-	lruvec_memcg_debug(lruvec, page);
+	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto retry;
+	}
+
+	/* See the comments in lock_page_lruvec(). */
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1215,10 +1217,18 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
-	lruvec_memcg_debug(lruvec, page);
+	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in lock_page_lruvec(). */
+	rcu_read_unlock();
 
 	return lruvec;
 }
diff --git a/mm/swap.c b/mm/swap.c
index e0d5699213cc..f3ce307d09fa 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -313,6 +313,11 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
+	/*
+	 * The rcu read lock is held by the caller, so we do not need to
+	 * care about the lruvec returned by mem_cgroup_page_lruvec() being
+	 * released.
+	 */
 	lru_note_cost(mem_cgroup_page_lruvec(page),
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
-- 
2.11.0

