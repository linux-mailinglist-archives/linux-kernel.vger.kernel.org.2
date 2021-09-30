Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE21041DDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbhI3PjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344500AbhI3PjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:39:01 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917BAC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:37:18 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z62-20020a509e44000000b003da839b9821so6728137ede.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yWAvf4aQlVR2F4yVcHUaOtHEh1BNX6MVAiZjUIr82Uk=;
        b=agJQ6ParoQ5qoZN/UB6cQqFuJimcYA6IkRfvw62IlHl4ENmP0QKUEirlzUF9NqEeQR
         gzPkp9DGPVJlmuy/fUVk6MtQmDdJbJ+T8xF5cWkxtYk5fmnACVV3VE/gE6tM2BJYHMBe
         9eysVUrRAF9iNVlcwKDaawscJ45v/umjbSOR2AjaR3oSCzbTJoyObZEmSJX1aaR94FXM
         52OGDACT8JRCYzJOVnXwQS3jJosLqYEOg/OSpUF20FZXnL1hrQBeyJOktKR4hp0KolXi
         D7jwm0XblroooRYDavrCeWYlkP90SE9iAtI28DKB5MUeXfZ1+4RQHIQJZE8rivs+KQky
         ytTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yWAvf4aQlVR2F4yVcHUaOtHEh1BNX6MVAiZjUIr82Uk=;
        b=4P5a/CqY/HuNMiCQZt0aED6Bbhjc6G1t2kPYRkDuzyMFzV/ubZ4yq/p4qKkZjc5jVt
         Q/Xcn+xySKZrkR3//U8lcWYjdFPMhoegBMvk7RjtLlWNTOe2th8O5VHUqICqRPoSG5Nq
         r7X0acFKwbX7keCPN3sLVy32eUZ/5JRhmdrlqsebogOVDzoiHUgqmhsmNbp1eRj2Tf/f
         RZMfN2n8DKL7MLAUqvN8wPNNe3VDRD9B9MfO1yV61sX+RvaiATBv5v8UJTEMjFs9XaHK
         q85wAAlXTz7QnPPvHxE3Gn4O8pVV+wJfJG883M7mPPFGG0fyyLdve4u+mReahqVm7a7t
         1I5A==
X-Gm-Message-State: AOAM533RZaY9fS7RGC362dTjw7ejP5K8Q7GopkL2oQSsVAVio5g7fVT5
        T7Kxq2Ggz85CPJ6Z2KUxt9ZwMlfarQ==
X-Google-Smtp-Source: ABdhPJxWIKdJoMfJk5APMrRcVXFXeqnuCl45P2uJdVgvCuTsu/ahFUcn5cJnOpeO/+mraM71DX4uVuZ1pw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4c54:2b8f:fabf:78b0])
 (user=elver job=sendgmr) by 2002:a05:6402:21ef:: with SMTP id
 ce15mr7675136edb.19.1633016237037; Thu, 30 Sep 2021 08:37:17 -0700 (PDT)
Date:   Thu, 30 Sep 2021 17:37:06 +0200
Message-Id: <20210930153706.2105471-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] kfence: shorten critical sections of alloc/free
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

Initializing memory and setting/checking the canary bytes is relatively
expensive, and doing so in the meta->lock critical sections extends the
duration with preemption and interrupts disabled unnecessarily.

Any reads to meta->addr and meta->size in kfence_guarded_alloc() and
kfence_guarded_free() don't require locking meta->lock as long as the
object is removed from the freelist: only kfence_guarded_alloc() sets
meta->addr and meta->size after removing it from the freelist,  which
requires a preceding kfence_guarded_free() returning it to the list or
the initial state.

Therefore move reads to meta->addr and meta->size, including expensive
memory initialization using them, out of meta->lock critical sections.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index b61ef93d9f98..802905b1c89b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -309,12 +309,19 @@ static inline bool set_canary_byte(u8 *addr)
 /* Check canary byte at @addr. */
 static inline bool check_canary_byte(u8 *addr)
 {
+	struct kfence_metadata *meta;
+	unsigned long flags;
+
 	if (likely(*addr == KFENCE_CANARY_PATTERN(addr)))
 		return true;
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
-	kfence_report_error((unsigned long)addr, false, NULL, addr_to_metadata((unsigned long)addr),
-			    KFENCE_ERROR_CORRUPTION);
+
+	meta = addr_to_metadata((unsigned long)addr);
+	raw_spin_lock_irqsave(&meta->lock, flags);
+	kfence_report_error((unsigned long)addr, false, NULL, meta, KFENCE_ERROR_CORRUPTION);
+	raw_spin_unlock_irqrestore(&meta->lock, flags);
+
 	return false;
 }
 
@@ -324,8 +331,6 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
 	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
 	unsigned long addr;
 
-	lockdep_assert_held(&meta->lock);
-
 	/*
 	 * We'll iterate over each canary byte per-side until fn() returns
 	 * false. However, we'll still iterate over the canary bytes to the
@@ -414,8 +419,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	WRITE_ONCE(meta->cache, cache);
 	meta->size = size;
 	meta->alloc_stack_hash = alloc_stack_hash;
+	raw_spin_unlock_irqrestore(&meta->lock, flags);
 
-	for_each_canary(meta, set_canary_byte);
+	alloc_covered_add(alloc_stack_hash, 1);
 
 	/* Set required struct page fields. */
 	page = virt_to_page(meta->addr);
@@ -425,11 +431,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	if (IS_ENABLED(CONFIG_SLAB))
 		page->s_mem = addr;
 
-	raw_spin_unlock_irqrestore(&meta->lock, flags);
-
-	alloc_covered_add(alloc_stack_hash, 1);
-
 	/* Memory initialization. */
+	for_each_canary(meta, set_canary_byte);
 
 	/*
 	 * We check slab_want_init_on_alloc() ourselves, rather than letting
@@ -454,6 +457,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 {
 	struct kcsan_scoped_access assert_page_exclusive;
 	unsigned long flags;
+	bool init;
 
 	raw_spin_lock_irqsave(&meta->lock, flags);
 
@@ -481,6 +485,13 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 		meta->unprotected_page = 0;
 	}
 
+	/* Mark the object as freed. */
+	metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
+	init = slab_want_init_on_free(meta->cache);
+	raw_spin_unlock_irqrestore(&meta->lock, flags);
+
+	alloc_covered_add(meta->alloc_stack_hash, -1);
+
 	/* Check canary bytes for memory corruption. */
 	for_each_canary(meta, check_canary_byte);
 
@@ -489,16 +500,9 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 	 * data is still there, and after a use-after-free is detected, we
 	 * unprotect the page, so the data is still accessible.
 	 */
-	if (!zombie && unlikely(slab_want_init_on_free(meta->cache)))
+	if (!zombie && unlikely(init))
 		memzero_explicit(addr, meta->size);
 
-	/* Mark the object as freed. */
-	metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
-
-	raw_spin_unlock_irqrestore(&meta->lock, flags);
-
-	alloc_covered_add(meta->alloc_stack_hash, -1);
-
 	/* Protect to detect use-after-frees. */
 	kfence_protect((unsigned long)addr);
 
-- 
2.33.0.685.g46640cef36-goog

