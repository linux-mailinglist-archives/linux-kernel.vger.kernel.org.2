Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78C392795
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhE0G2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhE0G2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:28:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70965C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:26:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d78so2846830pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDeG++/blhLntk2pJHHgm+mSW8cVt7IZBOEblp/zC60=;
        b=DtpEH0I9Yks3SIBK6zIWD8R8VgT9fGU33bCNhHyJmktNP98gHzu6h5t1RIT/meam5f
         awAT2WP+76Z51QkQ60dtOvamBUPPUXfM7qdhq15wSMBcEDBXnUhMqIOPyw73jnG2RYBB
         aCIRzaW/jpP+oXABiXaym8ZbosFDdfpKQwlrOCOJ6OjqFW0pZpufqP59sJuI0dV5/5IU
         aP3QoANGK74pYhNxTnZNbTKuT9o1FUosMaEJiCF6tg9c1bXjVR+v6bBNZpgvu1qzAIdu
         WpnQvxRgE6K5THPZVmMwQ04qmWOaphT0yyP6G83/Af5J6y4eGMr/xB7qUiozd2IdKRvV
         OKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDeG++/blhLntk2pJHHgm+mSW8cVt7IZBOEblp/zC60=;
        b=UWKzmYV+fwjC9qIKxSMRXS7ICR6el6kBXn5mYl0M1WSX77UvqqYkCVFVpPBM3XO1mD
         dlDbBGB+B4htDUbcLCUJBeNHwqV57Kej7c4gTnvvpJv5cSFo1vdZz/xzjcMDC5MV+g7u
         cpVd7MzNEUJJm1dhVICnFuHg88EzLlr5H+UsWRlqHwBStmlVCSdQmNwlrMohY5ctIhmL
         E7qLnVV+Rm0gYoxjuspGoM3A3300KbKrQX1miSDlNFqxpnvoil9Qgzk8fHJJ7Yq36+1x
         dfjaQXHFc7E25sgFDWu4pifwQsN1+0EPt6V+gVTPehIjvuvAlP3211eEGtqw3YIbvrfE
         apdQ==
X-Gm-Message-State: AOAM5317afePhFwf4B/z1dQ3hoD2mQSu1Zek5kySK5iACTsBLYfXBPl5
        8Buz6HnQ5KvEPxRpbXCaCtTnDQ==
X-Google-Smtp-Source: ABdhPJy6LpMfHvxJKRmRoM7o+N0+95VtxvCbt414eASgexHfTHjbHGFW4pU6bsnvfRmroLKxBTlUXg==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr2334997pgv.64.1622096789011;
        Wed, 26 May 2021 23:26:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:28 -0700 (PDT)
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
Subject: [PATCH v2 18/21] mm: memcontrol: reuse memory cgroup ID for kmem ID
Date:   Thu, 27 May 2021 14:21:45 +0800
Message-Id: <20210527062148.9361-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two idrs being used by memory cgroup, one is for kmem ID,
another is for memory cgroup ID. The maximum ID of both is 64Ki.
Both of them can limit the total number of memory cgroups. Actually,
we can reuse memory cgroup ID for kmem ID to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 82b147597138..ae3ad1001824 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -342,23 +342,6 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 }
 
 /*
- * This will be used as a shrinker list's index.
- * The main reason for not using cgroup id for this:
- *  this works better in sparse environments, where we have a lot of memcgs,
- *  but only a few kmem-limited.
- */
-static DEFINE_IDA(memcg_cache_ida);
-
-/*
- * MAX_SIZE should be as large as the number of cgrp_ids. Ideally, we could get
- * this constant directly from cgroup, but it is understandable that this is
- * better kept as an internal representation in cgroup.c. In any case, the
- * cgrp_id space is not getting any smaller, and we don't have to necessarily
- * increase ours as well if it increases.
- */
-#define MEMCG_CACHES_MAX_SIZE MEM_CGROUP_ID_MAX
-
-/*
  * A lot of the calls to the cache allocation functions are expected to be
  * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
  * conditional to this static branch, we'll have to allow modules that does
@@ -3542,7 +3525,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
-	int memcg_id;
 
 	if (cgroup_memory_nokmem)
 		return 0;
@@ -3550,22 +3532,16 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		return 0;
 
-	memcg_id = ida_simple_get(&memcg_cache_ida, 0, MEMCG_CACHES_MAX_SIZE,
-				  GFP_KERNEL);
-	if (memcg_id < 0)
-		return memcg_id;
-
 	objcg = obj_cgroup_alloc();
-	if (!objcg) {
-		ida_simple_remove(&memcg_cache_ida, memcg_id);
+	if (!objcg)
 		return -ENOMEM;
-	}
+
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
 	static_branch_enable(&memcg_kmem_enabled_key);
 
-	memcg->kmemcg_id = memcg_id;
+	memcg->kmemcg_id = memcg->id.id;
 
 	return 0;
 }
@@ -3573,7 +3549,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *parent;
-	int kmemcg_id;
 
 	if (cgroup_memory_nokmem)
 		return;
@@ -3586,16 +3561,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	memcg_reparent_objcgs(memcg, parent);
-
-	/*
-	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
-	 * Cache it to @kmemcg_id.
-	 */
-	kmemcg_id = memcg->kmemcg_id;
-
 	memcg_reparent_list_lrus(memcg, parent);
-
-	ida_simple_remove(&memcg_cache_ida, kmemcg_id);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.11.0

