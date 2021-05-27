Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0545039275E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhE0G0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhE0G0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575DC061763
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:24:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a7so1830016plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJFialfFytJYqFwPaZ9fuqS4bMePk6YbpU38QlCLQ58=;
        b=UnH3qWYxoooroXQ84YWu+wKRLhX33XZ8fReFOkElDGPZjIkYvD7Jr2qj/bawaxtuVk
         0wrpttY3vPBp708taxt6/qzJsuldK0fBy3bLgTCrPL3d0sC9numUAvWqXjuZXeELsvc/
         LMxaiK1APmuWQ9LaWXQKeYFHr4fqK8x8yylDOlhBWr+nvuDOhjHjszRXm7qi22/ExL70
         sxt45gqta9o5nuddGF1vkcXYREgjkAsocjKBfinC9o9HaNao8SOR+yFPVe7teNDGoP1E
         XyyvfKZ0MpR5fgkMVUA/dPdakTQo0UE9CyPKCmNj8sZ0YHL2McUxOmM5NWOicVtKPJqo
         CFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJFialfFytJYqFwPaZ9fuqS4bMePk6YbpU38QlCLQ58=;
        b=Q3rOkyHG8J1MIOxL8d3oD7lkhK/8WimQSGpSz+NFmc0Wn5/E75HGRzrQS4Izhf74PZ
         TwMovZ2JMLouvsWPQbtTAzorp+NuFDE+QcsMduDysl5CZEzYcbWIS1GFu7u9QGibSENp
         FieYw5LU5KvW4jvVnQyBGgXjT1WZlhpORm7KNNLWocQJVP7O4+rKY9/DuLWB5GCCk7ZF
         XEAstCLB2m0FOqakAKAGobMxTdtlg7I0cW27oUfIUGdyDhnC4ya3prVnW7BbiKiloJU0
         fVMfZDIaZzp78EIwbCvqLY401Kl2V9IUpqzgiYRWH8fXjp3ufXfUJXcHxaZOaXYhKQol
         1i0g==
X-Gm-Message-State: AOAM530bjcJJTdJHJO4uZvkF0L1a76j+2m5LYuyQWCznBghBbOtbhPYZ
        4Cw8iOnoDDB7m0z2H6W7RDszsg==
X-Google-Smtp-Source: ABdhPJwVyZdBlb+jbI2xQkR+YujTB8jkU0xSIH8ff8LC+cL41/CANvCFkoeDu7g/QOWAnNTmHbCb1g==
X-Received: by 2002:a17:90b:4ac5:: with SMTP id mh5mr2108699pjb.226.1622096675874;
        Wed, 26 May 2021 23:24:35 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:35 -0700 (PDT)
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
Subject: [PATCH v2 03/21] mm: memcontrol: remove the kmem states
Date:   Thu, 27 May 2021 14:21:30 +0800
Message-Id: <20210527062148.9361-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the kmem states is only used to indicate whether the kmem is
offline. Because css_alloc() could fail, then we didn't make the
kmem offline. In this case, we need the kmem state to mark this
so that memcg_free_kmem() can make the kmem offline.

However, we can set ->kmemcg_id to -1 to indicate the kmem has
been offline. So we can remove the kmem states to simplify the
code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 7 -------
 mm/memcontrol.c            | 9 +++------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ce97eff79e2..6d0638e13fc1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -182,12 +182,6 @@ struct mem_cgroup_thresholds {
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
@@ -320,7 +314,6 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
-	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9add859f69d7..23a9fc8dc143 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3630,7 +3630,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 		return 0;
 
 	BUG_ON(memcg->kmemcg_id >= 0);
-	BUG_ON(memcg->kmem_state);
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3647,7 +3646,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
-	memcg->kmem_state = KMEM_ONLINE;
 
 	return 0;
 }
@@ -3657,11 +3655,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
@@ -3675,12 +3671,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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

