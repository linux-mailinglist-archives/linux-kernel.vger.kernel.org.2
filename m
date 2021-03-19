Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748F9342214
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCSQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCSQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:39:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7423C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:39:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so5141638pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvoDDerEyyb4UPjtZfh5TD8N4MiB2jCVDZj0evdETsk=;
        b=fQAZGlvsU3OmzhfCCu/HWUmLUqVlSmLNPymtXoqiH7pS5/I0Kze/+9HQ83upaFWyGx
         27vF1mZmZ0JHLI8Z8wq6ozzzU8AqboHGFbaj6Czj3czD/Ua7ReM1HfpWi/ebB0rkQZJL
         QN3YN+xGwz+97sGV5s/Q+Wa1T2XoZP1VGv00rN5XpMUWNMkACte4/mM3cAEhUqPG9A+g
         AhZHHDV7js9Fx2Y1DGTvB4kSZVDdPlKTrI3wfg/n9WForsmh7tqgzJ4t0qL8Awh/oHQE
         cbES+FQudokbFgW0+B2pkr3ARIYPrCMFjr16euT252iBOmH1BRmJPtoRYrCBMkRwwsFF
         v+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvoDDerEyyb4UPjtZfh5TD8N4MiB2jCVDZj0evdETsk=;
        b=gNm2/UIoEYeNbkgZ54Vogw9f8cPDeQmhj1oXa0jeC40f9kP6xPTUoRrm1UpJxCL9bT
         DnnpNMi2VNI2MLFPBZ0sOx8wlbrRL7spnPvNVy88QZBzHx2oW1Jrpurc3L9q2Ad1X1sY
         Xw3I2ceEXIfvaBek9Sa+G+Pok8P1H7oglp91dNLGE9KAdCTMu5yuf4hJB1QMFkrRJlCw
         +UegrUVrKNYay10svCpydFQq+SBBLpDOBfu1ptB8PxwEmPQSnJOC2DOzMsIdjbsW5FL3
         0KeYXx0S/mw/N+PL2JFLw06yiwvx0B/D/ZWmCIl5YSTyX+8Ee18ufmdI65/k46rdxxwV
         RH0A==
X-Gm-Message-State: AOAM5313TgJC57JMhAVyAdVGmul62PoYqWJbgNpvDK5Kcxn3+urY9cYr
        biazFGyYbxlFRbuXUpTxNoheWA==
X-Google-Smtp-Source: ABdhPJzTX5iyroetnM6aj9hw9+8hw65hqaf8cBYjqAVBt6aCABn+31HsHiv/OzYOJZnwh6rZk4GGaw==
X-Received: by 2002:a17:90b:ece:: with SMTP id gz14mr10719879pjb.192.1616171942380;
        Fri, 19 Mar 2021 09:39:02 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:39:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 6/7] mm: memcontrol: inline __memcg_kmem_{un}charge() into obj_cgroup_{un}charge_pages()
Date:   Sat, 20 Mar 2021 00:38:19 +0800
Message-Id: <20210319163821.20704-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one user of __memcg_kmem_charge(), so manually inline
__memcg_kmem_charge() to obj_cgroup_charge_pages(). Similarly manually
inline __memcg_kmem_uncharge() into obj_cgroup_uncharge_pages() and
call obj_cgroup_uncharge_pages() in obj_cgroup_release().

This is just code cleanup without any functionality changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 63 +++++++++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 962499542531..249bf6b4d94c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -255,10 +255,8 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
-static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
-			       unsigned int nr_pages);
-static void __memcg_kmem_uncharge(struct mem_cgroup *memcg,
-				  unsigned int nr_pages);
+static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+				      unsigned int nr_pages);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -295,7 +293,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	spin_lock_irqsave(&css_set_lock, flags);
 	memcg = obj_cgroup_memcg(objcg);
 	if (nr_pages)
-		__memcg_kmem_uncharge(memcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages);
 	list_del(&objcg->list);
 	mem_cgroup_put(memcg);
 	spin_unlock_irqrestore(&css_set_lock, flags);
@@ -3046,46 +3044,45 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
 
+/*
+ * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
+ * @objcg: object cgroup to uncharge
+ * @nr_pages: number of pages to uncharge
+ */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
-	__memcg_kmem_uncharge(memcg, nr_pages);
-	css_put(&memcg->css);
-}
 
-static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
-				   unsigned int nr_pages)
-{
-	struct mem_cgroup *memcg;
-	int ret;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		page_counter_uncharge(&memcg->kmem, nr_pages);
+	refill_stock(memcg, nr_pages);
 
-	memcg = get_mem_cgroup_from_objcg(objcg);
-	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
 	css_put(&memcg->css);
-
-	return ret;
 }
 
-/**
- * __memcg_kmem_charge: charge a number of kernel pages to a memcg
- * @memcg: memory cgroup to charge
+/*
+ * obj_cgroup_charge_pages: charge a number of kernel pages to a objcg
+ * @objcg: object cgroup to charge
  * @gfp: reclaim mode
  * @nr_pages: number of pages to charge
  *
  * Returns 0 on success, an error code on failure.
  */
-static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
-			       unsigned int nr_pages)
+static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
+				   unsigned int nr_pages)
 {
 	struct page_counter *counter;
+	struct mem_cgroup *memcg;
 	int ret;
 
+	memcg = get_mem_cgroup_from_objcg(objcg);
+
 	ret = try_charge(memcg, gfp, nr_pages);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
@@ -3097,25 +3094,15 @@ static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		 */
 		if (gfp & __GFP_NOFAIL) {
 			page_counter_charge(&memcg->kmem, nr_pages);
-			return 0;
+			goto out;
 		}
 		cancel_charge(memcg, nr_pages);
-		return -ENOMEM;
+		ret = -ENOMEM;
 	}
-	return 0;
-}
-
-/**
- * __memcg_kmem_uncharge: uncharge a number of kernel pages from a memcg
- * @memcg: memcg to uncharge
- * @nr_pages: number of pages to uncharge
- */
-static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
-{
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_uncharge(&memcg->kmem, nr_pages);
+out:
+	css_put(&memcg->css);
 
-	refill_stock(memcg, nr_pages);
+	return ret;
 }
 
 /**
-- 
2.11.0

