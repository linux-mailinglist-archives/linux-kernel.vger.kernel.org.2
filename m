Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3853359ECB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhDIMdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhDIMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:33:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A5EC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:33:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso4904064pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkwygiVjWU/odQpPcj4LBTXPK99AOuCbqNnVZygcuVU=;
        b=OIiYGYgaLyMc9DaF2jATUJ0wdYKQCFK8qzvLjnnZ6Kljx67Go32v69xS7DY+3/vuWv
         yU/ZzuXVny826ac8DW0pY9WFt5tipn98gG4VJ0WgtYLUhp2mzt2RXZn5asU9Cy1Td7XS
         t/oaLfVetQ8ZwX9gFq5yHKbpvb94Q1apj71OWxnBO+q2araLy6SGlpbSmPTph7zp4ti1
         g4lKnReN5wI23YRp9si7JJOTdVLGZvD0t23OE5/+Y6IwmhhLfzweLm1aB/UmDyeQkMHa
         uOwrKfhYg0guPR3WtSCsQd12J40WHj17QEtIpoDYZjEPH3flBijHiujYvey1CneOs5bg
         8Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkwygiVjWU/odQpPcj4LBTXPK99AOuCbqNnVZygcuVU=;
        b=VXDCYucO38FBdD1MplaZh03aoE472R05tF7105Uthab5L/EYfuY2Y125IQouGT/On1
         H5ZjLEend1netTnJ7GZee2oc0GhGxneRZuTysJj530c7kutfbwIhxEXHk75Mc20Lr5bR
         q3WSRDfXD1RvmeODTjcaNe/vS0sINkK5Puofk2u1szFq3gZ7EAguROgkSAXV/oo4QDym
         fm456mWpTGuh4127ity7qQBc0SMjhe7WRyY0wlnpMXLFo6vIAFIwuytiJjXp9d31dfxh
         uR66kYvhzYTNoFvU8o4FQr5oT2g0Kp/vLm7YzlcVoMeFjia2nd/arp1FKMi6jGksAjnb
         IoEg==
X-Gm-Message-State: AOAM530LnI/DhNcPEbpef67vvzr+v1qSg6MpwIAgsSiPX0zOir3Zq7EU
        Ezvr4/VbhI4g/s3N4l+cee/pcg==
X-Google-Smtp-Source: ABdhPJz+6M0EaKA7UonG/6FPqKDEcNlLgKwpnR3sggRvqNvIdbhIrdBCZgRDV6Brnp/QVho2vP1XbA==
X-Received: by 2002:a17:90a:3904:: with SMTP id y4mr13371509pjb.125.1617971591798;
        Fri, 09 Apr 2021 05:33:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.33.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:33:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 14/18] mm: memcontrol: introduce memcg_reparent_ops
Date:   Fri,  9 Apr 2021 20:29:55 +0800
Message-Id: <20210409122959.82264-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
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
index 7e15be2bd47a..fdc385ecff55 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -355,6 +355,17 @@ struct mem_cgroup {
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
index 2f4fcb182883..536be7bdc98f 100644
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

