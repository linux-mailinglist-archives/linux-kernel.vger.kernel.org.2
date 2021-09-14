Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4440A874
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhINHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbhINHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:46:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4B5C061A06
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n4so7593348plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsjYfDNMEc/jELMvGHtKH2gf13kKEK2Ue14TQA3Gi28=;
        b=OrcumWMrE2b/nfxa+Zj0GT88EGILDhLgk4KgBS0ly+inFAxhtUgjeLsg7pT69wYqZH
         wFV+svd7CjJghPycVKXor0/CzlVMpoZiR/nACPVNg1YQi55tIjsHrBdrFN87fp1KkE0y
         Ob8TDgk9Liwk6v9/oGafCXgkhUVrHPo4xjOuLzznMtX7ZT/cupnuhoLdcPq8tNkJs/lu
         gsHvmMCOvl6suOH5NhnzIMK4sRo73Z7yDOBsPs5iz86nLMFrrSEhzS1tBt5mGxmW5quY
         WpLnz6MQDewqeASmohKE2wSzc4WQSVje8QRVvxtsCaW2k0uaOrO05coInYwR0u5KHl+B
         XboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsjYfDNMEc/jELMvGHtKH2gf13kKEK2Ue14TQA3Gi28=;
        b=E2YY5Y/fxOFVxSgL9Fqwwr/e4N/URGuhBho86DRwXz7fMLnwi0ezfaVef2Msd76iRM
         3FqEDI+ezonIlzprdHZeRghFKLEcS24sYbXpOneOtZLJXh2pqCWKqW4YmZKlMzXfFxou
         kixNZnkAcsN/9cff1NEopqo6yJe5xGHsxlDXhS+lyCf00FIjGdSVamtfWqu1Vo3r8S80
         PPSLWE0xjhhu8mgD7HaYvsL2IfFyicQUUkldXxwKK8lCPHi0boR5dbPSpM+NmwJSG+eP
         W1+/1DuQVLShHyvQlHeeEW0y6kW/VdI0mPjgCZLrH4NbYkeaUGgpBTkeaWjHgvNvT/aM
         Ea0g==
X-Gm-Message-State: AOAM532Vfizvzy4FXP1IEX7cgi5VuZ3YnOWMiTvDwPylBlAlbC9wlnJD
        RDhQ4PeU2LrCR4Aiunu3WG/baQ==
X-Google-Smtp-Source: ABdhPJyuMSpSZr9qGteJJluv8QWQshuC0AqQLwhRVohTduvgabtXntr2JJefLZNIQDJJ1sZNrcZ/uw==
X-Received: by 2002:a17:902:7c94:b0:13b:8d10:cc4f with SMTP id y20-20020a1709027c9400b0013b8d10cc4fmr9894718pll.54.1631605285968;
        Tue, 14 Sep 2021 00:41:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 71/76] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Tue, 14 Sep 2021 15:29:33 +0800
Message-Id: <20210914072938.6440-72-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
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
 mm/list_lru.c            | 25 ++++++++++++-------------
 mm/memcontrol.c          |  4 ++--
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 62f407831b8c..5e9c632c9eb7 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -77,8 +77,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 48651c29a9d1..1e42d9847b08 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -460,8 +460,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -489,23 +489,22 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_unlock_irq(&nlru->lock);
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
 
 	memcg_list_lru_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
-	int src_idx = src_memcg->kmemcg_id;
+	int src_idx = memcg->kmemcg_id;
 
 	/*
 	 * Change kmemcg_id of this cgroup and all its descendants to the
@@ -520,17 +519,17 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
 	 * memcg_list_lru_free().
 	 */
 	rcu_read_lock();
-	css_for_each_descendant_pre(css, &src_memcg->css) {
-		struct mem_cgroup *memcg;
+	css_for_each_descendant_pre(css, &memcg->css) {
+		struct mem_cgroup *child;
 
-		memcg = mem_cgroup_from_css(css);
-		memcg->kmemcg_id = dst_memcg->kmemcg_id;
+		child = mem_cgroup_from_css(css);
+		child->kmemcg_id = parent->kmemcg_id;
 	}
 	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_memcg);
+		memcg_reparent_list_lru(lru, src_idx, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2045cd8b1d7f..4cf98de2ad09 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3636,12 +3636,12 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
 	 * Cache it to @kmemcg_id.
 	 */
 	kmemcg_id = memcg->kmemcg_id;
 
-	memcg_drain_all_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

