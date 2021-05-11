Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EDE37A52D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhEKKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhEKKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:54:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743AEC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:53:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v11-20020a17090a6b0bb029015cba7c6bdeso877621pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8N5ZUdYb8l/oRbGA6g7N4k0yzncAYFXCS7KEjhs0TU=;
        b=pE/EHpen5n4IYXpbRh8rAp8XuzT/8oWVSC4E6SwrUfStEJI8TITTEghKAeCrkLNFZI
         Q8U/OIBh/EJ3sZqvIvd5t2PPwjaw5PX1aWZcJlv0aAEG3q+uY3KUEf6xwBywKBp4OF9c
         vDT2wtI7BsdYMX6ltbRtlTC9hmlJ+l0O8yefFrC+65WYut3Dx+8hIHmi6kbs3CLdenAi
         jf89YMOOS1MDOlKuWkBLfqpSAjwKzqBuIZWoD/Lz8cXePLeDTZ1fkT9ELjjIMsv5UFOV
         b25XostjxyOgCTo4y5Mz/UwLe4pnqKJkCC++Gs65Y0p46H27uIpS3V9j29mk4eFuLgcV
         O3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8N5ZUdYb8l/oRbGA6g7N4k0yzncAYFXCS7KEjhs0TU=;
        b=ttoN+5mmm7JQZfIV4j3XB3nR+xUN2AX8FdS5uzeLBK3gQljqd3176X5tlrszPIglc8
         cUqjMc/prCC9K4W1RBhP7yMN+BuVizqWjAgGevTGCzgvXRF7sH1is2Yt9eRu3DtwrgEQ
         iKR/Bx6WZYg/aIDzGZRI5xKUeQVSmFMI2ZUfukEA2QMCb2DNUQCryA5kyqodzsvT1bij
         7SGE1O4NxN6eqlxqCa+BTotMiOGzMsC6K62hWKgWZYAVO7B+zyhHgwCxY17slqBQYxFM
         5J0wJHVZB1pXich1oCnLGHxlY05gvVfnYv/D+YlAIkbqIdlDoAEjRn/KEG5SCsf1WyHK
         2ztg==
X-Gm-Message-State: AOAM533D5BgfqFZDkS0Y4rl48ktHdBIXSjLVigpF1awad6j/C6dOVULl
        idavow6BQMQFCrLIRjwEDjG9gw==
X-Google-Smtp-Source: ABdhPJyh1wXx5mYfbkgRhiGJmuigd7/EclP3NGsv7ZdHfD+hX+newjmF7fotu22j9mscSwJYcjyXXQ==
X-Received: by 2002:a17:902:e804:b029:ed:5748:9047 with SMTP id u4-20020a170902e804b02900ed57489047mr29202382plg.36.1620730394053;
        Tue, 11 May 2021 03:53:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.53.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:53:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 16/17] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Tue, 11 May 2021 18:46:46 +0800
Message-Id: <20210511104647.604-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the memcg_drain_all_list_lrus() is list_lrus reparenting.
It is very similar to memcg_reparent_objcgs(). Rename it to
memcg_reparent_list_lrus() so that the name can more consistent with
memcg_reparent_objcgs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  3 +--
 mm/list_lru.c            | 19 +++++++++----------
 mm/memcontrol.c          |  4 ++--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 7d4346b93b24..9222d0295d30 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -76,8 +76,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index b5ed6b797a48..6d7ae24a4a70 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -440,8 +440,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -491,22 +491,21 @@ static void list_lru_per_memcg_free(struct list_lru *lru, int src_idx)
 		kvfree_rcu(mlru, rcu);
 }
 
-static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru(struct list_lru *lru,
+				    int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+		memcg_reparent_list_lru_node(lru, i, src_idx, dst_memcg);
 
 	list_lru_per_memcg_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct list_lru *lru;
-	int src_idx = src_memcg->kmemcg_id;
+	int src_idx = memcg->kmemcg_id;
 
 	/*
 	 * Change kmemcg_id of this cgroup to the parent's id, and then move
@@ -519,11 +518,11 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
 	 * from allocating list lrus for this cgroup after calling
 	 * list_lru_per_memcg_free().
 	 */
-	src_memcg->kmemcg_id = dst_memcg->kmemcg_id;
+	memcg->kmemcg_id = parent->kmemcg_id;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_memcg);
+		memcg_reparent_list_lru(lru, src_idx, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 879d2ff8d81f..02a65ff3b77a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3485,14 +3485,14 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
 	 * Cache it to @kmemcg_id.
 	 */
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
 	/* memcg_reparent_objcgs() must be called before this. */
-	memcg_drain_all_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

