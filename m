Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E097D3EC0AD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhHNF0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhHNF0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22808C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n12so14020204plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zU8OR12zD7dJpqHRBp+KmCGx/6l3jVZJYNBuhwInJvA=;
        b=baofm8jITXQu42I3toPmvetkxBbjHFnxRkbFgRFdxBfZ6oyK/6TabEj09051EGgJ+p
         y3DofQEU4pEbZoJBdN7RwS5XQxIcpcYQwSNKtmMd8MLnjLyyMlYcg8T6NxYuKJaC4BbF
         7OKcQpnfMG/tAskpjzUnL2UE7x0W6N/I7ESnW9LPwYIhr8g2/7V+SgHl5/ceaV5apzbZ
         BvofoUfNk/CWq3phd6fH2oICqTFQfuhAR7tAIVWwZPgSZjtFhoM3Aa4yOiRIE2ouXsRB
         Zw/7nublncnkgsn2sx04/Ds8xO9ETm3Opwb1y4AytxU5R15ITqtEiGL2ksqN0rW6pbPY
         4YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zU8OR12zD7dJpqHRBp+KmCGx/6l3jVZJYNBuhwInJvA=;
        b=FoT7HH1IQbMX6VVyKKF+bxxFoyQA+EdUbNxnJ85295ayXrP30HAeJA5mbzXUM1MsHw
         pnZ1AZwUpOl5mOROaubKDika68NOnDsjcdHnysNQUVgtm67pmpUr0GgMHyLgbfNTG6hu
         0664r4GdyMVX8rEfZ49zLjx+Zpxr5yn27fpQVbt/IYlvgmUiR6JZ+IL1MGjSsd8yaEbE
         eTZ84ZmIJGQSYNTfx+qZQsR6cSYi2Uj33vXdk2RF6VUqwL/dHim9TeWhpwdHr85/FIs7
         MDX+DhGc5PIW5i3BfpHM7yMnj7TZL08e+k3/Ak/71U/aI6Q+ZQDjjG0gxSHsLjSdTMGB
         abnw==
X-Gm-Message-State: AOAM532fohNx/cT2pwiuboefbFgqqUvGjPi622fLFFewYgOY/kRQLS/d
        zOR8cE2MqSxzt2CN7XGUUvSTaA==
X-Google-Smtp-Source: ABdhPJwTVasNRe+PjjQb6P1qvUabEk3txnhwNtwU4r5NANrxJo4s9X/GkVWU/mR0lIcT++wLuJY3mQ==
X-Received: by 2002:a65:50c2:: with SMTP id s2mr5377409pgp.113.1628918762726;
        Fri, 13 Aug 2021 22:26:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 05/12] mm: thp: introduce folio_split_queue_lock{_irqsave}()
Date:   Sat, 14 Aug 2021 13:25:12 +0800
Message-Id: <20210814052519.86679-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should make thp deferred split queue lock safe when LRU pages
are reparented. Similar to folio_lruvec_lock{_irqsave, _irq}(), we
introduce folio_split_queue_lock{_irqsave}() to make the deferred
split queue lock easier to be reparented.

And in the next patch, we can use a similar approach (just like
lruvec lock does) to make thp deferred split queue lock safe when
the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 93 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 24 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ade81c123d87..c49ef28e48c1 100644
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
+static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+
+	return memcg ? &memcg->deferred_split_queue : NULL;
 }
 #else
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static inline struct mem_cgroup *split_queue_memcg(struct deferred_split *queue)
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	return NULL;
+}
 
-	return &pgdat->deferred_split_queue;
+static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio)
+{
+	return NULL;
 }
 #endif
 
+static struct deferred_split *folio_split_queue(struct folio *folio)
+{
+	struct deferred_split *queue = folio_memcg_split_queue(folio);
+
+	return queue ? : &NODE_DATA(folio_nid(folio))->deferred_split_queue;
+}
+
+static struct deferred_split *folio_split_queue_lock(struct folio *folio)
+{
+	struct deferred_split *queue;
+
+	queue = folio_split_queue(folio);
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *
+folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
+{
+	struct deferred_split *queue;
+
+	queue = folio_split_queue(folio);
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
@@ -2610,8 +2655,9 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
  */
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
-	struct page *head = compound_head(page);
-	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct folio *folio = page_folio(page);
+	struct page *head = &folio->page;
+	struct deferred_split *ds_queue;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2689,13 +2735,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = folio_split_queue_lock(folio);
 	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
@@ -2710,7 +2756,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		__split_huge_page(page, list, end);
 		ret = 0;
 	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 fail:
 		if (mapping)
 			xa_unlock(&mapping->i_pages);
@@ -2733,24 +2779,22 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 void free_transhuge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(page_folio(page), &flags);
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
+	struct mem_cgroup *memcg;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
@@ -2768,7 +2812,8 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(page_folio(page), &flags);
+	memcg = split_queue_memcg(ds_queue);
 	if (list_empty(page_deferred_list(page))) {
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
@@ -2779,7 +2824,7 @@ void deferred_split_huge_page(struct page *page)
 					 deferred_split_shrinker.id);
 #endif
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
-- 
2.11.0

