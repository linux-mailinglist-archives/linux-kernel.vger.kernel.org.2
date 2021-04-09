Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F87359EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhDIMdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhDIMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:33:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA0C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j7so2685455plx.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLZrNiVEPJXjhQtz8kFl6b+yu9F8TwQrSh4SMqGiD1E=;
        b=1IDkk2oHNGNj78D/24tyi4X3RQrDTc1r29tCMIBkIqiT78Yyq8XbJaEgBsW8p4nu8T
         i+dIT7LgzsXueF1T9pAjOcXwc+frPDq1uqKWAgaPOcVaI1oayZhRY78IMRvskclJm9lc
         QSDD3UwPRJUJ8i8j8PXXNCfDj7ENF4UP1Mf+gXL+CNGsywBIbgI4f/A5Pw+Zkt/58Vo9
         7zYy0mBtQQ1ogeO6VBH/QMotPiC3oDEP++K9+AxXExqmPUuXb6AnUgwPyPag2YY8H9eo
         7iwUcrTwXCcPSBYwTHL80rjy9qjMDPD9puDdxjyfmmWHSfmjcoQUXJuZHW71i0zLqBam
         U/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLZrNiVEPJXjhQtz8kFl6b+yu9F8TwQrSh4SMqGiD1E=;
        b=m2DsUpSFLJRaxJTe8kx1Aupos+ls2WWG6cSdyg0ppYcDA90cMs+0ntORV4tbdyfdxF
         Rc6ig1cwTmZBFum7JOJZEdgfGujMUIcKKzPESssJLP2msHVgR9TkqtJnPWOWagM0LEk3
         hmFMfJDKvsyu0vPap9lnxjXIGhfhQ9xloyj6Ykgv+IzBxachFDfwt1Gex6BwoaLgDQ0u
         VruFy1G7f3XtY05XajjYHW4q3USkkjc7/mVXq0W/uycRapEWXUMlvdn6SOBeHB0QP7eT
         Z4hM2FfH0XP1YEf8+g32bwXdM/Ft13Wtj6lySgXAd36LMdj2f5O+z22fiFYFI7WcPRxx
         rk9A==
X-Gm-Message-State: AOAM532yjaCGkPHGj4hemnVVON4X35CBHOlH5tXQs6QvhB62JM1ov7Mo
        OxR14iFk6cT1d7SBVZhG4vtvmA==
X-Google-Smtp-Source: ABdhPJyJm9Tibec4EzxahFZu5zy5KuDUabDfhY4wooOMkJQG8AP8RC8mbCnuu9jzR9ttwEjQXnrSCA==
X-Received: by 2002:a17:902:e74e:b029:e5:bde4:2b80 with SMTP id p14-20020a170902e74eb02900e5bde42b80mr12608179plf.44.1617971575344;
        Fri, 09 Apr 2021 05:32:55 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 11/18] mm: thp: introduce lock/unlock_split_queue{_irqsave}()
Date:   Fri,  9 Apr 2021 20:29:52 +0800
Message-Id: <20210409122959.82264-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
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
index 437178ddbedb..275dbfc8b2ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -487,25 +487,76 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
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
@@ -2835,18 +2883,22 @@ void deferred_split_huge_page(struct page *page)
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

