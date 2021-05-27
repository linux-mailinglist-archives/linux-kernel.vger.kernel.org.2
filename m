Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F139279A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhE0G26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhE0G2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:28:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E4AC061352
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:26:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f8so98546pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93dDqyeWkKnQFRCldXYX+fDzer/GYrGyPOg9jpoyqVw=;
        b=Nk9bXw59X2fysUcGQbiJMRbXMwzRloCfTMmf3h085vLvhUOQeTEj2ksEGX73TEk4bK
         Kz08lppd8dGTEaRfD8bBIiUOOK66s4TnKXwycowV3NGBegFdDfHQrPGDzdG+Coqgbgwq
         lRd+c+DWMv6Y8nEwvBB+32DzLORgDxngetMIIjI0HnbSpPzlVs1plFXdOKSCZj/wvx+h
         xXNth7QnMMfQgMkd3Te6l1EaPrWTDQmxAQn90dqYPGiocbYkCkS9rco3A3K+7iPQd/Eo
         1s9b+z8z7cY/PdTna6AhelSJ9qtnpNHvhvFJD+L9PQxlrFFzKzoz0ICM0wEQ3D+Uk2dM
         yc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93dDqyeWkKnQFRCldXYX+fDzer/GYrGyPOg9jpoyqVw=;
        b=d2Hbnck11Moe+5ZPTwNcnaedg88B4vY2IieuoSFHzZfOKNHJQ++86O8y7ZDGRDbwBB
         RqubN1T+b5CD3tBg/uUzrUXaTl3XotiNF1UU5H+rnwveKwYmxxXHIYEathCPAjb7g1Ep
         OgLPg3IjbWKuBQB0uVmd+Tv4vP6MHdjjHCB9ipo4MevgRZISKhbTuh2nka9NkMw0S4hb
         k4BWJFYY19Hb0lvkv1wjmNUYbTQqRA96WbNivd44vPqUk/PU+E+7v+ldLBvNqlXVEA8Y
         fktw4QJRUN48FyI/nGtC8v+k42GfNAmIIWAHT/Ib0pkziaE6gPvLz3xMmcwBjNxEmqf/
         IdGw==
X-Gm-Message-State: AOAM532maS8V6iv8ngwt3DGG1zqn2NQDdlzSorbrTbl3nDlH9Kf6bdvJ
        tH+Lf4TJjq49cQNloVXfoA9uQQ==
X-Google-Smtp-Source: ABdhPJw5QU0YZIs70xkXlCIuCRFp/pljdG9zXUyMmIfOzkQiMS+SEzkpZQ4ufkNhu7bF4YXppazbQQ==
X-Received: by 2002:a17:903:1cd:b029:f0:c1c2:9e75 with SMTP id e13-20020a17090301cdb02900f0c1c29e75mr1808657plh.54.1622096802991;
        Wed, 26 May 2021 23:26:42 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:42 -0700 (PDT)
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
Subject: [PATCH v2 20/21] mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
Date:   Thu, 27 May 2021 14:21:47 +0800
Message-Id: <20210527062148.9361-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before now, the name of list_lru_memcg was occupied. Since previous
patch, the name is free. So rename list_lru_per_memcg to list_lru_memcg,
it is more brief.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index d7c9bd29e836..7497719ec71c 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,7 +32,7 @@ struct list_lru_one {
 	long			nr_items;
 };
 
-struct list_lru_per_memcg {
+struct list_lru_memcg {
 	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
 	struct list_lru_one	nodes[];
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 37052864bf78..77efdd0c8b24 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -52,7 +52,7 @@ static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
-		struct list_lru_per_memcg *mlru = xa_load(lru->xa, idx);
+		struct list_lru_memcg *mlru = xa_load(lru->xa, idx);
 
 		return mlru ? &mlru->nodes[nid] : NULL;
 	}
@@ -304,7 +304,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
 				      nr_to_walk);
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		unsigned long index;
 
 		xa_for_each(lru->xa, index, mlru) {
@@ -331,10 +331,10 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
+static struct list_lru_memcg *memcg_list_lru_alloc(gfp_t gfp)
 {
 	int nid;
-	struct list_lru_per_memcg *lru;
+	struct list_lru_memcg *lru;
 
 	lru = kmalloc(struct_size(lru, nodes, nr_node_ids), gfp);
 	if (!lru)
@@ -348,7 +348,7 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_per_memcg *mlru = xa_erase_irq(lru->xa, src_idx);
+	struct list_lru_memcg *mlru = xa_erase_irq(lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -378,7 +378,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	XA_STATE(xas, lru->xa, 0);
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
@@ -483,7 +483,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	int i, ret = 0;
 
 	struct list_lru_memcg_table {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
 
@@ -494,7 +494,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 		return 0;
 
 	/*
-	 * The allocated list_lru_per_memcg array is not accounted directly.
+	 * The allocated list_lru_memcg array is not accounted directly.
 	 * Moreover, it should not come from DMA buffer and is not readily
 	 * reclaimable. So those GFP bits should be masked off.
 	 */
@@ -506,7 +506,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
 	 * list_lru, we should make sure that this cgroup and all its
-	 * ancestors have allocated list_lru_per_memcg.
+	 * ancestors have allocated list_lru_memcg.
 	 */
 	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
 		if (memcg_list_lru_skip_alloc(lru, memcg))
@@ -525,7 +525,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = memcg_cache_id(table[i].memcg);
-		struct list_lru_per_memcg *mlru = table[i].mlru;
+		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
 retry:
-- 
2.11.0

