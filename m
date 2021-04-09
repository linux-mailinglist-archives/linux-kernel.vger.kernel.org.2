Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA6359EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhDIMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDIMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC07C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d10so3775630pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAcOkan8lqUM2sgPiLQlk+KtBYvhY5OYi0x3cfxvaGY=;
        b=EJu05/pXFFI0wunnnXGO4OVcoG1kZWWAlkIrwe4y8u6CsIh8GP6jHf4qP8a/SAfsCE
         MCOFGJmJRkxIOMW5RAIP6awRUz4FUja4lQsTS3y+PpmvYMU8SDQ1jHnQTHpQYkzh06K6
         OowEihYIqaxE0fNO56uQXrq8koqKc6X0/KQt20T40cGsa3z26PYZ9fjcBaKxi0BXM+4h
         F31McYclRiPzLkI+AaRmgY2dLhfXXVyAUYeUh3MF2dLwb8EW02M9Bh4p1f2bQAiGs+++
         oxrJ/N7zEtRkGzaSGQj7JgsHK50/omWVoIe8M1x+ai1jkFwqv6hxGETuevEsCGSXxUDK
         PnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAcOkan8lqUM2sgPiLQlk+KtBYvhY5OYi0x3cfxvaGY=;
        b=EHQ2qPOdzWR6kjtCXUnVvGFKmif5MDm6x41WFdGVZVOlug/Rb7aBB2zF+JMswG7C+O
         ziUtzDswmpZyPYeq5PUBsGLNdRr3MiqCh5hlwv6UxROvdT4L0u8AmlWB1T1GfDdn68Vk
         E13X8VCzedXqo+H2CoKNKoXnXM8el/jW4RmkM2O051FO/il9+CVphDsz9PngRVIVAITW
         FosuSgVVWPq1xwoMrBBB6kvr5BX6yyGbvU750Dkjlay6o7IOb4ufb4Yel5E6XC4kEIJ7
         JkkCxAGIJ+GzutFNkCrrkmgKfCWGa+TcYiuaMT7qfwvsiItaF+36O5dmbdfASqGrCRmu
         7KFA==
X-Gm-Message-State: AOAM530yId6ti6AMwj5qLdqfXoo141bm9EKY4ByJ2f0tSN3YCGIs2iGP
        neZEglStPaYAz9hGlD+1m4R6rA==
X-Google-Smtp-Source: ABdhPJz+3rRKPiWfZ0QQSYERRhJRGE24d2JY1YW13naz/zc5gIZdk18Mblc5QXUA9a6SuL7yAwXtqA==
X-Received: by 2002:a63:6d4e:: with SMTP id i75mr12711753pgc.97.1617971529426;
        Fri, 09 Apr 2021 05:32:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:09 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 03/18] mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
Date:   Fri,  9 Apr 2021 20:29:44 +0800
Message-Id: <20210409122959.82264-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers of mem_cgroup_page_lruvec() just pass page_pgdat(page)
as the 2nd parameter to it (except isolate_migratepages_block()). But
for isolate_migratepages_block(), the page_pgdat(page) is also equal
to the local variable of @pgdat. So mem_cgroup_page_lruvec() do not
need the pgdat parameter. Just remove it to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            |  9 +++------
 mm/swap.c                  |  2 +-
 mm/workingset.c            |  2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c960fd49c3e8..4f49865c9958 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -743,13 +743,12 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 /**
  * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
  * @page: the page
- * @pgdat: pgdat of the page
  *
  * This function relies on page->mem_cgroup being stable.
  */
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
-						struct pglist_data *pgdat)
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 {
+	pg_data_t *pgdat = page_pgdat(page);
 	struct mem_cgroup *memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
@@ -1223,9 +1222,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
-						    struct pglist_data *pgdat)
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 {
+	pg_data_t *pgdat = page_pgdat(page);
+
 	return &pgdat->__lruvec;
 }
 
diff --git a/mm/compaction.c b/mm/compaction.c
index caa4c36c1db3..e7da342003dd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1033,7 +1033,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = mem_cgroup_page_lruvec(page);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9cbfff59b171..1f807448233e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1177,9 +1177,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 struct lruvec *lock_page_lruvec(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1190,9 +1189,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1203,9 +1201,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
 	lruvec_memcg_debug(lruvec, page);
diff --git a/mm/swap.c b/mm/swap.c
index a75a8265302b..e0d5699213cc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -313,7 +313,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
-	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
+	lru_note_cost(mem_cgroup_page_lruvec(page),
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index b7cdeca5a76d..4f7a306ce75a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -408,7 +408,7 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	lruvec = mem_cgroup_page_lruvec(page);
 	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 out:
 	rcu_read_unlock();
-- 
2.11.0

