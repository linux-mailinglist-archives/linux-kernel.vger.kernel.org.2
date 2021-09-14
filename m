Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB040A77E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbhINHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240967AbhINHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:34:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A7C0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h3so11932174pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vnv6075e5xDpDmjVmdi7yoSCEZdGGyfQtI+r26s3BY0=;
        b=MXKF76sadscNWBEDPyWQ6ydw7qu1qu4KQ08PzoC25+M2nyogxyvWh6Vo6e6fuT9KjJ
         EPHFNIl5glwAj56Ghs9GNUoPI5ErOuZk44qv75QztfuFwjeTeG1L4pSr8kFop1qlM185
         nk/1J905u3EnKNBvCR6k/ukz51CCK3AScv60qazmh0X2omMmZGLRYGVBjaHI6si1YQBK
         VUQfLSZXq0wr0J2vgQZzlelhA5p8DH2WQpGrCT5TqlNJuj0rsY5ZNP0OE4RjwPJZ51Ib
         uuB3dT4G7NTTtGEU2UY7ZoxlHFdq57sVDFnJ6bgKQPwrdgqyd+PSzTju40UnVnea5lLX
         aPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vnv6075e5xDpDmjVmdi7yoSCEZdGGyfQtI+r26s3BY0=;
        b=KNTfDO24dugu6kmPxEvxmOil2TYVtUB5viJIGbeI9/1wPD0FgcnWARVvjyoXT5EWId
         NkL6iK8nWfbQvGLHG8jirO+BIMclI7CtUSDo9iu+7sCT/J7VbrB4JsyfmoqWAzLjjG9P
         MvSdPdBO10aYV7lLYxG7njnW0/I02ALOGf0bAOQVuCGkM23kZQnL/0NYerTkgqRpjNMG
         QD2ezojLc1odXbufXVIN4nOKReefo7dLMeBobSqZtxbGIgaStC4N4uGhpxh/mE2MIU/A
         HxAc9cG9Pd1Qucin4LeUCvAhdS7k9S7HST03fuEY5NwkVcMO4566e4Q7L9UtjZfMdIxc
         IYBQ==
X-Gm-Message-State: AOAM532tmIi9l70W7fL8R6w5bounkJIAZVKUQ6104o607c9rwF4tnUSS
        7hZj3130xihY1prC3j0/D1l1gA==
X-Google-Smtp-Source: ABdhPJyTYPgvYnhqECa/3pKjPwUP5/+kEmpd9Rxi8q+BV0aFN3ZhNlHMttkuLtRDk2VCixzj2EEC1Q==
X-Received: by 2002:a63:da49:: with SMTP id l9mr14246393pgj.277.1631604797007;
        Tue, 14 Sep 2021 00:33:17 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 03/76] mm: memcontrol: remove the kmem states
Date:   Tue, 14 Sep 2021 15:28:25 +0800
Message-Id: <20210914072938.6440-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the kmem states is only used to indicate whether the kmem is
offline. Because css_alloc() could fail, then we didn't make the
kmem offline. In this case, we need the kmem state to mark this
so that memcg_free_kmem() can make the kmem offline.

However, we can set ->kmemcg_id to -1 to indicate the kmem is
offline. Actually, we can remove the kmem states to simplify the
code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 7 -------
 mm/memcontrol.c            | 9 +++------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3a0ce40090c6..7267cf9d1f3d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -180,12 +180,6 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
-enum memcg_kmem_state {
-	KMEM_NONE,
-	KMEM_ALLOCATED,
-	KMEM_ONLINE,
-};
-
 #if defined(CONFIG_SMP)
 struct memcg_padding {
 	char x[0];
@@ -318,7 +312,6 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
-	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e0d7ceb0db26..6844d8b511d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3611,7 +3611,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 		return 0;
 
 	BUG_ON(memcg->kmemcg_id >= 0);
-	BUG_ON(memcg->kmem_state);
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3628,7 +3627,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
-	memcg->kmem_state = KMEM_ONLINE;
 
 	return 0;
 }
@@ -3638,11 +3636,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmem_state != KMEM_ONLINE)
+	if (cgroup_memory_nokmem)
 		return;
 
-	memcg->kmem_state = KMEM_ALLOCATED;
-
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3656,12 +3652,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
+	memcg->kmemcg_id = -1;
 }
 
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 	/* css_alloc() failed, offlining didn't happen */
-	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
+	if (unlikely(memcg->kmemcg_id != -1))
 		memcg_offline_kmem(memcg);
 }
 #else
-- 
2.11.0

