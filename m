Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFE359EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhDIMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhDIMcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E985C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so3103331pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nC8Od9f2oBG5t+4refuaB3HqlorOeDnX1iWgi2kZ4Xc=;
        b=mpjCCDvRK5U/OaBorPlCpF8QXpmEB5NFjfAq3eED5Z2RfV/YpRLFftkuBlLWS2PPxv
         bR2AYNdhZrStb9pBauk1NXaFv89N4u5AIJ+Bhoixw1HtTTM0sUMLCPVO4It+bSQ8YDx3
         mQwkb65lrewmLxhzfyUHt8hcprweMToH4esebGQOt/qF9o3+V56Lbksy4HTfXw7RzjW8
         xEXoP0urKi8cf/lqwhYRZloWBqEHagMW9MAu9fWuTFWk1tvzT0cMW7Rk8IforHQeR1Mm
         /Ujsi2uRGuNbpUxrFgfJCjBWHrov52yFLKiywT2imMiR48I7PisnIjB+yZ8kRcgvN8Ch
         WCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nC8Od9f2oBG5t+4refuaB3HqlorOeDnX1iWgi2kZ4Xc=;
        b=jW2F14jqEwm69UXCdyCuJWtCdGvElyectzzFz+ty8gMsNKx/ljkLXyp2k+xVDNfWCJ
         qXJ8OhZfB5+/y7Z/jLNPK1Vzim425JGWLI+jkP0z7Wh+BS5UbYlEA2QNM1SIPweua3y1
         BdDqsSVWCB1I2DV5c8+YY6o8WFHknSKTLKfLA1lZwvsmkljEH9fD8jdTopwTI26mhJZX
         wEqzUu4kzNpat0Tl49JqYSXpIgW9Ax6j5Zhf3xi8ikS9pZuJQU57vT1NnwDm2UOJuJb8
         3W7Ex4aD6bQsszbvNFJNXhXmYUw3+nh2HsxSqSO5EO8FS2/KC7JLVZ75m6YzBQVqNoJC
         QMcQ==
X-Gm-Message-State: AOAM5321OPjpz27M1UPDgBKlDG8pPzEQymAbu8NAg6MvcCQaf0wTupwd
        WHN8IT8F410oCrXUVY2RCzuAnw==
X-Google-Smtp-Source: ABdhPJwVWogSCbx2NTYnhbArHh7Sx6wabayU0VDccA3QV680VF9qp5CMf8h6oAzNrg/Xf/+fyjeEMw==
X-Received: by 2002:a17:90a:5103:: with SMTP id t3mr13833007pjh.68.1617971559635;
        Fri, 09 Apr 2021 05:32:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 08/18] mm: memcontrol: make lruvec lock safe when the LRU pages reparented
Date:   Fri,  9 Apr 2021 20:29:49 +0800
Message-Id: <20210409122959.82264-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
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
index ab948eb5f62e..93aa41600913 100644
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
@@ -1215,10 +1209,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
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
index c9efe3542b0a..5fd37e14404f 100644
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
index 27caf24bb0c1..3a2f5c43aed3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1186,23 +1186,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -1217,10 +1200,21 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1229,10 +1223,18 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
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
@@ -1241,10 +1243,18 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
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

