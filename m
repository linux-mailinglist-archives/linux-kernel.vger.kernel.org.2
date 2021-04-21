Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83623665FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhDUHCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhDUHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841CFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n10so9952361plc.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3S+xyFzwoI2Tiz3UVF4rpOSC3z1VJnG7vpue75CoFQ=;
        b=z5tJBr2ur9P2YtrugfWVGOrZDqwVPACR23eqLStSJjylUot9tAlyGHxrIb+9csvY4D
         H6z34XyOkomshPsi7qTu1ATg7IOegjwoU4t18+DfWrlGUt+j4X3Met6tc9OkphT2yaM/
         fsv4wzzZJydIzqeoe5n0AzkL1+98s09I69mQ9LEK2uvclqE3qg8VjStfmSD2t2IPnK8y
         NoLopcoc/CSUrCd4zIyAHFtuSOvUnUBoh0QuXtTJkEPrvWUsJpkRYaVB1TLXmdKyIPGD
         aWNS74F+f/cu7EyMMQ3HQBPpqwtlWXpBVQkcj5ByWZa7akrVAwIvyc1egrOEdH8pB1De
         o5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3S+xyFzwoI2Tiz3UVF4rpOSC3z1VJnG7vpue75CoFQ=;
        b=hvWwFxXzEuurYM7JcroA2CgSeAUsX72s6wJOul14NDdTUBE66aA7C+7/xP/mEwFWi5
         kV/e3aaCLA4vnKBzljaPRvQetgQgro9Wzw7gxD0e2DlSRLIGF8JekelQBTuF6/YmXlMS
         O9CazVSGY/VDRyF25X5soFoBA8QkP9zN4k4AOTwgNM8Qe6ahQMt2qTxsmuCCH4oJPoue
         r+fpaam5hUfydGM9N6ASeGMz5augLQWsY16OBI3KG7wFRa0cfEQL72R9j2ve5OxVFfxR
         46KmdseQ6WU+GIxW/7QyfZV8JTq9gPkLABaAoKGALU0TRjs+0bndeaqR0QqIGanDSnED
         9EZg==
X-Gm-Message-State: AOAM533cliG7a4fSFWEPqoq7ecvf2mCmcPl4InXKF0CSresAJTr/7kES
        y03sXcEe5oyiqnfsv9F0EK2SiA==
X-Google-Smtp-Source: ABdhPJyVeSTI7/VPYUKqwPyMzRwjxcAKtha71Al1PAz1CTlWTAJBp8V3y1lH+vzZhUILlIJ6XVfy+A==
X-Received: by 2002:a17:902:6b05:b029:e9:2810:7e59 with SMTP id o5-20020a1709026b05b02900e928107e59mr33202148plk.76.1618988523034;
        Wed, 21 Apr 2021 00:02:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:02:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 08/12] mm: memcontrol: introduce memcg_reparent_ops
Date:   Wed, 21 Apr 2021 15:00:55 +0800
Message-Id: <20210421070059.69361-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
index 228263f2c82b..b12847b0be09 100644
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
index a48403e5999c..f88fe2f06f5b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -330,6 +330,41 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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
@@ -339,9 +374,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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
@@ -351,7 +390,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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

