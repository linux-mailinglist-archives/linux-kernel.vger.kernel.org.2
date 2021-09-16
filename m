Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5772B40DBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhIPNzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbhIPNyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4305C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so6001718pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zJ+rajzCodDQWeoI37cULUx5xfm+EYhpR+j50QMba8=;
        b=UH0q2kMvwpE+oXiVGNhyaG/DpfCTcD3yJP4RI4OdyNI3bcpaFQG+yzqb8NVQKg1DpN
         DOUPe7YQUg3P01t3908CUfgU/X1z6/ooubNFka5e13rDo+0bEhnFU/wbaqU6bTOP2sjj
         ARz2nxJHBlGoK7BXo6ZKwbwWkMHew6yfg7dmmPwtmSmOxnVwzGTs4hVBSAcnaAqu3Bw3
         dFopBR5Z7ZNZTkQxdsyqoEBiicslqlwytz0mt3/JfKVOkrmmuX82jNFNyDBYuLmvAikv
         U/COC/LXn5akRPaFXjlFHPLYnCbAj5jOLctJSqtysE8hPp08hvYBr7Ujy+BO89yjik3b
         9UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zJ+rajzCodDQWeoI37cULUx5xfm+EYhpR+j50QMba8=;
        b=uRwzy1Xne2vZboWAR47XFke0AVBpFuN074DdsS3ty7v+IBDnLG8nwEDbbmcz7cumnr
         q32OM5unmR/rHGF/4J3JPaBC4Dvhh50Hb22zjHAcPF7T465wyqJWPk3DQThbP+oI8Dfj
         yrk10o4sJQMdFq3Cu2LtvOskH3vbLAfsfvpgCt571OqHC7XbknfTO5FSdlRqDUGfZmLO
         Y+Cs8cX5gNKJkiNlkgULD3RUSSkacacmv8bCWyN/pMPYIgsBcPCW31zOjTCY29ZkNIh3
         jLrUpyHjoCW10Bao/lnPw1tHWWs/bx8kj72exbPcwpzLSXgCPTG/EFi0VSVyVYXF8nbe
         5fxA==
X-Gm-Message-State: AOAM530HRKQOExdxtguk7QzikBjXC/PCuaJ5lafeJpK8j5LxME6vU7qt
        VQyAgQUX6Z4P2+aJkLqgiSI7gw==
X-Google-Smtp-Source: ABdhPJwxGZVjBFXnUvLHMSj361dGfdo0pyqFzMu2FSl2ZkHX6t6WAMc0bR0oqwQWyHCKbeJyZ6uePw==
X-Received: by 2002:a63:da14:: with SMTP id c20mr5099842pgh.155.1631800382477;
        Thu, 16 Sep 2021 06:53:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:53:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 09/13] mm: memcontrol: introduce memcg_reparent_ops
Date:   Thu, 16 Sep 2021 21:47:44 +0800
Message-Id: <20210916134748.67712-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
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
also needs to do something similar. So we extract the necessary three steps
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
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab3cd844e91d..18344c1f4333 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -350,6 +350,13 @@ struct mem_cgroup {
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
+struct memcg_reparent_ops {
+	/* Irq is disabled before calling those callbacks. */
+	void (*lock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+	void (*unlock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+	void (*reparent)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+};
+
 /*
  * size of first charge trial. "32" comes from vmscan.c's magic value.
  * TODO: maybe necessary to use big numbers in big irons.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 16db5b39cb81..3a73fd192734 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -333,6 +333,35 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
+static const struct memcg_reparent_ops *memcg_reparent_ops[] = {};
+
+static void memcg_reparent_lock(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)
+		memcg_reparent_ops[i]->lock(memcg, parent);
+}
+
+static void memcg_reparent_unlock(struct mem_cgroup *memcg,
+				  struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)
+		memcg_reparent_ops[i]->unlock(memcg, parent);
+}
+
+static void memcg_do_reparent(struct mem_cgroup *memcg,
+			      struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)
+		memcg_reparent_ops[i]->reparent(memcg, parent);
+}
+
 static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
@@ -342,9 +371,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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
@@ -354,7 +387,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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

