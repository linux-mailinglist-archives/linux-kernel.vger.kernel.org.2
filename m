Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0E392ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhE0Jf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhE0Jfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:35:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q67so144678pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YqeXDxKtAsmHDOtoB7d0+CQecCU4829NyXtDE054SM=;
        b=l8e/i+09LNmyHVOjutGSQ4+M+cZHVJyIOcGXrIws3Vy9qlU1811xLwujYufivAh6FZ
         O8J4YBdNWHQ6R6TdSicgIDIYXAFHGsKCv7KhrK6jwV3eGFaH00UjwwWmSHEcETBcb7gL
         s+ye3cZ/24DchFrVYjEVjm9gkrKdbioos6+wQF1YIAK3YwZVUO1yN0fY5ei/WDXiDjp9
         XdAlx7JGljYMuENOT13NKUFRurGSC7pZgo1y1TzUtiUxQSS0Nf1xNdKi1nrQwjNrMRAb
         mZCcCf8yvXoDD+QnRb9lXDe/rQpY8c00Bo7NfkViLwXsydn9J1gMpeVutzPPY04ZbykE
         iajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YqeXDxKtAsmHDOtoB7d0+CQecCU4829NyXtDE054SM=;
        b=NzYNqTUfEQcmmHFeg+shAfzIG1+FHyfC8T+/nbF/wxyhw0GY3Bc2/91BGnQsoy4/r2
         72ncvX4Wa7M40lSf8Ejo9+wuqEbU9e2fa8zcCDc2eycBJ1N7R96kS2RnxOfWKEkoOQE9
         HnFV7fkjWfh4JDyhTyx37LY1LyYCSiYh+j3xZr/Ad0+rt9P14ZdZhz7E3PHkidQ6qTm5
         dZMsU9ZuvsA4hZvi2WeY0YfQKOhweK8GoOTdv4JEuxHxuNfCziMVXoWRLO2a8PZRQdpN
         G7aIyP+6OKigMkKR+gocun62rjzPjwhQJr8hjGZSfHYl1Jrfsd1e9/hLPjD5wDz7dyKg
         poEw==
X-Gm-Message-State: AOAM531+DHqWT0mW268BXDNmWdvOAYgRB17tKZey3BR50sScJypW1Uw1
        /UbmYIYv5A4TxIaSnj6AZx0USQ==
X-Google-Smtp-Source: ABdhPJzzEk61uARdN0wZ79mfYDOI9qUpXMwm8OKKSbRIUWRtq51T6t+7jRjMbjIun3F0dU3/tDf97w==
X-Received: by 2002:a62:8f45:0:b029:28e:a5f2:2f2a with SMTP id n66-20020a628f450000b029028ea5f22f2amr2894395pfd.44.1622108060353;
        Thu, 27 May 2021 02:34:20 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 05/12] mm: thp: introduce lock/unlock_split_queue{_irqsave}()
Date:   Thu, 27 May 2021 17:33:29 +0800
Message-Id: <20210527093336.14895-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should make thp deferred split queue lock safe when LRU pages
reparented. Similar to lock_page_lruvec{_irqsave, _irq}(), we
introduce lock/unlock_split_queue{_irqsave}() to make the deferred
split queue lock easier to be reparented.

And in the next patch, we can use a similar approach (just like
lruvec lock did) to make thp deferred split queue lock safe when
the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 96 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 22 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 233474770424..d8590408abbb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -496,25 +496,76 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_MEMCG
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static inline struct mem_cgroup *split_queue_to_memcg(struct deferred_split *queue)
 {
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	return container_of(queue, struct mem_cgroup, deferred_split_queue);
+}
+
+static struct deferred_split *lock_split_queue(struct page *page)
+{
+	struct deferred_split *queue;
+	struct mem_cgroup *memcg;
+
+	memcg = page_memcg(compound_head(page));
+	if (memcg)
+		queue = &memcg->deferred_split_queue;
+	else
+		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
 
+static struct deferred_split *lock_split_queue_irqsave(struct page *page,
+						       unsigned long *flags)
+{
+	struct deferred_split *queue;
+	struct mem_cgroup *memcg;
+
+	memcg = page_memcg(compound_head(page));
 	if (memcg)
-		return &memcg->deferred_split_queue;
+		queue = &memcg->deferred_split_queue;
 	else
-		return &pgdat->deferred_split_queue;
+		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	return queue;
 }
 #else
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static struct deferred_split *lock_split_queue(struct page *page)
+{
+	struct deferred_split *queue;
+
+	queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *lock_split_queue_irqsave(struct page *page,
+						       unsigned long *flags)
+
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	struct deferred_split *queue;
+
+	queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
-	return &pgdat->deferred_split_queue;
+	return queue;
 }
 #endif
 
+static inline void unlock_split_queue(struct deferred_split *queue)
+{
+	spin_unlock(&queue->split_queue_lock);
+}
+
+static inline void unlock_split_queue_irqrestore(struct deferred_split *queue,
+						 unsigned long flags)
+{
+	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
+}
+
 void prep_transhuge_page(struct page *page)
 {
 	/*
@@ -2610,7 +2661,7 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct deferred_split *ds_queue;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int mapcount, extra_pins, ret;
@@ -2689,14 +2740,14 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = lock_split_queue(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		unlock_split_queue(ds_queue);
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
@@ -2711,7 +2762,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		__split_huge_page(page, list, end);
 		ret = 0;
 	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
+		unlock_split_queue(ds_queue);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		local_irq_enable();
@@ -2733,24 +2784,21 @@ fail:		if (mapping)
 
 void free_transhuge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = lock_split_queue_irqsave(page, &flags);
 	if (!list_empty(page_deferred_list(page))) {
 		ds_queue->split_queue_len--;
 		list_del(page_deferred_list(page));
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	unlock_split_queue_irqrestore(ds_queue, flags);
 	free_compound_page(page);
 }
 
 void deferred_split_huge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
-#ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-#endif
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
@@ -2768,18 +2816,22 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = lock_split_queue_irqsave(page, &flags);
 	if (list_empty(page_deferred_list(page))) {
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
-		if (memcg)
+		if (page_memcg(page)) {
+			struct mem_cgroup *memcg;
+
+			memcg = split_queue_to_memcg(ds_queue);
 			set_shrinker_bit(memcg, page_to_nid(page),
 					 deferred_split_shrinker.id);
+		}
 #endif
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	unlock_split_queue_irqrestore(ds_queue, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
-- 
2.11.0

