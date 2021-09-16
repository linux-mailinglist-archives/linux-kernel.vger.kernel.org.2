Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F285940DBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhIPNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbhIPNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC840C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f21so3903038plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjaeLDkNdZhTPTv/gmNAvH3aDq6cgB+MWQai9kSiTfY=;
        b=20ulyW5hYFscFP3he09U5EbDzlS3DZ57PB4D34MDxEnYh/v3nq61tuhu9r9+JzjwBo
         1QzZbxIgxk4v0xKqHFXLw6kKhcn+j68n5xb67OGAQ/DHDBZSY9dZdmIsgxRVRovFiIkO
         7LFgP0Ios8fPmDKXNGHp5l+8PPgXqtg8/wF62qYDUa1sTQVnZZKZgV0WrGzb2RM6RSd6
         0ofSp6KEdF4ie0GW0JwQlL0k2SB5baqSkL4o5vHnKAGNsfGGCekRDC/cG4xzI16LVPiy
         2b0kcsC9Cj5LNP7AqDrv7KVpYdtBFOms3xjajWUaxR2uqQy23V1/iHgIrc9uqsMzynL9
         Zshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjaeLDkNdZhTPTv/gmNAvH3aDq6cgB+MWQai9kSiTfY=;
        b=lsnJ2s71pH0VDUlF+K5NAnsDPxWoL2so8Ss17M503wd1lpdUPlQglLvebErE3+VAg5
         +iB/zss8SSfgcsoy936+ysDhkRPcT/qJcMfx+w1pYnqdMlCA8xquQKOkZ64AmD+H5nYp
         YARqew7vN6qrmurGoL3ZxnJHskrOkrzWQRhxidUheGA7AkFhZduhJNavILuyPs+XWeOj
         7O0a0aX2JppewOv7tTx7oyZMrVT3eYqfcBH5JvGem9QfED1Buq9kbxo8VkyUWdD6lbRL
         H0ZpTtpaX6hnKGyFC0EPTVpu0WtcjCvHdO13+8iNefQA2Q21u69Lm3s4nnYMpTXPSv3i
         7gTA==
X-Gm-Message-State: AOAM531gxy5eCapuGOD7ahJDGzq8FwkKkKQArfua0VHCxGx3DzoJEVg2
        MjNALts8k4jgGmmE2XHc+DydHg==
X-Google-Smtp-Source: ABdhPJybFFN5VDhv3mRTlB6DTZDsGPCl5X/CVrVIr+yT5LM/yviSYZF7nmYNrXJrLtBEb2Sn4DqYpA==
X-Received: by 2002:a17:902:9a04:b0:13a:1b2d:8a5c with SMTP id v4-20020a1709029a0400b0013a1b2d8a5cmr4945875plp.47.1631800352300;
        Thu, 16 Sep 2021 06:52:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 04/13] mm: memcontrol: make lruvec lock safe when the LRU pages reparented
Date:   Thu, 16 Sep 2021 21:47:39 +0800
Message-Id: <20210916134748.67712-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
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
index 490d4849a05a..6c2cb076c1a4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -756,7 +756,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
@@ -776,14 +778,6 @@ struct lruvec *lock_page_lruvec_irq(struct page *page);
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
@@ -1220,10 +1214,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
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
index bf1a6048b5a3..c4ba41de8591 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -515,6 +515,8 @@ static struct lruvec *compact_lock_page_irqsave(struct page *page,
 {
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+retry:
 	lruvec = mem_cgroup_page_lruvec(page);
 
 	/* Track if the lock is contended in async mode */
@@ -527,7 +529,13 @@ static struct lruvec *compact_lock_page_irqsave(struct page *page,
 
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
index f58010cd8414..a57cce0ea24b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1158,23 +1158,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
@@ -1189,10 +1172,21 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1201,10 +1195,18 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
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
@@ -1213,10 +1215,18 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
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
index 897200d27dd0..18d44f978b2e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -291,6 +291,11 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
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

