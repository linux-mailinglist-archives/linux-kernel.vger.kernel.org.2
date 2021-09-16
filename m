Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7A40DBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhIPNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbhIPNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B6C061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q68so6195164pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emzGgoQOnssPsBkzbuXL55Ev35q8xqQFOv8WuqwIjZE=;
        b=UUepn9rHGU0nXbviWK71cXLbiy3WYzBnnpHawMSiaeJZAk0nHTcl/tMUxPuf7W4E0c
         ZW7Cit53xZBc8ov3qoWPaCC5bRFmCBSL3OIOmd3J7eu4QAwoGVMLu42oOKo6TBRUgmzY
         Ve3GxknG7fDJ94IZdCDPeZ8GxuOAp+B8k6IsUUZPNwWOgZX6lsQIqMdA+qsHyAJl1w9q
         AK3pZ9xr+wKMiQ53oyLEGcof87i+LWxB7hqReWzY7ak/3tsZhAkC6hWHOIijfq5d2USK
         8Ii8mDcqAw/pdQN9LsEkpFTSPLRtmrMb9q58fxgR5BIWfh6LI70/mdEnDlqLZriMF0vb
         TXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emzGgoQOnssPsBkzbuXL55Ev35q8xqQFOv8WuqwIjZE=;
        b=y609o1nEDOGF+tpDeiwPGg4gV9d3kj9nvjnqRmXnRWGwkB//+0p91I52DIG3Racb9q
         tVegxH6m0AEmaHWD6lhoYoIY7aWAEQkZ3KQ3lLdwwArSZXJsQmhR0tHWsi95XArMVV5n
         Y5rWvTVnLdeX5mJF5NxabT9RvATVk8NtPJcjxGoNxLVKm2zuV89sCadAhgyhFEs0mNFi
         NASXQnXTXoFU4swgWp1YVSC5Xb0pCeoJP2YKNIdHQM5ZgR6xb//FOl6CEvhTuORVXG3w
         n39RMkK0RhSPpg2k7denPlz526LmYRCwg1uKqnGhGy2T1u8x8UM6lV8zmotFtt2JvH8D
         uj1g==
X-Gm-Message-State: AOAM531/Pe0VhSyhSSoX+o1iUbJJhcC+t7ChaTTYsKRrQzTC1ZNpMskK
        0EOtF9B/2fvrfY4daz5XiGDtWw==
X-Google-Smtp-Source: ABdhPJz+/bQHjro14FEEsTQjuOXbu6Tbg3dK0yLwJP7VQvx5HnZiCjNaoIlN/+bo9hEBsCrcPR5xIA==
X-Received: by 2002:a62:ae13:0:b0:440:385c:2ee9 with SMTP id q19-20020a62ae13000000b00440385c2ee9mr5637538pff.39.1631800334233;
        Thu, 16 Sep 2021 06:52:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 01/13] mm: move mem_cgroup_kmem_disabled() to memcontrol.h
Date:   Thu, 16 Sep 2021 21:47:36 +0800
Message-Id: <20210916134748.67712-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup_memory_nokmem is already a global variable, it is unnecessary
to define a global function of mem_cgroup_kmem_disabled(). Just move it
to memcontrol.h and mark inline on it. slab_common.c already includes
memcontrol.h, replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 8 +++++++-
 mm/internal.h              | 5 -----
 mm/memcontrol.c            | 5 -----
 mm/slab_common.c           | 2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3096c9a0ee01..e194d90aff56 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1639,7 +1639,13 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 #endif
 
 #ifdef CONFIG_MEMCG_KMEM
-bool mem_cgroup_kmem_disabled(void);
+extern bool cgroup_memory_nokmem;
+
+static inline bool mem_cgroup_kmem_disabled(void)
+{
+	return cgroup_memory_nokmem;
+}
+
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
diff --git a/mm/internal.h b/mm/internal.h
index cf3cb933eba3..649684e20fe4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -116,11 +116,6 @@ extern void putback_lru_page(struct page *page);
 extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
 
 /*
- * in mm/memcontrol.c:
- */
-extern bool cgroup_memory_nokmem;
-
-/*
  * in mm/page_alloc.c
  */
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b762215d73eb..528b134ca50c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -264,11 +264,6 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
-bool mem_cgroup_kmem_disabled(void)
-{
-	return cgroup_memory_nokmem;
-}
-
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..4c0549e0f349 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -857,7 +857,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 	if (type == KMALLOC_RECLAIM) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
-		if (cgroup_memory_nokmem) {
+		if (mem_cgroup_kmem_disabled()) {
 			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
 			return;
 		}
-- 
2.11.0

