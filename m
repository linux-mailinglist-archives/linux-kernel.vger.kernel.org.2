Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154733EBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCQIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCQIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:47:47 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E83C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:47:47 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id z26so10408395wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mQ9lVwNHA8xNGK/XyR+U8c7RoXUhm2JAea9oSpZR7Gk=;
        b=PqGjPWsZbO2fcKM9P4rv6POFLtYh4YOitqiF+q7Zg2a2KPrY6b7wV/O9TFvNlAJWS2
         MJH8Kue1m2y3aBhCR6X/8L+mdgkMWeRTyNQjfD18x2JfAUTT8qgVJCgZ6WPq6RMAXNzA
         7e9VE2eiZ65Xbwbi36YNXS5iyOSjgho+3ROFavU3ltnD0+ABCTKtQryUzeum3vFlpBU7
         HY/XACtWT4/bbDHnIwWkmicvgZptD8MtfIgZkgE9otdYGy4e0ydUfU7SkN7bp8PoKyV6
         Auzno6pwAz2gnNf5v+TTaaBnDOS9Lh1SC0U6pnCFbGytNO4FkkdxB2JWHyYLZsgw0T25
         3g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mQ9lVwNHA8xNGK/XyR+U8c7RoXUhm2JAea9oSpZR7Gk=;
        b=XA4I8bBoeD8vUDfPcavoFeuPiIFZTXGMyQkjBIbVQzJA70QoeHdns2mb+8eFzOKbR6
         8dRVqqXtxN+5kmVD/X8xYNlykYXOieBbpIN5gzX0zuBhUP2P16S8lvaEimCyb+rAeCmu
         4QLrAg91hmDpgd0Ljong2JA+kIIVjqm1UPaHHmFTFNUPdH7FpuvPL56cfOu8BkTtxVQe
         wkzpL9oO5KV3r9FGIWi67LDMJ52RJ1OQptxp0OQ8DXlVKHGvmcFBOSixZbrbKiTxkjUy
         67+1C9FNZbgOYedhkTr1oUDVvOFKTlgn/xWCTH4IAEuIRgCecIy8I6lQrKFPvtB2dNN3
         0HcA==
X-Gm-Message-State: AOAM531y6o/5TFQEZDL2F7hhDFZG42T88Af1TVwl1hv/J49gq15E4D/J
        DYHibvk1IpLv/wde+Ny985u0CXtGDA==
X-Google-Smtp-Source: ABdhPJyAxCG5vAkt29ipWf6uJkzF45lSYb3n8NVyVhwEJL5o0nZ3JUAkE9TJevfWiJrpEB38wUVZL/1gWg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1d09:9676:5eaa:550])
 (user=elver job=sendgmr) by 2002:a7b:c047:: with SMTP id u7mr2656333wmc.98.1615970865676;
 Wed, 17 Mar 2021 01:47:45 -0700 (PDT)
Date:   Wed, 17 Mar 2021 09:47:40 +0100
Message-Id: <20210317084740.3099921-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH mm] kfence: make compatible with kmemleak
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Luis Henriques <lhenriques@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because memblock allocations are registered with kmemleak, the KFENCE
pool was seen by kmemleak as one large object. Later allocations through
kfence_alloc() that were registered with kmemleak via
slab_post_alloc_hook() would then overlap and trigger a warning.
Therefore, once the pool is initialized, we can remove (free) it from
kmemleak again, since it should be treated as allocator-internal and be
seen as "free memory".

The second problem is that kmemleak is passed the rounded size, and not
the originally requested size, which is also the size of KFENCE objects.
To avoid kmemleak scanning past the end of an object and trigger a
KFENCE out-of-bounds error, fix the size if it is a KFENCE object.

For simplicity, to avoid a call to kfence_ksize() in
slab_post_alloc_hook() (and avoid new IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)
guard), just call kfence_ksize() in mm/kmemleak.c:create_object().

Reported-by: Luis Henriques <lhenriques@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 9 +++++++++
 mm/kmemleak.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index f7106f28443d..768dbd58170d 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
+#include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
@@ -481,6 +482,14 @@ static bool __init kfence_init_pool(void)
 		addr += 2 * PAGE_SIZE;
 	}
 
+	/*
+	 * The pool is live and will never be deallocated from this point on.
+	 * Remove the pool object from the kmemleak object tree, as it would
+	 * otherwise overlap with allocations returned by kfence_alloc(), which
+	 * are registered with kmemleak through the slab post-alloc hook.
+	 */
+	kmemleak_free(__kfence_pool);
+
 	return true;
 
 err:
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c0014d3b91c1..fe6e3ae8e8c6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -97,6 +97,7 @@
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
@@ -589,7 +590,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
-	object->size = size;
+	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
 	object->min_count = min_count;
 	object->count = 0;			/* white color initially */
-- 
2.31.0.rc2.261.g7f71774620-goog

