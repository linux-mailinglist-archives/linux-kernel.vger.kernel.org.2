Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD19359EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhDIMcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhDIMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55276C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k8so3792589pgf.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KboWzAA0Vo1Ky5mj5yxHhRMCFO2+9SMKFGuBaMmV7vg=;
        b=Fn+4FB9vLM9YrQj9Me1zs6sH/n4f8nrDEsuMRHxSCrQ4oIBF0ErYthEs5c5YPYxpgF
         OKP9kF0CU5WEWtQF55Lfa7A2AiYr2FAnylG5iCg0FVDLvSyBRJiAdrkXjOi7qKwZLiCe
         aqCJxtuDhVYDe3UoeTvHnA1CCFNNyp3Xv8/F4ZgVSJUM0t5ycK0XqOUJdFhkvZFex811
         /HjG9IBdMBp04eWC3BbTJy4MY3Nx1j6QPO8EcC289R+SYh5YK7rPZXJzskFqDfb10MrF
         jfIAvegBXUAdMiiQww1pVjvG5AeexX/BoWkTeZ6HZkwU2XCmTjyLrtj5G15IX1t9uKdg
         qFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KboWzAA0Vo1Ky5mj5yxHhRMCFO2+9SMKFGuBaMmV7vg=;
        b=V308YyI95qDzfSpixclaGO1Vw7Y/PwikaF4tV2DiVlMZH99oXqaiBo3f1bNQEH9E4k
         Q+wH3k1L9J3xadGnzfp5UnU3zy8OEYV7xpjDoE9YTOJtdSfkfCS36WBBIeFWh8OsPbxn
         CrUgCQR315/bKrhGWWtQyvKUAJjWzFFqvC43lapsjgwhdyv9Mk4963loBXcAIaFiJ+E3
         NTAFrPeiXPQuG4SeT8YA+a/obeVKcZZ8nqsxIwK11uzfDiIABrxVN8DDhlX9wkg6FqJM
         BihstmP821snSh2Au8ShCYHQZI9lzAlUU8Poz7zBnDcK/zA3WHFzs8EAqbYnO/rItFwX
         bJrw==
X-Gm-Message-State: AOAM531wFziuYfRXJzfp2bKM1ju4IVDJ3ee4rRTgfDF7c6GEcJhn9zk1
        c2fvNk8dV+jqUQUq/e7+fekqIg==
X-Google-Smtp-Source: ABdhPJy4EUwCPJplsg2FCY/PfNvR8+q2FxSz6X7rdJ98QKB0KOwEImFa1X8fqxQvMxKBXBCgykJIXQ==
X-Received: by 2002:a63:1d1:: with SMTP id 200mr9444674pgb.375.1617971540915;
        Fri, 09 Apr 2021 05:32:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 05/18] mm: memcontrol: simplify the logic of objcg pinning memcg
Date:   Fri,  9 Apr 2021 20:29:46 +0800
Message-Id: <20210409122959.82264-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
the css_set_lock. We do not need to care about objcg->memcg being
released in the process of obj_cgroup_release(). So there is no need
to pin memcg before releasing objcg. Remove those pinning logic to
simplfy the code.

There are only two places that modifies the objcg->memcg. One is the
initialization to objcg->memcg in the memcg_online_kmem(), another
is objcgs reparenting in the memcg_reparent_objcgs(). It is also
impossible for the two to run in parallel. So xchg() is unnecessary
and it is enough to use WRITE_ONCE().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1f807448233e..90c1ac58c64c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,7 +261,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
-	struct mem_cgroup *memcg;
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
 	unsigned long flags;
@@ -291,11 +290,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	spin_lock_irqsave(&css_set_lock, flags);
-	memcg = obj_cgroup_memcg(objcg);
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 	list_del(&objcg->list);
-	mem_cgroup_put(memcg);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
 	percpu_ref_exit(ref);
@@ -330,17 +327,14 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 
 	spin_lock_irq(&css_set_lock);
 
-	/* Move active objcg to the parent's list */
-	xchg(&objcg->memcg, parent);
-	css_get(&parent->css);
-	list_add(&objcg->list, &parent->objcg_list);
+	/* 1) Ready to reparent active objcg. */
+	list_add(&objcg->list, &memcg->objcg_list);
 
-	/* Move already reparented objcgs to the parent's list */
-	list_for_each_entry(iter, &memcg->objcg_list, list) {
-		css_get(&parent->css);
-		xchg(&iter->memcg, parent);
-		css_put(&memcg->css);
-	}
+	/* 2) Reparent active objcg and already reparented objcgs to parent. */
+	list_for_each_entry(iter, &memcg->objcg_list, list)
+		WRITE_ONCE(iter->memcg, parent);
+
+	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.11.0

