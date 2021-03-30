Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60E34E55A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhC3KWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhC3KWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o2so5916686plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trRXhcI2buKhbiPF1Cmv0EYAvkXYBR9MP7Cwm4odxNo=;
        b=rMUVCwGAerlhCaFyhFnoT84igkNv89tF5s/Xe0nynB9QECidYiZf2ShkllrUupF606
         Mrmyso9d8z9AXiRcUPM/d6NRAMGOrjsZmhs8xnN9oOgoPwfDFT0kJy+DnN8sg7sJrRcY
         bCaiZR/6tgjJE548y00tTiC/3BT0f6Imlvt5jLtOtwtnX+J7Dfr8HN66C4G3kif+Q6PN
         xF3/5DioZzFrjqJGHNWfqGsUt4VXCNsbltDB+YuXP3ekSblX7knFfsP5IZ3MPeFPOHR3
         vH+qTkhvVhP7azNxJCADYZrIG+KDoS0FJz4MVHojlMdMEYvb4USZDWnxzFBalh/fj7B1
         4wKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trRXhcI2buKhbiPF1Cmv0EYAvkXYBR9MP7Cwm4odxNo=;
        b=kUVtPMZIMJZc+KHscy+NwqeS6ccVRG9gToQMBHQ0eMtdRxNPk/ppFyLxWJIL/daT2n
         t6871yg2mPOe/GFuiFqzC22coCRaD/0Q7CpunpaNVdqIyVTNGh81wL9GM4c/7v/RpwlB
         9+zWsSX6jmBqhhX4Yt84x/g/i8BsViO30kA/LWYs1MLt1ZPA1Pzu4P3xlKSS5bGl43bx
         PjlvFFi8jw8J/qCmXHz6745veP9r+33TeTrisGtYXO08d1iMZkPrliqP2TRgFsWXOLhe
         vyKFvg1kkYMvNAjdA2GV63NLjcAa0VZyClgZpjvcZlpP//CGm0ej8o80TeEoXzSiogyz
         eJ8A==
X-Gm-Message-State: AOAM533hGKT28bPUCE7P/G1zizlaUyhrq3rUUlHXlQzxOTHMatKDrq97
        g2K3lq0pVmwElrYmkXn8RgYSeg==
X-Google-Smtp-Source: ABdhPJwYg4/GbAWtPjhDVOW8ONgYXJY5VA50X+1eJCxD6Fvmf/6UjCqsPJMH3OVPtERtfB8bOO/MCA==
X-Received: by 2002:a17:902:e889:b029:e7:1490:9da5 with SMTP id w9-20020a170902e889b02900e714909da5mr26905267plg.20.1617099741663;
        Tue, 30 Mar 2021 03:22:21 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:22:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 09/15] mm: thp: introduce lock/unlock_split_queue{_irqsave}()
Date:   Tue, 30 Mar 2021 18:15:25 +0800
Message-Id: <20210330101531.82752-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
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
 mm/huge_memory.c | 97 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 395c75111d33..186dc11e8992 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -486,25 +486,76 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
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
 
+	memcg = page_memcg(compound_head(page));
 	if (memcg)
-		return &memcg->deferred_split_queue;
+		queue = &memcg->deferred_split_queue;
 	else
-		return &pgdat->deferred_split_queue;
+		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *lock_split_queue_irqsave(struct page *page,
+						       unsigned long *flags)
+{
+	struct deferred_split *queue;
+	struct mem_cgroup *memcg;
+
+	memcg = page_memcg(compound_head(page));
+	if (memcg)
+		queue = &memcg->deferred_split_queue;
+	else
+		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	return queue;
 }
 #else
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static struct deferred_split *lock_split_queue(struct page *page)
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	struct deferred_split *queue;
 
-	return &pgdat->deferred_split_queue;
+	queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *lock_split_queue_irqsave(struct page *page,
+						       unsigned long *flags)
+
+{
+	struct deferred_split *queue;
+
+	queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
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
@@ -2668,7 +2719,7 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct deferred_split *ds_queue;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
@@ -2747,7 +2798,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = lock_split_queue(head);
 	count = page_count(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
@@ -2755,7 +2806,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		unlock_split_queue(ds_queue);
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
@@ -2778,7 +2829,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			dump_page(page, "total_mapcount(head) > 0");
 			BUG();
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		unlock_split_queue(ds_queue);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		local_irq_enable();
@@ -2800,24 +2851,21 @@ fail:		if (mapping)
 
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
@@ -2835,18 +2883,23 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = lock_split_queue_irqsave(page, &flags);
 	if (list_empty(page_deferred_list(page))) {
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
+
 #ifdef CONFIG_MEMCG
-		if (memcg)
+		if (page_memcg(page)) {
+			struct mem_cgroup *memcg;
+
+			memcg = split_queue_to_memcg(ds_queue);
 			memcg_set_shrinker_bit(memcg, page_to_nid(page),
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

