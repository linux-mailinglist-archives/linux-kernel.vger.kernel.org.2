Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA664396BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhJYMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhJYMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:55:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3814FC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:53:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 83so4601788pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqjXJItGS4YzuoDfo84aL3q/TLgAPyW97JB5OeC7FWM=;
        b=awGrCLBqKt46OYGLaxkc6leqIztb7LxrGq1vcFMqQEAev80h84si95P9OEHaKRe8qh
         EU2o5D5xslyrPgpzUgei4rcVX0VO7mKXWAp5s4wsp+vH5bW+tNenb2qTjasVnkjohJs4
         woiQupfxfUyq1WMTSkVCFCP+xZtEqGNlGP7BqtfUe7GweQdUUMcroRn7E+MDoEHejTga
         7952lroUT/zox/0oUEXjZcGA50vLi/sF7CTlOe0Ia7QEhZeUbsZ7losWOEhkWPeKcJqV
         HLbxYLpnCN1t2dDq06Pw+685hOjmsYILh4h8g7vBmwOgnGy7kXGjetShrwQA8SUps7LL
         fk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqjXJItGS4YzuoDfo84aL3q/TLgAPyW97JB5OeC7FWM=;
        b=xX7v2+cLzwpbp6DqlTYHuGDlaxiubRWyLTfv1l7TsYL0J5/e0tv9prcYYx+WhOShwp
         29PnR/KE0H1UdDqeIhBTciHPn9T2bY4Tgs9XPKaSf3xcRA/K5g8G0ptTB8aMu1Ghzdps
         07QZCIDTyaFS4kONkPeRyCFiXYSQbkWTFWqsW9QWXlr77572+rQAMbk11+uN98t8WU8M
         tdeOUUu78wGqCDPRMKWbjtQWM/jXxRwHI17GaItabfddyLK/H4QuJOz+BENWP1/B+39w
         /AWFDlXK5A1Vj6G9OdwpO5NWPPqY8sPoOo8QvNfa6/myPLxaakvpzu5rysiYE8ohMRfP
         yrvQ==
X-Gm-Message-State: AOAM530oktScbJi2NNWWw2t9WHKVNwTrdB6FRLZGjG8hHYJGVqr6F08o
        rEaabgp6qOLrFvJIBQcN6HT6Yw==
X-Google-Smtp-Source: ABdhPJyDucaDmVgY0HaVFQaWMWYdh3bNqExErgbPMsdz40RdZBM+2lhdhO5CcoHxfOtqB6S6LPqhDg==
X-Received: by 2002:a05:6a00:1142:b0:44d:d43a:ac5d with SMTP id b2-20020a056a00114200b0044dd43aac5dmr17886234pfm.30.1635166415800;
        Mon, 25 Oct 2021 05:53:35 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20sm18679912pfn.136.2021.10.25.05.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:53:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, shakeelb@google.com,
        willy@infradead.org, guro@fb.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: remove the kmem states
Date:   Mon, 25 Oct 2021 20:52:59 +0800
Message-Id: <20211025125259.56624-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the kmem states is only used to indicate whether the kmem is
offline. However, we can set ->kmemcg_id to -1 to indicate whether
the kmem is offline. Finally, we can remove the kmem states to
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 7 -------
 mm/memcontrol.c            | 7 ++-----
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e34bf0cbdf55..509e1480e3be 100644
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
index e26f87cd7e4c..760e3669a7c8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3621,7 +3621,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 		return 0;
 
 	BUG_ON(memcg->kmemcg_id >= 0);
-	BUG_ON(memcg->kmem_state);
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3638,7 +3637,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
-	memcg->kmem_state = KMEM_ONLINE;
 
 	return 0;
 }
@@ -3648,11 +3646,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmem_state != KMEM_ONLINE)
+	if (memcg->kmemcg_id == -1)
 		return;
 
-	memcg->kmem_state = KMEM_ALLOCATED;
-
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3671,6 +3667,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
+	memcg->kmemcg_id = -1;
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.11.0

