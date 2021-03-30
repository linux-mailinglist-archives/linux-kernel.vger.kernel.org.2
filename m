Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C034E556
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhC3KVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhC3KVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:21:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t140so4049625pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfWwAKuY+YWb39Txh7PaDKZ2adAgm9Qy+u/WjVIFUvM=;
        b=vBJ/T9bHr7jxeciveI0Wx03b+++8Eg2FiToVQoXaxTLTm3ghXZDZG6QiGdoMqziAWY
         Cg2VoGbSmPhizOHcUnltli2yxFctyPO2CHmdURsxRdFRKIIvhfkMW/iockIOrU5/Qz23
         nvcG+EwgtiACTww18oKFhVQJrZhDYXdJieKIEF4wiIhDF1ut9FTQct4NCX10BZHmkrDD
         VLMS9sgYEmmRD+9nVewGSTFcpn5MxQvlensWKOJSTu+qqUTfuCfgPvQyJEjapI29pVcP
         tbiJBXSQXV4wX8OwkCyqRPdsR45NHxKShoNCafRz3895S+YWI01TcT/kxc7Tm0Hb+204
         vl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfWwAKuY+YWb39Txh7PaDKZ2adAgm9Qy+u/WjVIFUvM=;
        b=b4Q6WKTbqtAHa2kJijJbEw9IDY7z9MJms0eFGjDuhL3OqX0yNySLOIFS0eX69Rh1tb
         uTXxmsIA9fvTy5aT9uf9s3KZzyutRjZeIKAeCwjE/Vs5a4EYI3cXsDK9eN/g2nhFKf5k
         hqPP77ALgAZaW9cjRIcIjuvugA1s5VEwj1C+f/g0uGezVu6SyXcg/LMyNi2PiPlC7iuk
         p4ZiMXPwAV/Mr2xjv0cuipD6/8CL+hBkRA1MjD/OFtd5b/7HTLHxKAbihOKuRuEGIpl+
         8HlT/DY/OGDoQN3FTK7Ii2bwl24au+SYR6jqQG/Pbljq73aW1L7pzwQvOyozumHz5gVp
         0ByA==
X-Gm-Message-State: AOAM531IprLH0/Z1l4q+0p4gHfYX3bSncb2jciCIlnsxvQxutvEi56uF
        uMMtpK6Qs3ldTlv98CDR/uItVA==
X-Google-Smtp-Source: ABdhPJxbOW2erq0nW/pOofv8s7ZSV2CLVgdPB/0PJ7/xLpa64488sjYyuXlCaG6bn7p8yhSswbLHgQ==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr27248025pgf.254.1617099701738;
        Tue, 30 Mar 2021 03:21:41 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.21.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:21:41 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 06/15] mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
Date:   Tue, 30 Mar 2021 18:15:22 +0800
Message-Id: <20210330101531.82752-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
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
index 6e3283828391..463fc7b78396 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -205,7 +205,9 @@ struct memcg_cgwb_frn {
 struct obj_cgroup {
 	struct percpu_ref refcnt;
 	struct mem_cgroup *memcg;
+#ifdef CONFIG_MEMCG_KMEM
 	atomic_t nr_charged_bytes;
+#endif
 	union {
 		struct list_head list;
 		struct rcu_head rcu;
@@ -303,9 +305,9 @@ struct mem_cgroup {
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
+#endif
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
-#endif
 
 	MEMCG_PADDING(_pad2_);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fdabe12e9df0..0107f23e7035 100644
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
@@ -3648,7 +3693,6 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3661,14 +3705,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
@@ -3692,7 +3728,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
-	memcg_reparent_objcgs(memcg, parent);
+	memcg_reparent_objcgs(memcg);
 
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
@@ -5192,6 +5228,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	memcg_obj_cgroup_free(memcg);
 	memcg_wb_domain_exit(memcg);
 	/*
 	 * Flush percpu vmstats and vmevents to guarantee the value correctness
@@ -5242,6 +5279,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
 		goto fail;
 
+	if (memcg_obj_cgroup_alloc(memcg))
+		goto free_wb;
+
 	INIT_WORK(&memcg->high_work, high_work_func);
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
@@ -5252,8 +5292,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5267,6 +5307,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
+free_wb:
+	memcg_wb_domain_exit(memcg);
 fail:
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
@@ -5304,6 +5346,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->tcpmem, NULL);
 
 		root_mem_cgroup = memcg;
+		root_obj_cgroup = memcg->objcg;
 		return &memcg->css;
 	}
 
-- 
2.11.0

