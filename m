Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4753665FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhDUHC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbhDUHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d124so27783632pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOcPgu6D5oEEgx7D2wD/VCzFGRTojx6iJbpWydghicw=;
        b=XlQkbgcbPWI6jkTWC3u5TrT3nH5vwuPPyVriG5daT7w8f1BQpiguK5hwLSevehvH6F
         HmVsv3eKQn9CrshzJZG3FQUH7YOeJrC5bO/oqyzSqEISLW8vbWBQ8kLi4Ai1rqe34QHL
         YquQb3k7hQTTcFPOvAuLkf4HQrOnGThHWdfQ6yvfeno7MtCxKnBXDxTbjTXiYt0NPqdl
         QAu4OVf8RgyC5PwJk/MfVrripCBfAuqKRaZfXGZGvDOVNkjJNqP8R9iwHatl9P/R4AI9
         MGoWSGiURj5w3okyfXuJfh2G5Wq4UgCJ4hx7N0Co6qUX2AIUQrapkjOQx56bxcSIRxcN
         JB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOcPgu6D5oEEgx7D2wD/VCzFGRTojx6iJbpWydghicw=;
        b=W1L0mS1/Rzq+OzdhejyzLUgBj7zSvMhDPIj+y8YOYKSGgSAtuu6wj45j9OK7Nf2qCo
         vDwxfXSwOugGq6z2E8smPVIXQNA+4IZT2PxNMq4pGIuGYAxfX+JqYszhu4tU8JhHvXgI
         hlBH+wxBMDWKjdGEY6v1u7/UvigwIApqolRq6mF51rlQJ3QmzLdWsFomjHavPCuH1GT4
         0pNYiXFaCBeuZqQm7WEJxp0zAicPbRD6kzAOTDNO8Ol6HG4wJOpxvw0ERXlNxS2aydVH
         XSkc05nvxCmXT/yTn2udCmtAfBi4tCXY3TsEG73CXXE6WEA641UeVb5CJyAxbdPAVnF6
         2ecg==
X-Gm-Message-State: AOAM532luDugrtRYtTGSZRTSgLfwsrI/kRikIyuWEdNxup4Cz9fzUuZB
        CWwVTyqYIR+2h6yrlF4sYTGk4A==
X-Google-Smtp-Source: ABdhPJyH4vKQChhJuWmIgWUOpefy4hsKuplUSNaZMj0jf5qZs8hysAcRoPo3hhI26/mDtMC3EVjSfQ==
X-Received: by 2002:aa7:9837:0:b029:264:b19e:acce with SMTP id q23-20020aa798370000b0290264b19eaccemr4918194pfl.79.1618988506150;
        Wed, 21 Apr 2021 00:01:46 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 05/12] mm: thp: introduce lock/unlock_split_queue{_irqsave}()
Date:   Wed, 21 Apr 2021 15:00:52 +0800
Message-Id: <20210421070059.69361-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
index 63ed6b25deaa..05ef9e8f9af5 100644
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
@@ -2656,7 +2707,7 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct deferred_split *ds_queue;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
@@ -2735,7 +2786,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = lock_split_queue(head);
 	count = page_count(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
@@ -2743,7 +2794,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		unlock_split_queue(ds_queue);
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
@@ -2766,7 +2817,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			dump_page(page, "total_mapcount(head) > 0");
 			BUG();
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		unlock_split_queue(ds_queue);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		local_irq_enable();
@@ -2788,24 +2839,21 @@ fail:		if (mapping)
 
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
@@ -2823,18 +2871,22 @@ void deferred_split_huge_page(struct page *page)
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

