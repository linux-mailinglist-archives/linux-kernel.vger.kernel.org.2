Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24138359EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhDIMcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhDIMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08821C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so4901132pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFZuKhV7S6QSJy1GvFIoKAK4uygF5Ytwzl1o/RAMqsk=;
        b=R8CXp4bSbzbmatlE3nPp/3ARR9oXj/k36wnDlueW3pgxp3+XQIhbGbmbCkS59QpJSk
         d7gXQ6MwoA4JtTUSMhHk9BjQQONWZZl8VLYiHfH3ho3AXGcj5q33uz7WaIIAwRuL7SIr
         gt/DwSfHAhSN9eY6kDWFwygd41t5P5RVOVe9iDsnE+s2TFIPkNtrfC8XgYVLsFC8NuYj
         CCBKj2zBu40Uh+2SJplKptD+taYdQNWhO6h2qAV+xnzhFW6K+Mo6TlT2roRlzzXvSI1p
         Cd/DAaaPOslNrphgyjKatbkHIfo+HjDIrWWzp7RvmUD7fscOc9iySA6RqGAmkPfFCI0W
         +xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFZuKhV7S6QSJy1GvFIoKAK4uygF5Ytwzl1o/RAMqsk=;
        b=AuCAu7GV3xJ3ZLl6SyiotuMpTpS1/i6pU6husCScOyZbT7iLiKIqPkn1TWQ5I/4VIk
         2a0z9BIuFisDG6wuJCSmmMwZaTxHMq2XTc9m/Qvc3kzubABgeaQq8lZLOc5tsDnXudPg
         2US5cUj/8ySAJuXYOaBQzB4MqxJhp3Gwj0V42s0zhi2O3GCccCo+vacygpkf1wRvk/oS
         ytTVJGYIf7+MZib8EDNWTOTKkfEhY76+suySxJ2w87nxIQ79qgH74bRcRxWqaJiVPhHh
         Pvd5eQisF2My4dqr+a6JuHM5eNNVKCwDY1ZXk8umYwIy7ItboV7i7ffzSZsmKB91rZLI
         gEWQ==
X-Gm-Message-State: AOAM530/v2JRSqw+Eu3fHm8dr1O02MX9ko1rKodYtp8b4OKfXJjJf99w
        FvmcbW53vtwzLqb6j5W9TWCUTw==
X-Google-Smtp-Source: ABdhPJwMfMFM/CsOTsuE/XlywFPgUORZLtav1Na9HS4WPyo5vEtidyQIl2o5W8jafuaaISBXRbuA5g==
X-Received: by 2002:a17:902:904b:b029:e5:5cc5:877d with SMTP id w11-20020a170902904bb02900e55cc5877dmr13083893plz.50.1617971546552;
        Fri, 09 Apr 2021 05:32:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 06/18] mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
Date:   Fri,  9 Apr 2021 20:29:47 +0800
Message-Id: <20210409122959.82264-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because memory allocations pinning memcgs for a long time - it exists
at a larger scale and is causing recurring problems in the real world:
page cache doesn't get reclaimed for a long time, or is used by the
second, third, fourth, ... instance of the same job that was restarted
into a new cgroup every time. Unreclaimable dying cgroups pile up,
waste memory, and make page reclaim very inefficient.

We can convert LRU pages and most other raw memcg pins to the objcg
direction to fix this problem, and then the page->memcg will always
point to an object cgroup pointer.

Therefore, the infrastructure of objcg no longer only serves
CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
can reuse it to charge pages.

We know that the LRU pages are not accounted at the root level. But the
page->memcg_data points to the root_mem_cgroup. So the page->memcg_data
of the LRU pages always points to a valid pointer. But the root_mem_cgroup
dose not have an object cgroup. If we use obj_cgroup APIs to charge the
LRU pages, we should set the page->memcg_data to a root object cgroup. So
we also allocate an object cgroup for the root_mem_cgroup and introduce
root_obj_cgroup to cache its value just like root_mem_cgroup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  4 ++-
 mm/memcontrol.c            | 71 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 38b8d3fb24ff..ab948eb5f62e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -223,7 +223,9 @@ struct memcg_cgwb_frn {
 struct obj_cgroup {
 	struct percpu_ref refcnt;
 	struct mem_cgroup *memcg;
+#ifdef CONFIG_MEMCG_KMEM
 	atomic_t nr_charged_bytes;
+#endif
 	union {
 		struct list_head list;
 		struct rcu_head rcu;
@@ -321,9 +323,9 @@ struct mem_cgroup {
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
+#endif
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
-#endif
 
 	MEMCG_PADDING(_pad2_);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 90c1ac58c64c..27caf24bb0c1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -75,6 +75,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+static struct obj_cgroup *root_obj_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
@@ -252,9 +253,14 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
+static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
+{
+	return objcg == root_obj_cgroup;
+}
+
+#ifdef CONFIG_MEMCG_KMEM
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
@@ -298,6 +304,20 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	percpu_ref_exit(ref);
 	kfree_rcu(objcg, rcu);
 }
+#else
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	unsigned long flags;
+
+	spin_lock_irqsave(&css_set_lock, flags);
+	list_del(&objcg->list);
+	spin_unlock_irqrestore(&css_set_lock, flags);
+
+	percpu_ref_exit(ref);
+	kfree_rcu(objcg, rcu);
+}
+#endif
 
 static struct obj_cgroup *obj_cgroup_alloc(void)
 {
@@ -318,10 +338,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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
 
@@ -342,6 +366,27 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	percpu_ref_kill(&objcg->refcnt);
 }
 
+static int memcg_obj_cgroup_alloc(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg;
+
+	objcg = obj_cgroup_alloc();
+	if (!objcg)
+		return -ENOMEM;
+
+	objcg->memcg = memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
+
+	return 0;
+}
+
+static void memcg_obj_cgroup_free(struct mem_cgroup *memcg)
+{
+	if (unlikely(memcg->objcg))
+		memcg_reparent_objcgs(memcg);
+}
+
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
@@ -3444,7 +3489,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3457,14 +3501,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
@@ -3488,7 +3524,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
-	memcg_reparent_objcgs(memcg, parent);
+	memcg_reparent_objcgs(memcg);
 
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
@@ -4978,6 +5014,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	int cpu;
 
+	memcg_obj_cgroup_free(memcg);
 	memcg_wb_domain_exit(memcg);
 	/*
 	 * Flush percpu lruvec stats to guarantee the value
@@ -5023,6 +5060,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
 		goto fail;
 
+	if (memcg_obj_cgroup_alloc(memcg))
+		goto free_wb;
+
 	INIT_WORK(&memcg->high_work, high_work_func);
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
@@ -5033,8 +5073,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5048,6 +5088,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
+free_wb:
+	memcg_wb_domain_exit(memcg);
 fail:
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
@@ -5085,6 +5127,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->tcpmem, NULL);
 
 		root_mem_cgroup = memcg;
+		root_obj_cgroup = memcg->objcg;
 		return &memcg->css;
 	}
 
-- 
2.11.0

