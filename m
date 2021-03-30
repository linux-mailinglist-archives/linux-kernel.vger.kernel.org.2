Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F389734E551
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhC3KVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhC3KVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:21:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284CAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m7so11379587pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzxvMRbUYa1GwcLB1wkQ6og1cTIvOHumZQ5rSMOWVXI=;
        b=f7HdTGTmy0fm4hATTZMFmFD5ccXmrfkBsfyEPWwsNzDwvP9dOHC7wIt0VOuiGmkyL7
         ckh8rAjqdUQB3qRSLvRJ1heoVAZYQlQgODYXFQNolXRSv1E9rOL4Q++JpTfdg+hS1W7d
         q7wODDo/0n8AbE931c6XZGxJUtymxBoNEbcKtJcWhcxu6roEexQWF3+VLWT+9ZZ5b2/P
         3GJV4+K47FjTLiNBp+WAeQc2B4b9M7yRpyASFVbmRlQH74bhcuU1utwnQtj+cPnOnZj9
         IKcrc1489ws/5Fi429Q1oV4627gS0Kih1k+PblrGObqf+JExcItvOVseUVMlm55rLR6g
         IcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzxvMRbUYa1GwcLB1wkQ6og1cTIvOHumZQ5rSMOWVXI=;
        b=LCWVvlX1gFRurZASm32rU76i29aLLxLE+nJtmXV/zfF1ilxAU9Nl+bGfw6gsKvEJg1
         ZfaJNf3/5BKdKQPBkEAHULWScNXbZxVfRsSvDMqYkOPKIJvMCkMaZENl3xb1KbfaCXE4
         XdkwEjo0kU5eWUpV3F1wEPTcH4glgbmik+NzzVEBi/U6+nBixdEUsn9SNhnIZrqoywQH
         WGheV+8XzH6vIOJ2kgn661kScBhHNMRMKR+KcK6B/q98NUeSuGXFgkLZc2Sg9U1Dqqa4
         YYt4siMRt1q6dr/VM5Qysk2jdPmJolN3Su/l+tEK1amYC3Eq4LUsENJJYCo5wTdzxj+I
         tRFA==
X-Gm-Message-State: AOAM530c6SfQv3LpGjt1i//Ubg6B1eRRX1KsVEy54Al3ETxu6gKzsWZU
        9zWHGwYcoWCSET3acVn+7z9lJQ==
X-Google-Smtp-Source: ABdhPJzxrphcnc3CBE3GFoJWSIJlIgixHfhNQtJGsS8OadTn0HoshWWR4jjjF0odWFA7PnllC5nneQ==
X-Received: by 2002:a62:5e05:0:b029:20b:241e:4e18 with SMTP id s5-20020a625e050000b029020b241e4e18mr29529352pfb.1.1617099663738;
        Tue, 30 Mar 2021 03:21:03 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.20.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:21:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 03/15] mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
Date:   Tue, 30 Mar 2021 18:15:19 +0800
Message-Id: <20210330101531.82752-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
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
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            |  9 +++------
 mm/page-writeback.c        |  2 +-
 mm/swap.c                  |  2 +-
 mm/workingset.c            |  2 +-
 6 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7fdc92e1983e..a35a22994cf7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -732,13 +732,12 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
@@ -1232,9 +1231,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
index e04f4476e68e..8b8fc279766e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -994,7 +994,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = mem_cgroup_page_lruvec(page);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48e4c20bf115..405c9642aac0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1305,9 +1305,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 struct lruvec *lock_page_lruvec(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1318,9 +1317,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1331,9 +1329,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
 	lruvec_memcg_debug(lruvec, page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..f517e0669924 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2727,7 +2727,7 @@ int test_clear_page_writeback(struct page *page)
 	int ret;
 
 	memcg = lock_page_memcg(page);
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	lruvec = mem_cgroup_page_lruvec(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..af695acb7413 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -300,7 +300,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
-	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
+	lru_note_cost(mem_cgroup_page_lruvec(page),
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index cd39902c1062..1ab5784c9e25 100644
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

