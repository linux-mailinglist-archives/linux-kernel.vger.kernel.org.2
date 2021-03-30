Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD1034E558
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhC3KWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhC3KWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67945C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k8so2231351pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xlRDpcZM1nqKykm7nw5VxdMkKGKLsb46vHmKtuxpiM=;
        b=jEPdFratXAzCkzUOa84wp5/kJojfK6fZ0lW0cWzAguwkNwiO6PFV16bfcRUYxKnk5C
         r30JBBFLuqpQMgjBw7GzF+S5nVZ6vciZXxHlNfsXt5GeMQFPgMCKL+FQOsGpteBHcXIo
         EKYUQWVwq6qIjV/4J6XfHy/iRbQlEcYLekAM4g+PzU3TVjc3Owr78cYkMEos50wkr6id
         B1H66N4G+6VgwxJhy4EJt+i2+F0+iP//ZhNy/X//Bhx1dm8GgM9mxJBDxuIblDyfbH/J
         xGVPasfw2stMr9Yt52zkbk18wDq8JY59dNkC5mI5IaWo/bxegqRNxqIJSTOerMKHowww
         IRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xlRDpcZM1nqKykm7nw5VxdMkKGKLsb46vHmKtuxpiM=;
        b=iTlDTh8SRuG4+pqAYpMnCPjOvyKe9demxobXbD6huZA2kLdUnhBNxcyVJuv3QA91UZ
         0ps3Gvni22kC2wh1+FcDCOd73UNUveC8SBxdroPMCjS2g73HpU+hN5XXDTZqetXwUmn9
         j65iQsXsuNp8ZqWMa68My/vgiPVnjxlFqBVLih2Mmb3l6UvssVVJOcH/kbHh0Z5FuSLj
         spS5bDSrjvM2Nf7FRWrk5n21D+PoyKKKzn+Kl3VxDH/evdNCm3THUbbCiFYlArxLmXlx
         S7in5GXEG92g//TL5oI0RCn11TZ4a7W/GLm1KZblMisKSZv5CJYqUw+Rr6ObsQ32i+iG
         DHWQ==
X-Gm-Message-State: AOAM530bdZ30ttLEJl7eU+fX/26/mhGoIVR9KHLnKLAgJlssA/xAxFwn
        Whh9u8RFSLSeGHgrsGlrGk36pQ==
X-Google-Smtp-Source: ABdhPJyFtmrXkqseL07KUSdajLU6owbhX5LiS593/reozQof0dYU9pkStvryvC9yzP80dqK/s7/D4A==
X-Received: by 2002:a62:ee0c:0:b029:214:7a61:6523 with SMTP id e12-20020a62ee0c0000b02902147a616523mr28827776pfi.59.1617099728977;
        Tue, 30 Mar 2021 03:22:08 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.21.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:22:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 08/15] mm: memcontrol: make lruvec lock safe when the LRU pages reparented
Date:   Tue, 30 Mar 2021 18:15:24 +0800
Message-Id: <20210330101531.82752-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
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
 include/linux/memcontrol.h | 16 +++----------
 mm/compaction.c            | 13 ++++++++++-
 mm/memcontrol.c            | 56 +++++++++++++++++++++++++++++-----------------
 mm/swap.c                  |  5 +++++
 4 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 463fc7b78396..5d7c8a060843 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -735,7 +735,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
@@ -771,14 +773,6 @@ struct lruvec *lock_page_lruvec_irq(struct page *page);
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
@@ -1500,10 +1494,6 @@ static inline
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
-
-static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
-{
-}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/mm/compaction.c b/mm/compaction.c
index d6b7d5f90fce..b0ad635dd576 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -517,6 +517,8 @@ compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 
 	/* Track if the lock is contended in async mode */
@@ -529,7 +531,16 @@ compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
 
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 out:
-	lruvec_memcg_debug(lruvec, page);
+	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
+		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0107f23e7035..2592e2b072ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1314,23 +1314,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -1345,10 +1328,21 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1357,10 +1351,21 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
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
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
 
 	return lruvec;
 }
@@ -1369,10 +1374,21 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
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
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
 
 	return lruvec;
 }
diff --git a/mm/swap.c b/mm/swap.c
index af695acb7413..044c240d8873 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -300,6 +300,11 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
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

