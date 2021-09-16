Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986BC40DBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhIPNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbhIPNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8EC061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x7so5916656pfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Czw+lJoI8c+vqpLarmySj3yLnTuDl0dY5o95pqOIb5c=;
        b=ZgWK155sZkXvFxsdPVc9idbYRDUwcU0WSFJ7BHU4VE5Qi6Ormq9uEOWap7v+NHFnyz
         DiMm0dZqdTbYfmWz6m0Ux0MsIiyl7kOvaheG+HLrfxHKYEkDRIn7S5Zj4eGGfFke4zug
         O4l4wY1TpAcuGNCjqXEQnhjHVrgdAEw5PRK1zXJifY0hSOphTKYuX85mhkp3yTT0BVHq
         AFD5Bgb2XpK4E7T3X/zsUkFze5d5kmqo3/6dP3K3GSrlYElplKsBMF+ClyZrOdKTGQKa
         3dzi/NtNJE0pucQigJVwo6dEZhqZDrkW/fwoOnBnaYMQNdw3OUy7mXkJP5npnJtoxlcf
         PfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Czw+lJoI8c+vqpLarmySj3yLnTuDl0dY5o95pqOIb5c=;
        b=wbJ4MFe+YV80I0W/z+MhevkrMRer4rSQRyIO6G1NAv4z4ooMEXveKfwVq8bYI+tE+z
         2eMwrAKSVU8j1asiBMhVq/lez0W2f/9hAZX+CYXWDyzvhhNKk2himQD5S/6wH0OAEFXD
         9EWTx3dWV/3pmhK084kTmr00wE0k7OuvEIe6GUmbZ13juUJnV7doI25xsReAQsxdF3Cv
         d26R2STOmTPpiVHGPwZ8pAW8HihrEMSgLGIrx0X6A4BMGhBb0oAUFI37vZDRKrAHTikK
         ZbhZMJOj0oLRKfYAqnpZ86AJYXMaLPuw69LzH3UW5BphOxYUFRstW3INlKvyFUT5Q/3H
         kqWg==
X-Gm-Message-State: AOAM532QRLn1yefLpInqD/fpTNydrBPrrw2GFPTIuDf8yg8NiihfTodb
        G2BrMJ5+lb6ruO2cq1yJUQ7STw==
X-Google-Smtp-Source: ABdhPJxjMl5ioCWxKY3IDwBaGXdistBIZIAxOdUzGGox92RGW/Jf0bHF4//MwnZaB7sanWqnuQQ77Q==
X-Received: by 2002:a63:f050:: with SMTP id s16mr5058345pgj.258.1631800364394;
        Thu, 16 Sep 2021 06:52:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 06/13] mm: thp: introduce split_queue_lock/unlock{_irqsave}()
Date:   Thu, 16 Sep 2021 21:47:41 +0800
Message-Id: <20210916134748.67712-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should make thp deferred split queue lock safe when LRU pages
reparented. Similar to lock_page_lruvec{_irqsave, _irq}(), we
introduce split_queue_lock/unlock{_irqsave}() to make the deferred
split queue lock easier to be reparented.

And in the next patch, we can use a similar approach (just like
lruvec lock did) to make thp deferred split queue lock safe when
the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 90 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..9d8dfa82991a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -499,25 +499,70 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_MEMCG
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static inline struct mem_cgroup *split_queue_memcg(struct deferred_split *queue)
 {
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	if (mem_cgroup_disabled())
+		return NULL;
+	return container_of(queue, struct mem_cgroup, deferred_split_queue);
+}
 
-	if (memcg)
-		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
+static inline struct deferred_split *page_memcg_split_queue(struct page *head)
+{
+	struct mem_cgroup *memcg = page_memcg(head);
+
+	return memcg ? &memcg->deferred_split_queue : NULL;
 }
 #else
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
++static inline struct mem_cgroup *split_queue_memcg(struct deferred_split *queue)
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	return NULL;
+}
 
-	return &pgdat->deferred_split_queue;
+static inline struct deferred_split *page_memcg_split_queue(struct page *head)
+{
+	return NULL;
 }
 #endif
 
+static struct deferred_split *page_split_queue(struct page *head)
+{
+	struct deferred_split *queue = page_memcg_split_queue(head);
+
+	return queue ? : &NODE_DATA(page_to_nid(head))->deferred_split_queue;
+}
+
+static struct deferred_split *split_queue_lock(struct page *head)
+{
+	struct deferred_split *queue;
+
+	queue = page_split_queue(head);
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *
+split_queue_lock_irqsave(struct page *head, unsigned long *flags)
+{
+	struct deferred_split *queue;
+
+	queue = page_split_queue(head);
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	return queue;
+}
+
+static inline void split_queue_unlock(struct deferred_split *queue)
+{
+	spin_unlock(&queue->split_queue_lock);
+}
+
+static inline void split_queue_unlock_irqrestore(struct deferred_split *queue,
+						 unsigned long flags)
+{
+	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
+}
+
 void prep_transhuge_page(struct page *page)
 {
 	/*
@@ -2610,7 +2655,7 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct deferred_split *ds_queue;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2690,13 +2735,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = split_queue_lock(head);
 	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
@@ -2711,7 +2756,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		__split_huge_page(page, list, end);
 		ret = 0;
 	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 fail:
 		if (mapping)
 			xa_unlock(&mapping->i_pages);
@@ -2734,24 +2779,22 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 void free_transhuge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = split_queue_lock_irqsave(page, &flags);
 	if (!list_empty(page_deferred_list(page))) {
 		ds_queue->split_queue_len--;
 		list_del(page_deferred_list(page));
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 	free_compound_page(page);
 }
 
 void deferred_split_huge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
-#ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-#endif
+	struct deferred_split *ds_queue;
+	struct mem_cgroup __maybe_unused *memcg;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
@@ -2769,7 +2812,8 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = split_queue_lock_irqsave(page, &flags);
+	memcg = split_queue_memcg(ds_queue);
 	if (list_empty(page_deferred_list(page))) {
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
@@ -2780,7 +2824,7 @@ void deferred_split_huge_page(struct page *page)
 					 deferred_split_shrinker.id);
 #endif
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
-- 
2.11.0

