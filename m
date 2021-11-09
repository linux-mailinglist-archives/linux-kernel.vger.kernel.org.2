Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19744A716
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbhKIG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbhKIG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:59:50 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA40C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:57:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b11so5982108pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XKMtNbhHard2yRQO8rFCjh0jyp/6c/s8q/mjmligM4=;
        b=aTp8Ll68DWdBAxBxCtQdANLlQKWtuEhwd0/T75cnUywhLq1CyenVIITsPjrA8sFYT7
         83PuMbn20BeizsO2YvQkQmA/r3GS752EFHleaeSWbCjJCdp1YOS16rqbzedjbtMPmi9A
         7hbYkHeMfVi1WOtipvn2NaV2W4z7LuFjzFHIoe08KIWKCV6bEtDk/AciN4XCRX/z+U4f
         05GZEwCibES9syHsUsdI9UmR5PGvOqErB8iWq30DNe6/YycSul0ZDNnV1GF/ztKV6anN
         ppoNFGR/Pt5WDiabL5rUUhQTb1fshGQLUtKQPv2D0DHkybiX9SN6QDkHGnc/xZq4l4WB
         OX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XKMtNbhHard2yRQO8rFCjh0jyp/6c/s8q/mjmligM4=;
        b=8AlEoFZ46p5E0+VzlGNc3Zpw2Ia51RjWCLvd/QGaJC79Z77OQ7ZC9D1mYq4FpQHbIG
         +zLr/qZUGydr4DAxh6qXwgCBVq3jPwjS+3WHPuPpbAYYuHm7ghwncbvSfNAvbikVFbuJ
         yTxvw0eE2MGajpJmH3RNYc36BxejipkAz9gW/HDKmKrkDII/RiMzPd6pptH/ukIzavmN
         0z2IQgiJW8kfb5wcBFP0YOppEK3EE4zh/n7li11wHQUxGfuQwN5l2XqtFrFRoiALVxaT
         bAphcyjLIhwRS9rDtYLV3dVD+sJMUwHpygxeryyGkCR7sZXdBjXaGUAqXwYtofykHQ+2
         Hc+w==
X-Gm-Message-State: AOAM530ueqbqOSE+8E2xp0a7GUhMZKD7pubwGpFcaau9H0Zc9PQAsTk0
        YwnQ7+Qo1azaB5Q2AwWbWvIX78MhXTa6eZYk
X-Google-Smtp-Source: ABdhPJyDQ8G3NeijGvDl3KVdjcylGfSlt21ZkJwtfAZgL5mIAc9E5GrN9dsW6AZI+zEy2W682XpfLw==
X-Received: by 2002:a17:902:900c:b0:13f:974c:19b0 with SMTP id a12-20020a170902900c00b0013f974c19b0mr4936931plp.12.1636441024400;
        Mon, 08 Nov 2021 22:57:04 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 142sm14254104pgh.22.2021.11.08.22.57.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 22:57:04 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: make cgroup_memory_nokmem static
Date:   Tue,  9 Nov 2021 14:54:18 +0800
Message-Id: <20211109065418.21693-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
caches") makes cgroup_memory_nokmem global, however, it is unnecessary
because there is already a function mem_cgroup_kmem_disabled() which
exports it.

Just make it static and replace it with mem_cgroup_kmem_disabled()
in mm/slab_common.c.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h    | 5 -----
 mm/memcontrol.c  | 2 +-
 mm/slab_common.c | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 18256e32a14c..ad15251d7a3c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -137,11 +137,6 @@ extern void putback_lru_page(struct page *page);
 extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
 
 /*
- * in mm/memcontrol.c:
- */
-extern bool cgroup_memory_nokmem;
-
-/*
  * in mm/page_alloc.c
  */
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f1d9c028897..89fc3ca65b2d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -84,7 +84,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
 static bool cgroup_memory_nosocket __ro_after_init;
 
 /* Kernel memory accounting disabled? */
-bool cgroup_memory_nokmem __ro_after_init;
+static bool cgroup_memory_nokmem __ro_after_init;
 
 /* Whether the swap controller is active */
 #ifdef CONFIG_MEMCG_SWAP
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e5d080a93009..d05203a11201 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -849,7 +849,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 	if (type == KMALLOC_RECLAIM) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
-		if (cgroup_memory_nokmem) {
+		if (mem_cgroup_kmem_disabled()) {
 			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
 			return;
 		}
-- 
2.11.0

