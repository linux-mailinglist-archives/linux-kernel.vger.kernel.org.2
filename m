Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47575366039
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhDTTbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233748AbhDTTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618947032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V8tpjiZVe9/HPR7EqqmVPxX4+H+yOIDgVesSOM9WmtY=;
        b=ExXlP/QgRAFDof4pxNIZXaI6bL/bMGwkwhoxdmnolVTNEt9k/UGMQVrncxhLDKe2WMZrdu
        eLQUjZch3/078FPjwvwXkBAJRTWiL0XIYaypI+qeoLa45GBlDiYGVqdV2omcfjwdg2UlOc
        yvgjE0B4G+ggrLiEtRm+AopeECRl6HE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-BI2hURGfPou-avkkOogtUw-1; Tue, 20 Apr 2021 15:29:56 -0400
X-MC-Unique: BI2hURGfPou-avkkOogtUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE51C107ACE8;
        Tue, 20 Apr 2021 19:29:51 +0000 (UTC)
Received: from llong.com (ovpn-114-123.rdu2.redhat.com [10.10.114.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFDFA610F3;
        Tue, 20 Apr 2021 19:29:49 +0000 (UTC)
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
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-next v5 3/4] mm/memcg: Improve refill_obj_stock() performance
Date:   Tue, 20 Apr 2021 15:29:06 -0400
Message-Id: <20210420192907.30880-4-longman@redhat.com>
In-Reply-To: <20210420192907.30880-1-longman@redhat.com>
References: <20210420192907.30880-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two issues with the current refill_obj_stock() code. First of
all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
be used again which leads to another call to drain_obj_stock() and
obj_cgroup_get() as well as atomically retrieve the available byte from
obj_cgroup. That is costly. Instead, we should just uncharge the excess
pages, reduce the stock bytes and be done with it. The drain_obj_stock()
function should only be called when obj_cgroup changes.

Secondly, when charging an object of size not less than a page in
obj_cgroup_charge(), it is possible that the remaining bytes to be
refilled to the stock will overflow a page and cause refill_obj_stock()
to uncharge 1 page. To avoid the additional uncharge in this case,
a new overfill flag is added to refill_obj_stock() which will be set
when called from obj_cgroup_charge().

A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
96-thread x86-64 system with 96 testing threads were run.  Before this
patch, the total number of kilo kmalloc+kfree operations done for a 4k
large object by all the testing threads per second were 4,304 kops/s
(cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
represents a performance improvement of 1.10X (cgroup v1) and 49.3X
(cgroup v2).

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 292b4783b1a7..2f87d0b05092 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3153,10 +3153,12 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 	return false;
 }
 
-static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
+			     bool overfill)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
+	unsigned int nr_pages = 0;
 
 	local_irq_save(flags);
 
@@ -3165,14 +3167,20 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
-		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
+		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
 	}
 	stock->nr_bytes += nr_bytes;
 
-	if (stock->nr_bytes > PAGE_SIZE)
-		drain_obj_stock(stock);
+	if (!overfill && (stock->nr_bytes > PAGE_SIZE)) {
+		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
+		stock->nr_bytes &= (PAGE_SIZE - 1);
+	}
 
 	local_irq_restore(flags);
+
+	if (nr_pages)
+		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -3201,14 +3209,14 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 
 	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
 	if (!ret && nr_bytes)
-		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
+		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes, true);
 
 	return ret;
 }
 
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_obj_stock(objcg, size);
+	refill_obj_stock(objcg, size, false);
 }
 
 #endif /* CONFIG_MEMCG_KMEM */
-- 
2.18.1

