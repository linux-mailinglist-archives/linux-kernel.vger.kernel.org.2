Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2E4016CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbhIFHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhIFHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:14:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B23C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 00:13:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e26so3817432wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f98kXLLkaijY0oNNLw6WgRRLwDsrarriBpxo943QWF8=;
        b=lhndPckmNwySFjmrzjNvoFroIMdpM6NxBQcQoHQEwqAUePzHJiIB/QTkiYln3Q8Rc1
         s8K3/NNcn5hqRQcdZUFGqySm7GaVS0mS9Md1XZLRKYuVEp9Oz7CYNlaiG09892pFDz+n
         xt/qR6B9XGsfD2Zqxw70jKQcvR01thN3enK0oHBnzO5wqqgGfNP6ovG11jRQvDrltJ9g
         Ti9a5T4pw34NCkSugoDALMj6fdhlNOTXWEuHqb3rp6Q8jqfNbBiTsj1CaYeEZsViKzfZ
         McF8Vt/w8w4t2K/o93KexuYDHfV4rtJkvxpWSGqQLgl4TpfgqVnnhDdjItbxtO2VyeGV
         xk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f98kXLLkaijY0oNNLw6WgRRLwDsrarriBpxo943QWF8=;
        b=p4w33U0hLExDSt0fX1r1S6JAmm8TYx3AnMiQBDvMcBpwU2tRWw8XiK+BaoxuaMTptO
         BQdUVt31Qgkv2q3TUhp+TX92UD+d2L1LmBXTtlRVgYLaM74F1oB3Ity1j3hAtwi5rXZg
         J4DAcmPu1dNQKt8ytCePJo+q+sSjzHGPjat+V+3J8o5MCuOSTYLRC5gd81D5BfxcepYV
         NmgPeTcPPRGwRL2+pjNZibULkdWS0TI1m9+5YEjIDjHVSQCiOiEXYdNKNJSabeM/+GYI
         3UTqqWuXZJX7VoNa0+3UUWKCGTxhEXLDOicBJ0frohqvTF+T2/zUUNKidXB+5gAJoyFr
         uDxQ==
X-Gm-Message-State: AOAM533SibrHNed8KsvcTAl661MoO7QXY46F7XuOALQ8dYul7yHYLP8U
        YUcVdQAH+8pC7sE58vOG9PMFXw==
X-Google-Smtp-Source: ABdhPJz9Dyh0HgBZ0fikqsnbEt3oRLsA0bDFOUI8fs95FBmkaAAXkTX62rpap98bmrbRQRCwoj0Fhw==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr9659808wmi.77.1630912384769;
        Mon, 06 Sep 2021 00:13:04 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:65cc:558b:a5e6:ac7b])
        by smtp.gmail.com with ESMTPSA id i5sm6956256wrc.86.2021.09.06.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:13:03 -0700 (PDT)
Date:   Mon, 6 Sep 2021 09:12:58 +0200
From:   Marco Elver <elver@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, akpm@linux-foundation.org,
        andreyknvl@gmail.com, dvyukov@google.com,
        walter-zh.wu@mediatek.com, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] workqueue: Don't record workqueue stack holding
 raw_spin_lock
Message-ID: <YTW/emWbsNX7OkOh@elver.google.com>
References: <20210902200134.25603-1-skhan@linuxfoundation.org>
 <CANpmjNPWyp67SSfRiXVYTiqRaMre9XVQzNVM-73PQ6TTjQW3Gw@mail.gmail.com>
 <2bd3759d-cd13-24f5-2cbd-00505d98e0c9@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5wZe6NYc7WWhKinL"
Content-Disposition: inline
In-Reply-To: <2bd3759d-cd13-24f5-2cbd-00505d98e0c9@linuxfoundation.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5wZe6NYc7WWhKinL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 02, 2021 at 05:46PM -0600, Shuah Khan wrote:
[...]
> > 3. Try to not allocate memory in stackdepot. Not sure this is feasible
> > without telling stackdepot to preallocate the max slabs on boot if RT.
> > 
> 
> We could. I have to ask though how much of the real world cases do we
> need to impact for the debug code to work?
> 
> > Anything else? Because I don't think any of the options are satisfying.
> 
> One option to consider is checking dry-run invalid nesting check and
> bail out if it is true in kasan_record_aux_stack()

Sadly, if lockdep is off, this won't work. And we need a way to
generically fix this, as otherwise we still have a bug (which may also
cause issues on RT kernels).

I propose we properly fix this and prevent stackdepot from replenishing
its "stack slab" pool if memory allocations cannot be done in the
current context. Specifically, I noticed technically it's a bug to use
either GFP_ATOMIC nor GFP_NOWAIT in certain non-preemptive contexts,
including raw_spin_locks (see gfp.h and ab00db216c9c7).

This is what kasan_record_aux_stack() via stackdepot does, and it's a
bug here regardless if lockdep is on or off.

I've prepared a series (see attached draft patches) that allows telling
stackdepot to not replenish its pool if alloc_pages() cannot be called
at all (where GFP_ATOMIC/NOWAIT doesn't even work).

The only downside is that saving a stack trace may fail if: stackdepot
runs out of space AND the same stack trace has not been recorded before.
I expect this to be unlikely, and a simple experiment (boot the kernel)
didn't result in any failure to record stack trace from insert_work().

I think this is a reasonable trade-off. And considering that we're
unsure if queuing work can or cannot be done from within an outer
raw_spin_lock'ed critical section, I don't see a better way.

If you agree, I'll send this series out for further review.

Thanks,
-- Marco

--5wZe6NYc7WWhKinL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-lib-stackdepot-introduce-__stack_depot_save.patch"

From d765613f04b6aee4ebde71e21c2a6210fe93927d Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Sun, 5 Sep 2021 16:51:26 +0200
Subject: [PATCH 1/4] lib/stackdepot: introduce __stack_depot_save()

Add __stack_depot_save(), which provides more fine-grained control over
stackdepot's memory allocation behaviour, in case stackdepot runs out of
"stack slabs".

Normally stackdepot uses alloc_pages() in case it runs out of space;
passing can_alloc==false to __stack_depot_save() prohibits this, at the
cost of more likely failure to record a stack trace.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/stackdepot.h |  4 ++++
 lib/stackdepot.c           | 38 ++++++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 6bb4bc1a5f54..3735b97f62be 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -13,6 +13,10 @@
 
 typedef u32 depot_stack_handle_t;
 
+depot_stack_handle_t __stack_depot_save(unsigned long *entries,
+					unsigned int nr_entries,
+					gfp_t gfp_flags, bool can_alloc);
+
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c80a9f734253..ec26845b4e29 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -248,17 +248,26 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
 /**
- * stack_depot_save - Save a stack trace from an array
+ * __stack_depot_save - Save a stack trace from an array
+ *
+ * Save a stack trace from an array. If |can_alloc| is false, avoids allocating
+ * new stack slabs if no space is left in the current stack slab.
+ *
+ * Setting |can_alloc| to false is required if alloc_pages() cannot be used from
+ * the current context; currently this is the case from contexts where not even
+ * %GFP_ATOMIC or %GFP_NOWAIT can be used (NMI, raw_spin_lock).
  *
  * @entries:		Pointer to storage array
  * @nr_entries:		Size of the storage array
  * @alloc_flags:	Allocation gfp flags
+ * @can_alloc:		Allocate stack slabs (increased chance of failure if false)
  *
- * Return: The handle of the stack struct stored in depot
+ * Return: The handle of the stack struct stored in depot (0 on failure)
  */
-depot_stack_handle_t stack_depot_save(unsigned long *entries,
-				      unsigned int nr_entries,
-				      gfp_t alloc_flags)
+depot_stack_handle_t __stack_depot_save(unsigned long *entries,
+					unsigned int nr_entries,
+					gfp_t alloc_flags,
+					bool can_alloc)
 {
 	struct stack_record *found = NULL, **bucket;
 	depot_stack_handle_t retval = 0;
@@ -291,7 +300,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |next_slab_inited| in depot_alloc_stack() and init_stack_slab().
 	 */
-	if (unlikely(!smp_load_acquire(&next_slab_inited))) {
+	if (unlikely(can_alloc && !smp_load_acquire(&next_slab_inited))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -339,6 +348,23 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 fast_exit:
 	return retval;
 }
+EXPORT_SYMBOL_GPL(__stack_depot_save);
+
+/**
+ * stack_depot_save - Save a stack trace from an array
+ *
+ * @entries:		Pointer to storage array
+ * @nr_entries:		Size of the storage array
+ * @alloc_flags:	Allocation gfp flags
+ *
+ * Return: The handle of the stack struct stored in depot (0 on failure)
+ */
+depot_stack_handle_t stack_depot_save(unsigned long *entries,
+				      unsigned int nr_entries,
+				      gfp_t alloc_flags)
+{
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+}
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
 static inline int in_irqentry_text(unsigned long ptr)
-- 
2.33.0.153.gba50c8fa24-goog


--5wZe6NYc7WWhKinL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-kasan-common-provide-can_alloc-in-kasan_save_stack.patch"

From b297b06ca93a124f450c06ea41b9b0d761ca3402 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Sun, 5 Sep 2021 16:56:43 +0200
Subject: [PATCH 2/4] kasan: common: provide can_alloc in kasan_save_stack()

Add another argument, can_alloc, to kasan_save_stack() which is passed
as-is to __stack_depot_save().

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kasan/common.c  | 6 +++---
 mm/kasan/generic.c | 2 +-
 mm/kasan/kasan.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2baf121fb8c5..3e0999892c36 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -30,20 +30,20 @@
 #include "kasan.h"
 #include "../slab.h"
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags)
+depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
 	nr_entries = filter_irq_stacks(entries, nr_entries);
-	return stack_depot_save(entries, nr_entries, flags);
+	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
 	track->pid = current->pid;
-	track->stack = kasan_save_stack(flags);
+	track->stack = kasan_save_stack(flags, true);
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index c3f5ba7a294a..2a8e59e6326d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -345,7 +345,7 @@ void kasan_record_aux_stack(void *addr)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
+	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, true);
 }
 
 void kasan_set_free_info(struct kmem_cache *cache,
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fa02c88b6948..e442d94a8f6e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -260,7 +260,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
 
 struct page *kasan_addr_to_page(const void *addr);
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags);
+depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-- 
2.33.0.153.gba50c8fa24-goog


--5wZe6NYc7WWhKinL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-kasan-generic-introduce-kasan_record_aux_stack_noall.patch"

From 098d9384609748bc12e6ea75038d0fc7659459a5 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Sun, 5 Sep 2021 17:12:33 +0200
Subject: [PATCH 3/4] kasan: generic: introduce
 kasan_record_aux_stack_noalloc()

Introduce a variant of kasan_record_aux_stack() that does not do any
memory allocation through stackdepot. This will permit using it in
contexts that cannot allocate any memory.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kasan.h |  2 ++
 mm/kasan/generic.c    | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dd874a1ee862..736d7b458996 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -370,12 +370,14 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
+void kasan_record_aux_stack_noalloc(void *ptr);
 
 #else /* CONFIG_KASAN_GENERIC */
 
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 static inline void kasan_record_aux_stack(void *ptr) {}
+static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
 
 #endif /* CONFIG_KASAN_GENERIC */
 
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 2a8e59e6326d..84a038b07c6f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -328,7 +328,7 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
-void kasan_record_aux_stack(void *addr)
+static void __kasan_record_aux_stack(void *addr, bool can_alloc)
 {
 	struct page *page = kasan_addr_to_page(addr);
 	struct kmem_cache *cache;
@@ -345,7 +345,17 @@ void kasan_record_aux_stack(void *addr)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, true);
+	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, can_alloc);
+}
+
+void kasan_record_aux_stack(void *addr)
+{
+	return __kasan_record_aux_stack(addr, true);
+}
+
+void kasan_record_aux_stack_noalloc(void *addr)
+{
+	return __kasan_record_aux_stack(addr, false);
 }
 
 void kasan_set_free_info(struct kmem_cache *cache,
-- 
2.33.0.153.gba50c8fa24-goog


--5wZe6NYc7WWhKinL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-workqueue-kasan-avoid-alloc_pages-when-recording-sta.patch"

From 0da4fd0de4ed32ed0d7ddd8e9518ddffba31471a Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Sun, 5 Sep 2021 17:17:19 +0200
Subject: [PATCH 4/4] workqueue, kasan: avoid alloc_pages() when recording
 stack

Shuah Khan reported:

 | When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
 | kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
 | it tries to allocate memory attempting to acquire spinlock in page
 | allocation code while holding workqueue pool raw_spinlock.
 |
 | There are several instances of this problem when block layer tries
 | to __queue_work(). Call trace from one of these instances is below:
 |
 |     kblockd_mod_delayed_work_on()
 |       mod_delayed_work_on()
 |         __queue_delayed_work()
 |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
 |             insert_work()
 |               kasan_record_aux_stack()
 |                 kasan_save_stack()
 |                   stack_depot_save()
 |                     alloc_pages()
 |                       __alloc_pages()
 |                         get_page_from_freelist()
 |                           rm_queue()
 |                             rm_queue_pcplist()
 |                               local_lock_irqsave(&pagesets.lock, flags);
 |                               [ BUG: Invalid wait context triggered ]

The default kasan_record_aux_stack() calls stack_depot_save() with
GFP_NOWAIT, which in turn can then call alloc_pages(GFP_NOWAIT, ...).
In general, however, it is not even possible to use either GFP_ATOMIC
nor GFP_NOWAIT in certain non-preemptive contexts, including
raw_spin_locks (see gfp.h and ab00db216c9c7).

Fix it by instructing stackdepot to not expand stack storage via
alloc_pages() in case it runs out by using kasan_record_aux_stack_noalloc().

While there is an increased risk of failing to insert the stack trace,
this is typically unlikely, especially if the same insertion had already
succeeded previously (stack depot hit). For frequent calls from the same
location, it therefore becomes extremely unlikely that
kasan_record_aux_stack_noalloc() fails.

Link: https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..0681774e6908 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1329,7 +1329,7 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 	struct worker_pool *pool = pwq->pool;
 
 	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack(work);
+	kasan_record_aux_stack_noalloc(work);
 
 	/* we own @work, set data and link */
 	set_work_pwq(work, pwq, extra_flags);
-- 
2.33.0.153.gba50c8fa24-goog


--5wZe6NYc7WWhKinL--
