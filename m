Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB28834FBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhCaIwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhCaIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:52:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:52:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so764386wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fwt0WLOhquJhgye7Yu7LsgU1jgDJ8L/oCfgCwbcLyss=;
        b=is3OwWphrHI3UOuP46knn5KlWCMcHkZHC05/gfR7trPJxNkYnd/f9IYazjk8kdgSlE
         BVpAoTGjiyDlmzpDqG0CtnZMujEKvPy4EApikV6/KfxWwL9aL8/zyzlTHg7XmS8sfl3P
         yJKaTuHcGiN42kwBVtX1r/iyFI3rJ7/Qoh0Quz1+QCJ+FKhqHp1dmYrbO7Rc3JanFqwo
         nxiLaQJX0cZ7UQMZr17GdKqQSyMgQN1KDOUaa/DW8lCnEbf+8Lg40GXm/L8NBLCz82fX
         286EfLx0U5W9HhFb7G25jQbxvD+JNwG8KankOmLbPZHoJtiJgQ7BC2qYkRB86h/paDgI
         AAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fwt0WLOhquJhgye7Yu7LsgU1jgDJ8L/oCfgCwbcLyss=;
        b=BBYkXL6RrVT91q/hOGZYGyAPSo9CLoojxwN5Uub0VJX3jthvJrM5Fp79QfSkzQDZPV
         iSHK03yPPmoyFr+sgUs4nZrxjaqoTESCHBFBzg03et+lj3q4yhT3qQF2MIQbkuiz1c6R
         Dcz9k94aEyKot3lfSRRxikPRRGAV3v8JMsYgBXApffrwDDWbT4gcc+JeDjukw/PNSTzB
         9YsF+6PQa/N5hmFvZ1aNtCpx6A6e4FHupBLf8Yy3SXGl+q8+/qRrBanpzqkl266bqV30
         u4PEpDch1DA+qAmWwPzRm+3dIYcM7KsYu1yc/mGGQggSPign5g8W2yxjsdCV9KxWIBKC
         dxCw==
X-Gm-Message-State: AOAM530sa9Kl6sw7gIeyQbCvg6jzj8Wg8VZdP9UefYM1tS1NS45okWr/
        V74/rJYC8mJ56VMjXqJE9T8=
X-Google-Smtp-Source: ABdhPJxd3JD9ULyFgXV/3YWsbDHBUQvZMFyPOZc/ACB0UowVHZULQIZLTGjN2r3Y6FsMkp/wLQIlGg==
X-Received: by 2002:a1c:bdc2:: with SMTP id n185mr2185771wmf.128.1617180719426;
        Wed, 31 Mar 2021 01:51:59 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:d1ec:8c5:2b34:58fe])
        by smtp.gmail.com with ESMTPSA id m11sm3205346wrz.40.2021.03.31.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 01:51:59 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oliver Glitta <glittao@gmail.com>
Subject: [PATCH v3 2/2] slub: remove resiliency_test() function
Date:   Wed, 31 Mar 2021 10:51:56 +0200
Message-Id: <20210331085156.5028-2-glittao@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331085156.5028-1-glittao@gmail.com>
References: <20210331085156.5028-1-glittao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Function resiliency_test() is hidden behind #ifdef
SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
runs it.

This function is replaced with KUnit test for SLUB added
by the previous patch "selftests: add a KUnit test for SLUB
debugging functionality".

Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/slub.c | 64 -------------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7083e89432d0..6eff5754895f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -153,9 +153,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  * - Variable sizing of the per node arrays
  */
 
-/* Enable to test recovery from slab corruption on boot */
-#undef SLUB_RESILIENCY_TEST
-
 /* Enable to log cmpxchg failures */
 #undef SLUB_DEBUG_CMPXCHG
 
@@ -4923,66 +4920,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 }
 #endif	/* CONFIG_SLUB_DEBUG */
 
-#ifdef SLUB_RESILIENCY_TEST
-static void __init resiliency_test(void)
-{
-	u8 *p;
-	int type = KMALLOC_NORMAL;
-
-	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
-
-	pr_err("SLUB resiliency testing\n");
-	pr_err("-----------------------\n");
-	pr_err("A. Corruption after allocation\n");
-
-	p = kzalloc(16, GFP_KERNEL);
-	p[16] = 0x12;
-	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
-	       p + 16);
-
-	validate_slab_cache(kmalloc_caches[type][4]);
-
-	/* Hmmm... The next two are dangerous */
-	p = kzalloc(32, GFP_KERNEL);
-	p[32 + sizeof(void *)] = 0x34;
-	pr_err("\n2. kmalloc-32: Clobber next pointer/next slab 0x34 -> -0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-
-	validate_slab_cache(kmalloc_caches[type][5]);
-	p = kzalloc(64, GFP_KERNEL);
-	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
-	*p = 0x56;
-	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-	validate_slab_cache(kmalloc_caches[type][6]);
-
-	pr_err("\nB. Corruption after free\n");
-	p = kzalloc(128, GFP_KERNEL);
-	kfree(p);
-	*p = 0x78;
-	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][7]);
-
-	p = kzalloc(256, GFP_KERNEL);
-	kfree(p);
-	p[50] = 0x9a;
-	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][8]);
-
-	p = kzalloc(512, GFP_KERNEL);
-	kfree(p);
-	p[512] = 0xab;
-	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][9]);
-}
-#else
-#ifdef CONFIG_SYSFS
-static void resiliency_test(void) {};
-#endif
-#endif	/* SLUB_RESILIENCY_TEST */
-
 #ifdef CONFIG_SYSFS
 enum slab_stat_type {
 	SL_ALL,			/* All slabs */
@@ -5831,7 +5768,6 @@ static int __init slab_sysfs_init(void)
 	}
 
 	mutex_unlock(&slab_mutex);
-	resiliency_test();
 	return 0;
 }
 
-- 
2.17.1

