Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABD362DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhDQEil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDQEik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so17461677pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUAxTMYGPKcXUKklEvyCvysOG+ZnpjCi0FGjCzotqSU=;
        b=rZV3Lx/DG+nk2yOJopVmLtWk63dUiCzC/kXZfxaop1AJ0FAZfmyf2w4SM/saLYzAK8
         4Rj59/gtH6GGeuQl+ONJaMCilputqDh0R8QOjVdpKnHnxcsOJ7jS5D8uVqHnJfT2XbxK
         JqzKeKWfqOSMFt6ZQPnPw3RD+SQ4cYiF7thutI51Ck8Vso9AaDvxszCXA8GROWHHn92j
         IagTTI3d6dZsxbDqusXTDbBIOS5eCGGudc+aw1mS2SYKwLc/T3wp8Ntto3X/StjH6ZE6
         JGw1vidb5iDt484PLTbmBeout5mXkw9GnEITsLtKRkltPYpq0MxEAK9U88jF/pwN7L2U
         a18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUAxTMYGPKcXUKklEvyCvysOG+ZnpjCi0FGjCzotqSU=;
        b=Tp1OONGM3p2d1bBAo+7/oAhGDrf9aGtVdKiDCN7WAKJl9Co9YM+A7FA3l4uN6ynEc3
         kf0lVLxpGmTVgpj6nlYlH09fVhV6JQLYpLtibz/Og8jWCSVkp/f6YjDD1OFOtj2b43p1
         kkZCvkFPwvTNckNtYtXN7fUo0ics1cEEehHWqoWhZ6scxbLCcva28yZBbmkDYVyaTf14
         K1w/lnKKs7TaaUpRgtaYHzW2gcpg/Rbv3P4Fd6/+faePuFbIIZuFUB9Xbnnw3wOk7tTH
         tRx4PbM2aJSB90IiAP0GYUQKQu4sLMzKuS4YdZwaUY+AOOidwfgTiSJAP6N//XPauOmG
         1OAw==
X-Gm-Message-State: AOAM532aXwRih36YXx/xi2g/km1vUPw0GmngnLiPw7kzSaG/g5aTZYDc
        yc5N7+V7lKisQmuH6Rs0RJO6aQ==
X-Google-Smtp-Source: ABdhPJx1urRpgkyMn0GN9kMp05vLR8ipUAEHnpuOQwNghNNxGjpdwtQ1A8eZT+trOPcx+kGUbKD7Zg==
X-Received: by 2002:a17:90a:6396:: with SMTP id f22mr13217394pjj.91.1618634294427;
        Fri, 16 Apr 2021 21:38:14 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 3/8] mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
Date:   Sat, 17 Apr 2021 12:35:33 +0800
Message-Id: <20210417043538.9793-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            |  9 +++------
 mm/swap.c                  |  2 +-
 mm/workingset.c            |  2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..f2a5aaba3577 100644
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
@@ -1221,9 +1220,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
index 8c5028bfbd56..1c500e697c88 100644
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
index 50e3cf1e263e..caf193088beb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1181,9 +1181,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 struct lruvec *lock_page_lruvec(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1194,9 +1193,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1207,9 +1205,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
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

