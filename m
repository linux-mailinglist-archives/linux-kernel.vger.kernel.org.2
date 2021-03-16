Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E743B33DCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhCPS4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:56:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:41752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240212AbhCPSz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:55:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DCE8AE47;
        Tue, 16 Mar 2021 18:55:56 +0000 (UTC)
Date:   Tue, 16 Mar 2021 11:55:47 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 1/4] locking/ww_mutex: Simplify use_ww_ctx & ww_ctx
 handling
Message-ID: <20210316185547.4mu6zj2bwjjs2c62@offworld>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210316153119.13802-2-longman@redhat.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Waiman Long wrote:

>The use_ww_ctx flag is passed to mutex_optimistic_spin(), but the
>function doesn't use it. The frequent use of the (use_ww_ctx && ww_ctx)
>combination is repetitive.

I always found that very fugly.

>
>In fact, ww_ctx should not be used at all if !use_ww_ctx.  Simplify
>ww_mutex code by dropping use_ww_ctx from mutex_optimistic_spin() an
>clear ww_ctx if !use_ww_ctx. In this way, we can replace (use_ww_ctx &&
>ww_ctx) by just (ww_ctx).
>
>Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>

>---
> kernel/locking/mutex.c | 25 ++++++++++++++-----------
> 1 file changed, 14 insertions(+), 11 deletions(-)
>
>diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>index adb935090768..622ebdfcd083 100644
>--- a/kernel/locking/mutex.c
>+++ b/kernel/locking/mutex.c
>@@ -626,7 +626,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
>  */
> static __always_inline bool
> mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
>-		      const bool use_ww_ctx, struct mutex_waiter *waiter)
>+		      struct mutex_waiter *waiter)
> {
> 	if (!waiter) {
> 		/*
>@@ -702,7 +702,7 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
> #else
> static __always_inline bool
> mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
>-		      const bool use_ww_ctx, struct mutex_waiter *waiter)
>+		      struct mutex_waiter *waiter)
> {
> 	return false;
> }
>@@ -922,6 +922,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 	struct ww_mutex *ww;
> 	int ret;
>
>+	if (!use_ww_ctx)
>+		ww_ctx = NULL;
>+
> 	might_sleep();
>
> #ifdef CONFIG_DEBUG_MUTEXES
>@@ -929,7 +932,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> #endif
>
> 	ww = container_of(lock, struct ww_mutex, base);
>-	if (use_ww_ctx && ww_ctx) {
>+	if (ww_ctx) {
> 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
> 			return -EALREADY;
>
>@@ -946,10 +949,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
>
> 	if (__mutex_trylock(lock) ||
>-	    mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, NULL)) {
>+	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
> 		/* got the lock, yay! */
> 		lock_acquired(&lock->dep_map, ip);
>-		if (use_ww_ctx && ww_ctx)
>+		if (ww_ctx)
> 			ww_mutex_set_context_fastpath(ww, ww_ctx);
> 		preempt_enable();
> 		return 0;
>@@ -960,7 +963,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 	 * After waiting to acquire the wait_lock, try again.
> 	 */
> 	if (__mutex_trylock(lock)) {
>-		if (use_ww_ctx && ww_ctx)
>+		if (ww_ctx)
> 			__ww_mutex_check_waiters(lock, ww_ctx);
>
> 		goto skip_wait;
>@@ -1013,7 +1016,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 			goto err;
> 		}
>
>-		if (use_ww_ctx && ww_ctx) {
>+		if (ww_ctx) {
> 			ret = __ww_mutex_check_kill(lock, &waiter, ww_ctx);
> 			if (ret)
> 				goto err;
>@@ -1026,7 +1029,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 		 * ww_mutex needs to always recheck its position since its waiter
> 		 * list is not FIFO ordered.
> 		 */
>-		if ((use_ww_ctx && ww_ctx) || !first) {
>+		if (ww_ctx || !first) {
> 			first = __mutex_waiter_is_first(lock, &waiter);
> 			if (first)
> 				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>@@ -1039,7 +1042,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 		 * or we must see its unlock and acquire.
> 		 */
> 		if (__mutex_trylock(lock) ||
>-		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
>+		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
> 			break;
>
> 		spin_lock(&lock->wait_lock);
>@@ -1048,7 +1051,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> acquired:
> 	__set_current_state(TASK_RUNNING);
>
>-	if (use_ww_ctx && ww_ctx) {
>+	if (ww_ctx) {
> 		/*
> 		 * Wound-Wait; we stole the lock (!first_waiter), check the
> 		 * waiters as anyone might want to wound us.
>@@ -1068,7 +1071,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> 	/* got the lock - cleanup and rejoice! */
> 	lock_acquired(&lock->dep_map, ip);
>
>-	if (use_ww_ctx && ww_ctx)
>+	if (ww_ctx)
> 		ww_mutex_lock_acquired(ww, ww_ctx);
>
> 	spin_unlock(&lock->wait_lock);
>-- 
>2.18.1
>
