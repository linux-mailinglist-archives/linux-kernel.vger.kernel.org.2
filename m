Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3581C3665F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbhDUHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbhDUHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:01:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008BCC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so5447476plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjBrTiHyQ1mxWGjoMyihfL+XNe32FXvdA88JZHKm/Oc=;
        b=vDnyij3n2X+NWMBjJ3kE8wZeGwUIOn+WXKFjnH1vrTUe/axRcMNEctAV+YThVdknOx
         3HDE6i/UQr8MLOcNC8jv/cK2w72b4XsBUq8lP8kV+BeDa9xvUABjbP8itFDRXHVxHjd3
         6V9kndH1Xp/a87YzcvsxEElrQgOJpHMcLJycpdpV09jMAIssN4A1qSdr1EOg6LvC1k6n
         Ila+W9VBCZZUAcy3O8PnGV74pkBzurET7Pn6NlRt1JC91Bep1m+ZLH0X58EMjKmrmHQP
         ndwN/ZU7BaJ2HFGyiwLUUYAGiIjdM1/hgO1i9P/6rpUXbyK3BnVELGJcwfFXbjvtrjiy
         JcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjBrTiHyQ1mxWGjoMyihfL+XNe32FXvdA88JZHKm/Oc=;
        b=VCCRWRFK9oWNI7H0sw3aQjY3ISd2Ijl7+FosLWIr3fM2LY+97CYobdb8VEntSEnPlR
         GtgesskNIikKI+95s5Mfb933GUab/8Izxh7NJ0AgJa6oGoofzn4YNrOXsbezKNhBVdRG
         kg9X2Tepv4yBlR8NmSvW5Sd+4CVtd5eV88efbGfUsqRKhTLEyUTOZa8wjhHR7JdkY4n8
         i8+k/TqptHJL/ANREGmxvn2QFk668e/i6foGJSc9kE/3XcTLNzxADqfO6RyvCrwG4EsL
         zm5zSdxElAIhDuZcTPyqwVYNnCT15rqk5Srb0IpzWMuMZmB2z190yj+a9A7AIX8kp9c+
         MMHQ==
X-Gm-Message-State: AOAM530okmpO0qqOrt2FFsqsqX24wiNTDqTcuIdOYOYE3MOpo3ffx6O0
        wgTmEvNkrnax566Az1plPqapAw==
X-Google-Smtp-Source: ABdhPJxRBEEb+qb3H1bJhZBiafE2qz+pSenmUryLTn+8WB0/0haWWIOLP0XdylhjsMZhCEqSqjJbzg==
X-Received: by 2002:a17:902:c410:b029:eb:279:f53b with SMTP id k16-20020a170902c410b02900eb0279f53bmr32995226plk.33.1618988481568;
        Wed, 21 Apr 2021 00:01:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 01/12] mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
Date:   Wed, 21 Apr 2021 15:00:48 +0800
Message-Id: <20210421070059.69361-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
 mm/memcontrol.c            | 62 ++++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ce97eff79e2..53a19db9f8eb 100644
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
index e0c398fe7443..dae7ab2b1406 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -252,18 +252,16 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
+#ifdef CONFIG_MEMCG_KMEM
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
-static void obj_cgroup_release(struct percpu_ref *ref)
+static void obj_cgroup_release_uncharge(struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
-	unsigned long flags;
 
 	/*
 	 * At this point all allocated objects are freed, and
@@ -291,6 +289,19 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+}
+#else
+static inline void obj_cgroup_release_uncharge(struct obj_cgroup *objcg)
+{
+}
+#endif
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	unsigned long flags;
+
+	obj_cgroup_release_uncharge(objcg);
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -319,10 +330,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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
 
@@ -341,6 +356,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	percpu_ref_kill(&objcg->refcnt);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
@@ -3447,7 +3463,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
 	int memcg_id;
 
 	if (cgroup_memory_nokmem)
@@ -3460,14 +3475,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
@@ -3491,8 +3498,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
-	memcg_reparent_objcgs(memcg, parent);
-
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
@@ -5036,8 +5041,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5109,21 +5114,33 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
 	css_get(css);
 	return 0;
+
+free_shrinker:
+	free_shrinker_info(memcg);
+remove_id:
+	mem_cgroup_id_remove(memcg);
+	return -ENOMEM;
 }
 
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
@@ -5147,6 +5164,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	memcg_reparent_objcgs(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
-- 
2.11.0

