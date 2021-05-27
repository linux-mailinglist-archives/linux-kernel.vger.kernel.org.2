Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEACD392ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhE0Jfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbhE0Jfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:35:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F574C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y202so135603pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3W85RK2l11iT8uuad/jlRS+jlbeAafTCAjCzBkyWb0=;
        b=JLDaY54il6lBZINHfH9PVlTa7r/VJEfHruZ7k7Q7yimpf655DXK2p8iRpph1TatlIu
         tABuMlehMjV4g7TyyQtDQ2Lf1HtAL0qMgnWuwjFyug7IncR8B8C8ERH2bjWyPnPuQ4+x
         km9nanVB0cifdq8RTilknPMiZ1ZE8Yso3W37pSntWayP7paAOI/KZLo/n83RfR8xqid9
         YVeaYNDyZM2jgRraFyhpEYyAx0XUbjm5h4lq6QTrBG98YeViEV853oV2IPAYJeAf4Y/l
         KXuhK3j4AJ7OsQImgFIoi7Xmr3nxLrfxnXYPgTSr/9ZtZEvMJuyAJhLUVFofR5xqUKFF
         yo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3W85RK2l11iT8uuad/jlRS+jlbeAafTCAjCzBkyWb0=;
        b=o/q7bc1B6HDngN+qgIfj5BrDRzYeqmlAqRUKxHF37rXiqUc0LX9XtzGd9KIYi9p93Z
         zt/h3pY1KgzSqwCbJP+o2xECDWNfunobZDvi/YDLYX4pPwdPv8a2CukvB6+qf6pEyQUQ
         2rGuMEXEWZnfbdDB84juS8b1FHgg8/D3BlmiLE1HfcygY4kE1e76TVEX1tyPlSJOWGH9
         uKidE2Kd/BRiau/Pk9PTe9y5GcWn4md5/l68jsuFRRB50HA4l4C3tJ8syoOPG2cskomT
         +3CqB0Du8gdhkS+n5mjUza2AdDme++PmlaAQ0jZgViqK+vn/XFLPhdAtGENMOCWGrfPx
         LuUw==
X-Gm-Message-State: AOAM533mBsIOOtnO93/OfDGartM+mI0Uy5lEhWhrB7aAwPe4KIAuGPv1
        68L8nRiYmhAEEZADoqnVxgO02A==
X-Google-Smtp-Source: ABdhPJzm+SfIBd6gbFIvCAnq9Jm8wfk5Wn/retcrwBVz3h721VZXhps2CyP82o8feu2FFuPCGmx5sg==
X-Received: by 2002:a05:6a00:139a:b029:2e3:db98:9ae3 with SMTP id t26-20020a056a00139ab02902e3db989ae3mr2915042pfg.81.1622108047957;
        Thu, 27 May 2021 02:34:07 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:07 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 03/12] mm: memcontrol: make lruvec lock safe when the LRU pages reparented
Date:   Thu, 27 May 2021 17:33:27 +0800
Message-Id: <20210527093336.14895-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
Acked-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 16 +++------------
 mm/compaction.c            | 10 +++++++++-
 mm/memcontrol.c            | 50 +++++++++++++++++++++++++++-------------------
 mm/swap.c                  |  5 +++++
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0159e1191a86..961ca3126d7f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -745,7 +745,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
@@ -765,14 +767,6 @@ struct lruvec *lock_page_lruvec_irq(struct page *page);
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
@@ -1212,10 +1206,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
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
index 851fd8f62695..225e06c63ec1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -517,6 +517,8 @@ static struct lruvec *compact_lock_page_irqsave(struct page *page,
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 
 	/* Track if the lock is contended in async mode */
@@ -529,7 +531,13 @@ static struct lruvec *compact_lock_page_irqsave(struct page *page,
 
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
index 66f6ad1cc8e4..06c6bcaa265a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1178,23 +1178,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -1209,10 +1192,21 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1221,10 +1215,18 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
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
@@ -1233,10 +1235,18 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
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
index 1958d5feb148..6260e0e11268 100644
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

