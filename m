Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C736639F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhDUC0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhDUCZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:25:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C21C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 19:25:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h15so9539534pfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dCJhI1fJvUae+RK1az1zv2HWWPb9fK682R4tcWUrdw=;
        b=WB5zZwfCqIVs7HgZ87AobyF4tz7HDBk0ZqdY/tjhYPQSkYqJGnyKTdC23bGM7v4wSn
         hRE6tncwr0sZMLV1ayrJ9udYmY6RvBpcoX22IQJkhmt5in8lbRAst9jRsFXT3VNj9BM6
         k8/hRYeo/XKxO4bptdslAwJu0UosAoCex7RzQtKh65pqcTI40OZZ8TKTlgygkkz9j1DI
         HJhI8/bBHizyryLAs6ODGTwMBiBbGb5TNNZDcAsaKHNykW7qmH+vFIqxNJR6TyT5GJDg
         8CVc0ZPK3KdcgDn46pWTIg3u9YIO53bpwrtBzrSeatwP8Nvban02UM7BEZfczcQSp7Ru
         /Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dCJhI1fJvUae+RK1az1zv2HWWPb9fK682R4tcWUrdw=;
        b=knL3eagHM2O0m43qB90vCD2mxZdkKTIOTLrZG4ZkR/1s7c9nHxteP2yIcItxfzz7WG
         TVakO+0UbKVca1s2xXlmgFJIPJFl++HPFpIbsoVYahBdTJb1uOg2dzSRPUoQG1Lvxfxi
         AE1npLprbhA9i8iqzOtpH4c3v4U/NHoATFp0/NNoa3FgK8oP/p3yzVw3CVoTP3tB3uyS
         aELtZLl6XGOPzkzzWtK7CLZVWhD1lOFEKb+Tvxzs/VQM5KW3WfQXxIlmUT6dxsqo8oP7
         JnMESwuc6luTjceFnoxOGP0axfoTC85xbUrCw3JiSTVtTB9nufqd+W2wjVbV+Jk/W3vM
         UCtw==
X-Gm-Message-State: AOAM5309ocOd9bmTsTLM1Xlo/N/eaEgWY42PpWdkGHFKfEJCekYCnyeW
        3IHUzfBIDgf5Cm8fEwSJWKQ=
X-Google-Smtp-Source: ABdhPJx2BVmJvDjs+S+GjL1n4IfWIXRiYNYSrxk9wJ6LVMcArDvbYJ2vtVLbCbtb8HcIUrJFpY/39w==
X-Received: by 2002:a17:90a:e54c:: with SMTP id ei12mr8185477pjb.164.1618971926628;
        Tue, 20 Apr 2021 19:25:26 -0700 (PDT)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id x18sm279583pfp.57.2021.04.20.19.25.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 19:25:26 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yejune Deng <yejune.deng@gmail.com>
Subject: [PATCH] mm/slab.c: use 'ac' from the caller
Date:   Wed, 21 Apr 2021 10:25:17 +0800
Message-Id: <20210421022518.67451-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can use 'ac' from ____cache_alloc() in cache_alloc_refill().
This saves call cpu_cache_get() twice.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 mm/slab.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index d0f725637663..4b2dc8f8cc37 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2896,11 +2896,11 @@ static __always_inline int alloc_block(struct kmem_cache *cachep,
 	return batchcount;
 }
 
-static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
+static void *cache_alloc_refill(struct kmem_cache *cachep, struct array_cache *ac, gfp_t flags)
 {
 	int batchcount;
 	struct kmem_cache_node *n;
-	struct array_cache *ac, *shared;
+	struct array_cache *shared;
 	int node;
 	void *list = NULL;
 	struct page *page;
@@ -2908,7 +2908,6 @@ static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
 	check_irq_off();
 	node = numa_mem_id();
 
-	ac = cpu_cache_get(cachep);
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
 		/*
@@ -3045,12 +3044,7 @@ static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 	}
 
 	STATS_INC_ALLOCMISS(cachep);
-	objp = cache_alloc_refill(cachep, flags);
-	/*
-	 * the 'ac' may be updated by cache_alloc_refill(),
-	 * and kmemleak_erase() requires its correct value.
-	 */
-	ac = cpu_cache_get(cachep);
+	objp = cache_alloc_refill(cachep, ac, flags);
 
 out:
 	/*
-- 
2.29.0

