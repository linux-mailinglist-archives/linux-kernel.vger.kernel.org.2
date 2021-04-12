Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE535D384
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbhDLWz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343846AbhDLWzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618268132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=6q8PwfMd38t+lXEGfKmsTXF5u9dPLNsn54ZL71OOV5A=;
        b=YNhCWw3+I3cmzRMLvbvLsHz0W9KAiw4PeUlFTGzUohpEHvHcKIuhon+yyqVN56Tw6IZOtV
        Z+/8g+EAVnAlXwy9H9TxoUygFfVIFXMZioawqXBVF/kGvXdk1+dbklA3JiVNLpWfpx+kAL
        0csfSCs9n/vk6YoT6Q5rMZHW6uanoY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-yukMJDvuNpyMpEirT1v5Dg-1; Mon, 12 Apr 2021 18:55:28 -0400
X-MC-Unique: yukMJDvuNpyMpEirT1v5Dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D05F11883520;
        Mon, 12 Apr 2021 22:55:25 +0000 (UTC)
Received: from llong.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 764775D6D1;
        Mon, 12 Apr 2021 22:55:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/5] mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
Date:   Mon, 12 Apr 2021 18:55:00 -0400
Message-Id: <20210412225503.15119-3-longman@redhat.com>
In-Reply-To: <20210412225503.15119-1-longman@redhat.com>
References: <20210412225503.15119-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
is followed by mod_objcg_state()/mod_memcg_state(). Each of these
function call goes through a separate irq_save/irq_restore cycle. That
is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
that combines them with a single irq_save/irq_restore cycle.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol.c            | 31 +++++++++++++++++++++++++++----
 mm/percpu.c                |  9 ++-------
 mm/slab.h                  |  6 +++---
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 95f12996e66c..6890f999c1a3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1592,6 +1592,8 @@ struct obj_cgroup *get_obj_cgroup_from_current(void);
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
+void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
+				   struct pglist_data *pgdat, int idx);
 
 extern struct static_key_false memcg_kmem_enabled_key;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d66e1e38f8ac..b19100c68aa0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3225,12 +3225,9 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 	return false;
 }
 
-static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+static void __refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
-
-	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
@@ -3243,7 +3240,14 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 
 	if (stock->nr_bytes > PAGE_SIZE)
 		drain_obj_stock(stock);
+}
+
+static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+{
+	unsigned long flags;
 
+	local_irq_save(flags);
+	__refill_obj_stock(objcg, nr_bytes);
 	local_irq_restore(flags);
 }
 
@@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size);
 }
 
+void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
+				   struct pglist_data *pgdat, int idx)
+{
+	unsigned long flags;
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec = NULL;
+
+	local_irq_save(flags);
+	__refill_obj_stock(objcg, size);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	if (pgdat)
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	__mod_memcg_lruvec_state(memcg, lruvec, idx, -(int)size);
+	rcu_read_unlock();
+	local_irq_restore(flags);
+}
+
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
diff --git a/mm/percpu.c b/mm/percpu.c
index 23308113a5ff..fd7aad6d7f90 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1631,13 +1631,8 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
 	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
 
-	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
-
-	rcu_read_lock();
-	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-			-(size * num_possible_cpus()));
-	rcu_read_unlock();
-
+	obj_cgroup_uncharge_mod_state(objcg, size * num_possible_cpus(),
+				      NULL, MEMCG_PERCPU_B);
 	obj_cgroup_put(objcg);
 }
 
diff --git a/mm/slab.h b/mm/slab.h
index bc6c7545e487..677cdc52e641 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -366,9 +366,9 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 			continue;
 
 		objcgs[off] = NULL;
-		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
-				-obj_full_size(s));
+		obj_cgroup_uncharge_mod_state(objcg, obj_full_size(s),
+					      page_pgdat(page),
+					      cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
 	}
 }
-- 
2.18.1

