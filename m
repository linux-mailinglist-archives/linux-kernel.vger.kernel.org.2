Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635735D868
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbhDMG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbhDMG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6D6C06134B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t22so7362943ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAcOkan8lqUM2sgPiLQlk+KtBYvhY5OYi0x3cfxvaGY=;
        b=QmCAL8WIuAgxioYK7NpUw9/sBETFVByeXQpm7kyI5VHPi5pwDJPyB8a+nhHMBuo6WT
         B+Zr+Zr3SCxIW2h+75mwlbjxZVIDIzMlVnTEAvs798nOBscKTjgwoIrSD2+LpFhwldww
         S9mc6K9Y1Rzz+KyDIY7T922eCKzZ1uoEUP//NTMU826MloN/mFKF+88bt7fxOXfGfc2p
         8A2e0mbUk2Ik9o1g23KEx6WvkwDT4VY8gSEd/HVFCu3m8G+BQHwO7rU4PgMutTmjtgiT
         100g6KxtRS1K00QLshgBcqSOhziRtm5DgDRqrmRBmb4ulAxG6Ik1fj9RU22VH9vChyok
         r8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAcOkan8lqUM2sgPiLQlk+KtBYvhY5OYi0x3cfxvaGY=;
        b=OoeAnkOg+fsfWN4xm72CrR68uKvhb9IHj68vpaRRny27zWrsqthprz6wCHnkBUJfUy
         /GEHq/NDyaDGrVqEPeEynLQQm2jpHmI6B75FnZMO+cNsjhcBQT8SGFzcQ0FqwJqK+gXv
         rx1nWb+HlAvj1nFh5md59YlWuA+ZSIk5MvCcQFpnucbtemFrpLBOEzc92CBUQbHIqtfT
         pl8voA/zxpSdL17CqTBVt+fesNnwF/ovMHrsAZz/mhoU1Dqw4RpBxvTbCkH+uKhGwIz2
         zLqvm1df5w/6Syn3/xnLus7X3Kun1D8A7DeRQzfngS7s+r/TaNoscSvJ96i0EREpcCFR
         7FSQ==
X-Gm-Message-State: AOAM531dO07GQ2OUDYCJ+rnZqGLdKns1c+3JfT3B6rR7xaAR+nKmpTic
        fmN8dsEWBYBJTpiCkk8cHg0r+A==
X-Google-Smtp-Source: ABdhPJzbzm3YhQoETTG24cA0s9yNRIvT+Rgje7TGdt12NOiazAUxV6xgQTVMdZpD04xJ0GBu2moFPw==
X-Received: by 2002:a17:902:d4ce:b029:eb:247a:805a with SMTP id o14-20020a170902d4ceb02900eb247a805amr3247729plg.19.1618297069021;
        Mon, 12 Apr 2021 23:57:49 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:57:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/7] mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
Date:   Tue, 13 Apr 2021 14:51:49 +0800
Message-Id: <20210413065153.63431-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
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

