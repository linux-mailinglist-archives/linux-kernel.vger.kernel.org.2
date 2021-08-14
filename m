Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9DA3EC0A9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhHNF0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhHNF0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FAC061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b7so14683344plh.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkgVxlGCf6bKLlXW3fToFeS0WRPiohkGWt+flADM0c8=;
        b=zqH6VtO93wr+br2CK1IMWR7G+IWiaw9LQQVShcKzoJrmdoPK9ujf3qwfUfIXJJ36MN
         j3LdxNiTOIYBWFNvY9mhNcp42bLiKzIy/BFEOUivH9Vv8KQ7MVBW0jKwgzA9yeQZMuZI
         Qh/1JTb8wGBNsl9G8Zk9XHTPs5LDQfNBgA7jib/Dn4RVlN/Dd4q1usTvDfjPhWRRQ/k9
         l0KHrAejHlpZ8+lO2/VV5ytbmFqPKi0C1v4eBbcKePdFtjxje8HkRd6TihIiY2fept2N
         g7ieAYrcfwQy/umPcdtzcQXFe4nAOHMk+5DWw5mapYrMy6K1XzOoSLG8p87bP4Pj2V5W
         KraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkgVxlGCf6bKLlXW3fToFeS0WRPiohkGWt+flADM0c8=;
        b=h/5VFTfJe9WcpK5pSGa9L8QDeSqSwczApy+AJcNR9m/Nkt9tNYVNy4a1NLAHzPD5sD
         VU5xBKcxmz0d696L+3CyGvcft02YDv5SyI+GSe5XudPaTO1y5TwgzPbiuxyUlhmug4Zt
         fUreAIzgO4da6qlrJQpxF9Cw79ieSJ2gnc49eB9p6b2MUDDJulY9Oge1lQ8u3ai6p4Sp
         JL4Z9UonYMe/06C1QFHOkaX4qC0uIhqdtepmEdQCAVriR2RFj5t3vAnEF09BaOsE4iaz
         y5SfUsYATxPGqlIsrLdlqJoZnEjqSqX5GuRxvirlBgjlQPyfQnjPa+Km9kYdi9aPU7s6
         KsPg==
X-Gm-Message-State: AOAM5335YmnIZfcrHzuToypInxAuwU0MWGP6zPo6YV8V85sLwyRj0VKI
        GC6Au3HbdByH6PvG1uYd8lMQdw==
X-Google-Smtp-Source: ABdhPJw9eg4WltKVUoPVy5UwA26m96K/Yiz/gagYIaWrb42c7e7FBwLkxyl3f6BMbsrb46sORKviRA==
X-Received: by 2002:a17:902:ce83:b0:12d:97e1:e199 with SMTP id f3-20020a170902ce8300b0012d97e1e199mr4097060plg.16.1628918739240;
        Fri, 13 Aug 2021 22:25:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.25.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:25:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 01/12] mm: memcontrol: prepare objcg API for non-kmem usage
Date:   Sat, 14 Aug 2021 13:25:08 +0800
Message-Id: <20210814052519.86679-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
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

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  4 ++-
 mm/memcontrol.c            | 66 +++++++++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ff146486aed..41a35de93d75 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -221,7 +221,9 @@ struct memcg_cgwb_frn {
 struct obj_cgroup {
 	struct percpu_ref refcnt;
 	struct mem_cgroup *memcg;
+#ifdef CONFIG_MEMCG_KMEM
 	atomic_t nr_charged_bytes;
+#endif
 	union {
 		struct list_head list;
 		struct rcu_head rcu;
@@ -319,9 +321,9 @@ struct mem_cgroup {
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
+#endif
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
-#endif
 
 	MEMCG_PADDING(_pad2_);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e7c205a1852..7df2176e4f02 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,7 +261,6 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
 bool mem_cgroup_kmem_disabled(void)
@@ -269,15 +268,14 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
-static void obj_cgroup_release(struct percpu_ref *ref)
+static void obj_cgroup_release_kmem(struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
-	unsigned long flags;
 
 	/*
 	 * At this point all allocated objects are freed, and
@@ -291,9 +289,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
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
@@ -305,6 +303,19 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+}
+#else
+static inline void obj_cgroup_release_kmem(struct obj_cgroup *objcg)
+{
+}
+#endif
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	unsigned long flags;
+
+	obj_cgroup_release_kmem(objcg);
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -333,10 +344,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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
 
@@ -355,6 +370,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	percpu_ref_kill(&objcg->refcnt);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
@@ -3579,7 +3595,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3592,14 +3607,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
@@ -3623,8 +3630,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
-	memcg_reparent_objcgs(memcg, parent);
-
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
@@ -5151,8 +5156,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5224,16 +5229,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
@@ -5243,6 +5254,12 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -5266,6 +5283,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	memcg_reparent_objcgs(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
-- 
2.11.0

