Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF43340435
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhCRLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhCRLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:08:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so2959246pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TztOCzATA+pN2UcYbo781lidO/cJKiaIDTOpooZzWOI=;
        b=RtHjb3BEb634rw2cRzq5x6Cpc7DPO5fSxKMhj7AjrplO2Bz+w0XXQkEd0hqkubYAVS
         ITNb907kk8Gybnptayw8r+iyL0/WLT/dBCbZ29VazpJweqObDgC8KJ1+z8owlzrHicDm
         rgs7L226KXoRR+diND4hyWRgPtkABJvkia/mq6fvYUqPVmEaXKfst1bUPCT2Y74BrkF3
         U93aOvrxUcsf1F/jyHEu99pJW3LO6/v8ekeFGITRfy0DwTsY38d8X2WyLtRiR+/nB3Ao
         ZZxYTYm70kbQJw7KMfCZ5JllTpaH4+CKBow6PzCuobo70034iMKzMNjSQLzBr57NxBgQ
         xotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TztOCzATA+pN2UcYbo781lidO/cJKiaIDTOpooZzWOI=;
        b=lKvCspqliwVdXeqP5TOTjGdu6rxepY30AAJh+Xzhpmy9H8CyOOLFWXDL3SvLsbDCCW
         b9xprndCFV05ytaVGBU7Q3zrb45upSpU9oVoOWNPB2+VHGXZh7KvUbYJNnDceeUnj0qT
         A74C4Itn3fULpDDxiIzmD/7k7H8A+Mra9qTWISDnraMu0PvAU8Ekp8RaVXjhqgm3ADko
         lRrOvhWU2aysW0IUmHaohGKhZa/fIpGq+BD5olk04bq6kJflivvsxXHTbz2xmAy0cp6l
         isUd2a/e8wJ5vVMYorkeId5AnAgA2gRPA++5DWW+hQySms51YKH/tYpw4M3KdoSD8qA+
         NpJw==
X-Gm-Message-State: AOAM530fxLqBQYtODbP4dhcWCVbgIhRayUhbaNk2ITtT64nM3ApoXn8u
        9nN52Tk6eBObHR4MxjfafUNgqg==
X-Google-Smtp-Source: ABdhPJyZog8X8qd5W2MX+ZfV1meTNzZkWX9hR1wGICdHzPhctAPATP7EEG9rfk75V5HElX1wtb3fhA==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr3740453pjp.227.1616065710773;
        Thu, 18 Mar 2021 04:08:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e21sm1779509pgv.74.2021.03.18.04.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:08:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/5] mm: memcontrol: introduce obj_cgroup_{un}charge_pages
Date:   Thu, 18 Mar 2021 19:06:54 +0800
Message-Id: <20210318110658.60892-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210318110658.60892-1-songmuchun@bytedance.com>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
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
 mm/memcontrol.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 845eec01ef9d..fc22da9805fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3056,6 +3056,34 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
 
+static inline void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+					     unsigned int nr_pages)
+{
+	rcu_read_lock();
+	__memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
+	rcu_read_unlock();
+}
+
+static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
+				   unsigned int nr_pages)
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
+			obj_cgroup_uncharge_pages(old, nr_pages);
 
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
+	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
 	if (!ret && nr_bytes)
 		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
 
-	css_put(&memcg->css);
 	return ret;
 }
 
-- 
2.11.0

