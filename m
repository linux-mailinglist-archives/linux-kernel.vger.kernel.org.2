Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3055934E561
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhC3KX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC3KW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BFFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f10so11372028pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LlVfK3tBgrU0BmUX2bWJJi+yNP+gPFz4okGwO5zSo8A=;
        b=npOuj/IXL32HPg+K23Sf+62ebOlixpsNhaNB6Q3mb/mp0VlX2286qJxPe43mPC206Q
         sKe0ASbkn8j9Y6Bu1nY89TM5lv4O7xe6RmLNinsrYRcvQoQkiDcrCvob1ltIglysLe1/
         FJkYD9zLZVp7JaXlnxo/GoQDqb5523ZL6hvS6i5ihuVzIZ/dgZwqd7Vs253seeHV6wf6
         SufLYUloFclKQVRLkUFN+8qZHerr5cE4Fi263QbIuTBVqNstFg6PYRMaZzV4gfsMOCjH
         MdPzLEykQ+MzbaHjAogbvIr1kHzzzthVUPvsf7zPTAY2Zxf2P0SjkwGjATdxL0Hp49kX
         3glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlVfK3tBgrU0BmUX2bWJJi+yNP+gPFz4okGwO5zSo8A=;
        b=VMAbwcxLmt1ekRepRx168vI84cPpdx7qperqAfwllWG0qlUMQagcQbul+Uw862t/RW
         DRerjzB1aMXjZ6XsT1+4KWjlmt0ypoJJXKWnTSGmxz7rVcF2GbYDS0V86O+migJjAa+m
         je+KAL5VyE3N7fFF87exScmaWGgCHKfPNptO4YcUhvNlu3TzvHt8Ukx/qoGM4t0UYVLM
         81YPABCoPHaHNB/JCDIupaPj5BrrTLOy/+VAWojXqSEEg0n1WDmTyodMvWza+tQatmvI
         EHcQzKgW+ybqbRfTpT59/cR7uCDwr06rF/HHftVmo9wAPT5zdXYl6Hyk80mmxbuTaGkq
         5qFQ==
X-Gm-Message-State: AOAM531/L8MWiJRX0GHvZ3UP+yc2bV0w5nd/tYxrs+d5RcqmAYxcu/mc
        IPfj02aHVoXkLssvANCFGzi00w==
X-Google-Smtp-Source: ABdhPJyOUnZ7tulMq0ZkReZZufRvoJjBeThdaJ2q71EIRLjtbmbmrs8OtM6B/E1tX6dkgSDD809a5w==
X-Received: by 2002:a65:5308:: with SMTP id m8mr26351120pgq.266.1617099777573;
        Tue, 30 Mar 2021 03:22:57 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:22:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 12/15] mm: memcontrol: introduce memcg_reparent_ops
Date:   Tue, 30 Mar 2021 18:15:28 +0800
Message-Id: <20210330101531.82752-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patch, we know how to make the lruvec lock safe when the
LRU pages reparented. We should do something like following.

    memcg_reparent_objcgs(memcg)
        1) lock
        // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
        spin_lock(&lruvec->lru_lock);
        spin_lock(&lruvec_parent->lru_lock);

        2) do reparent
        // Move all the pages from the lruvec list to the parent lruvec list.

        3) unlock
        spin_unlock(&lruvec_parent->lru_lock);
        spin_unlock(&lruvec->lru_lock);

Apart from the page lruvec lock, the deferred split queue lock (THP only)
also needs to do something similar. So we extracted the necessary 3 steps
in the memcg_reparent_objcgs().

    memcg_reparent_objcgs(memcg)
        1) lock
        memcg_reparent_ops->lock(memcg, parent);

        2) reparent
        memcg_reparent_ops->reparent(memcg, reparent);

        3) unlock
        memcg_reparent_ops->unlock(memcg, reparent);

Now there are two different locks (e.g. lruvec lock and deferred split
queue lock) need to use this infrastructure. In the next patch, we will
use those APIs to make those locks safe when the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 11 +++++++++++
 mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8944115ebf8e..c79770ce3c81 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -341,6 +341,17 @@ struct mem_cgroup {
 	/* WARNING: nodeinfo must be the last member here */
 };
 
+struct memcg_reparent_ops {
+	struct list_head list;
+
+	/* Irq is disabled before calling those functions. */
+	void (*lock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+	void (*unlock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+	void (*reparent)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+};
+
+void __init register_memcg_repatent(struct memcg_reparent_ops *ops);
+
 /*
  * size of first charge trial. "32" comes from vmscan.c's magic value.
  * TODO: maybe necessary to use big numbers in big irons.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb650d089d9f..d5701117794a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -338,6 +338,41 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
+static LIST_HEAD(reparent_ops_head);
+
+static void memcg_reparent_lock(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent)
+{
+	struct memcg_reparent_ops *ops;
+
+	list_for_each_entry(ops, &reparent_ops_head, list)
+		ops->lock(memcg, parent);
+}
+
+static void memcg_reparent_unlock(struct mem_cgroup *memcg,
+				  struct mem_cgroup *parent)
+{
+	struct memcg_reparent_ops *ops;
+
+	list_for_each_entry(ops, &reparent_ops_head, list)
+		ops->unlock(memcg, parent);
+}
+
+static void memcg_do_reparent(struct mem_cgroup *memcg,
+			      struct mem_cgroup *parent)
+{
+	struct memcg_reparent_ops *ops;
+
+	list_for_each_entry(ops, &reparent_ops_head, list)
+		ops->reparent(memcg, parent);
+}
+
+void __init register_memcg_repatent(struct memcg_reparent_ops *ops)
+{
+	BUG_ON(!ops->lock || !ops->unlock || !ops->reparent);
+	list_add(&ops->list, &reparent_ops_head);
+}
+
 static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
@@ -347,9 +382,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
+	local_irq_disable();
+
+	memcg_reparent_lock(memcg, parent);
+
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
-	spin_lock_irq(&css_set_lock);
+	spin_lock(&css_set_lock);
 
 	/* 1) Ready to reparent active objcg. */
 	list_add(&objcg->list, &memcg->objcg_list);
@@ -361,7 +400,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
-	spin_unlock_irq(&css_set_lock);
+	spin_unlock(&css_set_lock);
+
+	memcg_do_reparent(memcg, parent);
+
+	memcg_reparent_unlock(memcg, parent);
+
+	local_irq_enable();
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.11.0

