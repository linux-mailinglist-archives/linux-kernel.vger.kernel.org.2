Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C240DBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhIPNxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbhIPNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7EC061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a591700b001976d2db364so4810829pji.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+lhnVk7PNaw87qVUGvTWZVe5ibvmpQFNKH+BgTcKz8=;
        b=EJQB64IheoOUUYV8uBbFxOrZQ0bA2eBWzQUajrW7B2SAQfbPETCpLBQ5pbZRarUg3M
         MjcRE0VGVU0WyDLRzmsfEdddTI/z+UmqlKicA8hjHRukMTXT/Vu5SB22Z+K2nxQiXZxA
         ZiREktdWOYMLZ5sPgiFOyQamMRfzA8TiZa14MFdJyfvS4EaDWw0iaEy2pHqaXPbLByYq
         qLBSJPJHtzxpu00LjkV0zzeOShA6D1GnWTjRW4FyeRO9sI6TEIASEIrSqwLTSjEt4drA
         g8uTivFdOYSLKF4y26Ek3y0GUnynx6DNGDv6DvTw8uXOirqiTNoKJlA70sMAew+DYaP+
         icNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+lhnVk7PNaw87qVUGvTWZVe5ibvmpQFNKH+BgTcKz8=;
        b=Lo1iPvTa3c1ull3T41e7scHDrRjlegEaUNu5cava3URyMEWkT637CxA1lVL06fB+RW
         QlZpm4jD+Raw6hkCg2bhk7+kdCA7me1jX4jd8nCOlZhGzuwzyPUMECKdbczZ0EdTjEm3
         ux1cWstNqscmK7x1SxIwulhaFN3XVsJxO0M3wPqEABhoJLczXKfnmICXoupjvn0RzjWp
         fBuTgWDgp4xQWJMnMFQraVt7UE7xxuw5j4sJlvNZ9YSRNuh/bZH/xcuz2N8JTUSzGGOe
         kBi+zwIcgNC4djZBbT+BW+V3XkACUK3iCKI3Q3uSXFH+Y8zoinAvEX8VLLJt1m/Q8E77
         TMsw==
X-Gm-Message-State: AOAM5334+4bGm+FuLuf7fRAftU3LZ0Kw47yHPZdJg9wBd8KKueisI+rK
        CaSmUmAkZFkyT4jKvqR92L8pgg==
X-Google-Smtp-Source: ABdhPJwlkh8gx/1dLOzmmevDx4a2iG3zshcF6PRapEicFD7Mg4VLMeRDP4oy9Fq9DNOGgCMG97VDqw==
X-Received: by 2002:a17:902:9895:b0:13c:94f8:d74b with SMTP id s21-20020a170902989500b0013c94f8d74bmr4935296plp.20.1631800340774;
        Thu, 16 Sep 2021 06:52:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 02/13] mm: memcontrol: prepare objcg API for non-kmem usage
Date:   Thu, 16 Sep 2021 21:47:37 +0800
Message-Id: <20210916134748.67712-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pagecache pages are charged at the allocation time and holding a
reference to the original memory cgroup until being reclaimed.
Depending on the memory pressure, specific patterns of the page
sharing between different cgroups and the cgroup creation and
destruction rates, a large number of dying memory cgroups can be
pinned by pagecache pages. It makes the page reclaim less efficient
and wastes memory.

We can convert LRU pages and most other raw memcg pins to the objcg
direction to fix this problem, and then the page->memcg will always
point to an object cgroup pointer.

Therefore, the infrastructure of objcg no longer only serves
CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
can reuse it to charge pages.

We know that the LRU pages are not accounted at the root level. But
the page->memcg_data points to the root_mem_cgroup. So the
page->memcg_data of the LRU pages always points to a valid pointer.
But the root_mem_cgroup dose not have an object cgroup. If we use
obj_cgroup APIs to charge the LRU pages, we should set the
page->memcg_data to a root object cgroup. So we also allocate an
object cgroup for the root_mem_cgroup.

As roman said "we might wanna to eliminate CONFIG_MEMCG_KMEM
completely", so we do not add new dependencies.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 60 +++++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e194d90aff56..490d4849a05a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -319,9 +319,9 @@ struct mem_cgroup {
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
+#endif
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
-#endif
 
 	MEMCG_PADDING(_pad2_);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 528b134ca50c..f58010cd8414 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,18 +261,15 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
-static void obj_cgroup_release(struct percpu_ref *ref)
+static void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
-	unsigned long flags;
 
 	/*
 	 * At this point all allocated objects are freed, and
@@ -286,9 +283,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	 * 3) CPU1: a process from another memcg is allocating something,
 	 *          the stock if flushed,
 	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
-	 * 5) CPU0: we do release this object,
+	 * 4) CPU0: we do release this object,
 	 *          92 bytes are added to stock->nr_bytes
-	 * 6) CPU0: stock is flushed,
+	 * 5) CPU0: stock is flushed,
 	 *          92 bytes are added to objcg->nr_charged_bytes
 	 *
 	 * In the result, nr_charged_bytes == PAGE_SIZE.
@@ -300,6 +297,14 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+}
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	unsigned long flags;
+
+	obj_cgroup_release_bytes(objcg);
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -328,10 +333,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
-				  struct mem_cgroup *parent)
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
+	struct mem_cgroup *parent;
+
+	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		parent = root_mem_cgroup;
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
@@ -350,6 +359,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	percpu_ref_kill(&objcg->refcnt);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
@@ -3587,7 +3597,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3600,14 +3609,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (memcg_id < 0)
 		return memcg_id;
 
-	objcg = obj_cgroup_alloc();
-	if (!objcg) {
-		memcg_free_cache_id(memcg_id);
-		return -ENOMEM;
-	}
-	objcg->memcg = memcg;
-	rcu_assign_pointer(memcg->objcg, objcg);
-
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
@@ -3631,8 +3632,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
-	memcg_reparent_objcgs(memcg, parent);
-
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
@@ -5159,8 +5158,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5232,16 +5231,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct obj_cgroup *objcg;
 
 	/*
 	 * A memcg must be visible for expand_shrinker_info()
 	 * by the time the maps are allocated. So, we allocate maps
 	 * here, when for_each_mem_cgroup() can't skip it.
 	 */
-	if (alloc_shrinker_info(memcg)) {
-		mem_cgroup_id_remove(memcg);
-		return -ENOMEM;
-	}
+	if (alloc_shrinker_info(memcg))
+		goto remove_id;
+
+	objcg = obj_cgroup_alloc();
+	if (!objcg)
+		goto free_shrinker;
+
+	objcg->memcg = memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
 
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
@@ -5251,6 +5256,12 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   2UL*HZ);
 	return 0;
+
+free_shrinker:
+	free_shrinker_info(memcg);
+remove_id:
+	mem_cgroup_id_remove(memcg);
+	return -ENOMEM;
 }
 
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
@@ -5274,6 +5285,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	memcg_reparent_objcgs(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
-- 
2.11.0

