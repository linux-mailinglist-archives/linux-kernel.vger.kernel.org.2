Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5F362DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhDQEjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbhDQEi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E70C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so17466157pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8wWJIpwyMTu3hxIlWXzmIud8VzdA+zaDtz12NM5n5U=;
        b=gOlDpI9W4hNk8OJOLpqJsXe7e3d8XW3uIRecNncUmDast0FIsNwEoukqsd92tIuXYS
         4S9+Hg1qJokG2rU5GBwTlujrn6cb7eUE/O5soU6MDUsB6ZnMlldD6aeX97Vf0sjZUH6J
         rOOyszSYismDKyNKucJHCd9d7lB3hROGCDbpF57945bR5Lh/+0wSFO9LnmJaZJKqIX4N
         oL/XuAorQSZlwsgaDUvjvU5w6A/dZh3lZuzTzXKZyR0Fj/+TGjI4tbqSUScR4IvQig6O
         Mfwui3WpKH1vmNkVObxYjB9OtobnsE1qegYgcKfLd2VCr0pxUCUoGNJCfvboZYFIVTQH
         V7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8wWJIpwyMTu3hxIlWXzmIud8VzdA+zaDtz12NM5n5U=;
        b=SB0N3wvuw6hlPhwzHJeZ6oAQTGOyNHYb65NKACji+RnLcp6FHr9zrO1F7s+lo+ek1g
         twDeAlpsKZvVO5vJLeMAansQSL/dvsN0MFnPqfAYjsMT/jEV3/l5U/ionaE9uXFyfYrW
         q85ruqGtGRELlqz7jG4oDvuCUdJB9WNetOIlCYWZbLkf0hcJiwfKiJc1sD+B54Y6m/GX
         RZUdGGH2EYjTZZpQYEmyTp4zQiN9r8TrapSeOb5HocldK9lZsAerA8gyxV+5MieviBWQ
         iMqu5A70mTViixOMLGN19WcH5GYr6jjXiGlZDiYG+SsMXHT6WLNyHaOEDeOowu6JEM6C
         1vqw==
X-Gm-Message-State: AOAM531AlFiJ2d/nO8egHPKNOFH+xwQ+oBNyfmolQQzxu+oqbscNFYSD
        uHyLys5Xz3CYQfUbeLVUGlLVtEiUBGheKQ==
X-Google-Smtp-Source: ABdhPJyjWUSSWRy9zIYjqf2tg/9AOXpV4Sq7NMnXrLiBovzHs2ttyWQ1tvrW4y8CSIsagtmxFg5dTQ==
X-Received: by 2002:a17:902:501:b029:eb:7a1b:c96c with SMTP id 1-20020a1709020501b02900eb7a1bc96cmr11483702plf.76.1618634311277;
        Fri, 16 Apr 2021 21:38:31 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 6/8] mm: memcontrol: simplify the logic of objcg pinning memcg
Date:   Sat, 17 Apr 2021 12:35:36 +0800
Message-Id: <20210417043538.9793-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
the css_set_lock. We do not need to care about objcg->memcg being
released in the process of obj_cgroup_release(). So there is no need
to pin memcg before releasing objcg. Remove those pinning logic to
simplfy the code.

There are only two places that modifies the objcg->memcg. One is the
initialization to objcg->memcg in the memcg_online_kmem(), another
is objcgs reparenting in the memcg_reparent_objcgs(). It is also
impossible for the two to run in parallel. So xchg() is unnecessary
and it is enough to use WRITE_ONCE().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index caf193088beb..c4eebe2a2914 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,7 +261,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
-	struct mem_cgroup *memcg;
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
 	unsigned long flags;
@@ -291,11 +290,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	spin_lock_irqsave(&css_set_lock, flags);
-	memcg = obj_cgroup_memcg(objcg);
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 	list_del(&objcg->list);
-	mem_cgroup_put(memcg);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
 	percpu_ref_exit(ref);
@@ -330,17 +327,12 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 
 	spin_lock_irq(&css_set_lock);
 
-	/* Move active objcg to the parent's list */
-	xchg(&objcg->memcg, parent);
-	css_get(&parent->css);
-	list_add(&objcg->list, &parent->objcg_list);
-
-	/* Move already reparented objcgs to the parent's list */
-	list_for_each_entry(iter, &memcg->objcg_list, list) {
-		css_get(&parent->css);
-		xchg(&iter->memcg, parent);
-		css_put(&memcg->css);
-	}
+	/* 1) Ready to reparent active objcg. */
+	list_add(&objcg->list, &memcg->objcg_list);
+	/* 2) Reparent active objcg and already reparented objcgs to parent. */
+	list_for_each_entry(iter, &memcg->objcg_list, list)
+		WRITE_ONCE(iter->memcg, parent);
+	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.11.0

