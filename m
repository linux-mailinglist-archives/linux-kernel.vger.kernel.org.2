Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6D4104A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhIRHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhIRHRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:17:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:16:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s11so11873225pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4eSocmINO9DM/nsnuozs7zFs5+R33uFfLe2OLUBhoI=;
        b=iiGWy30v0yGnAMDIN+Xw4shv6+BI7AW2yAHxsVxRudefH2vNl3p3ljyHDlXatjh7Kd
         bGaNOEusZK2e6V4fWzzmK0lcUggJlPQzdbkVh8UDV8cLkZE6NNYT1mk8r5EiNa/mA312
         7JNVzbVsAIVpfU+me43YAoy8NOCVcagU9ZHdAKJR2xWkiZ6PV5tYQb6J1WKwsmWwjgN+
         jLCO0aImTuPxlLXUwE3wT8U/aD4UaqSYCF+Brq/6SAaMtvH0e8B0OM9txpvbTwzB6VVB
         8GAjxDh/c3f8/Niwnzkq7bplo9tDLh0RvwQacDrDBGa4bd9YuYEOeJrIvoQBiNYzX/uJ
         kkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4eSocmINO9DM/nsnuozs7zFs5+R33uFfLe2OLUBhoI=;
        b=Yv4pG3INxuSrIqRLgh76r21L5BiUgaZ8dvKoiJ85T5YsGv0nThKG4GZtQYeIbkxbJ8
         aXREi66d2BKPrAinNX9jOlUnhsAPsbR8UxoEm4PNZzy4cj2erJGYaeUn6t0GLdQTI9Vo
         g8xo0L9xb8X1BF70A9aCcrJSNqcVkz/16xOfoGeNL7FakMeoK6SFbCJjxdeNfIYu4R/V
         SGKDxAKyk08lNIMHCFqCwciE/DE7bd9Cz8YGq2RoSvxkGwPTeuyDPs/oJohulIwNvgRM
         jmrdkypWO7B08FpLnMUsFMzFbof732xNaMw3A6kp5iIRkBkIzY3iWKlZ/N6/D5lyJP49
         R0kg==
X-Gm-Message-State: AOAM531KAHngr9paR1W0qvoBaX01p1cIM2mPggHQgs8NCzxfeE10Ser9
        GJilRDT1DwI1Zg3dl7ieSP+dFTEjiRY=
X-Google-Smtp-Source: ABdhPJxLFUrck4i3qspHVH2ydoDCp9EJBR9czP2rN46FQgIVoEn9Ech8WY3FHlVrHhbThEhnGcxaUQ==
X-Received: by 2002:a62:15ca:0:b0:43f:76a3:2988 with SMTP id 193-20020a6215ca000000b0043f76a32988mr14934060pfv.65.1631949370198;
        Sat, 18 Sep 2021 00:16:10 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id v3sm8080751pfc.193.2021.09.18.00.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:16:09 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     42.hyeyoo@gmail.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: slub: merge get_freelist into ___slab_alloc
Date:   Sat, 18 Sep 2021 07:15:51 +0000
Message-Id: <20210918071552.53171-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_freelist was introduced commit 213eeb9fd9d6 ("slub: Extract
get_freelist from __slab_alloc") and its comment says this function
transfers freelist to the per cpu freelist or deactivate page.

But what it actually does is just deactivating page and returning
its freelist. And the code working with variable 'new' is confusing
because it does nothing.

This function have been unmaintained for a long time and is confusing
reader. So simplify it for better readability.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 46 +++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..26fe1eb50d88 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2815,40 +2815,6 @@ static inline bool pfmemalloc_match_unsafe(struct page *page, gfp_t gfpflags)
 	return true;
 }
 
-/*
- * Check the page->freelist of a page and either transfer the freelist to the
- * per cpu freelist or deactivate the page.
- *
- * The page is still frozen if the return value is not NULL.
- *
- * If this function returns NULL then the page has been unfrozen.
- */
-static inline void *get_freelist(struct kmem_cache *s, struct page *page)
-{
-	struct page new;
-	unsigned long counters;
-	void *freelist;
-
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
-
-	do {
-		freelist = page->freelist;
-		counters = page->counters;
-
-		new.counters = counters;
-		VM_BUG_ON(!new.frozen);
-
-		new.inuse = page->objects;
-		new.frozen = freelist != NULL;
-
-	} while (!__cmpxchg_double_slab(s, page,
-		freelist, counters,
-		NULL, new.counters,
-		"get_freelist"));
-
-	return freelist;
-}
-
 /*
  * Slow path. The lockless freelist is empty or we need to perform
  * debugging duties.
@@ -2874,6 +2840,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	void *freelist;
 	struct page *page;
 	unsigned long flags;
+	unsigned long counters;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -2920,12 +2887,21 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_page;
 	}
+
 	freelist = c->freelist;
 	if (freelist)
 		goto load_freelist;
 
-	freelist = get_freelist(s, page);
+	/* deactivate page */
+	do {
+		freelist = page->freelist;
+		counters = page->counters;
+	} while (!__cmpxchg_double_slab(s, page,
+		freelist, counters,
+		NULL, counters,
+		"deactivate_page"));
 
+	/* there was no free objects in that page  */
 	if (!freelist) {
 		c->page = NULL;
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-- 
2.27.0

