Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEA343206
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCUKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCUKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 06:53:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 03:53:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so16589138ejj.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zCN4AL8wSlt/iffhE7v2YPEf6OrWr+gbGg6zPXG8k2I=;
        b=clPEArqZETn87sxsXNmQoymMS+5cfyjiCRCl5bqNVj5qbikRfxNz05f3pwEljJWArk
         LpaoEmRmelv3XBSCDStbfCmKxPaMCab9JYOxHJeZO+gP+GJ1UroPNFFJE2+hQ+c/T9xY
         FIg+oX6K7d7cHQKUsuxcyCdFfNeOGLLVVNAV3hTv+v+A0Bz4n01dmYQkFdc8tHZxzZbX
         Y/nsDfqO3R2aefaTk+VthIS/Zuu8HhslEemUOqfblYoK3twxnReNGmpHVKcmqr3VthOt
         7IiaakQDW3zvCO6dGmplIBOqYYN2X5R3/BtBZwXBcuh7Sh1r8aCOzaRAfvH36sgCiNWM
         IofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zCN4AL8wSlt/iffhE7v2YPEf6OrWr+gbGg6zPXG8k2I=;
        b=J8HhSZnB4M+6iJJQnPQA4YRosfF1Ua1MnaJc7EAyNKajsjOE4Xpw1XFdUK4DjFt9wY
         9sOvQsxRodmosR1VnfMOoFd8Qn+Glg0a7GvyiiCOh4hxUr1Ss/wvD7MOfS8MD1jIAjh3
         zYr/oVt4Mzlv3v8963B+cuDqyi0t8mzkiDCIBrTvhHqVgxQFOnnQS0s6wAUsX+sEkvWv
         nQa8a2Ak3UOkrsByFLQFWNlGBh8yIUOpjkn1Pw5WN2qHkVzo6NJvJ0jmKqT4ak1HZ740
         iYeM5WdHGp+AuUiZnbEq0H9NjjaYi/il4j2ZX6YhuVS5LhVFpnHy+Lp2OISWEFxzcjhI
         8KVw==
X-Gm-Message-State: AOAM532LiGexNDKlB1X+kT03RyqCvbYBdEHGJJr9I//ODdcDd6CMmbio
        0a7vZTkdIu/JMWwND6VpCm22KikLfjU=
X-Google-Smtp-Source: ABdhPJxgd0VWjZAau/rdFaYIzkh3IiaoVjRmkzf6E+FqG7+eJ7/V8JJiHVG4/Vl/Cgua0xpwco19Og==
X-Received: by 2002:a17:907:a042:: with SMTP id gz2mr13775551ejc.174.1616324025845;
        Sun, 21 Mar 2021 03:53:45 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id fi11sm6750729ejb.73.2021.03.21.03.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 03:53:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Mar 2021 11:53:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20210321105343.GA124289@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-21

   # HEAD: 38c93587375053c5b9ef093f4a5ea754538cba32 static_call: Fix static_call_update() sanity check

Locking fixes:

- Get static calls & modules right. Hopefully.
- WW mutex fixes

 Thanks,

	Ingo

------------------>
Peter Zijlstra (3):
      static_call: Fix static_call_set_init()
      static_call: Align static_call_is_init() patching condition
      static_call: Fix static_call_update() sanity check

Waiman Long (2):
      locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling
      locking/ww_mutex: Fix acquire/release imbalance in ww_acquire_init()/ww_acquire_fini()


 include/linux/ww_mutex.h |  5 +++--
 kernel/jump_label.c      |  8 ++++++++
 kernel/locking/mutex.c   | 25 ++++++++++++++-----------
 kernel/static_call.c     | 42 ++++++++++++++++++++++++------------------
 4 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 850424e5d030..6ecf2a0220db 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -173,9 +173,10 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
-
+#endif
+#ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index c6a39d662935..ba39fbb1f8e7 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -407,6 +407,14 @@ static bool jump_label_can_update(struct jump_entry *entry, bool init)
 		return false;
 
 	if (!kernel_text_address(jump_entry_code(entry))) {
+		/*
+		 * This skips patching built-in __exit, which
+		 * is part of init_section_contains() but is
+		 * not part of kernel_text_address().
+		 *
+		 * Skipping built-in __exit is fine since it
+		 * will never be executed.
+		 */
 		WARN_ONCE(!jump_entry_is_init(entry),
 			  "can't patch jump_label at %pS",
 			  (void *)jump_entry_code(entry));
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index adb935090768..622ebdfcd083 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -626,7 +626,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
  */
 static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
-		      const bool use_ww_ctx, struct mutex_waiter *waiter)
+		      struct mutex_waiter *waiter)
 {
 	if (!waiter) {
 		/*
@@ -702,7 +702,7 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 #else
 static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
-		      const bool use_ww_ctx, struct mutex_waiter *waiter)
+		      struct mutex_waiter *waiter)
 {
 	return false;
 }
@@ -922,6 +922,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	struct ww_mutex *ww;
 	int ret;
 
+	if (!use_ww_ctx)
+		ww_ctx = NULL;
+
 	might_sleep();
 
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -929,7 +932,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 #endif
 
 	ww = container_of(lock, struct ww_mutex, base);
-	if (use_ww_ctx && ww_ctx) {
+	if (ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
 			return -EALREADY;
 
@@ -946,10 +949,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
 	if (__mutex_trylock(lock) ||
-	    mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, NULL)) {
+	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
-		if (use_ww_ctx && ww_ctx)
+		if (ww_ctx)
 			ww_mutex_set_context_fastpath(ww, ww_ctx);
 		preempt_enable();
 		return 0;
@@ -960,7 +963,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	 * After waiting to acquire the wait_lock, try again.
 	 */
 	if (__mutex_trylock(lock)) {
-		if (use_ww_ctx && ww_ctx)
+		if (ww_ctx)
 			__ww_mutex_check_waiters(lock, ww_ctx);
 
 		goto skip_wait;
@@ -1013,7 +1016,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			goto err;
 		}
 
-		if (use_ww_ctx && ww_ctx) {
+		if (ww_ctx) {
 			ret = __ww_mutex_check_kill(lock, &waiter, ww_ctx);
 			if (ret)
 				goto err;
@@ -1026,7 +1029,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * ww_mutex needs to always recheck its position since its waiter
 		 * list is not FIFO ordered.
 		 */
-		if ((use_ww_ctx && ww_ctx) || !first) {
+		if (ww_ctx || !first) {
 			first = __mutex_waiter_is_first(lock, &waiter);
 			if (first)
 				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
@@ -1039,7 +1042,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * or we must see its unlock and acquire.
 		 */
 		if (__mutex_trylock(lock) ||
-		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
+		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
 		spin_lock(&lock->wait_lock);
@@ -1048,7 +1051,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 acquired:
 	__set_current_state(TASK_RUNNING);
 
-	if (use_ww_ctx && ww_ctx) {
+	if (ww_ctx) {
 		/*
 		 * Wound-Wait; we stole the lock (!first_waiter), check the
 		 * waiters as anyone might want to wound us.
@@ -1068,7 +1071,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 
-	if (use_ww_ctx && ww_ctx)
+	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	spin_unlock(&lock->wait_lock);
diff --git a/kernel/static_call.c b/kernel/static_call.c
index ae825295cf68..2c5950b0b90e 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -35,27 +35,30 @@ static inline void *static_call_addr(struct static_call_site *site)
 	return (void *)((long)site->addr + (long)&site->addr);
 }
 
+static inline unsigned long __static_call_key(const struct static_call_site *site)
+{
+	return (long)site->key + (long)&site->key;
+}
 
 static inline struct static_call_key *static_call_key(const struct static_call_site *site)
 {
-	return (struct static_call_key *)
-		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
+	return (void *)(__static_call_key(site) & ~STATIC_CALL_SITE_FLAGS);
 }
 
 /* These assume the key is word-aligned. */
 static inline bool static_call_is_init(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
+	return __static_call_key(site) & STATIC_CALL_SITE_INIT;
 }
 
 static inline bool static_call_is_tail(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
+	return __static_call_key(site) & STATIC_CALL_SITE_TAIL;
 }
 
 static inline void static_call_set_init(struct static_call_site *site)
 {
-	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
+	site->key = (__static_call_key(site) | STATIC_CALL_SITE_INIT) -
 		    (long)&site->key;
 }
 
@@ -146,6 +149,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	};
 
 	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
+		bool init = system_state < SYSTEM_RUNNING;
 		struct module *mod = site_mod->mod;
 
 		if (!site_mod->sites) {
@@ -165,6 +169,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 		if (mod) {
 			stop = mod->static_call_sites +
 			       mod->num_static_call_sites;
+			init = mod->state == MODULE_STATE_COMING;
 		}
 #endif
 
@@ -172,25 +177,26 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 		     site < stop && static_call_key(site) == key; site++) {
 			void *site_addr = static_call_addr(site);
 
-			if (static_call_is_init(site)) {
-				/*
-				 * Don't write to call sites which were in
-				 * initmem and have since been freed.
-				 */
-				if (!mod && system_state >= SYSTEM_RUNNING)
-					continue;
-				if (mod && !within_module_init((unsigned long)site_addr, mod))
-					continue;
-			}
+			if (!init && static_call_is_init(site))
+				continue;
 
 			if (!kernel_text_address((unsigned long)site_addr)) {
-				WARN_ONCE(1, "can't patch static call site at %pS",
+				/*
+				 * This skips patching built-in __exit, which
+				 * is part of init_section_contains() but is
+				 * not part of kernel_text_address().
+				 *
+				 * Skipping built-in __exit is fine since it
+				 * will never be executed.
+				 */
+				WARN_ONCE(!static_call_is_init(site),
+					  "can't patch static call site at %pS",
 					  site_addr);
 				continue;
 			}
 
 			arch_static_call_transform(site_addr, NULL, func,
-				static_call_is_tail(site));
+						   static_call_is_tail(site));
 		}
 	}
 
@@ -349,7 +355,7 @@ static int static_call_add_module(struct module *mod)
 	struct static_call_site *site;
 
 	for (site = start; site != stop; site++) {
-		unsigned long s_key = (long)site->key + (long)&site->key;
+		unsigned long s_key = __static_call_key(site);
 		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
 		unsigned long key;
 
