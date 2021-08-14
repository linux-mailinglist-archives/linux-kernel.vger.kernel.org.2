Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0623EC0B0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhHNF0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhHNF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BACC061757
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n12so14020679plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPIEUgCv2CfVB3RBhBUqutTabZnAlwkc6TmF8u0la+M=;
        b=evzFsEQ5cP5VAHIL/eesP/y9sy4kvCZ9J4vPwMM2WZeM3i2WpFmYbgXqFhi7udyynW
         1aMUdu+vZBYPWaxURBSa7XvTgGwbtY2Yti0mSH1AAERVh8UGsXqrKAKvcvMj2UnJJQ+a
         JXOPRC9/lmWRFRzm2zDJac+b32GcJJmKA64coKjcw4dkIOsFQL7IGMMaX7O1/Ay+jfqa
         to8CPnjiQh/hSZjI3V0a8RTln46tcbOf+p/S72IZunpbIOzatgr0PJFm0XxBXm11xIr8
         osFk2afW32RSq/oNKn00qTjBLBWtlMZYo4XNh5NjDYGIbPRh/nkRSYmm+Moiv2c+QijM
         7rVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPIEUgCv2CfVB3RBhBUqutTabZnAlwkc6TmF8u0la+M=;
        b=Sx500uTlIaHhtW16w8nISSHQL+1ZtktF3voIVeo3dZnH3aOf61auAVZbOyE1pT+r7A
         XwVKkmJXN/x/lprr6pnd6nDA7t8OTvJrDWHxbIFwuO2iCU8gWKDNdC7sgJdWOoDmyj33
         +os736mQ9kbqHU91pR/6OYx/dyyiLe8Q3Xv8sSVXzgf+8SmqGyGOpAGdmgwqyM3TRwnH
         86ovnj/nFTLp79LZ2ePA0VgUMzPWbXoy5FwJq0YolSYHLt+R7toPKwiZMBoXH2MOAPJC
         PM/JOJArwpQYfoZ4GuiJAAbzr38xYqbutw3qm3u7em+xeLV139vYqGt7UT4y02mWSBzm
         DB7Q==
X-Gm-Message-State: AOAM5301rjzoLPPVL2YhUzp02cFM2vTyNhBpZMbZLjLFI6Xw9n37D0Ne
        YEMXaZyGmF1wxMcUtjp7hcmBfQ==
X-Google-Smtp-Source: ABdhPJzxwFjAn1im6gsgSEHt+LwD4iGMz1KIVynJ4deShVJLjmTgUF214h03/eIQOp5o9YqHY/X2sA==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr5996988pjs.57.1628918779474;
        Fri, 13 Aug 2021 22:26:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 08/12] mm: memcontrol: introduce memcg_reparent_ops
Date:   Sat, 14 Aug 2021 13:25:15 +0800
Message-Id: <20210814052519.86679-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patch, we know how to make the lruvec lock safe when LRU
pages are reparented. We should do something like following.

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
index 431fc606f6f9..d85c03f2d76d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -352,6 +352,13 @@ struct mem_cgroup {
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
index 0eca3cf6cede..8cfb4221c36a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -344,6 +344,35 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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
@@ -353,9 +382,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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
@@ -365,7 +398,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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

