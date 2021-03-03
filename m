Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB932BAD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbhCCMDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451336AbhCCGCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:02:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B39C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:02:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso2367453pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F82I5iLp8QFjgHMvqeGaLr+bXfCpx3cOa12t/BoWkUc=;
        b=V4sz59O76soBeKy1MtglLuevbONhfDwYgKBjaM6jRAq5iGUyXxuhFVAubUttj4Qaq2
         eGQX8LQEEdLLnXDwgCwkwozmk5FnEcYk4fbUYIn1gPCBwWEQLJoGhaVfm/GpyBQWCFHL
         QMd45GCGTuAJfq5IyUuyUlmJxISaYqTi6ry4Nv6eKBD7/fRMCJA4UUkyiK16h6HNmq0z
         QPwHG4yKBTbj6BVvkcmRZcXBQ3mKRuKMf2ECWHcV/AcRModiP+2oaDmqXku4j4DwRZ0Y
         cF6TgUO2s+Fy+T5U1bwwwkeRHCaBUGolgLjyv4tit6qRB0qVLG/fp8tkJd8akHV7n6BC
         2Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F82I5iLp8QFjgHMvqeGaLr+bXfCpx3cOa12t/BoWkUc=;
        b=HDuwiXdbatbnvWtE5KbFnMaqJ8fVoH9yuaxYfuLfd07Ouyl1+TXhCKcJusDXr/6vkj
         Foxfyn/XHNTgivQ7Zs7D3Q1WnYnw/NA4qGW45lsDUgLqYqau7Bm6GoEvIYKVgjj0ZxMP
         Zq7ttq8TP7R0pntaJs6DWNcpt9zXGj9GnR6uLWsYX20SRTxEeD0ArK+Vej7LQsJSFo67
         Q2kO58Koct/r04dZ0r9CLHq13ZpNXB8Ot+38y17lT4UBATH06r76xFGIrFbjZWcqrMek
         tyEhAYe27IPfqov6e03lrZ4HpwnSq0lhA0CYoz6z0nRK4ZJVql8dhI+eILDrKQICikrJ
         J6zg==
X-Gm-Message-State: AOAM5307ZfZ3IZmCEZE03OCM7rW/q2ORLBumXhICkGUWKXYN9WGkjFbS
        FivIQ3PuyyEO9kgDF9UVkF3iRw==
X-Google-Smtp-Source: ABdhPJxuvuQPCxWld98PGk2EfLaYsZ+wBxAcY5gKqkYYX2FVRttJA3tsDjGtOfGjpWzxBRS47UAmrA==
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr8063126pjb.9.1614751319812;
        Tue, 02 Mar 2021 22:01:59 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x11sm6131088pjh.0.2021.03.02.22.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:01:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/5] mm: memcontrol: introduce obj_cgroup_{un}charge_page
Date:   Wed,  3 Mar 2021 13:59:13 +0800
Message-Id: <20210303055917.66054-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210303055917.66054-1-songmuchun@bytedance.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know that the unit of slab object charging is bytes, the unit of
kmem page charging is PAGE_SIZE. If we want to reuse obj_cgroup APIs
to charge the kmem pages, we should pass PAGE_SIZE (as third parameter)
to obj_cgroup_charge(). Because the size is already PAGE_SIZE, we can
skip touch the objcg stock. And obj_cgroup_{un}charge_page() are
introduced to charge in units of page level.

In the later patch, we also can reuse those two helpers to charge or
uncharge a number of kernel pages to a object cgroup. This is just
a code movement without any functional changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 845eec01ef9d..faae16def127 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3056,6 +3056,34 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
 
+static inline void obj_cgroup_uncharge_page(struct obj_cgroup *objcg,
+					    unsigned int nr_pages)
+{
+	rcu_read_lock();
+	__memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
+	rcu_read_unlock();
+}
+
+static int obj_cgroup_charge_page(struct obj_cgroup *objcg, gfp_t gfp,
+				  unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	rcu_read_lock();
+retry:
+	memcg = obj_cgroup_memcg(objcg);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
+
+	css_put(&memcg->css);
+
+	return ret;
+}
+
 /**
  * __memcg_kmem_charge: charge a number of kernel pages to a memcg
  * @memcg: memory cgroup to charge
@@ -3180,11 +3208,8 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
-		if (nr_pages) {
-			rcu_read_lock();
-			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
-			rcu_read_unlock();
-		}
+		if (nr_pages)
+			obj_cgroup_uncharge_page(old, nr_pages);
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3242,7 +3267,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 {
-	struct mem_cgroup *memcg;
 	unsigned int nr_pages, nr_bytes;
 	int ret;
 
@@ -3259,24 +3283,16 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
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
+	ret = obj_cgroup_charge_page(objcg, gfp, nr_pages);
 	if (!ret && nr_bytes)
 		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
 
-	css_put(&memcg->css);
 	return ret;
 }
 
-- 
2.11.0

