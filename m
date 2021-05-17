Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A63822FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhEQDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232509AbhEQDNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:13:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97408B223;
        Mon, 17 May 2021 03:12:32 +0000 (UTC)
Date:   Sun, 16 May 2021 20:12:27 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, 1vier1@web.de
Subject: Re: [PATCH] ipc/sem.c: use READ_ONCE()/WRITE_ONCE() for
 use_global_lock
Message-ID: <20210517031227.qqir3hk2z45pzjum@offworld>
References: <20210514175319.12195-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210514175319.12195-1-manfred@colorfullife.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021, Manfred Spraul wrote:

>The patch solves two weaknesses in ipc/sem.c:
>
>1) The initial read of use_global_lock in sem_lock() is an
>intentional race. KCSAN detects these accesses and prints
>a warning.
>
>2) The code assumes that plain C read/writes are not
>mangled by the CPU or the compiler.
>
>To solve both issues, use READ_ONCE()/WRITE_ONCE().
>Plain C reads are used in code that owns sma->sem_perm.lock.
>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>---
> ipc/sem.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/ipc/sem.c b/ipc/sem.c
>index bf534c74293e..a0ad3a3edde2 100644
>--- a/ipc/sem.c
>+++ b/ipc/sem.c
>@@ -217,6 +217,8 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
>  * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
>  * is inside a spin_lock() and after a write from 0 to non-zero a
>  * spin_lock()+spin_unlock() is done.
>+ * To prevent the compiler/cpu temporarily writing 0 to use_global_lock,
>+ * READ_ONCE()/WRITE_ONCE() is used.
>  *
>  * 2) queue.status: (SEM_BARRIER_2)
>  * Initialization is done while holding sem_lock(), so no further barrier is
>@@ -342,10 +344,10 @@ static void complexmode_enter(struct sem_array *sma)
> 		 * Nothing to do, just reset the
> 		 * counter until we return to simple mode.
> 		 */
>-		sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
>+		WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
> 		return;
> 	}
>-	sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
>+	WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
>
> 	for (i = 0; i < sma->sem_nsems; i++) {
> 		sem = &sma->sems[i];
>@@ -371,7 +373,8 @@ static void complexmode_tryleave(struct sem_array *sma)
> 		/* See SEM_BARRIER_1 for purpose/pairing */
> 		smp_store_release(&sma->use_global_lock, 0);
> 	} else {
>-		sma->use_global_lock--;
>+		WRITE_ONCE(sma->use_global_lock,
>+				sma->use_global_lock-1);
> 	}
> }
>
>@@ -412,7 +415,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
> 	 * Initial check for use_global_lock. Just an optimization,
> 	 * no locking, no memory barrier.
> 	 */
>-	if (!sma->use_global_lock) {
>+	if (!READ_ONCE(sma->use_global_lock)) {
> 		/*
> 		 * It appears that no complex operation is around.
> 		 * Acquire the per-semaphore lock.
>-- 
>2.31.1
>
