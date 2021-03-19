Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEF342210
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhCSQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:38:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C3AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso6954049pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tK2Kyn55J1ACRGVq+2xCPNndPw6tNbpgN30+dQ6cs1M=;
        b=KlDrOsu3HXjqYEWfzW96OEELxMjlB+S8Aw6bTHI/LlQiy+ywS0J0DShcNA93lHkM20
         OEDgjQOwtPsJk8R+HGZ7/R5Z4Qaa5HW6Ut14J7eJydjrNJsvIBRzHHOxwWcAe3dqzTh8
         cNhr3GysdJxDaMDmOO1krGskM3Azh4LgDVPkBOehY+AILcU0bRItR3ZUqpYK0nbPg7qs
         deAZyDUWNtlbSriVmMeFcqsBGT/Ku27az6BYsrWqaJbxzZAYWeKz4s6pjgk9S30+jCY+
         w/g8nP1rCZoTV6mkO6zVygUphY7HbszeLo8MZ0L6M0qi88MJU8PBPGF2AQVVWTnrvZ9/
         zyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tK2Kyn55J1ACRGVq+2xCPNndPw6tNbpgN30+dQ6cs1M=;
        b=IwWTuqeMgDOoDVsBCE3s6qX5nbFNn+KW8clV2dvB7w2CM7JVkeeTLfV7ddCYQGqZoh
         jknXpY7N6JGufMIEs7nsalzOwMphVcNd1fYl8rEJqNrRP7ymYWUK4lTNuEztv0oNVKFz
         deSKnkA1kHru6zeegrpWdO1a4oK1QJIfXn5ep2YvWuQceyU5AVQzzARBEOS89Rj3UX/5
         Q0LXV3v2TuWLKgky6SrQA0yTWt9HOYA4AoEsfMeS30d/t+qhus6yZWZS648QhAwmzOSu
         +nSF/3qgAeTCfP91uGnBYd2OHyeAOv/sUrJjX0qdvn+fQNsjjYwmxx0kOcVwm3Kzw4MG
         oH4g==
X-Gm-Message-State: AOAM533zs1hq/koeptSBysENxua7h6E6/FNmN/wqNWn3P524fimdWca3
        Fu/C2wCzS+wUAkDIegTzIK+Gew==
X-Google-Smtp-Source: ABdhPJyO9aDWXR5ZTvV+MBsj7/ZU9SJfeDhvcDMisicQWhb4extbGfdF6avKGjschmd5J381U6rN2w==
X-Received: by 2002:a17:90b:284:: with SMTP id az4mr10684970pjb.12.1616171926457;
        Fri, 19 Mar 2021 09:38:46 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:38:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 2/7] mm: memcontrol: introduce obj_cgroup_{un}charge_pages
Date:   Sat, 20 Mar 2021 00:38:15 +0800
Message-Id: <20210319163821.20704-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know that the unit of slab object charging is bytes, the unit of
kmem page charging is PAGE_SIZE. If we want to reuse obj_cgroup APIs
to charge the kmem pages, we should pass PAGE_SIZE (as third parameter)
to obj_cgroup_charge(). Because the size is already PAGE_SIZE, we can
skip touch the objcg stock. And obj_cgroup_{un}charge_pages() are
introduced to charge in units of page level.

In the later patch, we also can reuse those two helpers to charge or
uncharge a number of kernel pages to a object cgroup. This is just
a code movement without any functional changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 63 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2cda76ff0629..9489c7fc1e04 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2905,6 +2905,20 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	page->memcg_data = (unsigned long)memcg;
 }
 
+static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = obj_cgroup_memcg(objcg);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
@@ -3056,6 +3070,29 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
 
+static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+				      unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	__memcg_kmem_uncharge(memcg, nr_pages);
+	css_put(&memcg->css);
+}
+
+static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
+				   unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
+	css_put(&memcg->css);
+
+	return ret;
+}
+
 /**
  * __memcg_kmem_charge: charge a number of kernel pages to a memcg
  * @memcg: memory cgroup to charge
@@ -3180,19 +3217,8 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
-		if (nr_pages) {
-			struct mem_cgroup *memcg;
-
-			rcu_read_lock();
-retry:
-			memcg = obj_cgroup_memcg(old);
-			if (unlikely(!css_tryget(&memcg->css)))
-				goto retry;
-			rcu_read_unlock();
-
-			__memcg_kmem_uncharge(memcg, nr_pages);
-			css_put(&memcg->css);
-		}
+		if (nr_pages)
+			obj_cgroup_uncharge_pages(old, nr_pages);
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3250,7 +3276,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 {
-	struct mem_cgroup *memcg;
 	unsigned int nr_pages, nr_bytes;
 	int ret;
 
@@ -3267,24 +3292,16 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 	 * refill_obj_stock(), called from this function or
 	 * independently later.
 	 */
-	rcu_read_lock();
-retry:
-	memcg = obj_cgroup_memcg(objcg);
-	if (unlikely(!css_tryget(&memcg->css)))
-		goto retry;
-	rcu_read_unlock();
-
 	nr_pages = size >> PAGE_SHIFT;
 	nr_bytes = size & (PAGE_SIZE - 1);
 
 	if (nr_bytes)
 		nr_pages += 1;
 
-	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
+	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
 	if (!ret && nr_bytes)
 		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
 
-	css_put(&memcg->css);
 	return ret;
 }
 
-- 
2.11.0

