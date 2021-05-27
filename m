Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1160D392AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhE0JgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhE0JgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:36:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v13so2048391ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ib7RAPbfbKwKwT5M4f1jjNI8X1DqgVyFDhXu+pU2YDc=;
        b=mNp6Cb1YLHUxy6cw26u4CUhDgTDs0cRAiiyaSoga5m7N5h7Ak8Tvs4drwUtB2eKDsq
         BR9FRA2N93+3w3QtwDqRvBOhlA/Lqg+LKwC5f0G0cOuXPq0Yt3YbHFKirW8iCm17JCtN
         //J1JYMA+O73JMTbQnHwKJj8owPWVgoaxAcqFA1ApVDbozQypBp4QbQqBOjSQfgyUmvM
         PWXUQ6T9X4W7wNMcG4kcqG8CJa+iUad6qqbDeHTUQa3P+22iX6ujANNij0ErKLEwQTv8
         W7ma61dnHJF6yj1QASuNvLz/9i/JF3VekHkTjnF8EdgEVdwoozlRRzvVnqnpYogdsH18
         SkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ib7RAPbfbKwKwT5M4f1jjNI8X1DqgVyFDhXu+pU2YDc=;
        b=FUT3Bxl1MOxyU7OKWG49m4aOiXaoLaD/nH9thQll/rvtCDCEap0TIF/pCOlrnVkWav
         DzL1eqqMK8deoPBTpoC9IvbaXOQUWdZqKb/j5EQUCXm48YEldYHhu1EGBkBPzkUkP/Pc
         Z7VESq7Cx2q5RPN5mkW0mkP+pVqhWXOitF7viRIH7XLbSUuZvaLrhFwu9/v9+tEFsWtz
         wUoE8K2cCH4C9/4XKi5TBt2DvS8k82fk1ZpM1/njZVjJIoP5vpdw9eMgByandQz90Ayy
         M51iuJXOfnL25tCfd6oixwyDrzXOMudFHfDTD6UE5imgL8afU8xUnSG1Ympbgx2lNcOv
         yVlw==
X-Gm-Message-State: AOAM533TZDkJrCDddMuqhP14UAaCc1dadqP9xZ30nmX0PbaF5OecUNZe
        5JRr9cQwe+UyjfzgKgXYrMQyqg==
X-Google-Smtp-Source: ABdhPJyVdHLzLicsxAPsLrq7ExyFFcuw1c5u2QVn6IBOaYMRrKOmc4rGueAku/4U/9ofUGoaghdX4A==
X-Received: by 2002:a17:902:d30c:b029:fe:c349:14c1 with SMTP id b12-20020a170902d30cb02900fec34914c1mr1936785plc.81.1622108077583;
        Thu, 27 May 2021 02:34:37 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 08/12] mm: memcontrol: introduce memcg_reparent_ops
Date:   Thu, 27 May 2021 17:33:32 +0800
Message-Id: <20210527093336.14895-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
index 99f745e23607..336d80605763 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -354,6 +354,13 @@ struct mem_cgroup {
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
index d294504aea0c..470cdf0fbff1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -330,6 +330,35 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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
@@ -339,9 +368,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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
@@ -351,7 +384,13 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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

