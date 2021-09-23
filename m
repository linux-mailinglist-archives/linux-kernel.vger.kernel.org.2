Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC78D415C39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhIWKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbhIWKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:49:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D49C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 100-20020aed30ed000000b002a6b3dc6465so10441515qtf.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QoufVORGRixTO8MhoQUDRlzmXbjgEZCp2vEpgCNZeS8=;
        b=RkZpopRFiOjxNsrmecoWsi1UduTb+8JLsEAwtEPG1lrGsiOw54eRPsTPfESoDEwLkJ
         WSSnirsYqa9d+h1C3KoIiyrkzylhkTJGE2RvWpvaLDDQDn0sPgOkD9MzMu+t5DKilDk2
         TkJtDCtGHiZ5Q9E2fL41SMBC/m0JhgiokwIDuqbL5qAE/KwwLnYnLWOtMJz3PmXKxaix
         X5jC5u7WtggSpbU+oCUNFUCO7CfQ7TCb3+sZhusU9i+t3hoPGo5AeJdUiKdsr+nLpy+R
         rhGGB04EmDjrXvMIeBLpHRnKRmUGbWLO8U6RNLFF5/jI9NwpUeOQTinHhAJZVN8OArJQ
         FrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QoufVORGRixTO8MhoQUDRlzmXbjgEZCp2vEpgCNZeS8=;
        b=e1xX3HcpoBMNuC6fMbMyyHOxSKCL3LVG/6jglbvG/eSxN3fUgqmyYZGwLiWyoUi66G
         2ebzC5VHIrCqT1rAB0daZYojEzBkMiCNqj3H2r+92HibFG9bZuljxGYF3EhDRUB3WhNZ
         ogkj/3y8/IbIMpcD/1fDpjsvs6LvNQXXFSaA55vIkGDN+54O5qnPwXmge7jxEifnQjU4
         dMXvlPrskayWAdFRz/ajsNGgTkib8ONwdhqDYBI1KZTbgQFYk6QEusq4rV1CLFoCEDlt
         XUfCmXT0IxEhJRLGLryUB/ZhXpP+9SEnjP+VnBOyL/hmFLW6DxISAK5mc8c1e5aoCMDA
         qzSA==
X-Gm-Message-State: AOAM533NOkDYbQENm8HHdQEZWaRUU7r0djy1U2KorPstlMmMu2OSxsLI
        IlYFFcyWcckuyRNe8piYcBXkZkpePQ==
X-Google-Smtp-Source: ABdhPJw2ccb7nXnaRKRSmiDJt/UyuuctC2avhfN9qyANiuPdcVjTxceHwmJez6L7WkM9VcAFK9qvF7JvCA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:bd72:fd35:a085:c2e3])
 (user=elver job=sendgmr) by 2002:a05:6214:406:: with SMTP id
 z6mr3769082qvx.34.1632394096539; Thu, 23 Sep 2021 03:48:16 -0700 (PDT)
Date:   Thu, 23 Sep 2021 12:48:01 +0200
In-Reply-To: <20210923104803.2620285-1-elver@google.com>
Message-Id: <20210923104803.2620285-3-elver@google.com>
Mime-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 3/5] kfence: move saving stack trace of allocations into __kfence_alloc()
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
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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

