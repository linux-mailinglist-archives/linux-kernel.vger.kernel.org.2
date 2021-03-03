Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1132BAD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358319AbhCCMFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451390AbhCCGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:03:19 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D2C061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:02:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l2so15576945pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SGcDLK5SCw5qpmMPfN20YvzOKzNsNe/KAEKeLOxazs=;
        b=0UkELpminMnKj+/y5cec+UKoj8HsSQiO78XgmB1nrVeP82D5dj50AWBuJEO7BW5icC
         9dK8N2baH9CXKY6CNsydeG04XvU2+WBf84vIycyUqT1p84869gehyw1GI11M26Sgt9ff
         vsjU9U4nfH8Iq0sYtPsYpMxP/I52Bkr85EbjliLl++2wS6lMEwVwEvJDlZb4+wHla1Xg
         K/fIdpS3D98i8f8SB3l/o+/ss5sXqDTIjZz8sX5bZnzjlL417b9oqCoHQDuTaHoWIJDC
         AVaQ9ZUcBJo8zXksBoiRadIq+hbcT2pJwiy0vfPrbsxqZFFQfnxXR1TktzsuWFtU9ng+
         HkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SGcDLK5SCw5qpmMPfN20YvzOKzNsNe/KAEKeLOxazs=;
        b=siUjX8d8VnlV3PJt0WKfAjCNfMw3N2dnDicYXVArMPYvYOLWZasgGG1/tOB2u6B+ul
         M9Llk0gBmYSAwFDSy8SdxnJlR51cmO0iHSpx2wztuUhywuZqpQtVDDDayjI/VCiyEQ1h
         mR5qT7METooTj2FALELKCXk9XlpH1JKlfBBa3oHmW5T1Q7DZiAmcGa5gdzFXqYikQx6H
         mA3E08QnsKvXH8NhlcmJs0zrgE+xRsvWnszWc9LNASqgT2VugUikKFsJbCMLasIrxlPU
         p8fD3e53t+pw5eCU/TadarU3OeQCs/mC+3JlhxR7f6sHN/vZqRew268XCfrustVdMZ3E
         Nkag==
X-Gm-Message-State: AOAM531ZuCMUgxWFprbViEms+Pi9ShpxKJaVr//2Hj6HkahR0QrsbAwn
        2+OUoOeGI1l2V3Bnxq3COytTLA==
X-Google-Smtp-Source: ABdhPJxHRgAYE/gGW7hwehOpCGLV4nafnC3fnk24fHbDceASODAgq3mqh5UXHDn4SKCox6Wle6MkbA==
X-Received: by 2002:a62:b606:0:b029:1ec:ecf1:cc5 with SMTP id j6-20020a62b6060000b02901ececf10cc5mr1851762pff.62.1614751338218;
        Tue, 02 Mar 2021 22:02:18 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x11sm6131088pjh.0.2021.03.02.22.02.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:02:17 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 5/5] mm: memcontrol: use remote objcg charging APIs to charge kernel memory
Date:   Wed,  3 Mar 2021 13:59:17 +0800
Message-Id: <20210303055917.66054-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210303055917.66054-1-songmuchun@bytedance.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of remote memory cgroup charging (e.g. bpf and fsnotify)
can switch to the remote objcg charging APIs. Because they just want
to charge kernel memory to the remote memcg. Finally, all the kernel
memory are charged by using obj_cgroup APIs and do not hold a refcount
to the memory cgroup. It can prevent long-living objects from pinning
the original memory cgroup in the memory efficiently.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/buffer.c                          | 10 ++++++---
 fs/notify/fanotify/fanotify.c        |  6 +++---
 fs/notify/fanotify/fanotify_user.c   |  2 +-
 fs/notify/group.c                    |  3 ++-
 fs/notify/inotify/inotify_fsnotify.c |  8 ++++----
 fs/notify/inotify/inotify_user.c     |  2 +-
 include/linux/bpf.h                  |  2 +-
 include/linux/fsnotify_backend.h     |  2 +-
 include/linux/memcontrol.h           | 15 ++++++++++++++
 kernel/bpf/syscall.c                 | 35 ++++++++++++++++----------------
 mm/memcontrol.c                      | 39 +++++++++++++++++++++++++++++++++---
 11 files changed, 89 insertions(+), 35 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 591547779dbd..6915195b1a70 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -842,14 +842,16 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	struct buffer_head *bh, *head;
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
 	long offset;
-	struct mem_cgroup *memcg, *old_memcg;
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg, *old_objcg;
 
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
 	/* The page lock pins the memcg */
 	memcg = page_memcg(page);
-	old_memcg = set_active_memcg(memcg);
+	objcg = get_obj_cgroup_from_mem_cgroup(memcg);
+	old_objcg = set_active_objcg(objcg);
 
 	head = NULL;
 	offset = PAGE_SIZE;
@@ -868,7 +870,9 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
+	if (objcg)
+		obj_cgroup_put(objcg);
 	return head;
 /*
  * In case anything failed, we just free everything we got.
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1192c9953620..d4ca37b85c56 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -530,7 +530,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	struct mem_cgroup *old_memcg;
+	struct obj_cgroup *old_objcg;
 	struct inode *child = NULL;
 	bool name_event = false;
 
@@ -580,7 +580,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
-	old_memcg = set_active_memcg(group->memcg);
+	old_objcg = set_active_objcg(group->objcg);
 
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
@@ -608,7 +608,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event->pid = get_pid(task_tgid(current));
 
 out:
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
 	return event;
 }
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9e0c1afac8bd..055ca36d4e0e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -985,7 +985,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->fanotify_data.user = user;
 	group->fanotify_data.flags = flags;
 	atomic_inc(&user->fanotify_listeners);
-	group->memcg = get_mem_cgroup_from_mm(current->mm);
+	group->objcg = get_obj_cgroup_from_current();
 
 	group->overflow_event = fanotify_alloc_overflow_event();
 	if (unlikely(!group->overflow_event)) {
diff --git a/fs/notify/group.c b/fs/notify/group.c
index ffd723ffe46d..fac46b92c16f 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -24,7 +24,8 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
 	if (group->ops->free_group_priv)
 		group->ops->free_group_priv(group);
 
-	mem_cgroup_put(group->memcg);
+	if (group->objcg)
+		obj_cgroup_put(group->objcg);
 	mutex_destroy(&group->mark_mutex);
 
 	kfree(group);
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 1901d799909b..ece6dd561659 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -66,7 +66,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	int ret;
 	int len = 0;
 	int alloc_len = sizeof(struct inotify_event_info);
-	struct mem_cgroup *old_memcg;
+	struct obj_cgroup *old_objcg;
 
 	if (name) {
 		len = name->len;
@@ -81,12 +81,12 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 
 	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
-	 * trigger OOM killer in the target monitoring memcg as it may have
+	 * trigger OOM killer in the target monitoring objcg as it may have
 	 * security repercussion.
 	 */
-	old_memcg = set_active_memcg(group->memcg);
+	old_objcg = set_active_objcg(group->objcg);
 	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
 
 	if (unlikely(!event)) {
 		/*
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c71be4fb7dc5..5b4de477fcac 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -649,7 +649,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	oevent->name_len = 0;
 
 	group->max_events = max_events;
-	group->memcg = get_mem_cgroup_from_mm(current->mm);
+	group->objcg = get_obj_cgroup_from_current();
 
 	spin_lock_init(&group->inotify_data.idr_lock);
 	idr_init(&group->inotify_data.idr);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cccaef1088ea..b6894e3cd095 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -158,7 +158,7 @@ struct bpf_map {
 	u32 btf_value_type_id;
 	struct btf *btf;
 #ifdef CONFIG_MEMCG_KMEM
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
 	u32 btf_vmlinux_value_type_id;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index e5409b83e731..d0303f634da6 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -220,7 +220,7 @@ struct fsnotify_group {
 						 * notification list is too
 						 * full */
 
-	struct mem_cgroup *memcg;	/* memcg to charge allocations */
+	struct obj_cgroup *objcg;	/* objcg to charge allocations */
 
 	/* groups can define private fields here or use the void *private */
 	union {
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5911b9d107b0..d5a286e3394f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1643,6 +1643,7 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
+struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg);
 struct obj_cgroup *get_obj_cgroup_from_current(void);
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
@@ -1693,6 +1694,20 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 struct mem_cgroup *mem_cgroup_from_obj(void *p);
 
 #else
+static inline
+struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
+
+static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+	return NULL;
+}
+
+static inline void obj_cgroup_put(struct obj_cgroup *objcg)
+{
+}
 
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c859bc46d06c..0703dc94cb30 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -390,37 +390,38 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static void bpf_map_save_memcg(struct bpf_map *map)
+static void bpf_map_save_objcg(struct bpf_map *map)
 {
-	map->memcg = get_mem_cgroup_from_mm(current->mm);
+	map->objcg = get_obj_cgroup_from_current();
 }
 
-static void bpf_map_release_memcg(struct bpf_map *map)
+static void bpf_map_release_objcg(struct bpf_map *map)
 {
-	mem_cgroup_put(map->memcg);
+	if (map->objcg)
+		obj_cgroup_put(map->objcg);
 }
 
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node)
 {
-	struct mem_cgroup *old_memcg;
+	struct obj_cgroup *old_objcg;
 	void *ptr;
 
-	old_memcg = set_active_memcg(map->memcg);
+	old_objcg = set_active_objcg(map->objcg);
 	ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
 
 	return ptr;
 }
 
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 {
-	struct mem_cgroup *old_memcg;
+	struct obj_cgroup *old_objcg;
 	void *ptr;
 
-	old_memcg = set_active_memcg(map->memcg);
+	old_objcg = set_active_objcg(map->objcg);
 	ptr = kzalloc(size, flags | __GFP_ACCOUNT);
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
 
 	return ptr;
 }
@@ -428,22 +429,22 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags)
 {
-	struct mem_cgroup *old_memcg;
+	struct obj_cgroup *old_objcg;
 	void __percpu *ptr;
 
-	old_memcg = set_active_memcg(map->memcg);
+	old_objcg = set_active_objcg(map->objcg);
 	ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
 
 	return ptr;
 }
 
 #else
-static void bpf_map_save_memcg(struct bpf_map *map)
+static void bpf_map_save_objcg(struct bpf_map *map)
 {
 }
 
-static void bpf_map_release_memcg(struct bpf_map *map)
+static void bpf_map_release_objcg(struct bpf_map *map)
 {
 }
 #endif
@@ -454,7 +455,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
 	security_bpf_map_free(map);
-	bpf_map_release_memcg(map);
+	bpf_map_release_objcg(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
 }
@@ -877,7 +878,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_sec;
 
-	bpf_map_save_memcg(map);
+	bpf_map_save_objcg(map);
 
 	err = bpf_map_new_fd(map, f_flags);
 	if (err < 0) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e48d4ab0af76..367d1a485292 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3023,6 +3023,22 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return page_memcg_check(page);
 }
 
+struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg = NULL;
+
+	rcu_read_lock();
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+		objcg = NULL;
+	}
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct obj_cgroup *objcg;
@@ -5356,16 +5372,33 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	return ERR_PTR(error);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static inline struct obj_cgroup *memcg_obj_cgroup(struct mem_cgroup *memcg)
+{
+	return memcg ? memcg->objcg : NULL;
+}
+#else
+static inline struct obj_cgroup *memcg_obj_cgroup(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
+#endif
+
 static struct cgroup_subsys_state * __ref
 mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
-	struct mem_cgroup *memcg, *old_memcg;
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *old_objcg;
 	long error = -ENOMEM;
 
-	old_memcg = set_active_memcg(parent);
+	/*
+	 * The @parent cannot be offlined, so @parent->objcg cannot be freed
+	 * under us.
+	 */
+	old_objcg = set_active_objcg(memcg_obj_cgroup(parent));
 	memcg = mem_cgroup_alloc();
-	set_active_memcg(old_memcg);
+	set_active_objcg(old_objcg);
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
 
-- 
2.11.0

