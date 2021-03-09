Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125D933229C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCIKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhCIKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:08:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B39C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:08:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so749882pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xRtOftBY21GmUXexhKrE28MdVkLxMN/4d1pu6nQNN8=;
        b=hNN+YWXsXLksN60dbLKXBQX/Cr3xJeGMf8V9dDcTek5cnogE3TtAGDMc3A0hfQjAQK
         ptq0q98JTymuZscsMw22tAcLajmKNCXhaVpyyMrB45echJ5fsE8ii9LpZhcV4m8bmJ3C
         pIyBlpp4wxRph7jyxmcNKKhFnaraIygRCeR3W7SlyXSc80tNM1OONpbUkTegUuP5Y41z
         M5Xu+rXq7gWvRCtsHvDzurR5CfYliql7xabiCkg9UBLh0Jr6QYB+CXorIHJ45IOVCFO/
         NSe7qeVKLdEmvH2yb7mkthh2wA+EXNzcwnYL1rkXu6hIe+f3w5jov0yey1zgq2mEx/e7
         KStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xRtOftBY21GmUXexhKrE28MdVkLxMN/4d1pu6nQNN8=;
        b=oDkDKKdh+nB4nMaNP1Bp81li7hR9Kzx24v+diyGTCAl6QPeznBFo6OENkE8r9YkLXu
         zVrfk72vlITW92rEVGBjkpUtg+N1SovNMQpEAuKY9MU0xwWmR4esZdjkM0QD9dM2E+MW
         Aca4NzJwwpnSHQ8lXEpG4HhGtAAkrMW63zAWoLUiYMAZi2RXJKAlH+CwqMGsUMr/GqLq
         M1iZhpSes1dJ54+cA6qvKITeDpNLPLgQjxBzvqNfjafP9gIguUo05VQJN0LOxzbYa8tA
         Mgzrk2NW36+IRBT6hVKKgcN9LQBmZymggV3OPxD1jFI0IumXQ3bDiM0BKe+Fi/f2FsUC
         m60A==
X-Gm-Message-State: AOAM531g0sVhZkABbgLsz5JlKIJdRy/DmW+p1NdFHukZ5vsBTACYvdws
        F+2gG2xzXOF8z07RvXKg2NDvow==
X-Google-Smtp-Source: ABdhPJxTskKRWtRP87imNGgOSe6VfN1ZIrQZB+dUhFMW12WPfJFOTaBXUG1v5Z1VyOWKJJW4mZfgyQ==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr3935153pjo.61.1615284539383;
        Tue, 09 Mar 2021 02:08:59 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id a70sm9258424pfa.202.2021.03.09.02.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 02:08:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/4] mm: memcontrol: introduce obj_cgroup_{un}charge_pages
Date:   Tue,  9 Mar 2021 18:07:14 +0800
Message-Id: <20210309100717.253-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210309100717.253-1-songmuchun@bytedance.com>
References: <20210309100717.253-1-songmuchun@bytedance.com>
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

