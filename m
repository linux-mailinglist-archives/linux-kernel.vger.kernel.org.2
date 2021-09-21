Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2122E413155
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhIUKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhIUKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:11:56 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B3C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:27 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id j16-20020adfa550000000b0016012acc443so3013362wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4f6yUJ+4Yot7zlWdOonsXRBu3J0/vvau8TCpbcwqOZE=;
        b=FhrffzQuuvwmcqfZInJt7xW7xX09gltSG0J7M3O03dANv0GcgQW9opGQFiwzomyoHU
         iAWtFimWyOqrk1dBiqwcLrH5F302D9FtWfW4BT1nkjgKvovvewNaaWNayowTUh1MCjbR
         /kuw9LPqZWmhLsryAUecaX1Zs1ubY6C5tLNsB2rrV+8Dowzmz1sM4tvxXnUMtXTaSSRQ
         uzewm2xXpyaegumJhsKYghqUCiWooIJbPqrtqy5oJrE0F0nozAdbvdNdvdMPkf+ECgNI
         NtakRX6VkT7rP0nSVRo+cgxE4kmfvpi+I6Nepe1o7FUgVoWT1NWBQV/D6+l8b0wVuloi
         DwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4f6yUJ+4Yot7zlWdOonsXRBu3J0/vvau8TCpbcwqOZE=;
        b=6tiEPQf4jCTKMFqdYfrP2YwngHC22+GO3fHXDb4FzxAkjEI2ri9PH+Gtj23Edf0w/b
         N0mL0C9xDURXsfYhFA+9II4YylqnIdL3fgYh5j9fJ7wg4PMwRTSzxx2dxLGOapEw05k+
         qr2+gim+H4dJiSFlxu+8SvvhJPYICDSZv4kxlJ7ZDPYLFDPoh3N1XUjIP3o7hD6tgOe8
         eR4QoiUjtEa4u2hlP7M24vD1Qidp141fCcwJdUa0Hrt3vwxvV0oilDvh6ryjWL9OlL9T
         oaCJaiMCB3h6D3nfRbMlEirKg89gocuhZvrapjdThlXVAWzGu988XkeNH4m4df/+JHQA
         3Z9w==
X-Gm-Message-State: AOAM531hklTljMVVMlQupw9r+LqzfpGu6eBjVckf/3uSf3NPJH6A9vbs
        m5rwcZA1GPv0WuzR/PI2zzYn1yZHig==
X-Google-Smtp-Source: ABdhPJwpp8di3cIrkok5g79tnAJ+pYtjLSV2AAjX0dc2ZYWN2XZib61LEjP22aKYvA6CpSXzfmZn1yvNJQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dd03:c280:4625:60db])
 (user=elver job=sendgmr) by 2002:a05:600c:4f55:: with SMTP id
 m21mr3560923wmq.149.1632219026385; Tue, 21 Sep 2021 03:10:26 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:10:12 +0200
In-Reply-To: <20210921101014.1938382-1-elver@google.com>
Message-Id: <20210921101014.1938382-3-elver@google.com>
Mime-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 3/5] kfence: move saving stack trace of allocations into __kfence_alloc()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the saving of the stack trace of allocations into __kfence_alloc(),
so that the stack entries array can be used outside of
kfence_guarded_alloc() and we avoid potentially unwinding the stack
multiple times.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 mm/kfence/core.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 249d75b7e5ee..db01814f8ff0 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -187,19 +187,26 @@ static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *m
  * Update the object's metadata state, including updating the alloc/free stacks
  * depending on the state transition.
  */
-static noinline void metadata_update_state(struct kfence_metadata *meta,
-					   enum kfence_object_state next)
+static noinline void
+metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state next,
+		      unsigned long *stack_entries, size_t num_stack_entries)
 {
 	struct kfence_track *track =
 		next == KFENCE_OBJECT_FREED ? &meta->free_track : &meta->alloc_track;
 
 	lockdep_assert_held(&meta->lock);
 
-	/*
-	 * Skip over 1 (this) functions; noinline ensures we do not accidentally
-	 * skip over the caller by never inlining.
-	 */
-	track->num_stack_entries = stack_trace_save(track->stack_entries, KFENCE_STACK_DEPTH, 1);
+	if (stack_entries) {
+		memcpy(track->stack_entries, stack_entries,
+		       num_stack_entries * sizeof(stack_entries[0]));
+	} else {
+		/*
+		 * Skip over 1 (this) functions; noinline ensures we do not
+		 * accidentally skip over the caller by never inlining.
+		 */
+		num_stack_entries = stack_trace_save(track->stack_entries, KFENCE_STACK_DEPTH, 1);
+	}
+	track->num_stack_entries = num_stack_entries;
 	track->pid = task_pid_nr(current);
 	track->cpu = raw_smp_processor_id();
 	track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
@@ -261,7 +268,8 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
 	}
 }
 
-static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
+static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp,
+				  unsigned long *stack_entries, size_t num_stack_entries)
 {
 	struct kfence_metadata *meta = NULL;
 	unsigned long flags;
@@ -320,7 +328,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	addr = (void *)meta->addr;
 
 	/* Update remaining metadata. */
-	metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED);
+	metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED, stack_entries, num_stack_entries);
 	/* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
 	WRITE_ONCE(meta->cache, cache);
 	meta->size = size;
@@ -400,7 +408,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 		memzero_explicit(addr, meta->size);
 
 	/* Mark the object as freed. */
-	metadata_update_state(meta, KFENCE_OBJECT_FREED);
+	metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
 
 	raw_spin_unlock_irqrestore(&meta->lock, flags);
 
@@ -742,6 +750,9 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 
 void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 {
+	unsigned long stack_entries[KFENCE_STACK_DEPTH];
+	size_t num_stack_entries;
+
 	/*
 	 * Perform size check before switching kfence_allocation_gate, so that
 	 * we don't disable KFENCE without making an allocation.
@@ -786,7 +797,9 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (!READ_ONCE(kfence_enabled))
 		return NULL;
 
-	return kfence_guarded_alloc(s, size, flags);
+	num_stack_entries = stack_trace_save(stack_entries, KFENCE_STACK_DEPTH, 0);
+
+	return kfence_guarded_alloc(s, size, flags, stack_entries, num_stack_entries);
 }
 
 size_t kfence_ksize(const void *addr)
-- 
2.33.0.464.g1972c5931b-goog

