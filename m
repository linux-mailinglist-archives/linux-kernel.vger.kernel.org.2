Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930F6458046
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 21:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKTUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhKTUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:15:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FDEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 12:12:44 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id h2-20020a632102000000b003210bade52bso28719pgh.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 12:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d3b1nVGIZXYy+vW6njXoGGYnh5z92DR8Qs9Js11uG4c=;
        b=lvhrt5+94ZafWIvjVlEi/Q5YKK67SJRcvFeNjR7v32bEi2xfuCp/ApfnjFf1uugdoG
         reT6YJV7x1EJC3fMZvSv35nkuGV+AdDTU6W2jI06xZxN/p9faVtpkBV0Ln4fWQhf61M8
         y7301nFUgskQCdOdkJB6oDN5CDJMGYnq0mVaIEGgZY310jS4UsxO/Ee9Mi2Kk5BWOM+3
         9Ei7eu7p+S9sDTrGjmH3a8ATNuKEYv/vBg15ZBBD1JeeFqn+20DYaHpLmVQwli61KCQm
         pMYKlg/B+zII9wWtQlRmVjrT4t05qY/isZqYItKEHcyE1tGK4msStvvd3Um6YPmPAkqF
         7Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d3b1nVGIZXYy+vW6njXoGGYnh5z92DR8Qs9Js11uG4c=;
        b=FL+aY9Kmdtv+n/EBALffiJjTbQlObQbeuLvyCb0fkhnNeazGem2m30xQto9cP9Gie8
         myery2uC/bTgKwE0x+bbfFFrW5LZPLnAgPje70Qg3yGVQ69tPhUTahnEQcTVFLulDDM3
         fHSBrzjVhG3eJxB7nw2/4vxGx+oDDokX6rmlCqGGgt7eXtIFBMcDyE18GhgbbM5oVCOQ
         g5+sgqd/E64YV5lsrcM7h8Nt5M58ntFS4be3o/86WsCFYJpeha3TtW5TNn39V8pqWKnK
         T6hscIiPbJKMZpCssyyl524DSRKbI92N7qgv/N5Gvb5f5Lz4UVjWmNbJ1Wf58tX+2dXX
         eKvA==
X-Gm-Message-State: AOAM5328NmskGRvVPzH76GURL89l6P4gsTAtzKjV0TIdYcBCpbbNXcHg
        2kQr2pQvEaYuhXd18fZ85MS+XFCiBwE2WA==
X-Google-Smtp-Source: ABdhPJwRfEMFST7mpnPWnXBHH9Ii/xmCV+dzZPgQdMU3SaEey10fj7pjHjocqIjJ5uS20Qn7/ff569qaZR4SXA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:b46b:4675:ed89:d807])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:4c51:: with SMTP id
 np17mr13489635pjb.213.1637439164383; Sat, 20 Nov 2021 12:12:44 -0800 (PST)
Date:   Sat, 20 Nov 2021 12:12:30 -0800
Message-Id: <20211120201230.920082-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] mm: split thp synchronously on MADV_DONTNEED
From:   Shakeel Butt <shakeelb@google.com>
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many applications do sophisticated management of their heap memory for
better performance but with low cost. We have a bunch of such
applications running on our production and examples include caching and
data storage services. These applications keep their hot data on the
THPs for better performance and release the cold data through
MADV_DONTNEED to keep the memory cost low.

The kernel defers the split and release of THPs until there is memory
pressure. This causes complicates the memory management of these
sophisticated applications which then needs to look into low level
kernel handling of THPs to better gauge their headroom for expansion. In
addition these applications are very latency sensitive and would prefer
to not face memory reclaim due to non-deterministic nature of reclaim.

This patch let such applications not worry about the low level handling
of THPs in the kernel and splits the THPs synchronously on
MADV_DONTNEED.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/mmzone.h   |  5 ++++
 include/linux/sched.h    |  4 ++++
 include/linux/sched/mm.h | 11 +++++++++
 kernel/fork.c            |  3 +++
 mm/huge_memory.c         | 50 ++++++++++++++++++++++++++++++++++++++++
 mm/madvise.c             |  8 +++++++
 6 files changed, 81 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..7fa0035128b9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -795,6 +795,11 @@ struct deferred_split {
 	struct list_head split_queue;
 	unsigned long split_queue_len;
 };
+void split_local_deferred_list(struct list_head *defer_list);
+#else
+static inline void split_local_deferred_list(struct list_head *defer_list)
+{
+}
 #endif
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9d27fd0ce5df..a984bb6509d9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1412,6 +1412,10 @@ struct task_struct {
 	struct mem_cgroup		*active_memcg;
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct list_head		*deferred_split_list;
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 	struct request_queue		*throttle_queue;
 #endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index fdf742e15e27..9b438c7e811e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -374,6 +374,17 @@ set_active_memcg(struct mem_cgroup *memcg)
 }
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline void set_local_deferred_list(struct list_head *list)
+{
+	current->deferred_split_list = list;
+}
+#else
+static inline void set_local_deferred_list(struct list_head *list)
+{
+}
+#endif
+
 #ifdef CONFIG_MEMBARRIER
 enum {
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY		= (1U << 0),
diff --git a/kernel/fork.c b/kernel/fork.c
index 01af6129aa38..8197b8ed4b7a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1019,6 +1019,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	tsk->deferred_split_list = NULL;
 #endif
 	return tsk;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..2f73eeecb857 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2754,6 +2754,7 @@ void free_transhuge_page(struct page *page)
 void deferred_split_huge_page(struct page *page)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct list_head *list = current->deferred_split_list;
 #ifdef CONFIG_MEMCG
 	struct mem_cgroup *memcg = page_memcg(compound_head(page));
 #endif
@@ -2774,7 +2775,14 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
+	if (list && list_empty(page_deferred_list(page))) {
+		/* corresponding put in split_local_deferred_list. */
+		get_page(page);
+		list_add(page_deferred_list(page), list);
+	}
+
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+
 	if (list_empty(page_deferred_list(page))) {
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
@@ -2801,6 +2809,48 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
+void split_local_deferred_list(struct list_head *defer_list)
+{
+	struct list_head *pos, *next;
+	struct page *page;
+
+	/* First iteration for split. */
+	list_for_each_safe(pos, next, defer_list) {
+		page = list_entry((void *)pos, struct page, deferred_list);
+		page = compound_head(page);
+
+		if (!trylock_page(page))
+			continue;
+
+		if (split_huge_page(page)) {
+			unlock_page(page);
+			continue;
+		}
+		/* split_huge_page() removes page from list on success */
+		unlock_page(page);
+
+		/* corresponding get in deferred_split_huge_page. */
+		put_page(page);
+	}
+
+	/* Second iteration to putback failed pages. */
+	list_for_each_safe(pos, next, defer_list) {
+		struct deferred_split *ds_queue;
+		unsigned long flags;
+
+		page = list_entry((void *)pos, struct page, deferred_list);
+		page = compound_head(page);
+		ds_queue = get_deferred_split_queue(page);
+
+		spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+		list_move(page_deferred_list(page), &ds_queue->split_queue);
+		spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+
+		/* corresponding get in deferred_split_huge_page. */
+		put_page(page);
+	}
+}
+
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 8c927202bbe6..15614115e359 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -762,7 +762,15 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
+	LIST_HEAD(list);
+
+	set_local_deferred_list(&list);
+
 	zap_page_range(vma, start, end - start);
+
+	set_local_deferred_list(NULL);
+	split_local_deferred_list(&list);
+
 	return 0;
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

