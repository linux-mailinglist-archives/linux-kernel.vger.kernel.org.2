Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2237A510
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhEKKxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhEKKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:53:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3BEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:52:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso1123772pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tthoopsr5G2zL3tdafUCx6W9EvXjjGg7T7Xsd3uJmoE=;
        b=DgYc8YN57QkMjkN4APmwzgLRQgmYPr6XAFw2JfSibXgtfC++yeyD2TcEF54woH1iN2
         n3zN6l/Hg1pIpYz72F+QESwZX61Xfx7RRwihrrrf+301eP5i0+TuQIlLLZCYHcPYMKEi
         sqROIWtzd+oljqufTEt62BJ2ZGFMQCcdQ/7NBm24/ZFNp18uXHsVWlyZJtrrcrGtBLe7
         w+2xnmvaEXXaoTitxY1U0UcOOAmXKlF+xzrr/Fw3xbHDy/W+es+jMUhSgsoTuThZu+1x
         cPBKwUaBjcUcHmj8lVtNXisgc7gTBD+sc/LxGtS+WWGhyPrPvtMCPoENtEBVhLHHQ//a
         5evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tthoopsr5G2zL3tdafUCx6W9EvXjjGg7T7Xsd3uJmoE=;
        b=IVUPGUZAugFQHd/fhM9GcfO56otyqQaxQKX3YIYinEZt/PiQa7csmG+8DzOWXzfUWa
         qCmbVMVb1m+d4tiXC/pkBHj2nkvPbuymKacvs9plG25t/u7TWk161albd9jvCSH0AEh0
         Qw16e6kXb42dSw+KjR9m0+ss9ZQqhkazzdptwhOX+091PQmH4Vq8Jq+ddDTGVRQeYZDI
         A+1sNHEqGy1utFqAaZow9wQAW6GxyftWbOJY+rq5+Q2+aDPisCOahj0EZxk3YUrWTJQo
         gkkV1DU/QEznrGc3nCKNaomczMm+afw7CaX3+xW4FJQbbvkWSxwPqBVou7a1YKAWW8tp
         QVQw==
X-Gm-Message-State: AOAM530PaVEZi7hnlJ5rgOdh8G8n+7MkSOvDWTdQy6SncWa9IJgSuAQM
        hi3P1ntOC5PVzzoR+TMXlGmHWg==
X-Google-Smtp-Source: ABdhPJywOW5mRiqRiX3AMrSpDX1DjzEOYzvjOm7zqQXU9JNa6vfWHW/5engdadWoRg8kIR60CTh+Ng==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr33070016pjn.143.1620730334181;
        Tue, 11 May 2021 03:52:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.52.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:52:13 -0700 (PDT)
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
Subject: [PATCH 08/17] mm: list_lru: remove memcg_aware from struct list_lru
Date:   Tue, 11 May 2021 18:46:38 +0800
Message-Id: <20210511104647.604-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use ->memcg_lrus to indicate if the lru is memcg aware. So
->memcg_aware is redundant and remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h | 1 -
 mm/list_lru.c            | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 228bef9fdd0b..00a13ad6128a 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -55,7 +55,6 @@ struct list_lru {
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 	int			shrinker_id;
-	bool			memcg_aware;
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 57c55916cc1c..cf17ff5a5940 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(list_lrus_mutex);
 
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
-	return lru->memcg_aware;
+	return !!lru->memcg_lrus;
 }
 
 static void list_lru_register(struct list_lru *lru)
@@ -73,7 +73,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	struct list_lru_one *l = &nlru->lru;
 	struct mem_cgroup *memcg = NULL;
 
-	if (!lru->memcg_lrus)
+	if (!list_lru_memcg_aware(lru))
 		goto out;
 
 	memcg = mem_cgroup_from_obj(ptr);
@@ -368,9 +368,10 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 	struct list_lru_memcg *memcg_lrus;
 	int size = memcg_nr_cache_ids;
 
-	lru->memcg_aware = memcg_aware;
-	if (!memcg_aware)
+	if (!memcg_aware) {
+		lru->memcg_lrus = NULL;
 		return 0;
+	}
 
 	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
-- 
2.11.0

