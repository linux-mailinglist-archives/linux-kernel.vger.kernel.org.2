Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9884E433378
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhJSK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbhJSK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:27:46 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18981C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:25:34 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id o137-20020a1ca58f000000b0030d89b84726so634202wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QtB1JTnzUP+wCjNXipQfBq+gxdYpMqzkTaAZVfPtWwI=;
        b=bLgLHB1EsD6Xqf/nesKeJq6K8NpxXqKu4siGjC40FCFeSYan7eAaWhX7avRE0Bepx7
         Y6qqbNNQ/A07vx4efyod3le2wZ1p0cD080aqYbKGx/yslzQBooO1UxzORc5d40hIkkHa
         Ga1Ohc+v/to6XT8CiBIBVksccv9L0oaOuTrPxR7CXdMB5lyUOZcT4dHf35Hkeeymuw7h
         CEU5Lzj7I64RNr6Jrb2CNAZvzltzYzY00qRW0N7Ncs+7YOjUimB0ws/wHXbitiQzBWxC
         DliOsP4jxlnlkvyCSdiiboBPbx4rq2bRzjz7oD0B8+j0lOyKnqW15UegbpXWk2NAY2zJ
         teUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QtB1JTnzUP+wCjNXipQfBq+gxdYpMqzkTaAZVfPtWwI=;
        b=nEx3TcYcUK6Bm1NQfNBS+zqYHN8YJPdV4HhGeC9hqgkDW/BDXpBo1K5XPJFa/ziykz
         CC3CZkZKCiF7z2+x9Q9xX09i2maE+DqjON13jNe5SLegxJG3AShFUJHslJxA7A8hNzDi
         ZBlUcdJ3PJtJidFPv5BTej8/OaPyhhC6S8ZQ70p3bCnIwMpkSBMSLQQDxYE/6HlITY3B
         ktth488iWyJ2lOnuxE0jj9nLG+0cGuEpyej2dcT5+QkId/XoFNagljiJz9DGOlf1da9G
         CeTCRUhtswsPeRjRtaCDPN5l3C4A2Eg1EKZDB3gO5VyyGFtFHzdNxx2vDknWZhpeJorG
         zldg==
X-Gm-Message-State: AOAM530pGUjSbxAC0UOhN+B4aYNZ1n3JnHtsL7ovReWC2XQ1duPUvJL1
        htd6b9E0SUjWY5rw2S+J7jqhaFFRMw==
X-Google-Smtp-Source: ABdhPJw1fLlelqg3KerFPx343JWE60pNjScsycCfcOz5DzweIH6O9KAzUxjmnPsfsZtQilKbBZ4HhNNpzw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:feca:f6ef:d785:c732])
 (user=elver job=sendgmr) by 2002:a1c:f31a:: with SMTP id q26mr5061343wmq.148.1634639132518;
 Tue, 19 Oct 2021 03:25:32 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:25:23 +0200
Message-Id: <20211019102524.2807208-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/2] kfence: always use static branches to guard kfence_alloc()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of KFENCE mode (CONFIG_KFENCE_STATIC_KEYS: either using
static keys to gate allocations, or using a simple dynamic branch),
always use a static branch to avoid the dynamic branch in kfence_alloc()
if KFENCE was disabled at boot.

For CONFIG_KFENCE_STATIC_KEYS=n, this now avoids the dynamic branch if
KFENCE was disabled at boot.

To simplify, also unifies the location where kfence_allocation_gate is
read-checked to just be inline in kfence_alloc().

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kfence.h | 21 +++++++++++----------
 mm/kfence/core.c       | 16 +++++++---------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 3fe6dd8a18c1..4b5e3679a72c 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -14,6 +14,9 @@
 
 #ifdef CONFIG_KFENCE
 
+#include <linux/atomic.h>
+#include <linux/static_key.h>
+
 /*
  * We allocate an even number of pages, as it simplifies calculations to map
  * address to metadata indices; effectively, the very first page serves as an
@@ -22,13 +25,8 @@
 #define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
 extern char *__kfence_pool;
 
-#ifdef CONFIG_KFENCE_STATIC_KEYS
-#include <linux/static_key.h>
 DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
-#else
-#include <linux/atomic.h>
 extern atomic_t kfence_allocation_gate;
-#endif
 
 /**
  * is_kfence_address() - check if an address belongs to KFENCE pool
@@ -116,13 +114,16 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags);
  */
 static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 {
-#ifdef CONFIG_KFENCE_STATIC_KEYS
-	if (static_branch_unlikely(&kfence_allocation_key))
+#if defined(CONFIG_KFENCE_STATIC_KEYS) || CONFIG_KFENCE_SAMPLE_INTERVAL == 0
+	if (!static_branch_unlikely(&kfence_allocation_key))
+		return NULL;
 #else
-	if (unlikely(!atomic_read(&kfence_allocation_gate)))
+	if (!static_branch_likely(&kfence_allocation_key))
+		return NULL;
 #endif
-		return __kfence_alloc(s, size, flags);
-	return NULL;
+	if (likely(atomic_read(&kfence_allocation_gate)))
+		return NULL;
+	return __kfence_alloc(s, size, flags);
 }
 
 /**
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 802905b1c89b..09945784df9e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -104,10 +104,11 @@ struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
 static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
 static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freelist. */
 
-#ifdef CONFIG_KFENCE_STATIC_KEYS
-/* The static key to set up a KFENCE allocation. */
+/*
+ * The static key to set up a KFENCE allocation; or if static keys are not used
+ * to gate allocations, to avoid a load and compare if KFENCE is disabled.
+ */
 DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
-#endif
 
 /* Gates the allocation, ensuring only one succeeds in a given period. */
 atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
@@ -774,6 +775,8 @@ void __init kfence_init(void)
 		return;
 	}
 
+	if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
+		static_branch_enable(&kfence_allocation_key);
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
@@ -866,12 +869,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 		return NULL;
 	}
 
-	/*
-	 * allocation_gate only needs to become non-zero, so it doesn't make
-	 * sense to continue writing to it and pay the associated contention
-	 * cost, in case we have a large number of concurrent allocations.
-	 */
-	if (atomic_read(&kfence_allocation_gate) || atomic_inc_return(&kfence_allocation_gate) > 1)
+	if (atomic_inc_return(&kfence_allocation_gate) > 1)
 		return NULL;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 	/*
-- 
2.33.0.1079.g6e70778dc9-goog

